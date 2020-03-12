defmodule LearEcto.TestApplication do
  use Application

  @moduledoc false

  def start(_type, _args) do
    import Supervisor.Spec
    children = [
      supervisor(LearEcto.TestRepo, [])
    ]

    opts = [strategy: :one_for_one, name: LearEcto.Supervisor]
    Supervisor.start_link(children, opts)
  end
end