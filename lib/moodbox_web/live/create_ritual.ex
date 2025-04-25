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
          <.p>
            You Just Experienced An Audio-Visual Ritual Designed
            <br />
            To Help You Shift From <%= mood_text(@mood).shift_from %> To <%= mood_text(@mood).shift_to %>.
          </.p>
          <.p>Here Are More Ideas You Can Add To Deepen And Expand Your Ritual.</.p>

          <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-8 mt-8 w-full max-w-4xl">
            <.ritual_card title="POWER POSES & FLOW" description="Yoga & Power Posing" link_href="/power-poses" current_path={@current_path} img_url="https://ik.imagekit.io/soulgenesis/Moodinabox/ritual_monk.png?updatedAt=1745586775656" />
            <.ritual_card title="CRYSTAL FREQUENCIES" description="Crystal Image Download" link_href="/crystal-frequencies" current_path={@current_path} img_url="https://ik.imagekit.io/soulgenesis/Moodinabox/ritual_crystal.png?updatedAt=1745586728866" />
            <.ritual_card title="ELEMENTAL IMMERSION" description="Bathtime Rituals-Salts & Candles Affiliate AJ" link_href="/elemental-immersion" current_path={@current_path} img_url="https://ik.imagekit.io/soulgenesis/Moodinabox/ritual_candle.png?updatedAt=1745586704900" />
            <.ritual_card title="ALCHEMY OF SCENT" description="Aromatherapy Blends-Affiliate Doterra" link_href="/alchemy-of-scent" current_path={@current_path} img_url="https://ik.imagekit.io/soulgenesis/Moodinabox/ritual_diffuser.png?updatedAt=1745586760326" />
            <.ritual_card title="TEA CEREMONY" description="Herbal Tea Blends" link_href="/tea-ceremony" current_path={@current_path} img_url="https://ik.imagekit.io/soulgenesis/Moodinabox/ritual_tea.png?updatedAt=1745586281177" />
            <.ritual_card title="INTENTION INFUSION" description="Intentional Clothing, Coffee Mugs Etc" link_href="/intention-infusion" current_path={@current_path} img_url="" />
          </div>

          <.p class="mt-10 max-w-3xl">
            Emotions, Memories, And Senses Are Deeply Connected, Making Them A Powerful
            Tool For Transformation. By Linking Your Elevated State To Sensory Cues — Sound,
            Scent, Sight, Taste, Or Movement — You Create An Effortless Shortcut Back To Feeling
            Amazing. These Anchors Instantly Help You Shift Your Mood Whenever Needed.
          </.p>
        </div>
      </.centered_block>
      <.base_bg />
    </.container>
    """
  end

  attr :title, :string, required: true
  attr :description, :string, required: true
  attr :link_href, :string, required: true
  attr :current_path, :string, required: true
  attr :img_url, :string, required: true

  defp ritual_card(assigns) do
    ~H"""
    <.link patch={@current_path <> @link_href} class="flex flex-col items-center gap-4 group">
      <img src={@img_url} class="w-40 h-40 shadow-md rounded-3xl bg-white bg-opacity-20 group-hover:scale-105 transition-transform duration-200" />
      <div class="bg-[#6b2a6d] text-white px-4 py-2 rounded-full text-sm font-semibold transition-colors duration-200">
        <%= @title %>
      </div>
      <p class="text-sm text-gray-700"><%= @description %></p>
    </.link>
    """
  end

  defp mood_text(mood) do
    case mood do
      "angry" -> %{shift_from: "Anger", shift_to: "Bliss"}
      "sad" -> %{shift_from: "Sadness", shift_to: "Joy"}
      "afraid" -> %{shift_from: "Fear", shift_to: "Power"}
      _ -> %{shift_from: "Emotion", shift_to: "Wellbeing"} # Default case
    end
  end
end
