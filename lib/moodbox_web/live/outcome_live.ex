defmodule MoodboxWeb.OutcomeLive do
  use MoodboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <p>Outcome page</p>
    """
  end
end
