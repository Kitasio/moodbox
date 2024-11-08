defmodule MoodboxWeb.IntensityLive do
  use MoodboxWeb, :live_view

  def mount(params, _session, socket) do
    mood = params["mood"] || "angry"
    socket = assign(socket, :mood, mood)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <p>Intensity page</p>
    <div>Current mood: <%= @mood %></div>
    <div :for={i <- 1..10}>
      <.link patch={~p"/moods/#{@mood}/#{i}"} class="text-3xl">
        <%= i %>
      </.link>
    </div>
    """
  end
end
