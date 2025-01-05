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
          <%= if String.to_integer(@score) >= 8 do %>
            <h1 class="text-3xl md:text-4xl lg:text-5xl font-bold text-[#6b2a6d] mb-4">
              <%= get_title(@score) %>
            </h1>

            <p class="text-gray-600 text-lg md:text-xl mb-8">
              <%= get_description(@score) %>
            </p>

            <h2 class="text-2xl font-bold text-[#6b2a6d] mb-6">
              WHAT'S NEXT?
            </h2>

            <p class="text-xl text-gray-800 mb-8">
              Unlock even deeper levels of relaxation and well-being through:
            </p>

            <div class="grid md:grid-cols-3 gap-8 mb-12">
              <div class="text-left">
                <h3 class="text-xl font-bold text-[#6b2a6d] mb-4">
                  Guided Hypnosis Sessions
                </h3>
                <p class="text-gray-600">
                  Reprogram your subconscious mind for lasting calm with personalized hypnotic journeys.
                </p>
              </div>

              <div class="text-left">
                <h3 class="text-xl font-bold text-[#6b2a6d] mb-4">
                  Powerful Anchoring Techniques
                </h3>
                <p class="text-gray-600">
                  Learn to trigger feelings of peace instantly with simple practices you can incorporate anywhere.
                </p>
              </div>

              <div class="text-left">
                <h3 class="text-xl font-bold text-[#6b2a6d] mb-4">
                  Exclusive Binaural Beat Library
                </h3>
                <p class="text-gray-600">
                  Access a curated collection of advanced binaural beats designed for deeper relaxation and focus.
                </p>
              </div>
            </div>

            <.button variant="filled" class="text-lg" phx-click="unlock_deeper">
              UNLOCK DEEPER LEVELS OF RELAXATION
            </.button>
          <% else %>
            <h1 class="text-3xl md:text-4xl lg:text-5xl font-bold text-[#6b2a6d] mb-4">
              Want to dive deeper into calm?
            </h1>

            <p class="text-gray-600 text-lg md:text-xl mb-6">
              We noticed your peacefulness score wasn't quite a ten. That's okay – release happens in layers!
            </p>

            <p class="text-gray-600 text-xs md:text-base mb-12">
              The binaural beats you experienced are powerful tools for relaxation, and their effects can sometimes be subtle. If you're open to it, we recommend giving them another try!
            </p>

            <div class="grid md:grid-cols-3 gap-8 mb-12">
              <div class="text-left">
                <h3 class="text-xl font-bold text-[#6b2a6d] mb-4">
                  Give it another go.
                </h3>
                <p class="text-gray-600">
                  Tapping is most effective when done in two-three rounds and sometimes, listening to the binaural beats for a longer duration can amplify their calming effects.
                </p>
              </div>

              <div class="text-left">
                <h3 class="text-xl font-bold text-[#6b2a6d] mb-4">
                  Focus on the sensations.
                </h3>
                <p class="text-gray-600">
                  Pay close attention to any shifts in your mood or physical state as the video plays.
                </p>
              </div>

              <div class="text-left">
                <h3 class="text-xl font-bold text-[#6b2a6d] mb-4">
                  Close your eyes and relax.
                </h3>
                <p class="text-gray-600">
                  Minimize distractions and allow yourself to fully immerse yourself in the experience.
                </p>
              </div>
            </div>

            <div class="text-xl font-bold text-[#6b2a6d]">
              Let's find your perfect peace.
            </div>

            <p class="text-gray-600 text-lg mb-8">
              If you've repeated the tapping and binaurals and are not feeling more peaceful, would you like to connect with a guide to find the root cause?
            </p>

            <div class="flex gap-4 justify-center">
              <.button variant="filled" class="text-lg" phx-click="try_again">
                <.link patch={
                  ~p"/moods/#{@mood}/#{@intensity}/#{@texture}/#{@location}/#{@description}/outcome/classical"
                }>
                  TRY AGAIN
                </.link>
              </.button>

              <.button variant="outlined" class="text-lg" phx-click="find_root">
                FIND THE ROOT
              </.button>
            </div>
          <% end %>
        </div>
      </.centered_block>

      <.base_bg />
    </.container>
    """
  end

  defp get_title(score) when is_binary(score) do
    score
    |> String.to_integer()
    |> get_title()
  end

  defp get_title(score) when score >= 8 do
    "Congratulations! You've Unlocked Peak Serenity!"
  end

  defp get_title(_score) do
    "Keep Going! Your Journey to Serenity Continues"
  end

  defp get_description(score) when is_binary(score) do
    score
    |> String.to_integer()
    |> get_description()
  end

  defp get_description(score) when score >= 8 do
    "Wow! A #{score} on the peacefulness scale – that's fantastic! We are thrilled to have helped you reach a state of pure calmness."
  end

  defp get_description(score) do
    "You've reached a #{score} on the peacefulness scale. While you're making progress, there's still room to achieve even deeper states of relaxation."
  end

  def handle_event("find_root", _params, socket) do
    {:noreply, push_navigate(socket, to: ~p"/root")}
  end
end
