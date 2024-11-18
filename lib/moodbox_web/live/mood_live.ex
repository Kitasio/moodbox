defmodule MoodboxWeb.MoodLive do
  use MoodboxWeb, :live_view

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <.heading>
          How are you feeling?
        </.heading>
        <div class="mt-10 py-10 sm:px-14 flex flex-row flex-wrap">
          <div :for={mood <- @moods} class="w-1/2 lg:w-1/4 p-5 lg:p-10">
            <.link
              patch={~p"/moods/#{mood.resource}"}
              class="block transition-transform hover:scale-105"
            >
              <div class="flex flex-col items-center gap-5 lg:gap-10">
                <img src={mood.url} alt={mood.name} />
                <.btn>
                  <%= mood.name %>
                </.btn>
              </div>
            </.link>
          </div>
        </div>
      </.centered_block>

      <img
        phx-mounted={JS.transition({"ease-out duration-300", "opacity-0", "opacity-100"})}
        class="absolute inset-0 h-full w-full object-cover z-0"
        src="https://ik.imagekit.io/soulgenesis/Moodinabox/bg-base.webp"
      />
    </.container>
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
