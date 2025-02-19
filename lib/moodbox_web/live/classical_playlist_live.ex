defmodule MoodboxWeb.ClassicalPlaylistLive do
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

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <div class="flex flex-col gap-10 xl:gap-16">
          <.subheading>
            Ready for a mood shift?
          </.subheading>
          <.p>
            <span class="font-semibold">
              Let's begin with a proven effective way to release unwanted emotion.
            </span>
          </.p>
          <%= if @video_index == 1 do %>
            <p class="text-center mb-4 text-gray-700">
              Now for a classical approach. Place your hands on your heart or belly and enjoy.
            </p>
          <% end %>
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
            <%= if @video_index < length(@videos) - 1 do %>
              <.button
                phx-click="next_video"
                class="transition hover:scale-105 font-semibold px-16 py-3"
              >
                Next
              </.button>
            <% else %>
              <.link patch={@current_path <> "/revision"}>
                <.btn class="transition hover:scale-105 font-semibold px-16 py-3">
                  Continue
                </.btn>
              </.link>
            <% end %>
            
            <p class="text-sm text-gray-600 max-w-3xl text-center">
              <%= if @video_index == 0 do %>
                Releasing negative emotions through guided EFT (Emotional Freedom Technique) helps clear energetic blocks, reduce stress, and restore emotional balance. By tapping on key acupressure points while focusing on specific thoughts or feelings, EFT signals the brain to calm the nervous system and rewire emotional responses. This powerful practice allows you to let go of anger, fear, or sadness, creating space for inner peace, clarity, and a renewed sense of empowerment.
              <% else %>
                Enhancing classical music with binaural beats creates a powerful synergy that deepens focus, relaxation, and emotional balance. Binaural beats gently guide the brain into optimal states—whether for creativity, deep rest, or heightened concentration—while classical compositions provide a harmonious backdrop that soothes the nervous system. This combination blends science and artistry to elevate mood, sharpen cognition, and promote an effortless flow state.
              <% end %>
            </p>
          </div>
        </div>
      </.centered_block>

      <.base_bg />
    </.container>
    """
  end

  def handle_event("next_video", _params, socket) do
    {:noreply, update(socket, :video_index, &(&1 + 1))}
  end

  defp videos(mood) do
    case mood do
      "angry" ->
        [%{id: "6tKG9TfzdCU"}, %{id: "x6c2uI9K4zI"}]

      "sad" ->
        [%{id: "9PYdxr-QrXo"}, %{id: "n1HpgSzeUbE"}]

      "afraid" ->
        [%{id: "ej0MmiwEolk"}, %{id: "diiqrUhjkl4"}]
    end
  end
end
