defmodule SecretsManagerProvider.HttpClient do
  @moduledoc """
  A generic behaviour to implement Secret Manager Client for `SecretsManagerProvider`.
  """

  alias SecretsManagerProvider.Configuration

  @type http_method() :: :get | :post | :put | :delete | :options | :head

  @callback init(configuration :: Configuration.t()) :: Configuration.t()

  @callback request(
              method :: http_method(),
              url :: binary(),
              req_body :: binary(),
              headers :: [{binary(), binary()}, ...],
              http_opts :: term()
            ) ::
              {:ok, %{status_code: pos_integer(), headers: any()}}
              | {:ok, %{status_code: pos_integer(), headers: any(), body: binary()}}
              | {:error, %{reason: any()}}
end
