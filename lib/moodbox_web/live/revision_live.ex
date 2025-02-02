defmodule MoodboxWeb.RevisionLive do
  use MoodboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(_params, uri, socket) do
    {:noreply, assign(socket, :current_path, uri)}
  end

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <.subheading>
          How peaceful are you feeling now?
        </.subheading>
        <div class="mt-10 lg:mt-20 flex gap-5 xl:gap-7 flex-wrap justify-center">
          <.link :for={i <- 1..10} patch={@current_path <> "/#{i}"}>
            <div class="flex items-center justify-center text-xs sm:text-sm lg:text-xl font-semibold w-10 h-10 lg:w-20 lg:h-20 xl:w-24 xl:h-24 shadow-md hover:scale-105 transition rounded-full bg-[#6b2a6d]  text-white text-sm">
              <%= i %>
            </div>
          </.link>
        </div>
      </.centered_block>

      <.base_bg />

      <img
        class="absolute z-10 bottom-0 sm:right-10 right-4 w-32 lg:w-56 transform transition-transform"
        src="https://ik.imagekit.io/soulgenesis/Moodinabox/right-flower.webp"
      />

      <img
        class="absolute z-10 bottom-0 left-4 sm:left-10 w-32 lg:w-56 transform transition-transform"
        src="https://ik.imagekit.io/soulgenesis/Moodinabox/left-flower.webp"
      />
    </.container>
    """
  end
end
