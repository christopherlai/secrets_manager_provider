defmodule SecretsManagerProviderTest do
  use ExUnit.Case, async: true
  alias SecretsManagerProvider.Configuration
  import Mox

  setup :verify_on_exit!

  setup do
    {:ok, name: "/path/to"}
  end

  describe "init/1" do
    test "returns the given path", %{name: name} do
      expected = %Configuration{
        name: name,
        aws_client: SecretsManagerProvider.ExAwsClient,
        http_client: SecretsManagerProvider.HackneyClient,
        decoder: Toml
      }

      actual = SecretsManagerProvider.init([{:name, name}])

      assert actual == expected
    end
  end

  describe "load/2 with TOML" do
    setup %{name: name} do
      configuration = %Configuration{
        name: name,
        aws_client: SecretsManagerProvider.MockAwsClient,
        http_client: SecretsManagerProvider.HackneyClient,
        decoder: Toml
      }

      SecretsManagerProvider.MockAwsClient
      |> expect(:get_secrets, fn ^configuration ->
        """
        [toplevel]
        sublevel = "config"
        """
      end)

      expected = [toplevel: [sublevel: "config"]]

      {:ok, configuration: configuration, expected: expected}
    end

    test "returns keyword configurations", %{configuration: configuration, expected: expected} do
      assert SecretsManagerProvider.load([], configuration) == expected
    end

    test "returns merged keyword configurations", %{
      configuration: configuration,
      expected: expected
    } do
      assert SecretsManagerProvider.load([toplevel: [sublevel: false]], configuration) == expected
    end
  end

  describe "load/2 with JSON" do
    setup %{name: name} do
      configuration = %Configuration{
        name: name,
        aws_client: SecretsManagerProvider.MockAwsClient,
        http_client: SecretsManagerProvider.HackneyClient,
        decoder: Jason
      }

      SecretsManagerProvider.MockAwsClient
      |> expect(:get_secrets, fn ^configuration ->
        """
        {"toplevel": {
          "sublevel": "config"
          }
        }
        """
      end)

      expected = [toplevel: [sublevel: "config"]]

      {:ok, configuration: configuration, expected: expected}
    end

    test "returns keyword configurations", %{configuration: configuration, expected: expected} do
      assert SecretsManagerProvider.load([], configuration) == expected
    end

    test "returns merged keyword configurations", %{
      configuration: configuration,
      expected: expected
    } do
      assert SecretsManagerProvider.load([toplevel: [sublevel: false]], configuration) == expected
    end
  end
end
