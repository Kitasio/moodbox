defmodule MoodboxWeb.TextureLive do
  use MoodboxWeb, :live_view

  def mount(params, _session, socket) do
    mood = params["mood"] || "angry"
    intensity = params["intensity"]

    {:ok,
     socket
     |> assign(mood: mood)
     |> assign(intensity: intensity)
     |> assign(textures: textures())}
  end

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <.subheading>
          If your feeling had a texture, what would it be?
        </.subheading>

        <div class="mt-10 lg:mt-20">
          <.link
            :for={texture <- @textures}
            patch={~p"/moods/#{@mood}/#{@intensity}/#{texture.resource}"}
            class="mt-10 flex w-44 sm:w-96"
          >
            <.btn class="transition hover:scale-105">
              <%= texture.name %>
            </.btn>
          </.link>
        </div>
      </.centered_block>

      <img
        class="absolute inset-0 h-full w-full object-cover z-0"
        src="https://ik.imagekit.io/soulgenesis/Moodinabox/bg-base.webp"
      />

      <img
        phx-mounted={JS.transition({"ease-out duration-1000", "translate-y-3/4", "translate-y-2/4"})}
        class="absolute translate-y-3/4 z-10 bottom-0 sm:right-10 right-4 w-32 lg:w-56 transform transition-transform"
        src="https://ik.imagekit.io/soulgenesis/Moodinabox/right-flower.webp"
      />

      <img
        phx-mounted={JS.transition({"ease-out duration-1000", "translate-y-3/4", "translate-y-2/4"})}
        class="absolute translate-y-3/4 z-10 bottom-0 left-4 sm:left-10 w-32 lg:w-56 transform transition-transform"
        src="https://ik.imagekit.io/soulgenesis/Moodinabox/left-flower.webp"
      />
    </.container>
    """
  end

  defp textures do
    [
      %{
        name: "Soft - Mushy",
        resource: "soft"
      },
      %{
        name: "Hard - Sharp",
        resource: "hard"
      },
      %{
        name: "Neither",
        resource: "neither"
      }
    ]
  end
end
