defmodule SecretsManagerProviderTest do
  use ExUnit.Case
  doctest SecretsManagerProvider

  test "parses secrets" do
    secrets = """
              [api.secrets]
              user1 = "mysecret"
              """

    assert SecretsManagerProvider.load_config([], secrets) == [api: [secrets: [user1: "mysecret"]]]
  end

  test "parses single key secret" do
    secrets = """
              [api]
              secret = "mysecret"
              """

    assert SecretsManagerProvider.load_config([], secrets) == [api: [secret: "mysecret"]]
  end
end
