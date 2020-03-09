defmodule Lear.Ecto do
  @behaviour Lear.Store

  @impl Lear.Store
  def save_event(session_id, name, props) do

    {:error, nil}
  end

  @impl Lear.Store
  def save_session(user_id, props) do
    {:error, nil}
  end

  @impl Lear.Store
  def get_event(event_id) do
    nil
  end

  @impl Lear.Store
  def get_session(session_id) do
    nil
  end
end
