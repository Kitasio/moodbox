defmodule MoodboxWeb.RitualLive do
  use MoodboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, mood: "angry", current_path: nil)}
  end

  def handle_params(%{"mood" => mood, "ritual" => ritual}, uri, socket) do
    back_path = uri |> String.split("/") |> Enum.drop(-1) |> Enum.join("/")

    {:noreply,
     socket
     |> assign(:current_path, uri)
     |> assign(:back_path, back_path)
     |> assign(:mood, mood)
     |> assign(:ritual, ritual)}
  end

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
       <.power_poses_page back_path={@back_path} mood={@mood} :if={@ritual == "power-poses"} />
       <.crystal_frequencies_page back_path={@back_path} mood={@mood} :if={@ritual == "crystal-frequencies"} />
      </.centered_block>
      <.base_bg />
    </.container>
    """
  end

  attr :mood, :string, required: true
  attr :back_path, :string, required: true

  defp power_poses_page(assigns) do
    ~H"""
    <div class="flex flex-col items-center gap-6 text-center">
      <.subheading>Power Poses & Flow</.subheading>
      <.h3>
        POWER POSES & FLOW: SHIFT YOUR MOOD WITH MOVEMENT
      </.h3>

      <.p class="max-w-2xl text-left whitespace-pre-line">
        Your Body Shapes Your Mind — And Your Mood. Just Like A Slouched Posture Can
        Make You Feel Low-Energy, An Open, Expansive Stance Can Instantly Boost
        Confidence, Clarity, And Joy.

        Science Backs This Up! Research By Amy Cuddy Shows That Power Poses (Like
        Standing Tall With Hands On Hips) Can Increase Testosterone (Confidence Hormone)
        And Decrease Cortisol (Stress Hormone) In Just Two Minutes. Meanwhile, Yoga
        Postures Help Balance The Nervous System, Making It Easier To Shift Into
        A State Of Power, Bliss, Or Joy.
        
        By Using Intentional Movement, You’re Not Just Posing — You’re Anchoring A New
        State Of Being. <span class="font-bold">Ready To Embody The Energy You Want? Let’s Flow.</span>
      </.p>

      <%= case @mood do %>
        <% "angry" -> %>
          <.mood_specific_poses
            title="Bliss: Surrender & Serenity"
            power_pose="Victory Pose – Stand With Feet Grounded, Arms Raised Overhead In A 'V' Shape, Chin Slightly Lifted. This Posture Exudes Effortless Triumph And A Sense Of Ease."
            yoga_pose="Child’s Pose (Balasana) – A Deeply Restorative Posture That Invites Surrender, Safety, And Relaxation. Knees Wide, Forehead To The Ground, And Arms Stretched Forward, It Fosters A Sense Of Peace."
            alternative_pose="Reclined Butterfly (Supta Baddha Konasana) – Lying On Your Back With The Soles Of Your Feet Together, Knees Falling Open, This Gentle Heart-Opener Allows For Deep Relaxation And Release."
          />
        <% "afraid" -> %>
          <.mood_specific_poses
            title="Power: Command & Strength"
            power_pose="Superhero Pose – Stand Tall With Feet Hip-Width Apart, Hands On Hips, And Chest Open. This Stance Signals Confidence, Resilience, And Readiness To Take On The World."
            yoga_pose="Warrior II (Virabhadrasana II) – A Powerful Stance That Channels Focus And Inner Strength. With Feet Grounded, Arms Extended, And Gaze Steady, You Embody Unwavering Determination."
            alternative_pose="Goddess Pose (Utkata Konasana) – A Strong, Grounded Stance With Knees Bent And Arms Raised Like A Fierce Warrior Queen. This Pose Ignites Your Inner Power And Stability."
          />
        <% "sad" -> %>
          <.mood_specific_poses
            title="Joy: Expansion & Expression"
            power_pose="Expansive Star Pose – Stand With Feet Wide Apart, Arms Fully Outstretched, And Chest Lifted. This Pose Signals Openness, Excitement, And An Embrace Of Life’s Possibilities."
            yoga_pose="Backbend (Wheel Or Camel Pose) – Heart-Opening Postures That Create Space For Joy, Exhilaration, And Emotional Release. They Lift The Spirit And Energize The Body."
            alternative_pose="Wild Thing (Camatkarasana) – A Playful, Dynamic Backbend That Feels Like A Celebration. One Hand And Foot Remain Grounded While The Other Arm And Leg Extend, Creating A Sensation Of Freedom And Joy."
          />
      <% end %>

      <.link patch={@back_path} class="my-10">
        <.button variant="outlined">Back to rituals</.button>
      </.link>
    </div>
    """
  end

  attr :title, :string, required: true
  attr :power_pose, :string, required: true
  attr :yoga_pose, :string, required: true
  attr :alternative_pose, :string, required: true

  defp mood_specific_poses(assigns) do
    ~H"""
    <div class="mt-8 max-w-2xl w-full">
      <.h3><%= @title %></.h3>
      <ul class="mt-8 list-disc space-y-4 text-left">
        <li><span class="font-semibold">Power Pose:</span> <%= @power_pose %></li>
        <li><span class="font-semibold">Yoga Pose:</span> <%= @yoga_pose %></li>
        <li><span class="font-semibold">Alternative Yoga Pose:</span> <%= @alternative_pose %></li>
      </ul>
    </div>
    """
  end

  attr :title, :string, required: true
  attr :description, :string, required: true
  attr :water_ritual, :string, required: true
  attr :charging_ritual, :string, required: true
  attr :anchor_ritual, :string, required: true

  defp mood_specific_crystals(assigns) do
    ~H"""
    <div class="mt-8 max-w-2xl w-full">
      <.h3><%= @title %></.h3>
      <.p class="mt-4 text-left"><%= @description %></.p>
      <ul class="mt-4 list-disc space-y-2 text-left pl-5">
        <li><span class="font-semibold">Crystal Water Ritual:</span> <%= @water_ritual %></li>
        <li><span class="font-semibold">Moonlight/Sunlight Charging:</span> <%= @charging_ritual %></li>
        <li><span class="font-semibold">Blissful/Empowerment/Happiness Anchor:</span> <%= @anchor_ritual %></li>
      </ul>
    </div>
    """
  end

  attr :mood, :string, required: true
  attr :back_path, :string, required: true

  defp crystal_frequencies_page(assigns) do
      ~H"""
      <div class="flex flex-col items-center gap-6 text-center">
        <.subheading>Crystal Frequencies</.subheading>
        <.h3>
          Crystal Frequencies: Aligning Your Energy for Bliss, Power & Joy
        </.h3>

        <.p class="max-w-2xl md:px-10 text-left whitespace-pre-line">Crystals are powerful tools that help balance our frequency, acting as energetic anchors for our emotions and intentions. By pairing them with water, affirmations, and mindful placement, we can amplify their effects and cultivate a deeper connection with our desired emotional state.

        <span class="font-bold">The Power of Intention & Crystalline Structure: Lessons from Masaru Emoto</span>
        Dr. Masaru Emoto was a Japanese researcher who explored the impact of words, emotions, and intentions on the molecular structure of water. His groundbreaking work demonstrated that water responds to human consciousness, forming beautifully intricate or chaotic crystalline patterns based on the energy it is exposed to.

        <span class="font-bold">Water, Emotion & Intention</span>
        Emoto’s experiments involved exposing water to different words, sounds, and emotions before freezing it. Under a microscope, the frozen water droplets revealed:
        • Harmonious, symmetrical crystals when infused with loving words, gratitude, and positive emotions.
        • Disordered, fragmented structures when exposed to negativity, anger, or harsh language.
        Because the human body is over 60% water, Emoto’s research suggests that our thoughts and emotions literally shape us at a molecular level. Just like water, we crystallize the energy we are immersed in.

        <span class="font-bold">Crystals as Energy Amplifiers</span>
        Natural crystals and gemstones are also structured in precise geometric formations, making them powerful conduits for intention and frequency alignment. Just as water takes on the vibrational imprint of words and thoughts, crystals absorb, store, and amplify energy—which is why they’ve been used for healing and manifestation for centuries.

        <span class="font-bold">Bridging Water, Crystals & Intention</span>
        By combining Emoto’s water techniques with crystal energy, you can create a potent frequency-shifting practice:
        • Charge Your Water: Place a written affirmation (such as peace, confidence, or joy) under your water pitcher, or add a crystal nearby to infuse the water with its energy.
        • Crystal Programming: Hold a crystal in your hands, focus on a specific intention, and mentally imprint it with your desired frequency.
        • Sleep & Dream Work: Keep a crystal under your pillow with an affirmation card, allowing your subconscious to integrate positive shifts overnight.

        Both water and crystals hold memory, acting as energetic mirrors that reflect and reinforce our inner state. When we consciously engage with them, we create a bridge between the physical and energetic realms, allowing us to align with the emotions and experiences we wish to cultivate.

        <span class="font-bold">Cleansing & Charging Your Crystals</span>
        • Moonlight: Place your crystals under the full moon to cleanse and recharge them with gentle, reflective energy.
        • Sunlight: Let crystals like amazonite and carnelian soak in the morning sun to boost their vitality.
        • Water Rinse: Run crystals under a stream of cool water, visualizing negativity washing away.
        </.p>

        <%= case @mood do %>
          <% "angry" -> %>
            <.mood_specific_crystals
              title="Bliss: Rose Quartz & the Energy of Peace"
              description="Rose Quartz is the stone of unconditional love and emotional harmony. Its soft, nurturing energy encourages self-compassion, inner peace, and deep bliss."
              water_ritual="Place a rose quartz near your water pitcher or under your cup. You can also print an intention card with a word like serenity or love and set it underneath to infuse your water with a peaceful frequency."
              charging_ritual="Let your rose quartz bathe in the light of a full moon overnight, absorbing the calming lunar energy."
              anchor_ritual="Keep a small rose quartz crystal on your nightstand or under your pillow to promote restful sleep and heart-centered dreams."
            />
          <% "afraid" -> %>
            <.mood_specific_crystals
              title="Power: Amazonite & the Strength of Clear Intention"
              description="Amazonite is known for its bold, empowering energy. It helps you speak your truth, set boundaries, and move forward with confidence."
              water_ritual="Print an affirmation card with words like strength or clarity and place it under a pitcher of water to charge it with intention."
              charging_ritual="Amazonite thrives in morning sunlight, absorbing the energizing rays to boost motivation."
              anchor_ritual="Hold a small amazonite stone in your palm when making important decisions or speaking with conviction."
            />
          <% "sad" -> %>
            <.mood_specific_crystals
              title="Joy: Carnelian & the Fire of Creativity"
              description="Carnelian radiates warm, uplifting energy, sparking creativity, enthusiasm, and playfulness."
              water_ritual="Drop clean smooth carnelian stones in your water or place it near your glass while setting the intention for vibrant joy."
              charging_ritual="Let your carnelian charge in direct sunlight, amplifying its lively, passionate energy."
              anchor_ritual="Keep a carnelian stone on your desk or in your pocket to remind you to embrace joy and spontaneity throughout the day."
            />
        <% end %>

        <.link patch={@back_path} class="my-10">
          <.button variant="outlined">Back to rituals</.button>
        </.link>
      </div>
      """
    end
end
