defmodule MoodboxWeb.RevisionOutcomeLive do
  use MoodboxWeb, :live_view

  def mount(params, _session, socket) do
    mood = params["mood"]
    intensity = params["intensity"]
    texture = params["texture"]
    location = params["location"]
    description = params["description"]
    score = params["score"]

    {:ok,
     socket
     |> assign(mood: mood)
     |> assign(intensity: intensity)
     |> assign(texture: texture)
     |> assign(location: location)
     |> assign(description: description)
     |> assign(score: score)}
  end

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <div class="max-w-3xl mx-auto text-center px-4">
          <h1 class="text-3xl md:text-4xl lg:text-5xl font-bold text-[#6b2a6d] mb-4">
            Congratulations! You've Unlocked Peak Serenity!
          </h1>

          <p class="text-gray-600 text-lg md:text-xl mb-12">
            Wow! A perfect 10 on the peacefulness scale – that's fantastic! We are thrilled to have helped you reach a state of pure calmness.
          </p>

          <h2 class="text-2xl md:text-3xl font-bold text-[#6b2a6d] mb-8">
            WHAT'S NEXT?
          </h2>

          <p class="text-xl text-gray-700 mb-10">
            Unlock even deeper levels of relaxation and well-being through:
          </p>

          <div class="grid md:grid-cols-3 gap-8 mb-12">
            <div class="bg-white p-6 rounded-lg shadow-md">
              <h3 class="text-xl font-bold text-[#6b2a6d] mb-4">
                Guided Hypnosis Sessions
              </h3>
              <p class="text-gray-600">
                Reprogram your subconscious mind for lasting calm with personalized hypnotic journeys.
              </p>
            </div>

            <div class="bg-white p-6 rounded-lg shadow-md">
              <h3 class="text-xl font-bold text-[#6b2a6d] mb-4">
                Powerful Anchoring Techniques
              </h3>
              <p class="text-gray-600">
                Learn to trigger feelings of peace instantly with simple practices you can incorporate anywhere.
              </p>
            </div>

            <div class="bg-white p-6 rounded-lg shadow-md">
              <h3 class="text-xl font-bold text-[#6b2a6d] mb-4">
                Exclusive Binaural Beat Library
              </h3>
              <p class="text-gray-600">
                Access a curated collection of advanced binaural beats designed for deeper relaxation and focus.
              </p>
            </div>
          </div>

          <.button
            class="bg-[#6b2a6d] text-white px-8 py-4 rounded-lg text-lg font-semibold hover:bg-[#5a2359] transition-colors"
            phx-click="unlock_deeper_levels"
          >
            UNLOCK DEEPER LEVELS OF RELAXATION
          </.button>
        </div>
      </.centered_block>

      <.base_bg />
    </.container>
    """
  end
end
