defmodule MoodboxWeb.ClassicalPlaylistLive do
  use MoodboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Classical Playlist page</h1>
    """
  end
end
