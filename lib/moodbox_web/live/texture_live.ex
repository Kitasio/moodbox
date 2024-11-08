defmodule MoodboxWeb.TextureLive do
  use MoodboxWeb, :live_view

  def mount(params, _session, socket) do
    mood = params["mood"] || "angry"
    intensity = params["intensity"]

    {:ok, socket
      |> assign(mood: mood)
      |> assign(intensity: intensity)
      |> assign(textures: textures())
    }
  end

  def render(assigns) do
    ~H"""
    <p>Texture page</p>
    <div>Current mood: <%= @mood %></div>
    <div>Intensity: <%= @intensity %></div>

    <div :for={texture <- @textures} class="sm:w-1/2 md:w-1/4 p-5">
      <.link patch={~p"/moods/#{@mood}/#{@intensity}/#{texture.resource}"}>
        <%= texture.name %>
      </.link>
    </div>
    """
  end

  defp textures do
    [
      %{
        name: "Soft - Mushy",
        resource: "soft",
      },
      %{
        name: "Hard - Sharp",
        resource: "hard",
      },
      %{
        name: "Neither",
        resource: "neither",
      },
    ]
  end
end
