defmodule MoodboxWeb.DescriptionLive do
  use MoodboxWeb, :live_view

  def mount(params, _session, socket) do
    mood = params["mood"]
    intensity = params["intensity"]
    texture = params["texture"]
    location = params["location"]

    outcomes = choose_outcome(mood, intensity |> String.to_integer())

    {:ok,
     socket
     |> assign(mood: mood)
     |> assign(intensity: intensity)
     |> assign(texture: texture)
     |> assign(location: location)
     |> assign(outcomes: outcomes)}
  end

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <p>Description page</p>
        <div>Current mood: <%= @mood %></div>
        <div>Intensity: <%= @intensity %></div>
        <div>Texture: <%= @texture %></div>
        <div>Location: <%= @location %></div>

        <div>
          <%= for outcome <- @outcomes do %>
            <div class="sm:w-1/2 md:w-1/4 p-5">
              <.link patch={
                ~p"/moods/#{@mood}/#{@intensity}/#{@texture}/#{@location}/#{outcome.resource}"
              }>
                <%= outcome.name %>
              </.link>
            </div>
          <% end %>
        </div>
      </.centered_block>

      <img
        class="absolute inset-0 h-full w-full object-cover z-0"
        src="https://ik.imagekit.io/soulgenesis/Moodinabox/bg-base.webp"
      />

      <img
        phx-mounted={JS.transition({"ease-out duration-1000", "translate-y-1/4", "translate-y-0"})}
        class="absolute translate-y-1/4 z-10 bottom-0 sm:right-10 right-4 w-32 lg:w-56 transform transition-transform"
        src="https://ik.imagekit.io/soulgenesis/Moodinabox/right-flower.webp"
      />

      <img
        phx-mounted={JS.transition({"ease-out duration-1000", "translate-y-1/4", "translate-y-0"})}
        class="absolute translate-y-1/4 z-10 bottom-0 left-4 sm:left-10 w-32 lg:w-56 transform transition-transform"
        src="https://ik.imagekit.io/soulgenesis/Moodinabox/left-flower.webp"
      />
    </.container>
    """
  end

  defp choose_outcome(mood, intensity) do
    case {mood, intensity} do
      {"angry", intensity} when intensity <= 3 ->
        anger_low()

      {"angry", intensity} when intensity >= 4 and intensity <= 7 ->
        anger_mid()

      {"angry", intensity} when intensity >= 8 ->
        anger_high()

      {"sad", intensity} when intensity <= 3 ->
        sad_low()

      {"sad", intensity} when intensity >= 4 and intensity <= 7 ->
        sad_mid()

      {"sad", intensity} when intensity >= 8 ->
        sad_high()

      {"afraid", intensity} when intensity <= 3 ->
        fear_low()

      {"afraid", intensity} when intensity >= 4 and intensity <= 7 ->
        fear_mid()

      {"afraid", intensity} when intensity >= 8 ->
        fear_high()
    end
  end

  defp anger_low do
    [
      %{
        name: "Irritated",
        description: "Feeling mildly angry or annoyed.",
        resource: "irritated"
      },
      %{
        name: "Annoyed",
        description: "Feeling very annoyed.",
        resource: "annoyed"
      },
      %{
        name: "Agitated",
        description: "Feeling agitated or irritated.",
        resource: "agitated"
      },
      %{
        name: "Frustrated",
        description: "Feeling frustrated.",
        resource: "frustrated"
      },
      %{
        name: "Impatient",
        description: "Feeling impatient.",
        resource: "impatient"
      }
    ]
  end

  defp anger_mid do
    [
      %{
        name: "Offended",
        description: "Feeling very offended.",
        resource: "offended"
      },
      %{
        name: "Resentful",
        description: "",
        resource: "resentful"
      },
      %{
        name: "Hostile",
        description: "",
        resource: "hostile"
      },
      %{
        name: "Angry",
        description: "",
        resource: "angry"
      },
      %{
        name: "Exasperated",
        description: "",
        resource: "exasperated"
      }
    ]
  end

  defp anger_high do
    [
      %{
        name: "Outraged",
        description: "Feeling extremely outraged.",
        resource: "outraged"
      },
      %{
        name: "Vexed",
        description: "Feeling intensely vexed.",
        resource: "vexed"
      },
      %{
        name: "Furious",
        description: "Feeling absolutely furious.",
        resource: "furious"
      },
      %{
        name: "Wrathful",
        description: "Feeling wrathful.",
        resource: "wrathful"
      },
      %{
        name: "Bitterly Resentful",
        description: "Feeling bitterly resentful.",
        resource: "bitterly-resentful"
      }
    ]
  end

  defp fear_low do
    [
      %{
        name: "Uneasy",
        description: "Feeling uneasy.",
        resource: "uneasy"
      },
      %{
        name: "Nervous",
        description: "Feeling nervous.",
        resource: "nervous"
      },
      %{
        name: "Apprehensive",
        description: "Feeling apprehensive.",
        resource: "apprehensive"
      },
      %{
        name: "Worried",
        description: "Feeling worried.",
        resource: "worried"
      },
      %{
        name: "Concerned",
        description: "Feeling concerned.",
        resource: "concerned"
      }
    ]
  end

  defp fear_mid do
    [
      %{
        name: "Anxious",
        description: "Feeling anxious.",
        resource: "anxious"
      },
      %{
        name: "Tense",
        description: "Feeling tense.",
        resource: "tense"
      },
      %{
        name: "Afraid",
        description: "Feeling afraid.",
        resource: "afraid"
      },
      %{
        name: "Frightened",
        description: "Feeling frightened.",
        resource: "frightened"
      },
      %{
        name: "Overwhelmed",
        description: "Feeling overwhelmed.",
        resource: "overwhelmed"
      }
    ]
  end

  defp fear_high do
    [
      %{
        name: "Terrified",
        description: "Feeling terrified.",
        resource: "terrified"
      },
      %{
        name: "Panicked",
        description: "Feeling panicked.",
        resource: "panicked"
      },
      %{
        name: "Petrified",
        description: "Feeling petrified.",
        resource: "petrified"
      },
      %{
        name: "Horrified",
        description: "Feeling horrified.",
        resource: "horrified"
      },
      %{
        name: "Paralyzed",
        description: "Feeling paralyzed with fear.",
        resource: "paralyzed"
      }
    ]
  end

  defp sad_low do
    [
      %{
        name: "Disappointed",
        description: "Feeling disappointed.",
        resource: "disappointed"
      },
      %{
        name: "Dejected",
        description: "Feeling dejected.",
        resource: "dejected"
      },
      %{
        name: "Downcast",
        description: "Feeling downcast.",
        resource: "downcast"
      },
      %{
        name: "Wistful",
        description: "Feeling wistful.",
        resource: "wistful"
      },
      %{
        name: "Disheartened",
        description: "Feeling disheartened.",
        resource: "disheartened"
      }
    ]
  end

  defp sad_mid do
    [
      %{
        name: "Sad",
        description: "Feeling sad.",
        resource: "sad"
      },
      %{
        name: "Unhappy",
        description: "Feeling unhappy.",
        resource: "unhappy"
      },
      %{
        name: "Forlorn",
        description: "Feeling forlorn.",
        resource: "forlorn"
      },
      %{
        name: "Melancholy",
        description: "Feeling melancholy.",
        resource: "melancholy"
      },
      %{
        name: "Resigned",
        description: "Feeling resigned.",
        resource: "resigned"
      }
    ]
  end

  defp sad_high do
    [
      %{
        name: "Depressed",
        description: "Feeling deeply depressed.",
        resource: "depressed"
      },
      %{
        name: "Despairing",
        description: "Feeling despairing.",
        resource: "despairing"
      },
      %{
        name: "Hopeless",
        description: "Feeling hopeless.",
        resource: "hopeless"
      },
      %{
        name: "Miserable",
        description: "Feeling miserable.",
        resource: "miserable"
      },
      %{
        name: "Devastated",
        description: "Feeling devastated.",
        resource: "devastated"
      }
    ]
  end
end
