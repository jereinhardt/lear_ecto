# LearEcto

LearEcto is a Lear-compatible data store for plug-based Elixir applications that
saves tracking data to the database.

For more information on automated data tracking with Lear, see the 
[Lear repository](https://github.com/jereinhardt/lear).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `lear_ecto` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:lear_ecto, "~> 0.1.0"}
  ]
end
```

Because Lear is a dependency of LearEcto, there is no need to include both in
your dependencies.

Make sure you have completed [the installation steps for Lear](https://github.com/jereinhardt/lear#installation)
before beginning the setup process for LearEcto.

In your Lear implementation model, make sure to designate `LearEcto` as the
store:

```elixir
defmodule MyApp.Lear do
  use Lear, store: Lear.Ecto

  # ...
end
```

You will need to update your application's configuration to indicate which
repository you would like to use to save data to your database.

In `config/config.exs`:
```elixir
config :lear_ecto, repo: MyApp.Repo
```

Once you have configured your application, you will need to generate and run 
migrations that will add Lear database tables to your database.

```
mix lear_ecto.gen.migrations
mix ecto.migrate
```

## Development

After checking out the repo, run the following to set up your test enviroment:

```
MIX_ENV=test mix ecto.create
MIX_ENV=test mix ecto.migrate
```

## Documentation

Documentation can be found at [https://hexdocs.pm/lear](https://hexdocs.pm/lear_ecto).