-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
lvim.keys.normal_mode["<S-h>"] = ":bprevious<CR>"
lvim.keys.normal_mode["<S-l>"] = ":bnext<CR>"
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
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  }
}
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

vim.keymap.set('t', '<C-n>', '<C-\\><C-n>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>', { noremap = true, silent = true })
