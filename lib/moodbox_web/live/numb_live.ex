defmodule MoodboxWeb.NumbLive do
  use MoodboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(videos: videos())
     |> assign(video_index: 0)
     |> assign(show_modal: false)}
  end

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <div class="flex flex-col gap-10">
          <.subheading>
            Let's help you identify and feel your emotions
          </.subheading>
          <.p>
            Expand the videos to full screen and allow the sounds and visuals to fully immerse you.
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
            <.button phx-click="show_modal" class="transition hover:scale-105 font-semibold px-8 py-3">
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
              <.link patch={~p"/"}>
                <.btn class="transition hover:scale-105 font-semibold px-8 py-3">
                  Continue
                </.btn>
              </.link>
            <% end %>
          </div>
        </div>
      </.centered_block>

      <.modal :if={@show_modal} on_cancel={JS.patch(~p"/moods/numb")}>
        <.header>About These Videos</.header>
        <.p class="mt-4">
          These tracks were designed with sounds and frequencies to help you identify the feeling of anger, fear or sadness. Once provoked, heavy emotions like frustration, anxiety, overwhelm, disappointment, or grief can be released.
        </.p>
        <.p class="mt-4">
          Imagery and disharmonious sounds ranging from fires, rain, tea kettles, revving engines, traffic, bass, wind, subdued piano notes, sighs, thunder, sirens, fast heartbeats, ticking clocks, and frequencies below 20hz come together to deconstruct and honor dark emotions. Once we identify and feel an emotion, we can release it.
        </.p>
      </.modal>

      <.base_bg />
    </.container>
    """
  end

  def handle_event("next_video", _params, socket) do
    {:noreply, update(socket, :video_index, &(&1 + 1))}
  end

  def handle_event("show_modal", _, socket) do
    {:noreply, assign(socket, show_modal: true)}
  end

  defp videos do
    [
      %{id: "tZZEvXwvvDE"},
      %{id: "sK5QrPlQ5Yo"},
      %{id: "Cu4Ec9iwa0M"},
      %{id: "OD7zB3xqgec"}
    ]
  end
end
