defmodule MoodboxWeb.RevisionLive do
  use MoodboxWeb, :live_view

  def mount(params, _session, socket) do
    mood = params["mood"]
    intensity = params["intensity"]
    texture = params["texture"]
    location = params["location"]
    description = params["description"]

    {:ok,
     socket
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
        <.subheading>
          How peaceful are you feeling now?
        </.subheading>
        <div class="mt-10 lg:mt-20 flex gap-5 xl:gap-7 flex-wrap justify-center">
          <.link
            :for={i <- 1..9}
            patch={
              ~p"/moods/#{@mood}/#{@intensity}/#{@texture}/#{@location}/#{@description}/outcome/classical/revision/#{i}"
            }
          >
            <div class="flex items-center justify-center text-xs sm:text-sm lg:text-xl font-semibold w-10 h-10 lg:w-20 lg:h-20 xl:w-24 xl:h-24 shadow-md hover:scale-105 transition rounded-full bg-[#6b2a6d]  text-white text-sm">
              <%= i %>
            </div>
          </.link>
          <.link patch={
            ~p"/moods/#{@mood}/#{@intensity}/#{@texture}/#{@location}/#{@description}/outcome/classical/revision/deep-dive"
          }>
            <div class="flex items-center justify-center text-xs sm:text-sm lg:text-xl font-semibold w-10 h-10 lg:w-20 lg:h-20 xl:w-24 xl:h-24 shadow-md hover:scale-105 transition rounded-full bg-[#6b2a6d]  text-white text-sm">
              10
            </div>
          </.link>
        </div>
      </.centered_block>

      <.base_bg />
    </.container>
    """
  end
end
