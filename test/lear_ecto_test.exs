defmodule LearEctoTest do
  use ExUnit.Case, async: true
  doctest LearEcto

  alias LearEcto.Event
  alias LearEcto.Session
  alias LearEcto.TestRepo, as: Repo

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  test "save_event/3" do
    {res, event} =
      create_session()
      |> Map.get(:id)
      |> LearEcto.save_event("request", %{})

    assert res == :ok
    assert is_event(event)
  end

  test "save_session/2" do
    {res, session} = LearEcto.save_session(1, %{})

    assert res == :ok
    assert is_session(session)
  end

  describe "get_event/1" do
    test "returns the event when it exists" do
      event = create_event("request")

      result = LearEcto.get_event(event.id)

      assert result == event
    end

    test "returns nil when event doesn't exist" do
      result = LearEcto.get_event(1)

      assert is_nil(result)
    end
  end

  describe "get_session/1" do
    test "returns the session when it exists" do
      session = create_session()

      result = LearEcto.get_session(session.id)

      assert session == result
    end

    test "returns nil when session doesn't exist" do
      result = LearEcto.get_session(1)

      assert is_nil(result)
    end
  end

  test "update_session/2" do
    session = create_session(%{os: "mac"})

    {res, session} = LearEcto.update_session(session, %{os: "windows"})

    assert res == :ok
    assert session.os == "windows"
  end

  defp create_session(attrs \\ %{}) do
    {:ok, session} =
      %Session{}
      |> Session.changeset(attrs)
      |> Repo.insert()
  
    session
  end

  defp create_event(session, name) do
    {:ok, event} =
      session
      |> Ecto.build_assoc(:events)
      |> Event.changeset(%{name: name})
      |> Repo.insert()

    event
  end

  defp create_event(name) do
    create_session()
    |> create_event(name)
  end

  defp is_event(%Event{}), do: true
  defp is_event(_), do: false

  defp is_session(%Session{}), do: true
  defp is_session(_), do: false
end
