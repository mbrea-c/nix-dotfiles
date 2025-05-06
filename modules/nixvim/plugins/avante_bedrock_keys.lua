local function makeBedrockKeys()
  local profile = "default"
  local credentials = vim
      .system(
        { "aws", "configure", "export-credentials", "--profile", profile },
        { text = true }
      )
      :wait()
  if credentials.code ~= 0 then
    vim.notify(vim.trim(credentials.stderr), vim.log.levels.ERROR)
    return
  end
  local cred_data = vim.json.decode(credentials.stdout)
  -- local region = vim
  --     .system(
  --       { "aws", "configure", "get", "region", "--profile", profile },
  --       { text = true }
  --     )
  --     :wait()
  -- if region.code ~= 0 then
  --   vim.notify(vim.trim(region.stderr), vim.log.levels.ERROR)
  --   return
  -- end
  -- local region_text = vim.trim(region.stdout)
  local region_text = "us-east-1"
  local bedrock_keys = table.concat({
    cred_data.AccessKeyId,
    cred_data.SecretAccessKey,
    region_text,
    cred_data.SessionToken,
  }, ",")
  vim.env.BEDROCK_KEYS = bedrock_keys
  vim.notify(
    string.format(
      "BEDROCK_KEYS set for profile %s in region %s",
      profile,
      region_text
    ),
    vim.log.levels.INFO
  )
end

vim.api.nvim_create_user_command("BedrockKeys", makeBedrockKeys, {
  desc = "Set AWS Bedrock credentials from AWS profile",
  nargs = "?",
  complete = function()
    -- You could implement AWS profile completion here if needed
    return {}
  end,
})
