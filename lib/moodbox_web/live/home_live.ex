defmodule MoodboxWeb.HomeLive do
  use MoodboxWeb, :live_view

  alias Phoenix.LiveView.JS

  def mount(_params, _session, socket) do
    {:ok, assign(socket, terms_accepted: false)}
  end

  def handle_event("toggle-terms", _, socket) do
    {:noreply, update(socket, :terms_accepted, &(!&1))}
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
        <!-- Spacer to ensure margin is applied -->
        <div class="mt-8 sm:mt-10"></div>
        <.link patch={~p"/moods"}>
          <button
            class="transition hover:scale-105 px-8 py-4 xl:py-6 xl:px-12 xl:text-xl font-bold tracking-wider rounded-full bg-[#6b2a6d] text-white disabled:opacity-50 disabled:cursor-not-allowed"
            disabled={!@terms_accepted}
            phx-mounted={JS.transition({"ease-out duration-700", "opacity-0", "opacity-100"})}
          >
            EXPLORE MOOD IN A BOX
          </button>
        </.link>
        <div class="mt-4 ml-2 text-xs sm:text-sm text-gray-700 flex items-center gap-2">
          <input
            type="checkbox"
            id="terms-checkbox"
            phx-click="toggle-terms"
            checked={@terms_accepted}
            class="w-4 h-4 rounded border-gray-300 text-[#6b2a6d] focus:ring-[#6b2a6d] cursor-pointer"
          />
          <label for="terms-checkbox">
            I agree to the
            <button class="italic underline cursor-pointer" phx-click={show_modal("terms-modal")}>
              Terms
            </button>
          </label>
        </div>
      </div>

      <.modal id="terms-modal" on_cancel={hide_modal("terms-modal")}>
        <h2 class="text-xl font-bold mb-4">Welcome to Mood in a Box!</h2>

        <p class="mb-4">
          This interactive educational experience is designed to help you explore your mood with sensory healing based experiences that help you feel better.
        </p>

        <p class="mb-4 font-bold">
          PLEASE NOTE: Mood in a Box is not a replacement for therapy or medical advice. If you are struggling with your mental health, please seek help from a qualified professional.
        </p>

        <p class="mb-4">
          The results of this quiz are based on your answers and should not be taken as a diagnosis.
        </p>

        <p class="mb-4">
          If you are feeling overwhelmed, suicidal, or are having thoughts of harming yourself or others, please seek immediate help. You can call a crisis hotline or reach out to a mental health professional.
        </p>

        <p class="mb-4">
          By using Mood in a Box, you agree to these terms and conditions.
        </p>

        <p>
          Thank you for using Mood in a Box! We hope it helps you on your journey to better mental well-being.
        </p>
      </.modal>

      <img
        phx-mounted={JS.transition({"ease-out duration-300", "opacity-0", "opacity-100"})}
        class="absolute inset-0 h-full w-full object-cover z-0 top-32 sm:top-14 md:top-20"
        src="https://ik.imagekit.io/soulgenesis/Moodinabox/main-page.webp"
      />
    </div>
    """
  end
end
