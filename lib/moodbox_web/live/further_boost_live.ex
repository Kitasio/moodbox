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
     |> assign(description: description)}
  end

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <div class="flex flex-col gap-10 xl:gap-16">
          <.subheading>
            Let's boost your mood further.
          </.subheading>
          <.p>
            Expand the videos to full screen and allow the sounds and visuals to fully immerse you.
          </.p>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-10 xl:gap-20 w-full">
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
            <.link patch={~p"/moods/#{@mood}/#{@intensity}/#{@texture}/#{@location}/#{@description}/outcome"}>
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
        [
          %{id: "placeholder1", label: "Start here"},
          %{id: "placeholder2", label: "2"},
          %{id: "placeholder3", label: "3"},
          %{id: "placeholder4", label: "4"}
        ]

      "sad" ->
        [
          %{id: "placeholder5", label: "Start here"},
          %{id: "placeholder6", label: "2"},
          %{id: "placeholder7", label: "3"},
          %{id: "placeholder8", label: "4"}
        ]

      "afraid" ->
        [
          %{id: "placeholder9", label: "Start here"},
          %{id: "placeholder10", label: "2"},
          %{id: "placeholder11", label: "3"},
          %{id: "placeholder12", label: "4"}
        ]
    end
  end
end
