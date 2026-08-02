{ pkgs, ... }:

{
  programs.nixvim = {
    extraPackages = with pkgs; [
      vscode-extensions.vadimcn.vscode-lldb.adapter
    ];

    plugins = {
      dap = {
        enable = true;

        signs = {
          dapBreakpoint = {
            text = "●";
            texthl = "DiagnosticInfo";
          };
          dapBreakpointCondition = {
            text = "◆";
            texthl = "DiagnosticWarn";
          };
          dapBreakpointRejected = {
            text = "";
            texthl = "DiagnosticError";
          };
          dapLogPoint = {
            text = "◉";
            texthl = "DiagnosticHint";
          };
          dapStopped = {
            text = "▶";
            texthl = "DiagnosticWarn";
          };
        };
      };

      dap-ui = {
        enable = true;
      };

      dap-virtual-text = {
        enable = true;
        settings = {
          commented = true;
          show_stop_reason = true;
          virt_text_pos = "eol";
        };
      };

      dap-python = {
        enable = true;
        settings = {
          console = "integratedTerminal";
        };
        customConfigurations = [
          {
            type = "python";
            request = "launch";
            name = "Launch file";
            program = "\${file}";
            justMyCode = true;
          }
          {
            type = "python";
            request = "launch";
            name = "Launch file (all code)";
            program = "\${file}";
            justMyCode = false;
          }
        ];
      };

      dap-lldb = {
        enable = true;
        codelldb_path = "codelldb";
      };
    };

    extraConfigLua = ''
      local dap = require("dap")
      local dapui = require("dapui")

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end

      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end

      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end

      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>db";
        action = "<cmd>DapToggleBreakpoint<CR>";
        options.desc = "Toggle breakpoint";
      }
      {
        mode = "n";
        key = "<leader>dB";
        action = "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>";
        options.desc = "Conditional breakpoint";
      }
      {
        mode = "n";
        key = "<leader>dc";
        action = "<cmd>DapContinue<CR>";
        options.desc = "Start or continue";
      }
      {
        mode = "n";
        key = "<leader>di";
        action = "<cmd>DapStepInto<CR>";
        options.desc = "Step into";
      }
      {
        mode = "n";
        key = "<leader>do";
        action = "<cmd>DapStepOut<CR>";
        options.desc = "Step out";
      }
      {
        mode = "n";
        key = "<leader>ds";
        action = "<cmd>DapStepOver<CR>";
        options.desc = "Step over";
      }
      {
        mode = "n";
        key = "<leader>dr";
        action = "<cmd>DapToggleRepl<CR>";
        options.desc = "Toggle REPL";
      }
      {
        mode = "n";
        key = "<leader>dl";
        action = "<cmd>DapRunLast<CR>";
        options.desc = "Run last";
      }
      {
        mode = "n";
        key = "<leader>du";
        action = "<cmd>lua require('dapui').toggle()<CR>";
        options.desc = "Toggle debugger UI";
      }
      {
        mode = "n";
        key = "<leader>dx";
        action = "<cmd>DapTerminate<CR>";
        options.desc = "Terminate session";
      }
    ];
  };
}
