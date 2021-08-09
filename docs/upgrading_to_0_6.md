# Upgrading From 0.5.x

Following the [Elixir Library Guidelines], since the `0.6.0` release, Secrets Manager Provider
does not rely anymore on application configuration.

After upgrading the library remove any `:secrets_manager_provider` configuration
from your config files:

```elixir
config :secrets_manager_provider, :parser, Jason

```

And add it to the release configuration:

```elixir
def project do
  [
    app: :example,
    ...
    releases: [
      example: [
        config_providers: [{SecretsManagerProvider, [{:name, Jason}]]
      ]
    ]
  ]
end
```

If you were using the ENV variable to set the secret name at runtime, you can replace:

```elixir
{:env, "SECRET_NAME"}
```

With the system tuple:

```elixir
{:name, {:system, "SECRET_NAME"}}
```

[elixir library guidelines]: https://hexdocs.pm/elixir/master/library-guidelines.html
