defmodule MoodboxWeb.LocationLive do
  use MoodboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(locations: locations())}
  end

  def handle_params(_params, uri, socket) do
    {:noreply, assign(socket, :current_path, uri)}
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
            patch={@current_path <> "/#{location.resource}"}
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
        phx-mounted={
          JS.transition({"ease-out duration-1000", "translate-y-[35%]", "translate-y-[20%]"})
        }
        class="absolute translate-y-[35%] z-10 bottom-0 sm:right-10 right-4 w-32 lg:w-56 transform transition-transform"
        src="https://moodbox.fly.storage.tigris.dev/right-flower.webp"
      />

      <img
        phx-mounted={
          JS.transition({"ease-out duration-1000", "translate-y-[35%]", "translate-y-[20%]"})
        }
        class="absolute translate-y-[35%] z-10 bottom-0 left-4 sm:left-10 w-32 lg:w-56 transform transition-transform"
        src="https://moodbox.fly.storage.tigris.dev/left-flower.webp"
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
