defmodule MoodboxWeb.DescriptionLive do
  use MoodboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"mood" => mood, "intensity" => intensity}, uri, socket) do
    outcomes = choose_outcome(mood, intensity |> String.to_integer())

    {:noreply,
     socket
     |> assign(:current_path, uri)
     |> assign(:outcomes, outcomes)}
  end

  def render(assigns) do
    ~H"""
    <.container>
      <div class="h-dvh overflow-y-scroll">
        <.centered_block>
          <.subheading>
            Which word best describes this feeling? Remember your choice.
          </.subheading>

          <div class="mt-4 sm:mt-8 mb-40 sm:mb-0 lg:mt-16">
            <div :for={outcome <- @outcomes} class="mt-8 md:mt-10 flex flex-col w-44 sm:w-96">
              <.link patch={@current_path <> "/#{outcome.resource}"}>
                <.btn class="transition hover:scale-105">
                  <%= outcome.name %>
                </.btn>
              </.link>
              <span class="mt-0.5 md:mt-2 text-center text-sm text-gray-600">
                <%= outcome.description %>
              </span>
            </div>
          </div>
        </.centered_block>

        <.base_bg />

        <img
          phx-mounted={
            JS.transition({"ease-out duration-1000", "translate-y-[20%]", "translate-y-[0%]"})
          }
          class="absolute translate-y-[20%] z-10 bottom-0 sm:right-10 right-4 w-32 lg:w-56 transform transition-transform"
          src="https://moodbox.fly.storage.tigris.dev/right-flower.webp"
        />

        <img
          phx-mounted={
            JS.transition({"ease-out duration-1000", "translate-y-[20%]", "translate-y-[0%]"})
          }
          class="absolute translate-y-[20%] z-10 bottom-0 left-4 sm:left-10 w-32 lg:w-56 transform transition-transform"
          src="https://moodbox.fly.storage.tigris.dev/left-flower.webp"
        />
      </div>
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
        description: "Feeling slight anger or displeasure, typically over something trivial.",
        resource: "annoyed"
      },
      %{
        name: "Agitated",
        description: "Feeling nervous or unsettled, potentially leading to anger.",
        resource: "agitated"
      },
      %{
        name: "Frustrated",
        description:
          "Feeling upset or annoyed due to an inability to change or achieve something.",
        resource: "frustrated"
      },
      %{
        name: "Impatient",
        description:
          "Tendency to be quickly irritated or provoked, especially when waiting for something or someone.",
        resource: "impatient"
      }
    ]
  end

  defp anger_mid do
    [
      %{
        name: "Offended",
        description:
          "Feeling or expressing hurt, anger, or resentment due to a perceived insult or injustice.",
        resource: "offended"
      },
      %{
        name: "Resentful",
        description: "Feeling bitter indignation at having been treated unfairly.",
        resource: "resentful"
      },
      %{
        name: "Hostile",
        description: "Feeling unfriendly or antagonistic.",
        resource: "hostile"
      },
      %{
        name: "Angry",
        description: "Feeling strong annoyance, displeasure, or hostility.",
        resource: "angry"
      },
      %{
        name: "Exasperated",
        description: "Feeling intensely irritated or frustrated.",
        resource: "exasperated"
      }
    ]
  end

  defp anger_high do
    [
      %{
        name: "Outraged",
        description: "Feeling extremely angry, shocked, or indignant.",
        resource: "outraged"
      },
      %{
        name: "Vexed",
        description: "Feeling extremely annoyed and frustrated.",
        resource: "vexed"
      },
      %{
        name: "Furious",
        description: "Feeling intense, unruly anger.",
        resource: "furious"
      },
      %{
        name: "Wrathful",
        description: "Having a desire for revenge.",
        resource: "wrathful"
      },
      %{
        name: "Bitterly Resentful",
        description: "Feeling cold indignation approaching hatred.",
        resource: "bitterly-resentful"
      }
    ]
  end

  defp fear_low do
    [
      %{
        name: "Uneasy",
        description: "Feeling slightly uncomfortable or anxious.",
        resource: "uneasy"
      },
      %{
        name: "Nervous",
        description:
          "Feeling apprehensive or worried about something. Easily agitated or alarmed.",
        resource: "nervous"
      },
      %{
        name: "Apprehensive",
        description: "Feeling anxious or fearful that something bad will happen.",
        resource: "apprehensive"
      },
      %{
        name: "Worried",
        description: "Feeling anxious or troubled about actual or potential problems.",
        resource: "worried"
      },
      %{
        name: "Concerned",
        description: "Feeling troubled or worried.",
        resource: "concerned"
      }
    ]
  end

  defp fear_mid do
    [
      %{
        name: "Anxious",
        description:
          "Feeling worry, nervousness, or unease about something with an uncertain outcome.",
        resource: "anxious"
      },
      %{
        name: "Tense",
        description: "Feeling mental or emotional strain; anxious.",
        resource: "tense"
      },
      %{
        name: "Afraid",
        description: "Feeling fear; frightened.",
        resource: "afraid"
      },
      %{
        name: "Frightened",
        description: "Feeling fear or panic.",
        resource: "frightened"
      },
      %{
        name: "Overwhelmed",
        description:
          "Overcome by a feeling or situation; often unable to move forward due to an excess of stress.",
        resource: "overwhelmed"
      }
    ]
  end

  defp fear_high do
    [
      %{
        name: "Horrified",
        description: "Feeling shocked and scared.",
        resource: "horrified"
      },
      %{
        name: "Panicked",
        description: "Feeling a sudden, overwhelming fear that results in irrational behavior.",
        resource: "panicked"
      },
      %{
        name: "Terrified",
        description: "Feeling extreme fear.",
        resource: "terrified"
      },
      %{
        name: "Petrified",
        description:
          "Feeling so frightened that one is unable to move; paralyzed, due to fear or shock.",
        resource: "petrified"
      },
      %{
        name: "Dreading",
        description: "Anticipating with great apprehension or fear.",
        resource: "dreading"
      }
    ]
  end

  defp sad_low do
    [
      %{
        name: "Disappointed",
        description:
          "Sad or displeased because someone or something has failed to fulfill one's hopes or expectations.",
        resource: "disappointed"
      },
      %{
        name: "Dejected",
        description: "Feeling low in spirits or morale.",
        resource: "dejected"
      },
      %{
        name: "Downcast",
        description: "Feeling dejected or despondent.",
        resource: "downcast"
      },
      %{
        name: "Wistful",
        description: "Having a feeling of vague or regretful longing.",
        resource: "wistful"
      },
      %{
        name: "Disheartened",
        description: "Feeling a loss of hope or confidence.",
        resource: "disheartened"
      }
    ]
  end

  defp sad_mid do
    [
      %{
        name: "Sad",
        description: "Feeling sorrow or unhappiness.",
        resource: "sad"
      },
      %{
        name: "Unhappy",
        description: "Not happy; feeling or showing sorrow or discontent.",
        resource: "unhappy"
      },
      %{
        name: "Forlorn",
        description: "Feeling abandoned or lonely.",
        resource: "forlorn"
      },
      %{
        name: "Melancholy",
        description: "A deep, pensive, persistent sadness.",
        resource: "melancholy"
      },
      %{
        name: "Resigned",
        description:
          "Accepting something unpleasant that one cannot change; showing acceptance of a situation.",
        resource: "resigned"
      }
    ]
  end

  defp sad_high do
    [
      %{
        name: "Heartbroken",
        description: "Overcome by sorrow or grief; devastated.",
        resource: "heartbroken"
      },
      %{
        name: "Grief-stricken",
        description: "Feeling intense sorrow, especially due to a loss; mourning.",
        resource: "grief-stricken"
      },
      %{
        name: "Sorrowful",
        description: "Feeling deep sadness or regret.",
        resource: "sorrowful"
      },
      %{
        name: "Mournful",
        description: "Feeling grief or sorrow, often due to a loss.",
        resource: "mournful"
      },
      %{
        name: "Despondent",
        description: "Feeling a loss of hope or courage.",
        resource: "despondent"
      }
    ]
  end
end
