defmodule MoodboxWeb.DescriptionLive do
  use MoodboxWeb, :live_view

  def mount(params, _session, socket) do
    mood = params["mood"]
    intensity = params["intensity"]
    texture = params["texture"]
    location = params["location"]

    outcomes = choose_outcome(mood, intensity |> String.to_integer())

    {:ok, socket
      |> assign(mood: mood)
      |> assign(intensity: intensity)
      |> assign(texture: texture)
      |> assign(location: location)
      |> assign(outcomes: outcomes)
    }
  end

  def render(assigns) do
    ~H"""
    <p>Description page</p>
    <div>Current mood: <%= @mood %></div>
    <div>Intensity: <%= @intensity %></div>
    <div>Texture: <%= @texture %></div>
    <div>Location: <%= @location %></div>

    <div>
      <%= for outcome <- @outcomes do %>
        <div class="sm:w-1/2 md:w-1/4 p-5">
          <.link patch={~p"/moods/#{@mood}/#{@intensity}/#{@texture}/#{@location}/#{outcome.resource}"}>
            <%= outcome.name %>
          </.link>
        </div>
      <% end %>
    </div>
    """
  end

  defp choose_outcome(mood, intensity) do
    case {mood, intensity} do
      {"angry", intensity} when intensity <= 3 -> anger_low()
      {"angry", intensity} when intensity >= 4 and intensity <= 7 -> anger_mid()
      # {"angry", "high"} -> anger_high()
      # {"sad", "low"} -> sadness_low()
      # {"sad", "mid"} -> sadness_mid()
      # {"sad", "high"} -> sadness_high()
    end
  end

  defp anger_low do
    [
      %{
        name: "Irritated",
        description: "Feeling mildly angry or annoyed.",
        resource: "irritated",
      },
      %{
        name: "Annoyed",
        description: "Feeling very annoyed.",
        resource: "annoyed",
      },
      %{
        name: "Agitated",
        description: "Feeling agitated or irritated.",
        resource: "agitated",
      },
      %{
        name: "Frustrated",
        description: "Feeling frustrated.",
        resource: "frustrated",
      },
      %{
        name: "Impatient",
        description: "Feeling impatient.",
        resource: "impatient",
      }
    ]
  end

  defp anger_mid do
    [
      %{
        name: "Offended",
        description: "Feeling very offended.",
        resource: "offended",
      },
      %{
        name: "Resentful",
        description: "",
        resource: "resentful",
      },
      %{
        name: "Hostile",
        description: "",
        resource: "hostile",
      },
      %{
        name: "Angry",
        description: "",
        resource: "angry",
      },
      %{
        name: "Exasperated",
        description: "",
        resource: "exasperated",
      },
    ]
  end
end
