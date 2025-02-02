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

        <div class="mt-4 text-center">
          <button phx-click={show_modal("temperature-modal")} class="">
            <div class="flex gap-1 items-center">
              More Info
              <svg
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke-width="1.5"
                stroke="currentColor"
                class="w-4 h-4"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  d="M9.879 7.519c1.171-1.025 3.071-1.025 4.242 0 1.172 1.025 1.172 2.687 0 3.712-.203.179-.43.326-.67.442-.745.361-1.45.999-1.45 1.827v.75M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Zm-9 5.25h.008v.008H12v-.008Z"
                />
              </svg>
            </div>
          </button>
        </div>

        <.modal id="temperature-modal" on_cancel={hide_modal("temperature-modal")}>
          <p>
            Our emotions have a temperature. The states of our emotions can be compared to water, which can be frozen like ice, liquid and flowing or steamy like vapor. Rage, panic or grief are examples of hot. Resentment, paralysis or resignation are examples of cold.
          </p>

          <p class="mt-3">
            Understanding what state your emotion is in allows you to heat it up or cool it off so it can flow through and be released as it’s intended to. Emotions aren’t meant to stay with us. They give us a message so that we can change course and find equilibrium.
          </p>
        </.modal>

        <div class="mt-10 lg:mt-20">
          <.link
            :for={temp <- @temperatures}
            patch={@current_path <> "/#{temp.resource}"}
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
        phx-mounted={
          JS.transition({"ease-out duration-1000", "translate-y-[50%]", "translate-y-[35%]"})
        }
        class="absolute translate-y-[50%] z-10 bottom-0 sm:right-10 right-4 w-32 lg:w-56 transform transition-transform"
        src="https://ik.imagekit.io/soulgenesis/Moodinabox/right-flower.webp"
      />

      <img
        phx-mounted={
          JS.transition({"ease-out duration-1000", "translate-y-[50%]", "translate-y-[35%]"})
        }
        class="absolute translate-y-[50%] z-10 bottom-0 left-4 sm:left-10 w-32 lg:w-56 transform transition-transform"
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
