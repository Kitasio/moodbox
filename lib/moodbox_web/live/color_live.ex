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
            patch={String.replace(@current_path, ~r"/[^/]+$", "/#{color.resource}")}
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
        phx-mounted={JS.transition({"ease-out duration-1000", "translate-y-[60%]", "translate-y-[35%]"})}
        class="absolute translate-y-[60%] z-10 bottom-0 sm:right-10 right-4 w-32 lg:w-56 transform transition-transform"
        src="https://ik.imagekit.io/soulgenesis/Moodinabox/right-flower.webp"
      />

      <img
        phx-mounted={JS.transition({"ease-out duration-1000", "translate-y-[60%]", "translate-y-[35%]"})}
        class="absolute translate-y-[60%] z-10 bottom-0 left-4 sm:left-10 w-32 lg:w-56 transform transition-transform"
        src="https://ik.imagekit.io/soulgenesis/Moodinabox/left-flower.webp"
      />
    </.container>
    """
  end

  defp colors("angry") do
    [
      %{name: "Deep Red", resource: "deep-red", hex: "#8B0000"},
      %{name: "Crimson", resource: "crimson", hex: "#DC143C"},
      %{name: "Scarlet", resource: "scarlet", hex: "#FF2400"},
      %{name: "Blood Red", resource: "blood-red", hex: "#880808"}
    ]
  end

  defp colors("afraid") do
    [
      %{name: "Pale Yellow", resource: "pale-yellow", hex: "#FFF68F"},
      %{name: "Light Gold", resource: "light-gold", hex: "#FFD700"},
      %{name: "Amber", resource: "amber", hex: "#FFBF00"},
      %{name: "Mustard", resource: "mustard", hex: "#FFD700"}
    ]
  end

  defp colors("sad") do
    [
      %{name: "Navy Blue", resource: "navy-blue", hex: "#000080"},
      %{name: "Steel Blue", resource: "steel-blue", hex: "#4682B4"},
      %{name: "Deep Blue", resource: "deep-blue", hex: "#00008B"},
      %{name: "Midnight Blue", resource: "midnight-blue", hex: "#191970"}
    ]
  end
end
