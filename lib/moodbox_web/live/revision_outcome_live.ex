defmodule MoodboxWeb.RevisionOutcomeLive do
  use MoodboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"score" => score}, uri, socket) do
    {:noreply,
     socket
     |> assign(:current_path, uri)
     |> assign(:score, score)}
  end

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <div class="max-w-3xl mx-auto text-center px-4">
          <%= if String.to_integer(@score) >= 8 do %>
            <h1 class="text-3xl md:text-4xl lg:text-5xl font-bold text-[#6b2a6d] mb-4">
              Congrats on Creating Peace through Release!
            </h1>

            <.p class="mb-10">
              Taking control of your inner peace is fantastic and we're thrilled for you.
            </.p>

            <h2 class="text-2xl font-bold text-[#6b2a6d] mb-2">
              What's Next?
            </h2>

            <.p class="mb-10">
              It’s time to design your desired mood with a customized ritual.
            </.p>

            <div class="rounded-xl bg-white shadow-md text-gray-900 py-8 px-6 mb-2 max-w-2xl mx-auto">
              <.p class="text-center uppercase italic font-bold mb-6">
                "RITUALS ILLUMINE OUR TRANSITIONS AND ARE THE PRACTICES THAT CREATE THE FIELD OF POSSIBILITY."
              </.p>
              <.p class="text-center">
                JEAN HOUSTON
              </.p>
            </div>

            <.link class="mt-10 block" patch={@current_path <> "/explanation"}>
              <.button variant="filled" class="text-lg">
                Tell me the secret to transform my mood
              </.button>
            </.link>
          <% else %>
            <h1 class="text-3xl md:text-4xl lg:text-5xl font-bold text-[#6b2a6d] mb-4">
              Want to dive deeper into calm?
            </h1>

            <p class="text-gray-600 text-lg md:text-xl mb-6">
              We noticed your peacefulness score wasn't quite a ten. That's okay – release happens in layers!
            </p>

            <div class="grid md:grid-cols-3 gap-8 mb-12">
              <div class="text-left">
                <h3 class="text-xl font-bold text-[#6b2a6d] mb-4">
                  Give it another go.
                </h3>
                <p class="text-gray-600">
                  Tapping is most effective when done in two-three rounds and sometimes, listening to the binaural beats for a longer duration can amplify their calming effects.
                </p>
              </div>

              <div class="text-left">
                <h3 class="text-xl font-bold text-[#6b2a6d] mb-4">
                  Focus on the sensations.
                </h3>
                <p class="text-gray-600">
                  Pay close attention to any shifts in your mood or physical state as the video plays.
                </p>
              </div>

              <div class="text-left">
                <h3 class="text-xl font-bold text-[#6b2a6d] mb-4">
                  Close your eyes and relax.
                </h3>
                <p class="text-gray-600">
                  Minimize distractions and allow yourself to fully immerse yourself in the experience.
                </p>
              </div>
            </div>

            <div class="text-xl font-bold text-[#6b2a6d]">
              Let's find your perfect peace.
            </div>

            <p class="text-gray-600 text-lg mb-8">
              If you've repeated the tapping and binaurals and are not feeling more peaceful, would you like to connect with a guide to find the root cause?
            </p>

            <div class="flex gap-4 justify-center">
              <.button variant="filled" class="text-lg">
                <.link patch={String.replace(@current_path, ~r"/revision/.*$", "")}>
                  TRY AGAIN
                </.link>
              </.button>

              <.button variant="outlined" class="text-lg" phx-click="find_root">
                FIND THE ROOT
              </.button>
            </div>
          <% end %>
        </div>
      </.centered_block>

      <.base_bg />

      <img
        class="absolute z-10 bottom-0 sm:right-10 right-4 w-32 lg:w-56 transform transition-transform"
        src="https://moodbox.fly.storage.tigris.dev/right-flower.webp"
      />

      <img
        class="absolute z-10 bottom-0 left-4 sm:left-10 w-32 lg:w-56 transform transition-transform"
        src="https://moodbox.fly.storage.tigris.dev/left-flower.webp"
      />
    </.container>
    """
  end

  def handle_event("find_root", _params, socket) do
    {:noreply, push_navigate(socket, to: ~p"/root")}
  end
end
