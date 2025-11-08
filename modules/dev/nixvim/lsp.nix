{ nixosConfig }:

{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  gccCfg = nixosConfig.modules.language.gcc;
  pythonCfg = nixosConfig.modules.language.python;
  typstCfg = nixosConfig.modules.language.typst;
  rustCfg = nixosConfig.modules.language.rust;
in
{
  # Useful status updates for LSP.
  # https://nix-community.github.io/nixvim/plugins/fidget/index.html
  plugins.fidget.enable = true;

  # https://nix-community.github.io/nixvim/NeovimOptions/autoGroups/index.html
  autoGroups."kickstart-lsp-attach".clear = true;

  # A plugin that properly configures LuaLS for editing your Neovim config
  #  by lazily updating your workspace libraries.
  #  https://nix-community.github.io/nixvim/plugins/lazydev/index.html
  plugins.lazydev = {
    enable = true; # autoEnableSources not enough
    settings = {
      library = [
        {
          path = "\${3rd}/luv/library";
          words = [ "vim%.uv" ];
        }
      ];
    };
  };

  plugins.lsp = {
    enable = true;

    servers = mkMerge [
      # ----- C / C++ ---------------------------------------------------
      (mkIf gccCfg.enable {
        clangd.enable = true;
      })

      # ----- Python ----------------------------------------------------
      (mkIf pythonCfg.enable {
        pyright.enable = true;
      })

      # ----- Typst ------------------------------------------------------
      (mkIf typstCfg.enable {
        tinymist.enable = true;
      })

      # ----- Rust -------------------------------------------------------
      (mkIf rustCfg.enable {
        rust_analyzer.enable = true;
      })

      # ----- Miscellaneous (always on) ---------------------------------
      {
        # Lua LS – useful for editing your init.lua / config.nix
        lua_ls = {
          enable = true;
          settings = {
            completion.callSnippet = "Replace";
          };
        };

        # Nil (Nix) – keep it on unless you explicitly want to hide it
        nil_ls.enable = true;
      }
    ];

    keymaps = {
      # Diagnostic keymaps
      diagnostic = {
        "<leader>q" = {
          mode = "n";
          action = "setloclist";
          desc = "Open diagnostic [Q]uickfix list";
        };
      };

      extra = [
        # Find references for the word under your cursor.
        {
          mode = "n";
          key = "grr";
          action.__raw = "require('telescope.builtin').lsp_references";
          options = {
            desc = "LSP: [G]oto [R]eferences";
          };
        }
        # Jump to the implementation of the word under your cursor.
        #  Useful when your language has ways of declaring types without an actual implementation.
        {
          mode = "n";
          key = "gri";
          action.__raw = "require('telescope.builtin').lsp_implementations";
          options = {
            desc = "LSP: [G]oto [I]mplementation";
          };
        }
        # Jump to the definition of the word under your cursor.
        #  This is where a variable was first declared, or where a function is defined, etc.
        #  To jump back, press <C-t>.
        {
          mode = "n";
          key = "grd";
          action.__raw = "require('telescope.builtin').lsp_definitions";
          options = {
            desc = "LSP: [G]oto [D]efinition";
          };
        }
        # Fuzzy find all the symbols in your current document.
        #  Symbols are things like variables, functions, types, etc.
        {
          mode = "n";
          key = "gO";
          action.__raw = "require('telescope.builtin').lsp_document_symbols";
          options = {
            desc = "LSP: Open Document Symbols";
          };
        }
        # Fuzzy find all the symbols in your current workspace.
        #  Similar to document symbols, except searches over your entire project.
        {
          mode = "n";
          key = "gW";
          action.__raw = "require('telescope.builtin').lsp_dynamic_workspace_symbols";
          options = {
            desc = "LSP: Open Workspace Symbols";
          };
        }
        # Jump to the type of the word under your cursor.
        #  Useful when you're not sure what type a variable is and you want to see
        #  the definition of its *type*, not where it was *defined*.
        {
          mode = "n";
          key = "grt";
          action.__raw = "require('telescope.builtin').lsp_type_definitions";
          options = {
            desc = "LSP: [G]oto [T]ype Definition";
          };
        }
      ];

      lspBuf = {
        # Rename the variable under your cursor.
        #  Most Language Servers support renaming across files, etc.
        "grn" = {
          action = "rename";
          desc = "LSP: [R]e[n]ame";
        };
        # Execute a code action, usually your cursor needs to be on top of an error
        # or a suggestion from your LSP for this to activate.
        "gra" = {
          mode = [
            "n"
            "x"
          ];
          action = "code_action";
          desc = "LSP: [G]oto Code [A]ction";
        };
        # WARN: This is not Goto Definition, this is Goto Declaration.
        #  For example, in C this would take you to the header.
        "grD" = {
          action = "declaration";
          desc = "LSP: [G]oto [D]eclaration";
        };
      };
    };

    # LSP servers and clients are able to communicate to each other what features they support.
    #  By default, Neovim doesn't support everything that is in the LSP specification.
    # NOTE: This is done automatically by Nixvim when enabling blink.cmp
    #  Below is an example if you did want to add new capabilities
    #capabilities = ''
    #  require('blink.cmp').get_lsp_capabilities()
    #'';

    # This function gets run when an LSP attaches to a particular buffer.
    #   That is to say, every time a new file is opened that is associated with
    #   an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    #   function will be executed to configure the current buffer
    # NOTE: This is an example of an attribute that takes raw lua
    onAttach = ''
      -- NOTE: Remember that Lua is a real programming language, and as such it is possible
      -- to define small helper and utility functions so you don't have to repeat yourself.
      --
      -- In this case, we create a function that lets us more easily define mappings specific
      -- for LSP related items. It sets the mode, buffer and description for us each time.
      local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
      end

      -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
      ---@param client vim.lsp.Client
      ---@param method vim.lsp.protocol.Method
      ---@param bufnr? integer some lsp support methods only in specific files
      ---@return boolean
      local function client_supports_method(client, method, bufnr)
        if vim.fn.has 'nvim-0.11' == 1 then
          return client:supports_method(method, bufnr)
        else
          return client.supports_method(method, { bufnr = bufnr })
        end
      end

      -- The following two autocommands are used to highlight references of the
      -- word under your cursor when your cursor rests there for a little while.
      --    See `:help CursorHold` for information about when this is executed
      --
      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
          end,
        })
      end

      -- The following code creates a keymap to toggle inlay hints in your
      -- code, if the language server you are using supports them
      --
      -- This may be unwanted, since they displace some of your code
      if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
        map('<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        end, '[T]oggle Inlay [H]ints')
      end
    '';
  };
}
