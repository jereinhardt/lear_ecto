defmodule :"Elixir.Lear.Ecto.TestRepo.Migrations.create_lear_sessions_and_events" do
  use Ecto.Migration

  def change do
    create table("lear_sessions") do
      add :browser,         :string
      add :browser_version, :string
      add :device_type,     :string
      add :ip,              :string
      add :landing_page,    :string
      add :os,              :string
      add :os_version,      :string
      add :user_agent,      :string
      add :utm_campaign,    :string
      add :utm_content,     :string
      add :utm_medium,      :string
      add :utm_source,      :string
      add :utm_term,        :string
      add :properties,      :map
      add :user_id,         :integer

      timestamps()
    end

    create index("lear_sessions", [:user_id])

    create table("lear_events") do
      add :name,       :string, null: false
      add :properties, :map
      add :session_id, references(:lear_sessions)

      timestamps()
    end
  end
end
