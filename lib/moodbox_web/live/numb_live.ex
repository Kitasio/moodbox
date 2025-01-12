defmodule MoodboxWeb.NumbLive do
  use MoodboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(videos: videos())
     |> assign(video_index: 0)}
  end

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <div class="flex flex-col gap-10">
          <.subheading>
            Let’s identify your emotions.
          </.subheading>
          <.p>
            Watch the following videos to identify which one feels most like how you feel…
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
          <div class="flex w-full justify-center gap-4">
            <.button
              phx-click={show_modal("about-modal")}
              class="transition hover:scale-105 font-semibold px-8 py-3"
              variant="outlined"
            >
              More Info
            </.button>
            <%= if @video_index < length(@videos) - 1 do %>
              <.button
                phx-click="next_video"
                class="transition hover:scale-105 font-semibold px-8 py-3"
              >
                Next
              </.button>
            <% else %>
              <.link patch={~p"/moods/emotions-education"}>
                <.btn class="transition hover:scale-105 font-semibold px-8 py-3">
                  Continue
                </.btn>
              </.link>
            <% end %>
          </div>
        </div>
      </.centered_block>

      <.modal id="about-modal" on_cancel={hide_modal("about-modal")}>
        <.header>About These Videos</.header>
        <p class="mt-4">
          These tracks were designed with sounds and frequencies to help you identify the feeling of anger, fear or sadness. Once provoked, heavy emotions like frustration, anxiety, overwhelm, disappointment, or grief can be released.
        </p>
        <p class="mt-4">
          Imagery and disharmonious sounds ranging from fires, rain, tea kettles, revving engines, traffic, bass, wind, subdued piano notes, sighs, thunder, sirens, fast heartbeats, ticking clocks, and frequencies below 20hz come together to deconstruct and honor dark emotions. Once we identify and feel an emotion, we can release it.
        </p>
      </.modal>

      <.base_bg />
    </.container>
    """
  end

  def handle_event("next_video", _params, socket) do
    {:noreply, update(socket, :video_index, &(&1 + 1))}
  end

  defp videos do
    [
      %{id: "7sNZJ5N0F54"},
      %{id: "p8kltPdVLr4"},
      %{id: "9_VnTKNNb60"}
    ]
  end
end
