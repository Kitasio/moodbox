defmodule MoodboxWeb.NumbLive do
  use MoodboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, videos: videos())}
  end

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <div class="flex max-w-4xl flex-col justify-center items-center gap-7">
          <.subheading>
            Let’s identify your emotions.
          </.subheading>
          <.p>
            Watch the following videos to identify which one feels most like how you feel…
          </.p>

          <p class="mb-4 text-left p-4 md:p-8 bg-white rounded-xl shadow-md">
            These tracks were designed with sounds and frequencies to help you identify the feeling of anger, fear or sadness. Once provoked, heavy emotions like frustration, anxiety, overwhelm, disappointment, or grief can be released.
            <br /><br />
            Imagery and disharmonious sounds ranging from fires, rain, tea kettles, revving engines, traffic, bass, wind, subdued piano notes, sighs, thunder, sirens, fast heartbeats, ticking clocks, and frequencies below 20hz come together to deconstruct and honor dark emotions. Once we identify and feel an emotion, we can release it.
          </p>

          <div class="flex flex-col md:flex-row gap-8 w-full">
            <div :for={video <- @videos} class="aspect-video w-full">
              <div class="w-full h-full">
                <iframe
                  class="w-full h-full"
                  src={"https://www.youtube.com/embed/#{video.id}"}
                  title="YouTube video player"
                  frameborder="0"
                  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                  referrerpolicy="strict-origin-when-cross-origin"
                  allowfullscreen
                >
                </iframe>
              </div>
            </div>
          </div>
          <div class="flex w-full justify-center gap-4">
            <.link patch={~p"/moods/emotions-education"}>
              <.button class="transition hover:scale-105 font-semibold px-8 py-3">
                Continue
              </.button>
            </.link>
          </div>
        </div>
      </.centered_block>

      <.base_bg />
    </.container>
    """
  end

  defp videos do
    [
      %{id: "7sNZJ5N0F54"},
      %{id: "p8kltPdVLr4"},
      %{id: "9_VnTKNNb60"}
    ]
  end
end
