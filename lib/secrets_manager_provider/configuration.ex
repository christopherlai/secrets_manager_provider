defmodule SecretsManagerProvider.Configuration do
  @moduledoc """
  Struct for managing configurations like :client and :parser.
  """

  @type args :: [{atom(), any()}]
  @type t :: %__MODULE__{
          aws_client: module(),
          http_client: module(),
          name: String.t(),
          decoder: module()
        }

  defstruct aws_client: SecretsManagerProvider.ExAwsClient,
            http_client: SecretsManagerProvider.HackneyClient,
            name: nil,
            decoder: Toml

  @doc """
  Returns a new `Configuration` struct with defaults.
  """
  @spec new(args()) :: t()
  def new(args) do
    fields = Enum.into(args, %{}, &maybe_get_env/1)
    struct!(__MODULE__, fields)
  end

  @spec maybe_get_env(args()) :: args()
  def maybe_get_env({:name, {:system, env}}), do: {:name, System.get_env(env)}
  def maybe_get_env(field), do: field
end
