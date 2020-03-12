defmodule LearEcto.TestRepo do
  use Ecto.Repo,
    otp_app: :lear_ecto,
    adapter: Ecto.Adapters.Postgres

  @moduledoc false
end