require('ollama').setup({
  model = "mistral",
  url = "http://127.0.0.1:11434",
  serve = {
    on_start = false,
    command = "ollama",
    args = { "serve" },
    stop_command = "pkill",
    stop_args = { "-SIGTERM", "ollama" },
  },
  prompts = {
    Sample_Prompt = {
      prompt = "This is a sample prompt that receives $input and $sel(ection).",
      input_label = "> ",
      model = "mistral",
      action = "display",
    }
  }
})
