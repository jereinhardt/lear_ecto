defmodule LearEcto do
  @moduledoc """
  Store module for Lear that uses `Ecto` to store tracking data to the
  database.

  For more information about setting up Lear in your application, see the 
  [Lear documentation](https://github.com/jereinhardt/lear).

  ## Features

  * Provides basic API for saving tracking data to the database that complies
  to the behavior of `Lear.Store`
  * Provides mix task to generate necessary migrations

  ## Options

  Update your application's configuration to include the repository that 
  maps to the database where you would like Lear data to be saved

  ```elixir
  config :lear_ecto, repo: MyApp.Repo
  ```
  """

  alias LearEcto.Event
  alias LearEcto.Session

  @behaviour Lear.Store

  @impl Lear.Store
  def save_event(session_id, name, props) when is_binary(session_id) do
    String.to_integer(session_id)
    |> save_event(name, props)
  end

  @impl Lear.Store
  def save_event(session_id, name, props) do
    attrs = %{name: name, properties: props}
    changeset =      
      %Session{id: session_id}
      |> Ecto.build_assoc(:events)
      |> Event.changeset(attrs)

    apply(repo(), :insert, [changeset])
    |> respond_to_save()
  end

  @impl Lear.Store
  def save_session(user_id, props) when is_binary(user_id) do
    String.to_integer(user_id)
    |> save_session(props)
  end

  @impl Lear.Store
  def save_session(user_id, props) do
    attrs = Map.put(props, :user_id, user_id)
    changeset = Session.changeset(%Session{}, attrs)

    apply(repo(), :insert, [changeset])
    |> respond_to_save()
  end

  @impl Lear.Store
  def get_event(event_id) when is_binary(event_id) do
    String.to_integer(event_id)
    |> get_event()
  end

  @impl Lear.Store
  def get_event(event_id) do
    apply(repo(), :get, [Event, event_id])
  end

  @impl Lear.Store
  def get_session(session_id) when is_binary(session_id) do
    String.to_integer(session_id)
    |> get_session()
  end

  @impl Lear.Store
  def get_session(session_id) do
    apply(repo(), :get, [Session, session_id])
  end

  @impl Lear.Store
  def update_session(session, attrs) do
    changeset = Session.changeset(session, attrs)

    apply(repo(), :update, [changeset])
    |> respond_to_save()
  end

  defp repo do
    Application.fetch_env!(:lear_ecto, :repo)
  end

  defp respond_to_save(response) do
    case response do
      {:ok, record} -> {:ok, record}
      {:error, %{errors: [{attr, {message, _}}|_]}} ->
          {:error, "#{attr}: #{message}"}
    end
  end
end