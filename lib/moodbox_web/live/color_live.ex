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

        <div class="mt-10 lg:mt-20">
          <.link
            :for={color <- @colors}
            patch={@current_path <> "/#{color.resource}"}
            class="mt-10 flex w-44 sm:w-96"
          >
            <.btn class="transition hover:scale-105" style={"background-color: #{color.hex}"}>
              <%= color.name %>
            </.btn>
          </.link>
        </div>
      </.centered_block>

      <.base_bg />

      <img
        phx-mounted={
          JS.transition({"ease-out duration-1000", "translate-y-[65%]", "translate-y-[50%]"})
        }
        class="absolute translate-y-[65%] z-10 bottom-0 sm:right-10 right-4 w-32 lg:w-56 transform transition-transform"
        src="https://ik.imagekit.io/soulgenesis/Moodinabox/right-flower.webp"
      />

      <img
        phx-mounted={
          JS.transition({"ease-out duration-1000", "translate-y-[65%]", "translate-y-[50%]"})
        }
        class="absolute translate-y-[65%] z-10 bottom-0 left-4 sm:left-10 w-32 lg:w-56 transform transition-transform"
        src="https://ik.imagekit.io/soulgenesis/Moodinabox/left-flower.webp"
      />
    </.container>
    """
  end

  defp colors("angry") do
    [
      %{name: "Deep Red", resource: "deep-red", hex: "#b91c1c"},
      %{name: "Crimson", resource: "crimson", hex: "#991b1b"},
      %{name: "Scarlet", resource: "scarlet", hex: "#7f1d1d"},
      %{name: "Blood Red", resource: "blood-red", hex: "#450a0a"}
    ]
  end

  defp colors("afraid") do
    [
      %{name: "Pale Yellow", resource: "pale-yellow", hex: "#b45309"},
      %{name: "Light Gold", resource: "light-gold", hex: "#92400e"},
      %{name: "Amber", resource: "amber", hex: "#78350f"},
      %{name: "Mustard", resource: "mustard", hex: "#451a03"}
    ]
  end

  defp colors("sad") do
    [
      %{name: "Navy Blue", resource: "navy-blue", hex: "#0369a1"},
      %{name: "Steel Blue", resource: "steel-blue", hex: "#075985"},
      %{name: "Deep Blue", resource: "deep-blue", hex: "#0c4a6e"},
      %{name: "Midnight Blue", resource: "midnight-blue", hex: "#082f49"}
    ]
  end
end
