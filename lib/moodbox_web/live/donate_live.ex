defmodule MoodboxWeb.DonateLive do
  use MoodboxWeb, :live_view

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        Donate
      </.centered_block>

      <.base_bg />
    </.container>
    """
  end
end
