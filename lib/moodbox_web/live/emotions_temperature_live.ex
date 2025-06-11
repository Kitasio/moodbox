defmodule MoodboxWeb.EmotionsTemperatureLive do
  use MoodboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <div class="max-w-4xl mx-auto px-4">
          <div class="flex items-center gap-4 mb-8">
            <h1 class="text-4xl md:text-5xl font-bold text-[#6b2a6d]">
              Our emotions also have a temperature.
            </h1>
          </div>

          <p class="text-xl text-gray-600 mb-8">
            Some are hot like rage, panic or grief, and some are cold like resentment, paralysis or resignation.
          </p>

          <p class="text-xl text-gray-600 mb-8">
            The states of our emotions can be compared to water, which can be frozen like ice, liquid and flowing or steamy like vapor.
          </p>

          <p class="text-xl whitespace-pre-line text-gray-600 mb-12">
            Understanding what state your emotion is in allows you to heat it up or cool it off so it can flow through and be released as it's intended to.

            Emotions aren't meant to stay with us. They give us a message so that we can change course and find equilibrium.
          </p>

          <div class="mb-12">
            <h2 class="text-2xl font-bold text-[#6b2a6d] mb-6">I think I'm feeling:</h2>
            <div class="flex flex-wrap gap-4">
              <.link patch={~p"/moods/angry"}>
                <.button variant="filled" class="text-lg">ANGRY</.button>
              </.link>
              <.link patch={~p"/moods/sad"}>
                <.button variant="filled" class="text-lg">SAD</.button>
              </.link>
              <.link patch={~p"/moods/afraid"}>
                <.button variant="filled" class="text-lg">AFRAID</.button>
              </.link>
            </div>
          </div>
        </div>
      </.centered_block>

      <.base_bg />
    </.container>
    """
  end
end
