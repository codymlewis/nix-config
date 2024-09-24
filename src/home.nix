{ pkgs, ... }:

{
    home.username = "cody";
    home.homeDirectory = "/home/cody";

    home.packages = [
        pkgs.strawberry
        pkgs.zotero
        pkgs.wl-clipboard
        pkgs.krita
        pkgs.nil
        pkgs.keepassxc
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
            vim.api.nvim_create_autocmd({'FocusGained', 'BufEnter'}, {
                pattern = { '*' },
                callback = function()
                    vim.api.nvim_command [[checktime]]
                end,
                group = vim.api.nvim_create_augroup("Detect file changes", { clear = true }),
            })

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

            vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
                pattern = { '*.tex', '*.md', '*.txt' },
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
            require("lspconfig").rust_analyzer.setup{}

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

    programs.firefox = {
        enable = true;
        package = pkgs.firefox.override {
            extraPolicies = {
                DisableTelemetry = true;
                DNSOverHTTPS = {
                    Enabled = true;
                    Fallback = false;
                };
                EnableTrackingProtection = true;
                HttpsOnlyMode = "force_enabled";
                PasswordManagerEnabled = false;
                PictureInPicture = {
                    Enabled = false;
                    Locked = true;
                };
                PostQuantumKeyAgreementEnabled = true;
                DisablePocket = true;
                DisableFirefoxAccounts = true;
                SearchSuggestEnabled = false;
                DisplayBookmarksToolbar = "never";
                DisplayMenuBar = "default_off";

                ExtensionSettings = {
                    "*".installation_mode = "blocked";
                    "addon@darkreader.org" = {
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
                        installation_mode = "force_installed";
                        default_area = "navbar";
                    };
                    "keepassxc-browser@keepassxc.org" = {
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
                        installation_mode = "force_installed";
                        default_area = "menupanel";
                    };
                    "uBlock0@raymondhill.net" = {
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
                        installation_mode = "force_installed";
                        default_area = "navbar";
                    };
                    "sponsorBlocker@ajay.app" = {
                        install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
                        installation_mode = "force_installed";
                        default_area = "menupanel";
                    };
                    "zotero@chnm.gmu.edu" = {
                        install_url = "https://www.zotero.org/download/connector/dl?browser=firefox&version=5.0.144";
                        installation_mode = "force_installed";
                        default_area = "navbar";
                    };
                };

                Preferences = {
                    "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
                    "extensions.pocket.enabled" = { Value = false; Status = "locked"; };
                    "extensions.screenshots.disabled" = { Value = true; Status = "locked"; };
                    "browser.newtabpage.activity-stream.showSponsored" = { Value = false; Status = "locked"; };
                    "browser.newtabpage.activity-stream.system.showSponsored" = { Value = false; Status = "locked"; };
                    "browser.newtabpage.activity-stream.showSponsoredTopSites" = { Value = false; Status = "locked"; };
                  };
            };
        };
        profiles.default.settings = {
            "browser.startup.homepage" = "about:home";
            "browser.newtabpage.pinned" = [
                {
                    label = "proton";
                    url = "https://www.proton.me";
                }
                {
                    label = "github";
                    url = "https://www.github.com";
                }
                {
                    label = "standard notes";
                    url = "https://app.standardnotes.com";
                }
                {
                    label = "outlook";
                    url = "https://outlook.office.com/mail/";
                }
                {
                    label = "overleaf";
                    url = "https://www.overleaf.com";
                }
                {
                    label = "canvas";
                    url = "https://canvas.newcastle.edu.au";
                }
                {
                    label = "youtube";
                    url = "https://www.youtube.com";
                }
                {
                    label = "twitch";
                    url = "https://twitch.tv";
                }
                {
                    label = "steam";
                    url = "https://store.steampowered.com";
                }
                {
                    label = "one piece";
                    url = "https://mangaplus.shueisha.co.jp/titles/100020";
                }
            ];
        };
        profiles.default.search = {
            force = true;
            default = "StartPage";
            privateDefault = "StartPage";
            engines = {
                "StartPage" = {
                    urls = [{ template = "https://www.startpage.com/sp/search?q={searchTerms}"; }];
                    definedAliases = [ "@sp" ];
                };

                "Nix Packages" = {
                    urls = [{ template = "https://search.nixos.org/packages?query={searchTerms}"; }];
                    definedAliases = [ "nixp" ];
                };

                "Nix Options" = {
                    urls = [{ template = "https://search.nixos.org/options?query={searchTerms}"; }];
                    definedAliases = [ "nixo" ];
                };
            };
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
