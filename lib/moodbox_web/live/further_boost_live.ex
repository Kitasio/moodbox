defmodule MoodboxWeb.FurtherBoostLive do
  use MoodboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(videos: videos("angry")) |> assign(video_index: 0)}
  end

  def handle_params(%{"mood" => mood}, uri, socket) do
    {:noreply,
     socket
     |> assign(:current_path, uri)
     |> assign(:videos, videos(mood))
     |> assign(:video_index, 0)}
  end

  def handle_event("next_video", _params, socket) do
    {:noreply, update(socket, :video_index, &(&1 + 1))}
  end

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <div class="flex flex-col gap-10">
          <.subheading>
            Let's boost your mood further.
          </.subheading>
          <.p>
            Expand the video to full screen and allow the sounds and visuals to fully immerse you.
          </.p>

          <div class="aspect-video w-full">
            <div class="w-full h-full">
              <iframe
                class="w-full h-full"
                src={"https://www.youtube.com/embed/#{Enum.at(@videos, @video_index).id}"}
                title="YouTube video player"
                frameborder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                referrerpolicy="strict-origin-when-cross-origin"
                allowfullscreen
              >
              </iframe>
            </div>
          </div>

          <div class="flex flex-col items-center gap-6">
            <%= case @video_index do %>
              <% 0 -> %>
                <.h3 class="mt-8">Hypnosis: The Gateway to Superlearning</.h3>
                <.p class="mt-4 text-left">
                  Hypnosis is a highly focused state where positive suggestions take root effortlessly. It unlocks a superlearning mode, making it easier to absorb new insights, rewire habits, and accelerate transformation.
                  In this state, change isn’t just possible—it’s rapid and lasting.
                </.p>
              <% 1 -> %>
                <.p class="mt-8 text-left">
                  Experience the Power of Hypnotic Music & Binaural Beats
                  Immerse yourself in a mind-massaging journey of sound, where hypnotic music and binaural beats work in harmony to shift your emotional state. Each track is carefully designed with frequencies, tones, and rhythms that guide you from negativity to a vibrant, empowered mood—effortlessly rewiring your mind for positivity and clarity.
                </.p>
              <% 2 -> %>
                <.p class="text-left whitespace-pre-line">
                  The magic of anchoring.

                  One of the coolest tricks the subconscious mind performs is linking an emotional state with a sensory trigger—like a song—so you can access it anytime you need. Just as a familiar scent can transport you to a cherished memory, this track becomes your personal shortcut to confidence, joy, or bliss.

                  Each time you listen, your mind strengthens the connection, making it easier to shift into a high-vibe state instantly. Use it intentionally, and watch how quickly and effortlessly you can reclaim your power.

                  Instead of reacting to the past, you become anchored to your dreams, desires, and highest self. Welcome to the next level of emotional mastery.
                </.p>
            <% end %>

            <%= if @video_index < length(@videos) - 1 do %>
              <.button
                phx-click="next_video"
                class="transition hover:scale-105 font-semibold px-16 py-3"
              >
                Continue
              </.button>
            <% else %>
              <.link patch={@current_path <> "/create-ritual"}>
                <.button class="transition hover:scale-105 font-semibold px-16 py-3">
                  Create your own ritual
                </.button>
              </.link>
            <% end %>
          </div>
        </div>
      </.centered_block>

      <.base_bg />
    </.container>
    """
  end

  defp videos(mood) do
    case mood do
      "sad" ->
        [
          %{id: "v9plcR0fPk0"},
          %{id: "eprWxoRCOak"},
          %{id: "hdQDvDEM7_I"}
        ]

      "afraid" ->
        [
          %{id: "zqRIbFZwxEA"},
          %{id: "Cu4Ec9iwa0M"},
          %{id: "OD7zB3xqgec"}
        ]

      "angry" ->
        [
          %{id: "Gj2VXyoagsg"},
          %{id: "doOAKyDd0t8"},
          %{id: "4n-XvH6mcak"}
        ]
    end
  end
end
