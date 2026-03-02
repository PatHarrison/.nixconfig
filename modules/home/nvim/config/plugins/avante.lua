require('avante').setup({
  provider = "ollama",
  providers = {
    ollama = {
      model = "qwen2.5-coder:latest",
      is_env_set = require("avante.providers.ollama").check_endpoint_alive,
    },
  },
  system_prompt = [[
You are an expert Python dev specialising in:
- Geospatial analysis
- Data engineering with SQL database normalization design
- ETL pipeline design
- Writing clean, typed Python with proper docstrings
When suggesting code:
- Always use type hints
- Follow PEP8
- Use minimal commenting and NO EMOJIS
  ]],
  behaviour = {
    auto_suggestions = false,
    auto_set_highlight_group = true,
    auto_set_keymaps = true,
    auto_apply_diff_after_generation = false,
    support_paste_from_clipboard = false,
    use_codeblock_detection = true,
    auto_tool_call = false,
  },
  mappings = {
    ask = "<leader>aa",
    edit = "<leader>ae",
    refresh = "<leader>ar",
    diff = {
      ours = "co",
      theirs = "ct",
      none = "c0",
      both = "cb",
      next = "]x",
      prev = "[x",
    },
    jump = {
      next = "]]",
      prev = "[[",
    },
    submit = {
      normal = "<CR>",
      insert = "<C-s>",
    },
    clear = "<leader>ac"
  windows = {
    position = "right",
    wrap = true,
    width = 30,
    sidebar_header = {
      align = "center",
      rounded = true,
    },
  },
})
