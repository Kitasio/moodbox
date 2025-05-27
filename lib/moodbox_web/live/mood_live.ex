defmodule MoodboxWeb.MoodLive do
  use MoodboxWeb, :live_view

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <.subheading>
          How are you feeling?
        </.subheading>
        <div class="mt-10 py-10 sm:px-14 flex flex-row flex-wrap">
          <div :for={mood <- @moods} class="w-1/2 lg:w-1/4 p-5 lg:p-10">
            <.link
              patch={if mood.resource == "not-sure", do: ~p"/moods/not-sure", else: ~p"/moods/#{mood.resource}"}
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

      <.base_bg />
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
        url: "https://moodbox.fly.storage.tigris.dev/angry.webp"
      },
      %{
        name: "Sad",
        resource: "sad",
        url: "https://moodbox.fly.storage.tigris.dev/sad.webp"
      },
      %{
        name: "Afraid",
        resource: "afraid",
        url: "https://moodbox.fly.storage.tigris.dev/afraid.webp"
      },
      %{
        name: "I'm not sure",
        resource: "not-sure",
        url: "https://moodbox.fly.storage.tigris.dev/not%20sure.webp"
      }
    ]
  end
end
