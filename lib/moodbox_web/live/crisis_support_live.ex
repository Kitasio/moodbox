defmodule MoodboxWeb.CrisisSupportLive do
  use MoodboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <div class="max-w-3xl mx-auto text-center px-4">
          <h1 class="text-4xl md:text-5xl font-bold text-[#6b2a6d] mb-6">
            Your well-being is important to us.
          </h1>

          <p class="text-xl text-gray-600 mb-12">
            If you're feeling overwhelmed or having thoughts of harming yourself,
            please know that you're not alone and there is immediate and
            confidential support available.
          </p>

          <div class="text-2xl md:text-3xl font-bold text-[#6b2a6d] mb-4">
            CALL OR TEXT <span class="text-4xl">988</span> IN THE U.S. FOR CONFIDENTIAL HELP.
          </div>

          <a
            href="https://988lifeline.org/international/"
            class="inline-block px-8 py-3 bg-[#6b2a6d] text-white rounded-full hover:bg-[#8b3a8d] transition"
            target="_blank"
          >
            FIND HELP IN OTHER COUNTRIES
          </a>

          <div class="mt-8">
            <.link
              navigate={~p"/"}
              class="text-gray-500 hover:text-gray-700"
            >
              I'm good. I'm ready to proceed.
            </.link>
          </div>
        </div>
      </.centered_block>

      <.base_bg />
    </.container>
    """
  end
end
