defmodule SecretsManagerProvider.Configuration do
  def persist(config) when is_list(config) do
    for {app, app_config} <- config do
      base_config = Application.get_all_env(app)
      merged = merge_config(base_config, app_config)

      for {k, v} <- merged do
        Application.put_env(app, k, v, persistent: true)
      end
    end

    :ok
  end

  def merge_config(a, b) do
    Keyword.merge(a, b, fn _, app1, app2 ->
      Keyword.merge(app1, app2, &merge_config/3)
    end)
  end

  def merge_config(_key, val1, val2) do
    if Keyword.keyword?(val1) and Keyword.keyword?(val2) do
      Keyword.merge(val1, val2, &merge_config/3)
    else
      val2
    end
  end
end
