defmodule MoodboxWeb.TemperatureLive do
  use MoodboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(temperatures: temperatures())}
  end

  def handle_params(_params, uri, socket) do
    {:noreply, assign(socket, :current_path, uri)}
  end

  def render(assigns) do
    ~H"""
    <.container class="overflow-hidden">
      <.centered_block>
        <.subheading>
          If your feeling had a temperature, what would it be?
        </.subheading>

        <div class="mt-10 lg:mt-20">
          <.link
            :for={temp <- @temperatures}
            patch={String.replace(@current_path, ~r"/[^/]+$", "/#{temp.resource}")}
            class="mt-10 flex w-44 sm:w-96"
          >
            <.btn class="transition hover:scale-105">
              <%= temp.name %>
            </.btn>
          </.link>
        </div>
      </.centered_block>

      <.base_bg />

      <img
        phx-mounted={JS.transition({"ease-out duration-1000", "translate-y-[35%]", "translate-y-[20%]"})}
        class="absolute translate-y-[35%] z-10 bottom-0 sm:right-10 right-4 w-32 lg:w-56 transform transition-transform"
        src="https://ik.imagekit.io/soulgenesis/Moodinabox/right-flower.webp"
      />

      <img
        phx-mounted={JS.transition({"ease-out duration-1000", "translate-y-[35%]", "translate-y-[20%]"})}
        class="absolute translate-y-[35%] z-10 bottom-0 left-4 sm:left-10 w-32 lg:w-56 transform transition-transform"
        src="https://ik.imagekit.io/soulgenesis/Moodinabox/left-flower.webp"
      />
    </.container>
    """
  end

  defp temperatures do
    [
      %{
        name: "Cold/Frozen",
        resource: "cold"
      },
      %{
        name: "Lukewarm/Flowing",
        resource: "lukewarm"
      },
      %{
        name: "Steamy/Hot",
        resource: "hot"
      }
    ]
  end
end
