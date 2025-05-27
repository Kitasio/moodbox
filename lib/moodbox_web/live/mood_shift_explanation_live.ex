defmodule MoodboxWeb.MoodShiftExplanationLive do
  use MoodboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(_params, uri, socket) do
    {:noreply,
     socket
     |> assign(:current_path, uri)}
  end

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <.p class="text-left p-4 md:p-8 bg-white rounded-xl shadow-md">
          What if the key to transforming a bad mood wasn’t about resisting it—but about alchemizing it? Every negative emotion holds the seed of its opposite: Anger fuels bliss. Fear awakens power. Sadness births joy. This is the hidden magic of emotional transformation.
          <br /><br />
          Rooted in ancient wisdom—Taoism, alchemy, and the subconscious mind’s language of symbols—we can harness the natural interplay of opposites to shift our state. Emotion, memory, and the senses are deeply interconnected, and when we engage them intentionally, we create a powerful catalyst for change.
          <br /><br />
          Now that you’ve entered a relaxed, peaceful state, it’s time for a mood transformation. By pairing your elevated state with high frequency sensory “anchors”—sound, scent, sight, taste, or movement—you’ll create an effortless shortcut back to feeling amazing. In the future, whenever a low mood strikes, these anchors will instantly remind your body how to feel good again.
          <br /><br /> This is more than just a mood shift—it’s a reality shift ritual.
        </.p>
        <.link patch={@current_path <> "/further-boost"}>
          <.button variant="filled" class="text-lg mt-8">
            Let's begin
          </.button>
        </.link>
      </.centered_block>
      <.base_bg />

      <img
        class="absolute z-10 bottom-0 sm:right-10 right-4 w-32 lg:w-56 transform transition-transform"
        src="https://moodbox.fly.storage.tigris.dev/right-flower.webp"
      />

      <img
        class="absolute z-10 bottom-0 left-4 sm:left-10 w-32 lg:w-56 transform transition-transform"
        src="https://moodbox.fly.storage.tigris.dev/left-flower.webp"
      />
    </.container>
    """
  end
end
