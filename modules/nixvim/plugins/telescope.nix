{ ... }:
let desc = d: { desc = d; };
in {
  plugins = {
    telescope = {
      enable = true;
      extensions = { live-grep-args = { enable = true; }; };
      settings = {
        defaults = {
          mappings = {
            i = {
              "<Up>".__raw = "require('telescope.actions').cycle_history_prev";
              "<Down>".__raw =
                "require('telescope.actions').cycle_history_next";
              "<C-1>".__raw = ''
                function(prompt_bufnr)
                  require("telescope.actions.generate").refine(prompt_bufnr, {
                    prompt_to_prefix = true,
                    sorter = false,
                  })
                end
              '';
            };
            n = {
              "<Up>".__raw = "require('telescope.actions').cycle_history_prev";
              "<Down>".__raw =
                "require('telescope.actions').cycle_history_next";
              "<C-1>".__raw = ''
                function(prompt_bufnr)
                  require("telescope.actions.generate").refine(prompt_bufnr, {
                    prompt_to_prefix = true,
                    sorter = false,
                  })
                end
              '';
            };
          };
        };
      };
    };
  };
  keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>sg";
      action = "<cmd>Telescope live_grep_args<CR>";
      options = desc "Live grep in workspace";
    }
    {
      mode = [ "n" ];
      key = "<leader>sf";
      action = "<cmd>Telescope find_files<CR>";
      options = desc "Find files in workspace";
    }
  ];
}
