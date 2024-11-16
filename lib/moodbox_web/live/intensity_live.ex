defmodule MoodboxWeb.IntensityLive do
  use MoodboxWeb, :live_view

  def mount(params, _session, socket) do
    mood = params["mood"] || "angry"
    socket = assign(socket, :mood, mood)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <p>Intensity page</p>
        <div>Current mood: <%= @mood %></div>
        <div :for={i <- 1..10}>
          <.link patch={~p"/moods/#{@mood}/#{i}"} class="text-3xl">
            <%= i %>
          </.link>
        </div>
      </.centered_block>

      <img
        class="absolute inset-0 h-full w-full object-cover z-0"
        src="https://ik.imagekit.io/soulgenesis/Moodinabox/bg-base.webp"
      />

      <img
        phx-mounted={JS.transition({"ease-out duration-1000", "translate-y-full", "translate-y-3/4"})}
        class="absolute translate-y-full z-10 bottom-0 sm:right-10 right-4 w-32 lg:w-56 transform transition-transform"
        src="https://ik.imagekit.io/soulgenesis/Moodinabox/right-flower.webp"
      />

      <img
        phx-mounted={JS.transition({"ease-out duration-1000", "translate-y-full", "translate-y-3/4"})}
        class="absolute translate-y-full z-10 bottom-0 left-4 sm:left-10 w-32 lg:w-56 transform transition-transform"
        src="https://ik.imagekit.io/soulgenesis/Moodinabox/left-flower.webp"
      />
    </.container>
    """
  end
end
