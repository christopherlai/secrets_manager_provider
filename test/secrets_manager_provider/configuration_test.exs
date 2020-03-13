defmodule SecretsManagerProvider.ConfigurationTest do
  use ExUnit.Case, async: true
  alias SecretsManagerProvider.Configuration

  describe "new/0" do
    test "returns Configuration struct with default" do
      config = Configuration.new()

      assert config.client == SecretsManagerProvider.ExAwsClient
      assert config.parser == Toml
    end
  end
end
