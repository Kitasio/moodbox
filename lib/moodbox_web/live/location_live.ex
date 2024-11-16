defmodule MoodboxWeb.LocationLive do
  use MoodboxWeb, :live_view

  def mount(params, _session, socket) do
    mood = params["mood"]
    intensity = params["intensity"]
    texture = params["texture"]

    {:ok,
     socket
     |> assign(mood: mood)
     |> assign(intensity: intensity)
     |> assign(texture: texture)
     |> assign(locations: locations())}
  end

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <p>Location page</p>
        <div>Current mood: <%= @mood %></div>
        <div>Intensity: <%= @intensity %></div>
        <div>Texture: <%= @texture %></div>

        <div :for={location <- @locations} class="sm:w-1/2 md:w-1/4 p-5">
          <.link patch={~p"/moods/#{@mood}/#{@intensity}/#{@texture}/#{location.resource}"}>
            <%= location.name %>
          </.link>
        </div>
      </.centered_block>

      <img
        class="absolute inset-0 h-full w-full object-cover z-0"
        src="https://ik.imagekit.io/soulgenesis/Moodinabox/bg-base.webp"
      />

      <img
        phx-mounted={JS.transition({"ease-out duration-1000", "translate-y-2/4", "translate-y-1/4"})}
        class="absolute translate-y-2/4 z-10 bottom-0 sm:right-10 right-4 w-32 lg:w-56 transform transition-transform"
        src="https://ik.imagekit.io/soulgenesis/Moodinabox/right-flower.webp"
      />

      <img
        phx-mounted={JS.transition({"ease-out duration-1000", "translate-y-2/4", "translate-y-1/4"})}
        class="absolute translate-y-2/4 z-10 bottom-0 left-4 sm:left-10 w-32 lg:w-56 transform transition-transform"
        src="https://ik.imagekit.io/soulgenesis/Moodinabox/left-flower.webp"
      />
    </.container>
    """
  end

  defp locations do
    [
      %{
        name: "Head",
        resource: "head"
      },
      %{
        name: "Chest",
        resource: "chest"
      },
      %{
        name: "Stomach",
        resource: "stomach"
      },
      %{
        name: "Hand and Feet",
        resource: "hand-feet"
      },
      %{
        name: "All over",
        resource: "all"
      }
    ]
  end
end
