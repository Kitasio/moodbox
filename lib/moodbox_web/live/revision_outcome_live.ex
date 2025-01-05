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
            Want to dive deeper into calm?
          </h1>

          <p class="text-gray-600 text-lg md:text-xl mb-6">
            We noticed your peacefulness score wasn't quite a 10. That's okay – sometimes finding the perfect mood boost takes a little experimentation!
          </p>

          <p class="text-gray-600 text-lg md:text-xl mb-12">
            The binaural beats you experienced are powerful tools for relaxation, and their effects can sometimes be subtle. If you're open to it, we recommend giving them another try!
          </p>

          <div class="grid md:grid-cols-3 gap-8 mb-12">
            <div>
              <h3 class="text-xl font-bold text-[#6b2a6d] mb-4">
                Binaural beats work cumulatively.
              </h3>
              <p class="text-gray-600">
                Sometimes, listening for a longer duration or multiple times can amplify their calming effects.
              </p>
            </div>

            <div>
              <h3 class="text-xl font-bold text-[#6b2a6d] mb-4">
                Focus on the sensations.
              </h3>
              <p class="text-gray-600">
                Pay close attention to any shifts in your mood or physical state as the video plays.
              </p>
            </div>

            <div>
              <h3 class="text-xl font-bold text-[#6b2a6d] mb-4">
                Close your eyes and relax.
              </h3>
              <p class="text-gray-600">
                Minimize distractions and allow yourself to fully immerse yourself in the experience.
              </p>
            </div>
          </div>

          <div class="text-xl font-bold text-[#6b2a6d] mb-8">
            Let's Find Your Perfect Peace:
          </div>

          <div class="flex gap-4 justify-center">
            <.button
              class="bg-[#6b2a6d] text-white px-8 py-4 rounded-lg text-lg font-semibold hover:bg-[#5a2359] transition-colors"
              phx-click="try_again"
            >
              TRY AGAIN
            </.button>

            <.button
              class="border-2 border-[#6b2a6d] text-[#6b2a6d] px-8 py-4 rounded-lg text-lg font-semibold hover:bg-[#6b2a6d] hover:text-white transition-colors"
              phx-click="find_root"
            >
              FIND THE ROOT
            </.button>
          </div>
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
  def handle_event("try_again", _params, socket) do
    {:noreply, push_navigate(socket, to: ~p"/revision")}
  end

  def handle_event("find_root", _params, socket) do
    {:noreply, push_navigate(socket, to: ~p"/root")}
  end
end
