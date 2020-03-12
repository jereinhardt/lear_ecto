defmodule LearEcto.Session do
  @moduledoc """
  Provides an Ecto schema for Lear sessions.
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias LearEcto.Event

  schema "lear_sessions" do
    field :browser, :string
    field :browser_version, :string
    field :device_type, :string
    field :ip, :string
    field :landing_page, :string
    field :os, :string
    field :os_version, :string
    field :user_agent, :string
    field :utm_campaign, :string
    field :utm_content, :string
    field :utm_medium, :string
    field :utm_source, :string
    field :utm_term, :string
    field :properties, :map
    field :user_id, :integer

    has_many :events, Event

    timestamps()
  end

  def changeset(session, attrs) do
    cast(session, attrs,[
      :browser,
      :browser_version,
      :device_type,
      :ip,
      :landing_page,
      :os,
      :os_version,
      :user_agent,
      :utm_campaign,
      :utm_content,
      :utm_medium,
      :utm_source,
      :utm_term,
      :properties,
      :user_id    
    ])
  end
end