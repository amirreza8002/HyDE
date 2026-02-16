-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here
-- Optional: Only required if you need to update the language server settings
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
