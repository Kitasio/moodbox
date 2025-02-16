defmodule MoodboxWeb.FeelingCheckLive do
  use MoodboxWeb, :live_view

  def render(assigns) do
    ~H"""
    <.container class="min-h-screen">
      <.centered_block class="w-full h-full flex flex-col">
        <.subheading class="text-center">
          Are you feeling too much or is it hard to feel?
        </.subheading>

        <div class="flex-1 flex items-center justify-center">
          <div class="flex flex-col gap-8 w-full max-w-sm px-4">
            <div class="text-center">
              <.link patch={~p"/moods/overwhelmed"} class="w-full">
                <.button class="w-full py-6 text-lg">
                  Too much<br /> <span class="text-xs font-base">It's overwhelming</span>
                </.button>
              </.link>
            </div>

            <div class="text-center">
              <.link patch={~p"/moods/numb"} class="w-full">
                <.button class="w-full py-6 text-lg">
                  Numb<br /> <span class="text-xs font-base">I feel disconnected</span>
                </.button>
              </.link>
            </div>
          </div>
        </div>
      </.centered_block>
      <.base_bg />
    </.container>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
