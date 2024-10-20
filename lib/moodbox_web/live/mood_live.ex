defmodule MoodboxWeb.MoodLive do
  use MoodboxWeb, :live_view

  def render(assigns) do
    ~H"""
    <div>Current mood: <%= @mood %></div>
    """
  end

  def mount(params, _session, socket) do
    mood = params["mood"] || "angry"
    socket = assign(socket, :mood, mood)
    IO.inspect(self(), label: "MOOD PID")
    IO.inspect(socket, label: "MOOD SOCKET")

    {:ok, socket}
  end
end
