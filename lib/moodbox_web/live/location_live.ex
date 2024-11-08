defmodule MoodboxWeb.LocationLive do
  use MoodboxWeb, :live_view

  def mount(params, _session, socket) do
    mood = params["mood"]
    intensity = params["intensity"]
    texture = params["texture"]

    {:ok, socket
      |> assign(mood: mood)
      |> assign(intensity: intensity)
      |> assign(texture: texture)
      |> assign(locations: locations())
    }
  end

  def render(assigns) do
    ~H"""
    <p>Location page</p>
    <div>Current mood: <%= @mood %></div>
    <div>Intensity: <%= @intensity %></div>
    <div>Texture: <%= @texture %></div>

    <div :for={location <- @locations} class="sm:w-1/2 md:w-1/4 p-5">
      <.link patch={~p"/moods/#{@mood}/#{@intensity}/#{@texture}/#{location.resource}"}>
        <%= location.name %>
      </.link>
    </div>
    """
  end

  defp locations do
    [
      %{
        name: "Head",
        resource: "head",
      },
      %{
        name: "Chest",
        resource: "chest",
      },
      %{
        name: "Stomach",
        resource: "stomach",
      },
      %{
        name: "Hand and Feet",
        resource: "hand-feet",
      },
      %{
        name: "All over",
        resource: "all",
      },
    ]
  end
end
