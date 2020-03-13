# SecretsManagerProvider
Secrets Manager Provider is an Elixir Release provider that loads runtime configurations from [AWS Secrets Manager](https://aws.amazon.com/secrets-manager/).

## Installation
Add `secrets_manager_provider` to your `deps/0` in your `mix.exs` file. A TOML (`toml`) or JSON (`jason`) library will also need to be included. This can be any library, as long as it implements `decode!/1`. 

```elixir
defp deps do
  {:secrets_manager_provider, "~> 0.5"},
  {:toml, "~> 0.6"}
end
```

## Configuration
### Elixir
`toml` is the default parser library used by Secrets Manager Provider. Feel free to swap this out with a library of your choice.

```elixir
config :secrets_manager_provider, :parser, Jason
```

### AWS
[ExAws](https://hexdocs.pm/ex_aws/ExAws.html) is the default client used to get secrets from AWS Secrets Manager. Configuration options for `ExAws` can be found [here](https://hexdocs.pm/ex_aws/ExAws.html#module-aws-key-configuration).

The action `secretsmanager:GetSecretValue` must be added to your IAM Role or User. Below is an example of this policy:
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid" : "Stmt2GetSecretValue",  
            "Effect": "Allow",
            "Action": [ "secretsmanager:GetSecretValue" ],
            "Resource": "arn:aws:secretsmanager:<region>:<account_id>:secret:<secret-name>",
            "Condition" : { 
                "ForAnyValue:StringLike" : {
                    "secretsmanager:VersionStage" : "AWSCURRENT" 
                } 
            }
        }
    ]
}
```

## Usage
Add the following to your `mix.exs` configuration. In this example, the name of the app is `:example`.

```elixir
def project do
  [
    app: :example,
    ...
    releases: [ 
      example: [
        config_providers: [{SecretsManagerProvider, {:name, "name"}]
      ]
    ]
  ]
end
```

The name of the secret sorted in AWS Secrets Manager can provided in in two ways.
1. Provide the name directly in the release configurations by using the tuple `{:name, "secret/name"}` for the provider.
2. Provide the name of a ENV variable where the secret name can be found, `{:env, "secret/name"}`. This option is useful when your release is run in different environments. Make sure the ENV variable is set on the machine or container before starting the release.

You can store your runtime configurations in AWS Secrets Manager in any format. Below are two examples with TOML and JSON.
### Toml  (Default)
```toml
[example]
somekey = "key"

[example."Example.Repo"]
url = "ecto://postgres:postgres@localhost/example_dev"
```

### JSON
```json
{
  "example": {
      "Example.Repo": { "url": "ecto://postgres:postgres@localhost/example_dev"}
  }
}
```

The keys are converted to atoms, and the result are merged with existing configs.

## Code Status
[![Build Status](#)(https://travis-ci.org/christopherlai/secrets_manager_provider.svg?branch=master)](https://travis-ci.org/christopherlai/secrets_manager_provider)
[![Hex pm](#)(https://img.shields.io/hexpm/v/secrets_manager_provider.svg?style=flat)](https://hex.pm/packages/secrets_manager_provider)

## License
The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
