defmodule MoodboxWeb.OverwhelmedLive do
  use MoodboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <div class="flex flex-col gap-10">
          <.subheading>
            Take a Breath: Calm Your Mind and Body
          </.subheading>
          <.p>
            Feeling overwhelmed can leave you short of breath and out of control.
            But sometimes, the simplest solution is the most effective. Follow along
            with this breathing exercise to find your center.
          </.p>
          <div class="aspect-video w-full">
            <div class="w-full h-full">
              <iframe
                class="w-full h-full"
                src="https://www.youtube.com/embed/eFXDuWgDc-U"
                title="Breathing Exercise"
                frameborder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                allowfullscreen
              >
              </iframe>
            </div>
          </div>
          <div class="flex w-full justify-center gap-4">
            <.link patch={~p"/"}>
              <.btn class="transition hover:scale-105 font-semibold px-8 py-3">
                Continue
              </.btn>
            </.link>
          </div>
        </div>
      </.centered_block>

      <.base_bg />
    </.container>
    """
  end
end
