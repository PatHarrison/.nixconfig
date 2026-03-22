local capabilities = require('cmp_nvim_lsp').default_capabilities()
local servers = { 'nil_ls', 'pyright', 'rust_analyzer', 'ts_ls', 'sqlls' }

for _, lsp in ipairs(servers) do
  vim.lsp.enable(lsp, {
    capabilities = capabilities,
  })
end
