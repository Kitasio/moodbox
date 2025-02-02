defmodule MoodboxWeb.IntensityLive do
  use MoodboxWeb, :live_view

  def mount(params, _session, socket) do
    mood = params["mood"] || "angry"
    socket = assign(socket, :mood, mood)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.container class="overflow-hidden">
      <.centered_block>
        <.subheading>
          How intense is your feeling?
        </.subheading>
        <div class="mt-10 lg:mt-20 flex gap-5 xl:gap-7 flex-wrap justify-center">
          <.link :for={i <- 1..10} patch={~p"/moods/#{@mood}/#{i}"}>
            <div class="flex items-center justify-center text-xs sm:text-sm lg:text-xl font-semibold w-10 h-10 lg:w-20 lg:h-20 xl:w-24 xl:h-24 shadow-md hover:scale-105 transition rounded-full bg-[#6b2a6d]  text-white text-sm">
              <%= i %>
            </div>
          </.link>
        </div>
      </.centered_block>

      <.base_bg />

      <img
        phx-mounted={JS.transition({"ease-out duration-1000", "translate-y-[100%]", "translate-y-[80%]"})}
        class="absolute translate-y-[100%] z-10 bottom-0 sm:right-10 right-4 w-32 lg:w-56 transform transition-transform"
        src="https://ik.imagekit.io/soulgenesis/Moodinabox/right-flower.webp"
      />

      <img
        phx-mounted={JS.transition({"ease-out duration-1000", "translate-y-[100%]", "translate-y-[80%]"})}
        class="absolute translate-y-[100%] z-10 bottom-0 left-4 sm:left-10 w-32 lg:w-56 transform transition-transform"
        src="https://ik.imagekit.io/soulgenesis/Moodinabox/left-flower.webp"
      />
    </.container>
    """
  end
end
