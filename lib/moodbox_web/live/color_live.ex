defmodule MoodboxWeb.ColorLive do
  use MoodboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(colors: colors("angry"))}
  end

  def handle_params(%{"mood" => mood}, uri, socket) do
    {:noreply,
     socket
     |> assign(:current_path, uri)
     |> assign(:colors, colors(mood))}
  end

  def render(assigns) do
    ~H"""
    <.container class="overflow-hidden">
      <.centered_block>
        <.subheading>
          If your feeling had a color, what would it be?
        </.subheading>

        <div class="mt-10 lg:mt-20 flex flex-wrap gap-4 md:gap-6 lg:gap-8 justify-center">
          <.link :for={color <- @colors} patch={@current_path <> "/#{color.resource}"}>
            <.btn
              class="transition hover:scale-105 w-16 h-16 md:w-20 md:h-20 lg:w-28 lg:h-28 rounded-full"
              style={"background-color: #{color.hex}"}
              aria-label={color.name}
            />
          </.link>
        </div>
      </.centered_block>

      <.base_bg />

      <img
        phx-mounted={
          JS.transition({"ease-out duration-1000", "translate-y-[65%]", "translate-y-[50%]"})
        }
        class="absolute translate-y-[65%] z-10 bottom-0 sm:right-10 right-4 w-32 lg:w-56 transform transition-transform"
        src="https://moodbox.fly.storage.tigris.dev/right-flower.webp"
      />

      <img
        phx-mounted={
          JS.transition({"ease-out duration-1000", "translate-y-[65%]", "translate-y-[50%]"})
        }
        class="absolute translate-y-[65%] z-10 bottom-0 left-4 sm:left-10 w-32 lg:w-56 transform transition-transform"
        src="https://moodbox.fly.storage.tigris.dev/left-flower.webp"
      />
    </.container>
    """
  end

  defp colors("angry") do
    [
      %{name: "Bright Red", resource: "bright-red", hex: "#ef4444"},
      %{name: "Deep Red", resource: "deep-red", hex: "#b91c1c"},
      %{name: "Dark Red", resource: "dark-red", hex: "#7f1d1d"},
      %{name: "Light Red", resource: "light-red", hex: "#fca5a5"},
      %{name: "Pale Red", resource: "pale-red", hex: "#fee2e2"},
      %{name: "Blood Red", resource: "blood-red", hex: "#450a0a"}
    ]
  end

  defp colors("afraid") do
    [
      %{name: "Bright Yellow", resource: "bright-yellow", hex: "#fbbf24"},
      %{name: "Deep Yellow", resource: "deep-yellow", hex: "#b45309"},
      %{name: "Dark Yellow", resource: "dark-yellow", hex: "#78350f"},
      %{name: "Light Yellow", resource: "light-yellow", hex: "#fde68a"},
      %{name: "Pale Yellow", resource: "pale-yellow", hex: "#fef3c7"},
      %{name: "Amber", resource: "amber", hex: "#451a03"}
    ]
  end

  defp colors("sad") do
    [
      %{name: "Bright Blue", resource: "bright-blue", hex: "#3b82f6"},
      %{name: "Deep Blue", resource: "deep-blue", hex: "#1d4ed8"},
      %{name: "Dark Blue", resource: "dark-blue", hex: "#1e3a8a"},
      %{name: "Light Blue", resource: "light-blue", hex: "#93c5fd"},
      %{name: "Pale Blue", resource: "pale-blue", hex: "#dbeafe"},
      %{name: "Navy Blue", resource: "navy-blue", hex: "#082f49"}
    ]
  end
end
