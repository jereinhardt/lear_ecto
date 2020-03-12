defmodule LearEcto.MixProject do
  use Mix.Project

  @db_envs [:dev, :test]

  def project do
    [
      app: :lear_ecto,
      version: "0.1.0",
      elixir: "~> 1.8",
      elixirc_paths: elixirc_paths(Mix.env),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: mod(Mix.env)
    ]
  end

  defp deps do
    [
      {:lear, path: "../lear"},
      {:ecto, "~> 3.3"},
      {:ecto_sql, "~> 3.0", only: @db_envs},
      {:postgrex, ">= 0.0.0", only: @db_envs},
      {:jason, "~> 1.1", only: @db_envs}
    ]
  end

  defp elixirc_paths(env) when env in @db_envs, do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp mod(env) when env in @db_envs do
    {LearEcto.TestApplication, []}
  end
  defp mod(_), do: []
end
