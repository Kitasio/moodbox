defmodule MoodboxWeb.EmotionsEducationLive do
  use MoodboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <div class="max-w-4xl mx-auto px-4">
          <div class="flex items-center gap-4 mb-2">
            <h1 class="text-4xl md:text-5xl font-bold text-[#6b2a6d]">
              Our emotions carry messages.
            </h1>
          </div>

          <p class="text-xl text-gray-600 mb-12">
            What are yours telling you?
          </p>

          <div class="grid md:grid-cols-3 gap-8 mb-12">
            <div class="text-left">
              <h3 class="text-2xl font-bold text-[#6b2a6d] mb-2">Anger</h3>
              <p class="font-semibold mb-1">Message:</p>
              <p class="text-gray-600 mb-2">
                Anger lets us know that one of our boundaries has been crossed or that something we value is under threat.
              </p>
              <p class="font-semibold mb-1">Purpose:</p>
              <p class="text-gray-600">
                Anger is an energizing emotion that serves as a catalyst for change, motivating us to address injustices or to prepare to defend ourselves.
              </p>
            </div>

            <div class="text-left">
              <h3 class="text-2xl font-bold text-[#6b2a6d] mb-2">Fear</h3>
              <p class="font-semibold mb-1">Message:</p>
              <p class="text-gray-600 mb-2">
                Fear carries a message to prepare. It alerts us to potential danger or threats, whether they are physical, emotional, or social.
              </p>
              <p class="font-semibold mb-1">Purpose:</p>
              <p class="text-gray-600">
                It triggers the fight-or-flight response, preparing us to either confront or avoid the threat.
              </p>
            </div>

            <div class="text-left">
              <h3 class="text-2xl font-bold text-[#6b2a6d] mb-2">Sadness</h3>
              <p class="font-semibold mb-1">Message:</p>
              <p class="text-gray-600 mb-2">
                Sadness indicates a sense of loss or disappointment. Sadness is like an energy leak that can be triggered by unmet needs or expectations.
              </p>
              <p class="font-semibold mb-1">Purpose:</p>
              <p class="text-gray-600">
                It encourages us to slow down, reflect, and process our experiences, so that we can realign, heal and grow.
              </p>
            </div>
          </div>

          <div class="flex justify-center">
            <.link patch={~p"/moods/emotions-temperature"}>
              <.button variant="filled" class="text-lg">
                CONTINUE
              </.button>
            </.link>
          </div>
        </div>
      </.centered_block>

      <.base_bg />
    </.container>
    """
  end
end
