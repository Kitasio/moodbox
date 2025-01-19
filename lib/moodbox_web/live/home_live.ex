defmodule MoodboxWeb.HomeLive do
  use MoodboxWeb, :live_view

  alias Phoenix.LiveView.JS

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="relative overflow-hidden h-screen w-full">
      <div class="relative h-full z-10 px-4 py-8 sm:px-24 sm:py-20 xl:py-32">
        <h1
          phx-mounted={
            JS.transition({"transition ease-out duration-1000", "opacity-0", "opacity-100"})
          }
          class="text-5xl sm:text-6xl xl:text-7xl max-w-4xl xl:tracking-wide leading-tight sm:leading-snug text-[#6b2a6d] font-extrabold"
        >
          You Have the Power to&nbsp;Transform Your Mood
        </h1>
        <h2
          phx-mounted={JS.transition({"ease-out duration-300", "opacity-0", "opacity-100"})}
          class="text-md sm:text-lg mt-2 sm:mt-4 xl:mt-6 md:text-2xl xl:text-3xl font-medium text-gray-800"
        >
          Discover Your Path to a Brighter Mood
        </h2>
        <!-- Spacer to ensure margin is applied -->
        <div class="mt-16 sm:mt-20"></div>
        <.link patch={~p"/moods"}>
          <button
            class="transition hover:scale-105 px-8 py-4 xl:py-6 xl:px-12 xl:text-xl font-bold tracking-wider cursor-pointer rounded-full bg-[#6b2a6d] text-white"
            phx-mounted={JS.transition({"ease-out duration-700", "opacity-0", "opacity-100"})}
          >
            EXPLORE MOOD IN A BOX
          </button>
        </.link>
      </div>
      <img
        phx-mounted={JS.transition({"ease-out duration-300", "opacity-0", "opacity-100"})}
        class="absolute inset-0 h-full w-full object-cover z-0 top-32 sm:top-14"
        src="https://ik.imagekit.io/soulgenesis/Moodinabox/main-page.webp"
      />
    </div>
    """
  end
end
