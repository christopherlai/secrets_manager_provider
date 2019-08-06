# SecretsManagerProvider

AWS Secrets Manager ConfigProvider for Elixir Releases.

## Installation
The package can be installed by adding `secrets_manager_provider` to your list of dependencies in `mix.exs` along with `toml` or `jason`.

```elixir
defp deps do
  {:secrets_manager_provider, "~> 0.0.0"},
  {:toml, "~> 0.0.0"}
end
```

## Configuration
`toml` is used as the default parser, the parser can be configured to use any
parser that responds to `decode!/1`

```elixir
config :secrets_manager_provider, :parser, Jason
```

## Code Status
[![Build Status](https://travis-ci.org/christopherlai/secrets_manager_provider.svg?branch=master)](https://travis-ci.org/christopherlai/secrets_manager_provider)[![Hex pm](https://img.shields.io/hexpm/v/secrets_manager_provider.svg?style=flat)](https://hex.pm/packages/secrets_manager_provider)

## License

The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
