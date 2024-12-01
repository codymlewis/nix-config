{ pkgs, ... }:

{
    programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;

        plugins = with pkgs.vimPlugins; [
            nvim-lspconfig
            marks-nvim
            nvim-comment
            vim-airline
            vim-gitgutter
            nvim-autopairs
            indentLine
            nvim-cmp
            cmp-nvim-lsp
            cmp-nvim-lsp-signature-help
            cmp-path
            cmp-cmdline
            cmp-buffer
            molokai
        ];

        extraLuaConfig = ''
            vim.o.history = 500
            vim.o.autoread = true
            vim.api.nvim_create_autocmd({'FocusGained', 'BufEnter'}, {
                pattern = { '*' },
                callback = function()
                    vim.api.nvim_command [[checktime]]
                end,
                group = vim.api.nvim_create_augroup("Detect file changes", { clear = true }),
            })

            vim.o.smartcase = true
            vim.o.hlsearch = true
            vim.o.incsearch = true
            vim.o.magic = true
            vim.o.wildmenu = true
            vim.o.background = 'dark'
            vim.o.encoding = 'utf8'
            vim.o.swapfile = false
            vim.o.title = true

            vim.wo.number = true
            vim.wo.lbr = true
            vim.wo.wrap = true

            vim.bo.tabstop = 8
            vim.bo.softtabstop = 4
            vim.bo.shiftwidth = 4
            vim.bo.expandtab = true
            vim.bo.autoindent = true
            vim.bo.undofile = true

            vim.g.netrw_liststyle = 3
            vim.g.netrw_banner = 0

            vim.opt.clipboard = 'unnamedplus'

            vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
                pattern = { '*.tex', '*.bib', '*.md', '*.txt' },
                callback = function()
                    vim.opt_local.spell = true
                end,
                group = vim.api.nvim_create_augroup("Enable spell checking", { clear = true }),
            })

            vim.api.nvim_create_autocmd('BufWritePre', {
                pattern = { '*' },
                callback = function()
                    vim.api.nvim_command [[%s/\s\+$//e]]
                end,
                group = vim.api.nvim_create_augroup("Clean trailing spaces", { clear = true }),
            })

            vim.api.nvim_create_autocmd({'BufLeave', 'FocusLost'}, {
                pattern = { '*' },
                callback = function()
                    vim.api.nvim_command [[write]]
                end,
                group = vim.api.nvim_create_augroup("Autosave buffer", { clear = true }),
            })

            vim.api.nvim_set_keymap('n', '<Space>', "", {})
            vim.g.mapleader = ' '

            options = { noremap = true }
            vim.api.nvim_set_keymap('n', '<leader>s', ':setlocal spell!<cr>', options)
            vim.api.nvim_set_keymap('n', '<leader>p', ':set paste!<cr>', options)
            vim.api.nvim_set_keymap('n', '<leader>e', ':Explore<cr>', options)
            vim.api.nvim_set_keymap('n', '<s-tab>', ':bprevious<cr>', options)
            vim.api.nvim_set_keymap('n', '<tab>', ':bnext<cr>', options)

            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },

                sources = {
                    { name = "nvim_lsp" },
                    { name = 'nvim_lsp_signature_help' },
                    { name = "buffer" },
                },

                mapping = {
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                },

                preselect = cmp.PreselectMode.None,

                completion = {
                    compteopt = vim.o.completeopt,
                },
            })

            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            require("lspconfig").nil_ls.setup{ capabilities = capabilities, }
            require("lspconfig").ruff.setup{ capabilities = capabilities, }
            require("lspconfig").pyright.setup{ capabilities = capabilities, }
            require("lspconfig").rust_analyzer.setup{ capabilities = capabilities, }

            require('marks').setup()

            require('nvim_comment').setup()
            vim.api.nvim_set_keymap('n', ';', ':CommentToggle<cr>', options)
            vim.api.nvim_set_keymap('v', ';', ':CommentToggle<cr>', options)

            require('nvim-autopairs').setup()

            vim.g.indentLine_char_list = [[|]]
            vim.g.tex_conceal = ""
            vim.g.gitgutter_enabled = 1

            vim.api.nvim_command [[colorscheme molokai]]
        '';
    };

}
