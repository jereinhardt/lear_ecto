defmodule LearEcto.Event do
  @moduledoc """
  Provides an Ecto schema for Lear events.
  """
  
  use Ecto.Schema

  import Ecto.Changeset

  alias LearEcto.Session

  schema "lear_events" do
    field :name, :string
    field :properties, :map

    belongs_to :session, Session

    timestamps()
  end

  def changeset(event, attrs) do
    cast(event, attrs, [:name, :properties])
    |> validate_required([:name])
  end
end