-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- Define a mudança de buffer em teclas
lvim.keys.normal_mode["<S-h>"] = ":bprevious<CR>"
lvim.keys.normal_mode["<S-l>"] = ":bnext<CR>"


-- Configuração do git para mostrar informações git
lvim.builtin.gitsigns.active = true
lvim.builtin.gitsigns.opts = {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '-' },
  },
  numhl = false,
  linehl = false,
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = true,
}

vim.wo.relativenumber = true


lvim.plugins = {
  -- Fazer preview de markdown
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  -- Renderizar markdown no próprio vim
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    opts = {
      latex = { enabled = false },
      win_options = { conceallevel = { rendered = 2 } },
      on = {
          render = function()
              require('nabla').enable_virt({ autogen = false })
          end,
          clear = function()
              require('nabla').disable_virt()
          end,
      },
      code = {
          width = 'block',
          left_margin = 0.5,
          left_pad = 0.2,
          right_pad = 0.2,
      },
      heading = {
          sign = false,
          position = 'inline',
          width = 'block',
          left_margin = 0.5,
          left_pad = 0.2,
          right_pad = 0.2,
      },
      paragraph = { left_margin = 0.5 },

    },
  },
  -- Renderizar LaTeX nos arquivos markdown
  {
    "jbyuki/nabla.nvim",
    lazy = true,
    dependencies = {
      "nvim-neo-tree/neo-tree.nvim",
      "williamboman/mason.nvim",
    },
  },
  -- Renderizar imagens no próprio vim
  {
    "3rd/image.nvim",
    build = false,
    opts = {
        processor = "magick_cli",
        backend = "kitty",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = true,
            only_render_image_at_cursor_mode = "popup",
            floating_windows = true,
            filetypes = { "markdown", "vimwiki" },
          },
          neorg = {
            enabled = true,
            filetypes = { "norg" },
          },
          typst = {
            enabled = true,
            filetypes = { "typst" },
          },
          html = {
            enabled = false,
          },
          css = {
            enabled = false,
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
        scale_factor = 1.0,
        window_overlap_clear_enabled = false,
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
        editor_only_render_when_focused = false,
        tmux_show_only_in_active_window = false,
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
    }
  }
}

-- Configurações do markdown preview
vim.cmd(
[[
function! OpenMarkdownPreview (url)
  let cmd = "firefox --new-window " . a:url
  silen call system(cmd)
endfunction
]]
)
vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 1
vim.g.mkdp_refresh_slow = 0
vim.g.mkdp_command_for_global = 0
vim.g.mkdp_open_to_the_world = 0
vim.g.mkdp_open_ip = "127.0.0.1"
vim.g.mkdp_browser = "firefox"
vim.g.mkdp_echo_preview_url = 0
vim.g.mkdp_browserfunc = 'OpenMarkdownPreview'
vim.g.mkdp_preview_options = {
    mkit = {},
    katex = {},
    uml = {},
    maid = {},
    disable_sync_scroll = 0,
    sync_scroll_type = 'middle',
    hide_yaml_meta = 1,
    sequence_diagrams = {},
    flowchart_diagrams = {},
    content_editable = false,
    disable_filename = 0,
    toc = {}
}
vim.g.mkdp_markdown_css = ""
vim.g.mkdp_highlight_css = ""
vim.g.mkdp_port = ""
vim.g.mkdp_page_title = '「${name}」'
vim.g.mkdp_images_path = '/home/user/.markdown_images'
vim.g.mkdp_filetypes = { "markdown" }
vim.g.mkdp_theme = 'dark'
vim.g.mkdp_combine_preview = 0
vim.g.mkdp_combine_preview_auto_refresh = 1

-- Define teclas para sair do modo de terminal
vim.keymap.set('t', '<C-n>', '<C-\\><C-n>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>', { noremap = true, silent = true })

-- Configura o grep para usar o ripgrep
vim.opt.grepprg = "rg --vimgrep"


-- Configuração de script para fazer mudanças de uma string
function replace()

  local old = vim.fn.input("Old string: ")

  if old == "" then
    print("Old string cannot be empty!")
    return
  end

  local new = vim.fn.input("New string: ")

  local folder_input = vim.fn.input("Folder: ")

  local folder = '.'

  if folder_input ~= "" then
    folder = folder_input
  end

  vim.cmd('grep "' .. old .. '" ' .. folder)

  vim.cmd('cfdo %s/' .. old .. '/' .. new .. '/g | update')

  print("Replaced!")

end
vim.api.nvim_set_keymap('n', '<M-r>', ':lua replace()<CR>', { noremap = true, silent = true })


-- Configuração do fold
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 3

-- Configuração do spellcheck nos arquivos .md
vim.opt.spell = false
vim.api.nvim_create_augroup("MarkdownSpellcheck", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "MarkdownSpellcheck",
  pattern = { "markdown", "markdown.*", "text", "gitcommit" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "pt_br"
  end,
  desc = "Enable spellcheck for defined filetypes",
})
