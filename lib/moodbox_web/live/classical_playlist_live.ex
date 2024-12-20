defmodule MoodboxWeb.ClassicalPlaylistLive do
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
     |> assign(description: description)}
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
            Find a quiet space, grab your headphones and follow the instructions.
          </.p>
          <div class="flex flex-col md:flex-row gap-10 xl:gap-20 w-full">
            <div :for={video <- @videos} class="aspect-video w-full">
              <div class="w-full h-full">
                <p class="font-semibold text-[#6b2a6d] text-center uppercase">
                  <%= video.label %>
                </p>
                <iframe
                  class="w-full h-full"
                  src={"https://www.youtube.com/embed/#{video.id}"}
                  title="YouTube video player"
                  frameborder="0"
                  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                  referrerpolicy="strict-origin-when-cross-origin"
                  allowfullscreen
                >
                </iframe>
              </div>
            </div>
          </div>
          <div class="flex w-full justify-center">
            <.link patch={
              ~p"/moods/#{@mood}/#{@intensity}/#{@texture}/#{@location}/#{@description}/outcome/classical/revision"
            }>
              <.btn class="transition hover:scale-105 font-semibold px-16 py-3">
                Continue
              </.btn>
            </.link>
          </div>
        </div>
      </.centered_block>

      <.base_bg />
    </.container>
    """
  end

  defp videos(mood) do
    case mood do
      "angry" ->
        [%{id: "6tKG9TfzdCU", label: "Start here"}, %{id: "x6c2uI9K4zI", label: "2"}]

      "sad" ->
        [%{id: "9PYdxr-QrXo", label: "Start here"}, %{id: "n1HpgSzeUbE", label: "2"}]

      "afraid" ->
        [%{id: "ej0MmiwEolk", label: "Start here"}, %{id: "diiqrUhjkl4", label: "2"}]
    end
  end
end
