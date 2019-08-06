defmodule SecretsManagerProvider.SecretsManagerClient do
  @moduledoc """
  A generic behaviour to implement Secret Manager Client for `SecretsManagerProvider`.
  """

  @callback get_secrets(binary) :: binary
end
