defmodule MoodboxWeb.FeelingCheckLive do
  use MoodboxWeb, :live_view

  def render(assigns) do
    ~H"""
    <.container class="min-h-screen">
      <.centered_block class="w-full h-full flex flex-col">
        <.subheading>
          Are you feeling too much or is it hard to feel?
        </.subheading>

        <div class="flex-1 flex items-center justify-center">
          <div class="flex flex-col gap-8 w-full max-w-sm px-4">
            <div class="text-center space-y-3">
              <.link patch={~p"/moods/overwhelmed"} class="w-full">
                <.btn class="w-full py-6 text-lg">I'M FEELING TOO MUCH</.btn>
              </.link>
              <p class="text-sm text-gray-600">
                Choose this if you feel overwhelmed or intense emotions
              </p>
            </div>

            <div class="text-center space-y-3">
              <.link patch={~p"/moods/numb"} class="w-full">
                <.btn class="w-full py-6 text-lg">I'M FEELING NUMB</.btn>
              </.link>
              <p class="text-sm text-gray-600">
                Choose this if you feel disconnected or can't feel much
              </p>
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
