defmodule Mix.Tasks.LearEcto.Gen.Migrations do
  use Mix.Task

  import Mix.Generator
  import Mix.Ecto, except: [parse_repo: 1]
  import Mix.EctoSQL

  @aliases [
    r: :repo
  ]

  @switches [
    repo: [:string, :keep]
  ]

  @source_name "create_lear_sessions_and_events"

  @moduledoc """
  Generates migrations to create database tables where Lear data will be saved.

  The designated repository must be under `:repo` in the current app's 
  `:lear_ecto` configuration, or given via the `-r` option.

  ## Examples

      mix lear_ecto.gen.migrations -r MyApp.Repo

  ## Command line options

    * `-r`, `--repo` - The designated repository that maps to the database where
    lear data will be saved.
  """

  @impl true
  def run(args) do
    no_umbrella!("lear_ecto.gen.migrations")
    {opts, _} = OptionParser.parse!(args, strict: @switches, aliases: @aliases)
    repo = parse_repo(opts)
    
    if repo do
      ensure_repo(repo, args)
      path = Path.join(source_repo_priv(repo), "migrations")
      base_name = "#{@source_name}.exs"
      file = Path.join(path, "#{timestamp()}_#{base_name}")
      unless File.dir?(path), do: create_directory(path)

      fuzzy_path = Path.join(path, "*_#{base_name}")
      if Path.wildcard(fuzzy_path)!= [] do
        Mix.raise "migration can't be created because there is already a migration file with the name #{@source_name}"
      end

      assigns = [mod: Module.concat([repo, Migrations, @source_name])]
      create_file file, migration_template(assigns)
    end
  end

  defp parse_repo(opts) do
    repo_from_config = Application.get_env(:lear_ecto, :repo)
    if repo = Keyword.get(opts, :repo, repo_from_config) do
      repo
    else
      Mix.shell().error """
      Could not generate migrations because no repository was give.

      To fix this, please designate a repository using the `-r` or `--repo`
      options

          mix lear_ecto.gen.migrations -r MyApp.Repo

      Or update your configuration:

          config :lear_ecto, repo: MyApp.Repo
      """
      false
    end
  end

  defp timestamp do
    {{y, m, d}, {hh, mm, ss}} = :calendar.universal_time()
    "#{y}#{pad(m)}#{pad(d)}#{pad(hh)}#{pad(mm)}#{pad(ss)}"
  end

  defp pad(i) when i < 10, do: << ?0, ?0 + i >>
  defp pad(i), do: to_string(i)

  defp migration_module do
    case Application.get_env(:ecto_sql, :migration_module, Ecto.Migration) do
      migration_module when is_atom(migration_module) -> migration_module
      other -> Mix.raise "Expected :migration_module to be a module, got: #{inspect(other)}"
    end
  end

  embed_template :migration, """
  defmodule <%= inspect @mod %> do
    use <%= inspect migration_module() %>

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
  """
end