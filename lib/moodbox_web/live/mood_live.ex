defmodule MoodboxWeb.MoodLive do
  use MoodboxWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="max-w-screen-xl mx-auto p-6">
      <h1 class="text-5xl sm:text-6xl xl:text-7xl max-w-4xl xl:tracking-wide leading-tight sm:leading-snug text-[#6b2a6d] font-extrabold">
        How are you feeling?
      </h1>
      <div class="mt-10 py-10 px-14 flex flex-col sm:flex-row sm:flex-wrap">
        <div :for={mood <- @moods} class="sm:w-1/2 md:w-1/4 p-5">
          <.link patch={~p"/moods/#{mood.resource}"}>
            <div class="flex flex-col items-center gap-5">
              <img src={mood.url} alt={mood.name} />
              <button class="px-8 py-4 xl:py-6 xl:px-12 w-full xl:text-xl font-bold tracking-wider cursor-pointer rounded-full bg-[#6b2a6d] text-white">
                <%= mood.name %>
              </button>
            </div>
          </.link>
        </div>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    socket = assign(socket, :moods, moods())
    {:ok, socket}
  end

  defp moods() do
    [
      %{
        name: "Angry",
        resource: "angry",
        url: "https://ik.imagekit.io/soulgenesis/Moodinabox/angry.webp"
      },
      %{
        name: "Sad",
        resource: "sad",
        url: "https://ik.imagekit.io/soulgenesis/Moodinabox/sad.webp"
      },
      %{
        name: "Afraid",
        resource: "afraid",
        url: "https://ik.imagekit.io/soulgenesis/Moodinabox/afraid.webp"
      },
      %{
        name: "I'm not sure",
        resource: "not-sure",
        url: "https://ik.imagekit.io/soulgenesis/Moodinabox/not%20sure.webp"
      }
    ]
  end
end
