defmodule SecretsManagerProvider.Configuration do
  @moduledoc """
  Struct for managing configurations like :client and :parser.
  """

  @type t :: %__MODULE__{
          client: module(),
          parser: module()
        }

  defstruct client: SecretsManagerProvider.ExAwsClient,
            parser: Toml

  @doc """
  Returns a new `Configuration` struct with defaults.
  """
  @spec new :: t()
  def new do
    fields = Application.get_all_env(:secrets_manager_provider)

    struct(__MODULE__, fields)
  end
end
