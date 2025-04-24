defmodule MoodboxWeb.RitualLive do
  use MoodboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, mood: "angry", current_path: nil)}
  end

  def handle_params(%{"mood" => mood}, uri, socket) do
    {:noreply,
     socket
     |> assign(:current_path, uri)
     |> assign(:mood, mood)}
  end

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <div>TBD</div>
      </.centered_block>
    </.container>
    """
  end
end
