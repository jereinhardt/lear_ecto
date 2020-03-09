defmodule LearEcto.MixProject do
  use Mix.Project

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
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:lear, path: "../lear"},
      {:ecto, "~> 3.3"},
      {:ecto_sql, "~> 3.0", only: [:dev, :test]},
      {:postgrex, ">= 0.0.0", only: [:dev, :test]}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]
end
