# Nordbar for Quickshell + Hyprland

A compact Nord-themed top bar for Hyprland in Quickshell.

## Run

```bash
mkdir -p ~/.config/quickshell
cp -r nordbar-quickshell ~/.config/quickshell/nordbar
chmod +x ~/.config/quickshell/nordbar/scripts/status.sh
quickshell -c nordbar
# or, on packages that expose the short command:
qs -c nordbar
```

## Dependencies

- quickshell
- NetworkManager's `nmcli`
- WirePlumber's `wpctl`
- optional: `nvidia-smi` for NVIDIA dGPU temperature

## Adjust temps

Run:

```bash
for h in /sys/class/hwmon/hwmon*; do
  echo "== $h $(cat "$h/name" 2>/dev/null)"
  grep -H . "$h"/temp*_label "$h"/temp*_input 2>/dev/null
done
```

Then set `CPU_TEMP_PATH`, `IGPU_TEMP_PATH`, or `DGPU_TEMP_PATH` at the top of `scripts/status.sh` if auto-detection picks the wrong sensor.
