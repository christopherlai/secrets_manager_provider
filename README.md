# SecretsManagerProvider

AWS Secrets Manager ConfigProvider for Elixir Releases. It provides runtime configuration by fetching a parameter upon application start from the [AWS Systems Manager Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-parameter-store.html). 

## Installation
The package can be installed by adding `secrets_manager_provider` to your list of dependencies in `mix.exs` along with `toml` or `jason`.

```elixir
defp deps do
  {:secrets_manager_provider, "~> 0.4.0"},
  {:toml, "~> 0.5.0"}
end
```

## Configuration
`toml` is used as the default parser, the parser can be configured to use any
parser that responds to `decode!/1`

```elixir
config :secrets_manager_provider, :parser, Jason
```

This library by default uses ExAws to call the AWS api's. See [AWS-key-configuration](https://github.com/ex-aws/ex_aws#aws-key-configuration) on how to configure it. Ensure that you set the right region.

The IAM-user making the api-call needs to have `ssm:GetParameter` permission on the resource.

## Adding Config Provider
Add the following to your `mix.exs` configuration. In this case the name of the app is `:example`.

```elixir
  def project do
    [
      app: :example,
      ...
      releases: [
        example: [
          config_providers: [{SecretsManagerProvider, "parameter_name"}]
        ]
      ]
    ]
  end
```
Where `parameter_name` is the name of the parameter in the AWS Parameter Store. The value of this parameter should be a string and can be in either in `toml`, `json` or another format, provided a parser can parse it.

E.g. if your application name is `:example` and you want to retrieve the database url from the parameter store, the value of the parameter would be something like:

#### Toml 
Use the default parser
```toml
[example]
  [example."Example.Repo"]
  url = "ecto://postgres:postgres@localhost/example_dev"
```

#### JSON
Set the `:parser` to Jason
```json
{
  "example": {
      "Example.Repo": { "url": "ecto://postgres:postgres@localhost/example_dev"}
  }
}
```


The string keys are converted to atoms, and the result is merged with the existing config.

### Parameter name
The name of the parameter can be provided by its path: 
```elixir
config_providers: [{SecretsManagerProvider, "parameter_name"}]
# or equivalently 
config_providers: [{SecretsManagerProvider, {:path, "parameter_name"}}].
``` 

Alternatively, it can also be provided by an environment variable:

```elixir
config_providers: [{SecretsManagerProvider, {:env, "PARAM_NAME"}}]
```

## Code Status
[![Build Status](https://travis-ci.org/christopherlai/secrets_manager_provider.svg?branch=master)](https://travis-ci.org/christopherlai/secrets_manager_provider)
[![Hex pm](https://img.shields.io/hexpm/v/secrets_manager_provider.svg?style=flat)](https://hex.pm/packages/secrets_manager_provider)

## License

The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
