defmodule MoodboxWeb.RootLive do
  use MoodboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <div class="max-w-4xl mx-auto text-center px-4">
          <h1 class="text-4xl md:text-5xl font-bold text-[#6b2a6d] mb-6">
            Find The Root and<br />Unearth Lasting Peace
          </h1>

          <p class="text-xl text-gray-600 mb-12">
            You deserve lasting peace, and that might involve addressing<br />
            the root cause of your unease.
          </p>

          <h2 class="text-2xl font-bold text-gray-800 mb-8">
            Connect with a certified hypnotherapist who can help you:
          </h2>

          <div class="grid md:grid-cols-3 gap-8 mb-12">
            <div class="text-left">
              <h3 class="text-2xl font-bold text-[#6b2a6d] mb-4">
                Dig Deeper,<br />Unearth More
              </h3>
              <p class="text-gray-600">
                Our certified hypnotherapists will help you uncover the root cause of your unease.
              </p>
            </div>

            <div class="text-left">
              <h3 class="text-2xl font-bold text-[#6b2a6d] mb-4">
                Build Resilience,<br />Not Just Relaxation
              </h3>
              <p class="text-gray-600">
                Hypnotherapy equips you with powerful coping mechanisms to manage stress and anxiety effectively.
              </p>
            </div>

            <div class="text-left">
              <h3 class="text-2xl font-bold text-[#6b2a6d] mb-4">
                Cultivate Lasting<br />Peace
              </h3>
              <p class="text-gray-600">
                Cultivate a sense of lasting inner peace and well-being, for a more fulfilling life.
              </p>
            </div>
          </div>

          <.button
            variant="filled"
            class="text-lg"
            phx-click="connect_therapist"
          >
            <a target="_blank" href="https://miamifloridahypnosis.com/">
              CONNECT NOW
            </a>
          </.button>
        </div>
      </.centered_block>

      <.base_bg />
    </.container>
    """
  end
end
