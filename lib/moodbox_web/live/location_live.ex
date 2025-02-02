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
    <.container class="overflow-hidden">
      <.centered_block>
        <.subheading>
          Where do you feel it in your body?
        </.subheading>

        <div class="mt-10 lg:mt-20">
          <.link
            :for={location <- @locations}
            patch={~p"/moods/#{@mood}/#{@intensity}/#{@texture}/#{location.resource}"}
            class="mt-10 flex w-44 sm:w-96"
          >
            <.btn class="transition hover:scale-105">
              <%= location.name %>
            </.btn>
          </.link>
        </div>
      </.centered_block>

      <.base_bg />

      <img
        phx-mounted={JS.transition({"ease-out duration-1000", "translate-y-[20%]", "translate-y-[10%]"})}
        class="absolute translate-y-[20%] z-10 bottom-0 sm:right-10 right-4 w-32 lg:w-56 transform transition-transform"
        src="https://ik.imagekit.io/soulgenesis/Moodinabox/right-flower.webp"
      />

      <img
        phx-mounted={JS.transition({"ease-out duration-1000", "translate-y-[20%]", "translate-y-[10%]"})}
        class="absolute translate-y-[20%] z-10 bottom-0 left-4 sm:left-10 w-32 lg:w-56 transform transition-transform"
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
