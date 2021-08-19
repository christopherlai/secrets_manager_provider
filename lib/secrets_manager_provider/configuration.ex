defmodule SecretsManagerProvider.Configuration do
  @moduledoc """
  Struct for managing configurations like :client and :parser.
  """

  @type args :: [{atom(), any()}]
  @type t :: %__MODULE__{
          client: module(),
          name: String.t(),
          parser: module()
        }

  defstruct client: SecretsManagerProvider.ExAwsClient,
            name: nil,
            parser: Toml

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
