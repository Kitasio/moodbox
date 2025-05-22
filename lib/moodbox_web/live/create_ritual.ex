defmodule MoodboxWeb.CreateRitualLive do
  use MoodboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, mood: "angry", current_path: nil)}
  end

  def handle_params(%{"mood" => mood}, uri, socket) do
    {:noreply,
     socket
     |> assign(:current_path, uri)
     |> assign(:mood, mood)}
  end

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <div class="flex flex-col items-center gap-6 text-center">
          <.subheading>Create your own ritual</.subheading>
          <.p class="max-w-md xl:max-w-lg">
            You just experienced an audio-visual ritual designed
            to help you shift from <%= mood_text(@mood).shift_from %> to <%= mood_text(@mood).shift_to %>.
          </.p>
          <.p>Here are more ideas you can add to deepen and expand your ritual.</.p>

          <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-10 mt-8 w-full max-w-4xl">
            <.ritual_card
              title="POWER POSES & FLOW"
              link_href="/power-poses"
              current_path={@current_path}
              img_url="https://ik.imagekit.io/soulgenesis/Moodinabox/ritual_monk.png?updatedAt=1745586775656"
            />
            <.ritual_card
              title="CRYSTAL FREQUENCIES"
              link_href="/crystal-frequencies"
              current_path={@current_path}
              img_url="https://ik.imagekit.io/soulgenesis/Moodinabox/ritual_crystal.png?updatedAt=1745586728866"
            />
            <.ritual_card
              title="ELEMENTAL IMMERSION"
              link_href="/elemental-immersion"
              current_path={@current_path}
              img_url="https://ik.imagekit.io/soulgenesis/Moodinabox/ritual_candle.png?updatedAt=1745586704900"
            />
            <.ritual_card
              title="ALCHEMY OF SCENT"
              link_href="/alchemy-of-scent"
              current_path={@current_path}
              img_url="https://ik.imagekit.io/soulgenesis/Moodinabox/ritual_diffuser.png?updatedAt=1745586760326"
            />
            <.ritual_card
              title="TEA CEREMONY"
              link_href="/tea-ceremony"
              current_path={@current_path}
              img_url="https://ik.imagekit.io/soulgenesis/Moodinabox/ritual_tea.png?updatedAt=1745586281177"
            />
            <.ritual_card
              title="THE MAGIC SHOP"
              link_href="/magic-shop"
              current_path={@current_path}
              img_url=""
            />
          </div>

          <.p class="mt-10 max-w-3xl">
            Emotions, memories, and senses are deeply connected, making them a powerful
            tool for transformation. By linking your elevated state to sensory cues — sound,
            scent, sight, taste, or movement — you create an effortless shortcut back to feeling
            amazing. These anchors instantly help you shift your mood whenever needed.
          </.p>
        </div>
      </.centered_block>
      <.base_bg />
    </.container>
    """
  end

  attr :title, :string, required: true
  attr :link_href, :string, required: true
  attr :current_path, :string, required: true
  attr :img_url, :string, required: true

  defp ritual_card(assigns) do
    ~H"""
    <.link patch={@current_path <> @link_href} class="flex flex-col items-center gap-4 group">
      <img
        src={@img_url}
        class="w-40 h-40 shadow-md rounded-3xl bg-white bg-opacity-20 group-hover:scale-105 transition-transform duration-200"
      />
      <div class="bg-[#6b2a6d] text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors duration-200">
        <%= @title %>
      </div>
    </.link>
    """
  end

  defp mood_text(mood) do
    case mood do
      "angry" -> %{shift_from: "Anger", shift_to: "Bliss"}
      "sad" -> %{shift_from: "Sadness", shift_to: "Joy"}
      "afraid" -> %{shift_from: "Fear", shift_to: "Power"}
      # Default case
      _ -> %{shift_from: "Emotion", shift_to: "Wellbeing"}
    end
  end
end
