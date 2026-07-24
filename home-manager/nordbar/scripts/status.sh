#!/usr/bin/env bash
set -u

# Optional manual overrides. Useful when auto-detection picks the wrong hwmon sensor.
# Find candidates with:
#   for h in /sys/class/hwmon/hwmon*; do echo "== $h $(cat "$h/name" 2>/dev/null)"; grep -H . "$h"/temp*_label "$h"/temp*_input 2>/dev/null; done
CPU_TEMP_PATH="${CPU_TEMP_PATH:-}"
IGPU_TEMP_PATH="${IGPU_TEMP_PATH:-}"
DGPU_TEMP_PATH="${DGPU_TEMP_PATH:-}"

json_escape() {
  printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g'
}

as_json_number() {
  if [[ "${1:-}" =~ ^-?[0-9]+$ ]]; then
    printf '%s' "$1"
  else
    printf 'null'
  fi
}

read_temp_path() {
  local path="${1:-}"
  [[ -n "$path" && -r "$path" ]] || return 1
  local raw
  raw="$(cat "$path" 2>/dev/null || true)"
  [[ "$raw" =~ ^-?[0-9]+$ ]] || return 1
  if (( raw > 1000 )); then
    printf '%d' $((raw / 1000))
  else
    printf '%d' "$raw"
  fi
}

temp_by_hwmon_name() {
  local pattern="$1"
  local h name input raw
  for h in /sys/class/hwmon/hwmon*; do
    [[ -d "$h" ]] || continue
    name="$(cat "$h/name" 2>/dev/null || true)"
    [[ "$name" =~ $pattern ]] || continue
    for input in "$h"/temp*_input; do
      [[ -r "$input" ]] || continue
      raw="$(cat "$input" 2>/dev/null || true)"
      [[ "$raw" =~ ^-?[0-9]+$ ]] || continue
      printf '%d' $((raw / 1000))
      return 0
    done
  done
  return 1
}

cpu_usage() {
  local cpu user nice system idle iowait irq softirq steal guest guest_nice
  read -r cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat
  local idle1=$((idle + iowait))
  local nonidle1=$((user + nice + system + irq + softirq + steal))
  local total1=$((idle1 + nonidle1))

  sleep 0.20

  read -r cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat
  local idle2=$((idle + iowait))
  local nonidle2=$((user + nice + system + irq + softirq + steal))
  local total2=$((idle2 + nonidle2))

  local totald=$((total2 - total1))
  local idled=$((idle2 - idle1))
  if (( totald <= 0 )); then
    printf '0'
  else
    awk -v total="$totald" -v idle="$idled" 'BEGIN { printf "%d", ((total - idle) * 100 / total) }'
  fi
}

ram_usage() {
  awk '
    /MemTotal:/ { total=$2 }
    /MemAvailable:/ { available=$2 }
    END { if (total > 0) printf "%d", ((total - available) * 100 / total); else print 0 }
  ' /proc/meminfo
}

wp_volume() {
  local target="$1"
  local line number muted
  line="$(wpctl get-volume "$target" 2>/dev/null || true)"
  number="$(awk '{ for (i = 1; i <= NF; i++) if ($i ~ /^[0-9.]+$/) { printf "%d", $i * 100; exit } }' <<< "$line")"
  [[ -n "$number" ]] || number=0
  [[ "$line" == *MUTED* ]] && muted=true || muted=false
  printf '%s %s' "$number" "$muted"
}

wifi_ssid() {
  nmcli -t -f active,ssid dev wifi 2>/dev/null | awk -F: '$1 == "yes" { print $2; exit }'
}

battery_info() {
  local bat capacity status
  bat="$(find /sys/class/power_supply -maxdepth 1 -type l -name 'BAT*' 2>/dev/null | head -n 1)"
  if [[ -n "$bat" && -r "$bat/capacity" ]]; then
    capacity="$(cat "$bat/capacity" 2>/dev/null || true)"
    status="$(cat "$bat/status" 2>/dev/null || true)"
    printf '%s|%s' "$capacity" "$status"
  else
    printf 'null|'
  fi
}

cpu="$(cpu_usage)"
ram="$(ram_usage)"

read -r volume sink_muted < <(wp_volume '@DEFAULT_AUDIO_SINK@')
read -r _ mic_muted < <(wp_volume '@DEFAULT_AUDIO_SOURCE@')
[[ "$mic_muted" == "true" ]] && mic_on=false || mic_on=true

ssid="$(wifi_ssid)"
[[ -n "$ssid" ]] || ssid="offline"

cpu_temp="$(read_temp_path "$CPU_TEMP_PATH" 2>/dev/null || temp_by_hwmon_name 'coretemp|k10temp|zenpower' 2>/dev/null || true)"
igpu_temp="$(read_temp_path "$IGPU_TEMP_PATH" 2>/dev/null || temp_by_hwmon_name 'i915|intel|xe' 2>/dev/null || true)"
dgpu_temp="$(read_temp_path "$DGPU_TEMP_PATH" 2>/dev/null || nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -n 1 || temp_by_hwmon_name 'amdgpu' 2>/dev/null || true)"

battery_raw="$(battery_info)"
battery="${battery_raw%%|*}"
battery_status="${battery_raw#*|}"

printf '{'
printf '"volume":%s,' "$(as_json_number "$volume")"
printf '"sinkMuted":%s,' "$sink_muted"
printf '"micOn":%s,' "$mic_on"
printf '"ssid":"%s",' "$(json_escape "$ssid")"
printf '"cpu":%s,' "$(as_json_number "$cpu")"
printf '"ram":%s,' "$(as_json_number "$ram")"
printf '"cpuTemp":%s,' "$(as_json_number "$cpu_temp")"
printf '"igpuTemp":%s,' "$(as_json_number "$igpu_temp")"
printf '"dgpuTemp":%s,' "$(as_json_number "$dgpu_temp")"
printf '"battery":%s,' "$(as_json_number "$battery")"
printf '"batteryStatus":"%s"' "$(json_escape "$battery_status")"
printf '}\n'
