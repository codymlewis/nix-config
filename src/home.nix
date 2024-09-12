{ pkgs, ... }:

{
    home.username = "cody";
    home.homeDirectory = "/home/cody";

    home.packages = [
        pkgs.firefox
        pkgs.strawberry
        pkgs.zotero
        pkgs.wl-clipboard
        pkgs.krita
        pkgs.nil
    ];

    programs.fish = {
        enable = true;
        interactiveShellInit = ''
           set fish_greeting
           abbr -a -- x exit
           abbr -a -- g git
           abbr -a -- grep 'grep --color'
        '';
    };

    programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;

        plugins = [
            pkgs.vimPlugins.nvim-lspconfig
            pkgs.vimPlugins.marks-nvim
            pkgs.vimPlugins.nvim-comment
            pkgs.vimPlugins.vim-airline
            pkgs.vimPlugins.vim-gitgutter
            pkgs.vimPlugins.nvim-autopairs
            pkgs.vimPlugins.indentLine
            pkgs.vimPlugins.mini-nvim
            pkgs.vimPlugins.molokai
        ];

        extraLuaConfig = ''
            local o = vim.o
            local wo = vim.wo
            local bo = vim.bo
            local cmd = vim.cmd
            local map = vim.api.nvim_set_keymap
            local api = vim.api

            o.history = 500
            o.autoread = true
            cmd('autocmd FocusGained,BufEnter * checktime')
            
            o.smartcase = true
            o.hlsearch = true
            o.incsearch = true
            o.magic = true
            o.wildmenu = true
            o.background = 'dark'
            o.encoding = 'utf8'
            o.swapfile = false
            o.title = true

            wo.number = true
            wo.lbr = true
            wo.wrap = true

            bo.tabstop = 8
            bo.softtabstop = 4
            bo.shiftwidth = 4
            bo.expandtab = true
            bo.autoindent = true
            bo.undofile = true

            vim.g.netrw_liststyle = 3
            vim.g.netrw_banner = 0

            cmd([[
                augroup filetypedetect
                    autocmd!
                    autocmd BufRead,BufNewFile *tex setlocal spell
                    autocmd BufRead,BufNewFile *md setlocal spell
                augroup END
            ]])

            cmd([[
                augroup filewriteprocessing
                    autocmd!
                    autocmd BufWritePre * %s/\\s\\+$//e
                augroup END
            ]])

            map('n', '<Space>', "", {})
            vim.g.mapleader = ' '

            options = { noremap = true }
            map('n', '<leader>s', ':setlocal spell!<cr>', options)
            map('n', '<leader>p', ':set paste!<cr>', options)
            map('n', '<leader>e', ':Explore<cr>', options)
            map('n', '<s-tab>', ':bprevious<cr>', options)
            map('n', '<tab>', ':bnext<cr>', options)

            require("lspconfig").nil_ls.setup{}
            require("lspconfig").pylsp.setup{}

            require('mini.completion').setup()
            local imap_expr = function(lhs, rhs)
                vim.keymap.set('i', lhs, rhs, { expr = true })
            end
            imap_expr('<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
            imap_expr('<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

            require('marks').setup()

            require('nvim_comment').setup()
            map('n', ';', ':CommentToggle<cr>', options)
            map('v', ';', ':CommentToggle<cr>', options)

            require('nvim-autopairs').setup()

            vim.g.indentLine_char_list = [[|]]
            vim.g.tex_conceal = ""
            vim.g.gitgutter_enabled = 1

            api.nvim_command [[colorscheme molokai]]
        '';
    };

    programs.git = {
        enable = true;
        userName = "Cody Lewis";
        userEmail = "hello@codymlewis.com";
        signing = {
            key = null;
            signByDefault = true;
        };
        extraConfig = {
            push = { autoSetupRemote = true; };
            credential.helper = { store = true; };
            init.defaultBranch = "main";
        };
    };

    programs.mpv = {
        enable = true;
        config = {
            profile = "gpu-hq";
            hwdec = "auto";
        };
    };

    home.stateVersion = "24.05";
}
