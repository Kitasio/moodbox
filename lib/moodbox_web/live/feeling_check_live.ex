defmodule MoodboxWeb.FeelingCheckLive do
  use MoodboxWeb, :live_view

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <.subheading>
          Are you feeling too much or is it hard to feel?
        </.subheading>
        <div class="mt-10 flex flex-col sm:flex-row gap-5 justify-center">
          <.link patch={~p"/moods/overwhelmed"}>
            <.btn>I'M FEELING TOO MUCH</.btn>
          </.link>
          <.link patch={~p"/moods/numb"}>
            <.btn>I'M FEELING NUMB</.btn>
          </.link>
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
