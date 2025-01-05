defmodule MoodboxWeb.FurtherBoostLive do
  use MoodboxWeb, :live_view

  def mount(params, _session, socket) do
    mood = params["mood"]
    intensity = params["intensity"]
    texture = params["texture"]
    location = params["location"]
    description = params["description"]
    videos = videos(mood)

    {:ok,
     socket
     |> assign(videos: videos)
     |> assign(mood: mood)
     |> assign(intensity: intensity)
     |> assign(texture: texture)
     |> assign(location: location)
     |> assign(description: description)
     |> assign(video_index: 0)}
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
            Expand the videos to full screen and allow the sounds and visuals to fully immerse you.
          </.p>
          <div class="aspect-video w-full">
            <div class="w-full h-full">
              <p class="font-semibold text-[#6b2a6d] text-center uppercase">
                <%= Enum.at(@videos, @video_index).label %>
              </p>
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
          <div class="flex w-full justify-center">
            <%= if @video_index < length(@videos) - 1 do %>
              <.button phx-click="next_video" class="transition hover:scale-105 font-semibold px-16 py-3">
                Next
              </.button>
            <% else %>
              <.link patch={
                ~p"/moods/#{@mood}/#{@intensity}/#{@texture}/#{@location}/#{@description}/outcome"
              }>
                <.btn class="transition hover:scale-105 font-semibold px-16 py-3">
                  Continue
                </.btn>
              </.link>
            <% end %>
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
      "sad" ->
        [
          %{id: "Ht3tE_wHvpU", label: "3"},
          %{id: "eo-C1wDjbsQ", label: "4"},
          %{id: "eprWxoRCOak", label: "2"},
          %{id: "hdQDvDEM7_I", label: "Start here"}
        ]

      "afraid" ->
        [
          %{id: "tZZEvXwvvDE", label: "3"},
          %{id: "sK5QrPlQ5Yo", label: "4"},
          %{id: "Cu4Ec9iwa0M", label: "2"},
          %{id: "OD7zB3xqgec", label: "Start here"}
        ]

      "angry" ->
        [
          %{id: "wk3at10Nk3E", label: "3"},
          %{id: "CWInIJm2XQM", label: "4"},
          %{id: "doOAKyDd0t8", label: "2"},
          %{id: "4n-XvH6mcak", label: "Start here"}
        ]
    end
  end
end
