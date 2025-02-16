defmodule MoodboxWeb.CrisisSupportLive do
  use MoodboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.container class="relative min-h-screen bg-gradient-to-b from-white to-gray-100">
      <div class="absolute inset-0 overflow-hidden">
        <div class="absolute inset-0 bg-[url('https://ik.imagekit.io/soulgenesis/Moodinabox/watercolor-bg.webp')] bg-cover bg-center opacity-50">
        </div>
      </div>

      <.centered_block>
        <div class="relative z-10 max-w-3xl mx-auto text-center">
          <h1 class="text-4xl md:text-5xl font-bold text-[#6b2a6d] mb-6">
            Your well-being is important to us.
          </h1>

          <p class="text-xl font-medium text-gray-600 mb-12">
            Choosing 10 let's us know you're feeling big emotions. If you are experiencing 
            an emergency or having thoughts of self-harm, please seek live support. 
            Please know you are not alone and there are helpers who want to support you.
          </p>

          <div class="text-xl md:text-2xl font-semibold mb-8">
            CALL OR TEXT <span class="text-[#6b2a6d] text-4xl mx-1">988</span>
            IN THE U.S. FOR CONFIDENTIAL HELP.
          </div>

          <a
            href="https://findahelpline.com/"
            target="_blank"
            class="inline-block text-[#6b2a6d] text-lg font-semibold hover:text-[#8b3a8d] transition mb-8 underline"
          >
            FIND HELP IN OTHER COUNTRIES
          </a>

          <div class="mt-2">
            <.link
              navigate={~p"/"}
              class="inline-block px-12 py-4 bg-[#6b2a6d] text-white text-lg font-semibold rounded-lg hover:bg-[#8b3a8d] transition"
            >
              I'm OK. I'm ready to continue.
            </.link>
          </div>
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
