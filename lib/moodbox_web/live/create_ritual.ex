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

          <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mt-8 w-full max-w-4xl">
            <.ritual_card title="POWER POSES & FLOW" description="Yoga & Power Posing" link_href="#power-poses" />
            <.ritual_card title="CRYSTAL FREQUENCIES" description="Crystal Image Download" link_href="#crystal-frequencies" />
            <.ritual_card title="ELEMENTAL IMMERSION" description="Bathtime Rituals-Salts & Candles Affiliate AJ" link_href="#elemental-immersion" />
            <.ritual_card title="ALCHEMY OF SCENT" description="Aromatherapy Blends-Affiliate Doterra" link_href="#alchemy-of-scent" />
            <.ritual_card title="TEA CEREMONY" description="" link_href="#tea-ceremony" />
            <.ritual_card title="INTENTION INFUSION" description="Intentional Clothing, Coffee Mugs Etc" link_href="#intention-infusion" />
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

  defp ritual_card(assigns) do
    ~H"""
    <.link href={@link_href} class="flex flex-col items-center gap-4 group">
      <div class="w-40 h-40 border border-gray-400 rounded-lg bg-white bg-opacity-20 group-hover:scale-105 transition-transform duration-200">
        <%!-- Placeholder for image --%>
      </div>
      <div class="bg-purple-700 text-white px-4 py-2 rounded-full text-sm font-semibold group-hover:bg-purple-800 transition-colors duration-200">
        <%= @title %>
      </div>
      <.p class="text-sm"><%= @description %></.p>
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
