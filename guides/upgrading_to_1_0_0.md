# Upgrading From 0.6.x

Version 1.0.0 introduces a large number of improvements and breaking changes.

## What's New
1. Custom HTTP Client
  The default HTTP Client used by this library is `hackney`. You might not want to bring in `hackney` just for this library. With the release of `1.0.0`, you can pass in the name of a module that implements the `SecretsManagerProvider.HttpClient` behaviour via the `http_client` key.
  ```elixir
  config_providers: [{SecretsManagerProvider, [{:http_client, MyApp.HttpClient}]]
  ```
2. Custom AWS Client
  The default AWS Client used by this library is `SecretsManagerProvider.ExAwsClient`. This module simply wraps `ExAws`. With the release of `1.0.0`, you can pass in the name of a module that implements the `SecretsManagerProvider.AwsClient` behaviour via the `aws_client` key.
  ```elixir
  config_providers: [{SecretsManagerProvider, [{:aws_client, MyApp.AwsClient}]]
  ```
3. Transform
  List of maps are now transformed to keyword list.
  This:
  ```Elixir
  [%{secret: "foo"}, %{secret: "bar"}]
  ```
  Is transformed to:
  ```Elixir
  [[secret: "foo"], [secret: "bar"]]
  ```
