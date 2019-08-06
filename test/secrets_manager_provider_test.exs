defmodule SecretsManagerProviderTest do
  use ExUnit.Case, async: true

  import Mox

  setup :verify_on_exit!

  describe "init/1" do
    test "returns the given path" do
      assert SecretsManagerProvider.init("/path/to") == "/path/to"
    end
  end

  describe "load/2 with TOML" do
    setup do
      Application.put_env(:secrets_manager_provider, :client, SecretsManagerProvider.MockClient)
      Application.put_env(:secrets_manager_provider, :parser, Toml)

      SecretsManagerProvider.MockClient
      |> expect(:get_secrets, fn _path ->
        """
        [toplevel]
        sublevel = "config"
        """
      end)

      expected = [toplevel: [sublevel: "config"]]

      {:ok, %{expected: expected}}
    end

    test "returns keyword configurations", %{expected: expected} do
      assert SecretsManagerProvider.load([], "") == expected
    end

    test "returns merged keyword configurations", %{expected: expected} do
      assert SecretsManagerProvider.load([toplevel: [sublevel: false]], "") == expected
    end
  end

  describe "load/2 with JSON" do
    setup do
      Application.put_env(:secrets_manager_provider, :client, SecretsManagerProvider.MockClient)
      Application.put_env(:secrets_manager_provider, :parser, Jason)

      SecretsManagerProvider.MockClient
      |> expect(:get_secrets, fn _path ->
        """
        {"toplevel": {
          "sublevel": "config"
          }
        }
        """
      end)

      expected = [toplevel: [sublevel: "config"]]

      {:ok, %{expected: expected}}
    end

    test "returns keyword configurations", %{expected: expected} do
      assert SecretsManagerProvider.load([], "") == expected
    end

    test "returns merged keyword configurations", %{expected: expected} do
      assert SecretsManagerProvider.load([toplevel: [sublevel: false]], "") == expected
    end
  end
end
