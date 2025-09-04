defmodule MoodboxWeb.RitualLive do
  use MoodboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, mood: "angry", current_path: nil)}
  end

  def handle_params(%{"mood" => mood, "ritual" => ritual}, uri, socket) do
    back_path = uri |> String.split("/") |> Enum.drop(-1) |> Enum.join("/")
    %{img: crystal_img, label: crystal_label, color: crystal_color} = crystal_config(mood)

    {:noreply,
     socket
     |> assign(:current_path, uri)
     |> assign(:back_path, back_path)
     |> assign(:mood, mood)
     |> assign(:crystal_img, crystal_img)
     |> assign(:crystal_label, crystal_label)
     |> assign(:crystal_color, crystal_color)
     |> assign(:ritual, ritual)}
  end

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <.power_poses_page :if={@ritual == "power-poses"} back_path={@back_path} mood={@mood} />
        <.crystal_frequencies_page
          :if={@ritual == "crystal-frequencies"}
          back_path={@back_path}
          mood={@mood}
          crystal_img={@crystal_img}
          crystal_label={@crystal_label}
          crystal_color={@crystal_color}
        />
        <.elemental_immersion_page
          :if={@ritual == "elemental-immersion"}
          back_path={@back_path}
          mood={@mood}
        />
        <.alchemy_of_scent_page
          :if={@ritual == "alchemy-of-scent"}
          back_path={@back_path}
          mood={@mood}
        />
        <.tea_ceremony_page :if={@ritual == "tea-ceremony"} back_path={@back_path} mood={@mood} />
        <.light_language :if={@ritual == "light-language"} mood={@mood} back_path={@back_path} />
      </.centered_block>
      <.base_bg />
    </.container>
    """
  end

  attr :mood, :string, required: true
  attr :back_path, :string, required: true

  defp light_language(assigns) do
    ~H"""
    <div class="flex flex-col gap-6 text-center">
      <.subheading>Language of Light: Exploring Positive States</.subheading>

      <.p class="max-w-2xl text-left whitespace-pre-line">
        At Mood in a Box, we honor each emotion’s texture—not just the challenging ones we often dissect, but the luminous, subtle positive states we seldom name.
      </.p>

      <div class="max-w-2xl text-left">
        <p class="font-bold">Why this matters:</p>
        <ul class="list-disc space-y-2 pl-5 mt-2">
          <li>Naming a positive feeling with precision deepens your experience of it</li>
          <li>It opens new possibilities for aligning internal state with external action</li>
          <li>It rewires your mood map toward choice and presence</li>
        </ul>
      </div>

      <div class="bg-white rounded-xl shadow mt-10 p-4 md:p-8">
        <.h3>Let’s experiment:</.h3>

        <ol class="max-w-2xl w-full list-decimal space-y-2 text-left pl-5 mt-4">
          <li>
            Choose a word like
            <span class="font-semibold">radiant, peaceful, buoyant, enchanted, freedom,</span>
            or <span class="font-semibold">grounded.</span>
          </li>
          <li>
            Close your eyes and imagine stepping into that feeling—with imagery, sensory texture, metaphor, scene.
          </li>
          <li>
            Notice the tone the word sets within: is it warm like sunlight, soft like velvet, expansive like sky?
          </li>
        </ol>

        <.p class="max-w-2xl font-bold text-left mt-8">
          Example: “Enchanted”
        </.p>
        <.p class="text-left mt-2">
          Imagine a twilight forest illuminated by twinkling fireflies, moss soft under bare feet, and the air humming with whispered magic. Your heart feels curious, alive, receptive—pulled into spacious wonder. That’s enchanted: presence, awe, openness combined.
        </.p>

        <.p class="text-left mt-8">
          <span class="font-bold">Now you try:</span>
          choose a word below and feel it. What does your version of “radiant” or “peaceful” taste like, sound like, hold in your body? Let your mind wander into the sensory richness of that word.
        </.p>
      </div>

      <div class="max-w-4xl w-full text-left">
        <%= case @mood do %>
          <% "sad" -> %>
            <.mood_specific_language
              welcome_message="Welcome to the Language of Joy. Joy is not just a feeling—it’s a frequency that elevates everything it touches. From playful sparks to radiant inner light, each word here captures a unique facet of joy’s spectrum. As you explore, notice which words make your heart lift or your smile emerge. Let joy become something you practice, not just experience spontaneously."
              subheading="🌞 JOY — The Lighthearted Spark"
              words={joy_words()}
            />
          <% "angry" -> %>
            <.mood_specific_language
              welcome_message="Welcome to the Language of Bliss. Bliss is the sacred stillness where time melts and presence expands. These words invite you into subtlety, softness, and serenity—into the spaces where the soul exhales. As you move through them, allow yourself to slow down, drop in, and feel the elegance of being deeply at ease."
              subheading="🌸 BLISS — The Sacred Stillness"
              words={bliss_words()}
            />
          <% "afraid" -> %>
            <.mood_specific_language
              welcome_message="Welcome to the Language of Power. True power is rooted, sovereign, and magnetic—not forceful, but aligned. These words are keys to activating the potent energy that already lives within you. Read slowly. Let the language awaken something ancient, clear, and fiercely alive. Power isn’t something we take—it’s something we remember."
              subheading="🔥 POWER — The Embodied Force"
              words={power_words()}
            />
        <% end %>
      </div>
      <.link patch={@back_path} class="my-10">
        <.button variant="outlined">Back to rituals</.button>
      </.link>
    </div>
    """
  end

  attr :welcome_message, :string, required: true
  attr :subheading, :string, required: true
  attr :words, :list, required: true

  defp mood_specific_language(assigns) do
    ~H"""
    <div>
      <.h3 class="mt-8"><%= @subheading %></.h3>
      <.p class="whitespace-pre-line text-left mb-10"><%= @welcome_message %></.p>
      <div :for={item <- @words} class="mt-6">
        <p class="font-semibold md:text-2xl">
          <%= item.number %> <span title={item.definition}><%= item.term %></span>
        </p>
        <p>
          <%= item.description %>
        </p>
      </div>
    </div>
    """
  end

  attr :mood, :string, required: true
  attr :back_path, :string, required: true

  defp power_poses_page(assigns) do
    ~H"""
    <div class="flex flex-col items-center gap-6 text-center">
      <.subheading>Power poses & flow</.subheading>
      <.h4>
        Power poses & flow: Shift your mood with movement
      </.h4>

      <.p class="max-w-2xl text-left whitespace-pre-line">
        Your body shapes your mind—and your mood. Just like a slouched posture can
        make you feel low-energy, an open, expansive stance can instantly boost
        confidence, clarity, and joy.

        Science backs this up! Research by Amy Cuddy shows that power poses (like standing tall with hands on hips) can increase testosterone (confidence hormone) and decrease cortisol (stress hormone) in just two minutes. Meanwhile, yoga postures help balance the nervous system, making it easier to shift into a state of power, bliss, or joy.

        By using intentional movement, you’re not just posing—you’re anchoring a new
        state of being. <br />
        <span class="font-bold">Ready to embody the energy you want? Let’s flow.</span>
      </.p>

      <%= case @mood do %>
        <% "angry" -> %>
          <.mood_specific_poses
            title="Bliss: Surrender & serenity"
            power_pose_name="Victory Pose"
            power_pose_description="Stand with feet grounded, arms raised overhead in a 'V' shape, chin slightly lifted. This posture exudes effortless triumph and a sense of ease."
            power_pose_img="https://moodbox.fly.storage.tigris.dev/yoga_angry_1.png"
            yoga_pose_name="Child’s Pose (Balasana)"
            yoga_pose_description="A deeply restorative posture that invites surrender, safety, and relaxation. Knees wide, forehead to the ground, and arms stretched forward, it fosters a sense of peace."
            yoga_pose_img="https://moodbox.fly.storage.tigris.dev/yoga_angry_2.png"
            alternative_pose_name="Reclined Butterfly (Supta Baddha Konasana)"
            alternative_pose_description="Lying on your back with the soles of your feet together, knees falling open, this gentle heart-opener allows for deep relaxation and release."
            alt_pose_img="https://moodbox.fly.storage.tigris.dev/yoga_angry_3.png"
          />
        <% "afraid" -> %>
          <.mood_specific_poses
            title="Power: Command & strength"
            power_pose_name="Superhero Pose"
            power_pose_description="Stand tall with feet hip-width apart, hands on hips, and chest open. This stance signals confidence, resilience, and readiness to take on the world."
            power_pose_img="https://moodbox.fly.storage.tigris.dev/afraid_yoga_1.png"
            yoga_pose_name="Warrior II (Virabhadrasana II)"
            yoga_pose_description="A powerful stance that channels focus and inner strength. With feet grounded, arms extended, and gaze steady, you embody unwavering determination."
            yoga_pose_img="https://moodbox.fly.storage.tigris.dev/afraid_yoga_2.png"
            alternative_pose_name="Goddess Pose (Utkata Konasana)"
            alternative_pose_description="A strong, grounded stance with knees bent and arms raised like a fierce warrior queen. This pose ignites your inner power and stability."
            alt_pose_img="https://moodbox.fly.storage.tigris.dev/afraid_yoga_3.png"
          />
        <% "sad" -> %>
          <.mood_specific_poses
            title="Joy: Expansion & expression"
            power_pose_name="Expansive Star Pose"
            power_pose_description="Stand with feet wide apart, arms fully outstretched, and chest lifted. This pose signals openness, excitement, and an embrace of life’s possibilities."
            power_pose_img="https://moodbox.fly.storage.tigris.dev/yoga_sad_1.png"
            yoga_pose_name="Backbend (Wheel or Camel Pose)"
            yoga_pose_description="Heart-opening postures that create space for joy, exhilaration, and emotional release. They lift the spirit and energize the body."
            yoga_pose_img="https://moodbox.fly.storage.tigris.dev/yoga_sad_2.png"
            alternative_pose_name="Wild Thing (Camatkarasana)"
            alternative_pose_description="A playful, dynamic backbend that feels like a celebration. One hand and foot remain grounded while the other arm and leg extend, creating a sensation of freedom and joy."
            alt_pose_img="https://moodbox.fly.storage.tigris.dev/yoga_sad_3.png"
          />
      <% end %>

      <.link patch={@back_path} class="my-10">
        <.button variant="outlined">Back to rituals</.button>
      </.link>
    </div>
    """
  end

  attr :title, :string, required: true
  attr :power_pose_name, :string, required: true
  attr :power_pose_description, :string, required: true
  attr :power_pose_img, :string, required: true
  attr :yoga_pose_name, :string, required: true
  attr :yoga_pose_description, :string, required: true
  attr :yoga_pose_img, :string, required: true
  attr :alternative_pose_name, :string, required: true
  attr :alternative_pose_description, :string, required: true
  attr :alt_pose_img, :string, required: true

  defp mood_specific_poses(assigns) do
    ~H"""
    <div class="max-w-4xl w-full text-left">
      <.h3 class="md:text-center uppercase"><%= @title %></.h3>
      <.h3 class="md:text-center">Power Pose</.h3>
      <p class="mt-8 font-semibold md:text-lg xl:text-2xl"><%= @power_pose_name %></p>
      <details>
        <summary class="cursor-pointer text-gray-800">
          Instructions
        </summary>
        <.p class="mt-2 p-4 font-normal text-left bg-white rounded-xl shadow-md">
          <%= @power_pose_description %>
        </.p>
      </details>
      <div class="mx-auto flex items-center justify-center">
        <img src={@power_pose_img} alt="power pose picture" />
      </div>

      <.h3 class="mt-8 md:text-center">Yoga Poses</.h3>
      <p class="mt-8 font-semibold md:text-lg xl:text-2xl"><%= @yoga_pose_name %></p>
      <details>
        <summary class="cursor-pointer text-gray-800">
          Instructions
        </summary>
        <.p class="mt-2 p-4 font-normal text-left bg-white rounded-xl shadow-md">
          <%= @yoga_pose_description %>
        </.p>
      </details>
      <div class="mx-auto flex items-center justify-center">
        <img src={@yoga_pose_img} alt="yoga pose picture" />
      </div>

      <p class="mt-8 font-semibold md:text-lg xl:text-2xl"><%= @alternative_pose_name %></p>
      <details>
        <summary class="cursor-pointer text-gray-800">
          Instructions
        </summary>
        <.p class="mt-2 p-4 font-normal text-left bg-white rounded-xl shadow-md">
          <%= @alternative_pose_description %>
        </.p>
      </details>
      <div class="mx-auto flex items-center justify-center">
        <img src={@alt_pose_img} alt="alternative pose picture" />
      </div>
    </div>
    """
  end

  attr :title, :string, required: true
  attr :description, :string, required: true
  attr :water_ritual, :string, required: true
  attr :charging_ritual, :string, required: true
  attr :anchor_ritual, :string, required: true
  attr :stone_img, :string, required: true

  defp mood_specific_crystals(assigns) do
    ~H"""
    <div class="mt-8 max-w-2xl w-full text-left">
      <.h3 class="text-center"><%= @title %></.h3>
      <.p class="mt-4"><%= @description %></.p>
      <div class="my-16 mx-auto w-3/4 sm:w-1/2 h-64 rounded-lg flex items-center justify-center text-gray-500">
        <img src={@stone_img} />
      </div>
      <ul class="mt-4 list-disc space-y-2 pl-5">
        <li><span class="font-semibold">Crystal Water Ritual:</span> <%= @water_ritual %></li>
        <li>
          <span class="font-semibold">Moonlight/Sunlight Charging:</span> <%= @charging_ritual %>
        </li>
        <li>
          <span class="font-semibold">Blissful/Empowerment/Happiness Anchor:</span> <%= @anchor_ritual %>
        </li>
      </ul>
    </div>
    """
  end

  attr :mood, :string, required: true
  attr :back_path, :string, required: true
  attr :crystal_img, :string, required: true
  attr :crystal_label, :string, required: true
  attr :crystal_color, :string, required: true

  defp crystal_frequencies_page(assigns) do
    ~H"""
    <div class="flex flex-col items-center gap-6 text-center">
      <.subheading>Crystal frequencies</.subheading>
      <.h4>
        Crystal frequencies: Aligning your energy for bliss, power & joy
      </.h4>

      <.p class="max-w-2xl md:px-10 text-left whitespace-pre-line">
        Crystals are powerful tools that help balance our frequency, acting as energetic anchors for our emotions and intentions. By pairing them with water, affirmations, and mindful placement, we can amplify their effects and cultivate a deeper connection with our desired emotional state.
        <span class="font-bold">
          The power of intention & crystalline structure: Lessons from Masaru Emoto
        </span>
        Dr. Masaru Emoto was a Japanese researcher who explored the impact of words, emotions, and intentions on the molecular structure of water. His groundbreaking work demonstrated that water responds to human consciousness, forming beautifully intricate or chaotic crystalline patterns based on the energy it is exposed to.
        <br />
        <span class="font-bold">Water, emotion & intention</span>
        Emoto’s experiments involved exposing water to different words, sounds, and emotions before freezing it. Under a microscope, the frozen water droplets revealed:
        • Harmonious, symmetrical crystals when infused with loving words, gratitude, and positive emotions
        • Disordered, fragmented structures when exposed to negativity, anger, or harsh language

        Because the human body is over 60% water, Emoto’s research suggests that our thoughts and emotions literally shape us at a molecular level. Just like water, we crystallize the energy we are immersed in.
        <div class="max-w-sm flex flex-col gap-3">
          <a target="_blank" download href={@crystal_img}>
            <.button variant="outlined">Download Crystal Image</.button>
            <p class={"#{@crystal_color} mt-2 font-medium lg:text-xl uppercase"}>
              <%= @crystal_label %>
            </p>
          </a>
          <br />
        </div>
      </.p>
      <.p class="max-w-2xl md:px-10 text-left whitespace-pre-line">
        <span class="font-bold">Crystals as energy amplifiers</span>
        Natural crystals and gemstones are also structured in precise geometric formations, making them powerful conduits for intention and frequency alignment. Just as water takes on the vibrational imprint of words and thoughts, crystals absorb, store, and amplify energy—which is why they’ve been used for healing and manifestation for centuries.
        <br />
        <span class="font-bold">Bridging water, crystals & intention</span>
        By combining Emoto’s water techniques with crystal energy, you can create a potent frequency-shifting practice:
        • Charge your water: Place a written affirmation (such as peace, confidence, or joy) under your water pitcher, or add a crystal nearby to infuse the water with its energy
        • Crystal programming: Hold a crystal in your hands, focus on a specific intention, and mentally imprint it with your desired frequency
        • Sleep & dream work: Keep a crystal under your pillow with an affirmation card, allowing your subconscious to integrate positive shifts overnight

        Both water and crystals hold memory, acting as energetic mirrors that reflect and reinforce our inner state. When we consciously engage with them, we create a bridge between the physical and energetic realms, allowing us to align with the emotions and experiences we wish to cultivate.
        <br />
        <span class="font-bold">Cleansing & charging your crystals</span>
        • Moonlight: Place your crystals under the full moon to cleanse and recharge them with gentle, reflective energy
        • Sunlight: Let crystals like amazonite and carnelian soak in the morning sun to boost their vitality
        • Water rinse: Run crystals under a stream of cool water, visualizing negativity washing away
      </.p>

      <%= case @mood do %>
        <% "angry" -> %>
          <.mood_specific_crystals
            title="Bliss: Rose Quartz & the Energy of Peace"
            description="Rose Quartz is the stone of unconditional love and emotional harmony. Its soft, nurturing energy encourages self-compassion, inner peace, and deep bliss."
            water_ritual="Place a rose quartz near your water pitcher or under your cup. You can also print an intention card with a word like serenity or love and set it underneath to infuse your water with a peaceful frequency."
            charging_ritual="Let your rose quartz bathe in the light of a full moon overnight, absorbing the calming lunar energy."
            anchor_ritual="Keep a small rose quartz crystal on your nightstand or under your pillow to promote restful sleep and heart-centered dreams."
            stone_img="https://moodbox.fly.storage.tigris.dev/rose_quartz.webp"
          />
        <% "afraid" -> %>
          <.mood_specific_crystals
            title="Power: Amazonite & the Strength of Clear Intention"
            description="Amazonite is known for its bold, empowering energy. It helps you speak your truth, set boundaries, and move forward with confidence."
            water_ritual="Print an affirmation card with words like strength or clarity and place it under a pitcher of water to charge it with intention."
            charging_ritual="Amazonite thrives in morning sunlight, absorbing the energizing rays to boost motivation."
            anchor_ritual="Hold a small amazonite stone in your palm when making important decisions or speaking with conviction."
            stone_img="https://moodbox.fly.storage.tigris.dev/Amazonite.webp"
          />
        <% "sad" -> %>
          <.mood_specific_crystals
            title="Joy: Carnelian & the Fire of Creativity"
            description="Carnelian radiates warm, uplifting energy, sparking creativity, enthusiasm, and playfulness."
            water_ritual="Drop clean smooth carnelian stones in your water or place it near your glass while setting the intention for vibrant joy."
            charging_ritual="Let your carnelian charge in direct sunlight, amplifying its lively, passionate energy."
            anchor_ritual="Keep a carnelian stone on your desk or in your pocket to remind you to embrace joy and spontaneity throughout the day."
            stone_img="https://moodbox.fly.storage.tigris.dev/Carnelian.webp"
          />
      <% end %>

      <.link patch={@back_path} class="my-10">
        <.button variant="outlined">Back to rituals</.button>
      </.link>
    </div>
    """
  end

  attr :mood, :string, required: true
  attr :back_path, :string, required: true

  defp elemental_immersion_page(assigns) do
    ~H"""
    <div class="flex flex-col items-center gap-6 text-center">
      <.subheading>Elemental Immersion</.subheading>
      <.h4>
        Elemental Immersion: Transform Your Mood With Water, Fire & Ritual
      </.h4>

      <.p class="max-w-2xl md:px-10 text-left whitespace-pre-line">
        Water has the power to cleanse more than just the body—it resets the mind and energy field.

        Ancient cultures have long used bathing, hot springs, and cold plunges to shift states of mind, detoxify the body, and awaken the spirit.
        But water isn’t the only element that can enhance your mood.

        Fire, in the form of candlelight, adds another layer to your ritual.
        Lighting a candle signals a transition—a moment to pause, set an intention, and step into a new energy.

        The soft flicker soothes the nervous system, while color and scent can deepen your desired state.
        <span class="font-bold">
          By combining water, fire, and intention, you create a multi-sensory mood shift that stays with you long after you step out.
        </span>
        Choose your immersion experience:
      </.p>

      <%= case @mood do %>
        <% "angry" -> %>
          <.mood_specific_immersion
            title="BLISS: Melt into Deep Relaxation"
            salt="Himalayan Salt – Known for its detoxifying and grounding properties, helping to release stress and tension."
            temperature="Warm & Comforting – Keep the water cozy, not scalding, to soothe the nervous system and invite relaxation."
            candle="Soft pink or warm white for peace and self-love."
            scent="Lavender or chamomile essential oils for deep calm."
            extra_boost="Slow, deep breathing in Child’s Pose after your soak to extend the relaxation long after you step out."
            img_list={[
              "https://ik.imagekit.io/soulgenesis/Persephone/elemental_angry_1.webp?updatedAt=1747924353202",
              "https://ik.imagekit.io/soulgenesis/Persephone/elemental_angry_2-1.webp?updatedAt=1747926439393",
              "https://ik.imagekit.io/soulgenesis/Persephone/elemental_angry_3.webp?updatedAt=1747924353009",
              "https://ik.imagekit.io/soulgenesis/Persephone/elemental_angry_4.webp?updatedAt=1747924352848"
            ]}
          />
        <% "afraid" -> %>
          <.mood_specific_immersion
            title="POWER: Ignite Strength & Resilience"
            salt="Epsom Salt – Rich in magnesium, this salt soothes muscles, relieves tension, and restores strength."
            temperature="Contrast Therapy – Start with hot water to relax, then end with a cold rinse to boost circulation, resilience, and mental clarity."
            candle="Red or deep orange for courage and determination."
            scent="Eucalyptus or black pepper to awaken the senses and enhance focus."
            extra_boost="After soaking, stand tall in Warrior Pose and set an intention for unshakable confidence."
            img_list={[
              "https://ik.imagekit.io/soulgenesis/Persephone/elemental_afraid_1.webp?updatedAt=1747928003839",
              "https://ik.imagekit.io/soulgenesis/Persephone/elemental_angry_2-1.webp?updatedAt=1747926439393",
              "https://ik.imagekit.io/soulgenesis/Persephone/elemental_afraid_3.webp?updatedAt=1747928004019",
              "https://ik.imagekit.io/soulgenesis/Persephone/elemental_angry_4.webp?updatedAt=1747924352848"
            ]}
          />
        <% "sad" -> %>
          <.mood_specific_immersion
            title="JOY: Elevate & Energize"
            salt="Dead Sea Salt – Packed with minerals that refresh and rejuvenate, leaving you feeling light and radiant."
            temperature="Warm to Cool Refresh – Start with warm water to open up, then finish with a cool splash for a burst of energy."
            candle="Bright yellow or gold to enhance happiness and playfulness."
            scent="Citrus or peppermint essential oils for an uplifting boost."
            extra_boost="End your bath by dancing or stretching in Wild Thing Pose, letting your body express pure joy."
            img_list={[
              "https://ik.imagekit.io/soulgenesis/Persephone/elemental_sad_1.webp?updatedAt=1747928003998",
              "https://ik.imagekit.io/soulgenesis/Persephone/elemental_angry_2-1.webp?updatedAt=1747926439393",
              "https://ik.imagekit.io/soulgenesis/Persephone/elemental_sad_3.webp?updatedAt=1747928003871",
              "https://ik.imagekit.io/soulgenesis/Persephone/elemental_angry_4.webp?updatedAt=1747924352848"
            ]}
          />
      <% end %>

      <.p class="max-w-2xl md:px-10 text-left mt-8">
        Your elemental immersion is a sacred reset. Whether you soak, sweat, or plunge,
        lighting a candle marks the beginning of a transformational experience.
      </.p>

      <.link patch={@back_path} class="my-10">
        <.button variant="outlined">Back to rituals</.button>
      </.link>
    </div>
    """
  end

  attr :title, :string, required: true
  attr :salt, :string, required: true
  attr :temperature, :string, required: true
  attr :candle, :string, required: true
  attr :scent, :string, required: true
  attr :extra_boost, :string, required: true
  attr :img_list, :list, required: true

  defp mood_specific_immersion(assigns) do
    ~H"""
    <div class="mt-8 max-w-2xl w-full">
      <.h3><%= @title %></.h3>
      <div class="my-6 flex flex-wrap justify-between gap-6">
        <div
          :for={img <- @img_list}
          class="w-30 h-30 md:w-36 w-30 h-30 md:h-36 rounded-lg flex items-center justify-center text-gray-500"
        >
          <img class="rounded-3xl shadow-md" src={img} />
        </div>
      </div>
      <ul class="mt-4 list-disc space-y-2 text-left pl-5">
        <li><span class="font-semibold">Salt:</span> <%= @salt %></li>
        <li><span class="font-semibold">Temperature:</span> <%= @temperature %></li>
        <li><span class="font-semibold">Candle:</span> <%= @candle %></li>
        <li><span class="font-semibold">Scent:</span> <%= @scent %></li>
        <li><span class="font-semibold">Extra Boost:</span> <%= @extra_boost %></li>
      </ul>
    </div>
    """
  end

  attr :title, :string, required: true
  attr :essential_oils, :string, required: true
  attr :why_it_works, :string, required: true
  # List of strings for bullet points
  attr :how_to_use, :list, required: true

  defp mood_specific_scents(assigns) do
    ~H"""
    <div class="mt-8 max-w-2xl w-full text-left">
      <.h3><%= @title %></.h3>
      <div class="my-4 mx-auto w-full rounded-lg flex items-center justify-center text-gray-500">
        <img src="https://ik.imagekit.io/soulgenesis/Persephone/Alchemy_anger.webp?updatedAt=1747924353006" />
      </div>
      <ul class="mt-4 list-disc space-y-2 pl-5">
        <li><span class="font-semibold">Essential Oils:</span> <%= @essential_oils %></li>
        <li><span class="font-semibold">Why it works:</span> <%= @why_it_works %></li>
        <li>
          <span class="font-semibold">How to Use:</span>
          <ul class="list-disc space-y-1 pl-5 mt-1">
            <li :for={use_case <- @how_to_use}><%= use_case %></li>
          </ul>
        </li>
      </ul>
    </div>
    """
  end

  attr :mood, :string, required: true
  attr :back_path, :string, required: true

  defp alchemy_of_scent_page(assigns) do
    ~H"""
    <div class="flex flex-col items-center gap-6 text-center">
      <.subheading>Alchemy of Scent</.subheading>
      <.h4>
        Alchemy of Scent: Aromatherapy for Mood & Mind
      </.h4>

      <.p class="max-w-2xl md:px-10 text-left whitespace-pre-line">
        Aromatherapy isn’t just about pleasant scents—it’s a direct path to the brain’s emotional center.

        Because essential oil molecules cross the blood-brain barrier, their effects on mood, memory, and stress levels are both immediate and profound. A single inhale can activate relaxation, spark energy, or restore balance in seconds.

        Whether through diffusion, topical application, or inhalation, scent is one of the fastest ways to shift your state. Here’s how to incorporate it into your daily rituals for power, bliss, and joy.
      </.p>

      <%= case @mood do %>
        <% "angry" -> %>
          <.mood_specific_scents
            title="BLISS: Deep Relaxation & Emotional Harmony"
            essential_oils="Lavender, Rose, Bergamot, Melissa, Jasmine, Ylang Ylang"
            why_it_works="These floral and citrus oils support the heart and liver meridians, known for processing emotions and promoting inner peace."
            how_to_use={[
              "Evening Wind-Down: Diffuse lavender and chamomile while reading or meditating.",
              "Heart-Opening Self-Massage: Mix rose otto with a carrier oil and massage over your heart center.",
              "Pillow Mist: Spritz a blend of bergamot and ylang ylang on your pillow for restful sleep."
            ]}
          />
        <% "afraid" -> %>
          <.mood_specific_scents
            title="POWER: Strength, Confidence & Grounding"
            essential_oils="Ginger grass, Cedarwood, Bergamot, Vetiver, Marjoram"
            why_it_works="These oils support the solar plexus chakra, linked to confidence, digestion, and motivation. They also encourage focus and resilience."
            how_to_use={[
              "Morning Power Boost: Diffuse ginger grass & cedarwood while setting an intention for the day.",
              "Topical Power: Add a drop of bergamot or vetiver to your wrists before a big meeting.",
              "Shower Steam Activation: Place a few drops of ginger or marjoram oil on the shower floor and let the steam amplify their invigorating effect."
            ]}
          />
        <% "sad" -> %>
          <.mood_specific_scents
            title="JOY: Uplift, Energize & Inspire"
            essential_oils="Neroli, Bergamot, Jasmine, Orange, Lime, Frankincense, Sandalwood"
            why_it_works="These bright, citrusy and resinous scents stimulate the heart and pancreas meridians, linked to creativity and optimism."
            how_to_use={[
              "Midday Mood Boost: Diffuse orange and neroli oils for a natural energy lift.",
              "Wearable Joy: Dab jasmine and lime onto pulse points before heading out.",
              "Sunrise Ritual: Inhale frankincense and bergamot while journaling or stretching."
            ]}
          />
      <% end %>

      <.link patch={@back_path} class="my-10">
        <.button variant="outlined">Back to rituals</.button>
      </.link>
    </div>
    """
  end

  attr :mood, :string, required: true
  attr :back_path, :string, required: true

  defp tea_ceremony_page(assigns) do
    ~H"""
    <div class="flex flex-col items-center gap-6 text-center">
      <.subheading>Tea Ceremony</.subheading>
      <.h4>
        Tea Ceremony: Steeped in Serenity
      </.h4>

      <.p class="max-w-2xl md:px-10 text-left whitespace-pre-line">
        Tea has been revered for centuries as a sacred, grounding ritual—a way to pause, reset, and nourish both body and mind. Whether you prefer herbal, green, or black tea, preparing it with intention can be a meditative experience that enhances the benefits of your chosen mood.
      </.p>

      <.h3 class="mt-8">How to Brew the Perfect Cup of Tea</.h3>
      <ol class="max-w-2xl w-full list-decimal space-y-2 text-left pl-5 mt-4">
        <li>
          <span class="font-semibold">Use Fresh Water</span>
          – Avoid reboiling water, as it loses oxygen and dulls the flavor.
        </li>
        <li>
          <span class="font-semibold">Heat to the Right Temperature:</span>
          <ul class="list-disc space-y-1 pl-5 mt-1">
            <li>
              <span class="font-semibold">Herbal Tea:</span>
              Boiling (212°F / 100°C) – fully extracts flavors and benefits.
            </li>
            <li>
              <span class="font-semibold">Green Tea:</span>
              175–185°F (80–85°C) – prevents bitterness and preserves antioxidants.
            </li>
            <li>
              <span class="font-semibold">Black Tea:</span>
              200–212°F (93–100°C) – allows the full-bodied taste to develop.
            </li>
          </ul>
        </li>
        <li>
          <span class="font-semibold">Steep for the Perfect Time:</span>
          <ul class="list-disc space-y-1 pl-5 mt-1">
            <li><span class="font-semibold">Herbal:</span> 5–7 minutes</li>
            <li><span class="font-semibold">Green:</span> 2–3 minutes</li>
            <li><span class="font-semibold">Black:</span> 3–5 minutes</li>
          </ul>
        </li>
        <li>
          <span class="font-semibold">Sip Slowly & Savor</span>
          – Let each sip be a moment of presence, an opportunity to anchor into your chosen Power, Bliss, or Joy.
        </li>
      </ol>

      <.p class="max-w-2xl md:px-10 text-left mt-8 italic">
        “Take a sip of tea, savoring its warmth as you hold onto your sense of power, bliss, or joy.”
      </.p>

      <div class="max-w-2xl w-full text-left mt-4">
        <%= case @mood do %>
          <% "angry" -> %>
            <.p>
              <span class="font-semibold">Bliss:</span>
              Rose or Chamomile Tea – Soothing, floral, and heart-opening.
            </.p>
          <% "afraid" -> %>
            <.p>
              <span class="font-semibold">Power:</span>
              Ginger or Mint Tea – Energizing, digestive, and invigorating.
            </.p>
          <% "sad" -> %>
            <.p>
              <span class="font-semibold">Joy:</span>
              Jasmine or Jasmine Green Tea – Refreshing, floral, and gently uplifting.
            </.p>
        <% end %>
      </div>

      <div class="my-4 mx-auto w-3/4 sm:w-1/2 rounded-lg flex items-center justify-center text-gray-500">
        <img src="https://ik.imagekit.io/soulgenesis/Persephone/tea_angry.webp?updatedAt=1747924353259" />
      </div>

      <.link patch={@back_path} class="my-10">
        <.button variant="outlined">Back to rituals</.button>
      </.link>
    </div>
    """
  end

  defp joy_words do
    [
      %{
        number: "1.",
        term: "Delighted",
        description:
          "Laughter bubbles up like sparkling water. Your heart flutters with pleasant surprise, like catching sunlight through leaves.",
        definition: "Feeling or showing great pleasure and joy."
      },
      %{
        number: "2.",
        term: "Playful",
        description:
          "Like a kitten pouncing or a child skipping barefoot. Energy is light, spontaneous, and unconcerned with rules.",
        definition: "Full of fun and high spirits; lighthearted and spontaneous."
      },
      %{
        number: "3.",
        term: "Cheerful",
        description:
          "A melody hums in your mind. The air feels clear. Everything seems possible, and even small things make you smile.",
        definition: "Noticeably happy and optimistic; visibly upbeat in mood."
      },
      %{
        number: "4.",
        term: "Glowing",
        description:
          "Inner warmth shines outward. Your presence feels magnetic, your eyes soft and kind. It's joy with a soft halo.",
        definition: "Radiantly happy or beautiful; visibly bright with joy or health."
      },
      %{
        number: "5.",
        term: "Mirthful",
        description:
          "Unrestrained laughter with friends. The joy is full-bodied—your cheeks ache, your eyes water. You’re in it.",
        definition: "Full of laughter and amusement; joyful and merry."
      },
      %{
        number: "6.",
        term: "Uplifted",
        description:
          "Imagine being lifted by a gust of good news. Lightness floods your chest, and your thoughts rise with it.",
        definition: "Emotionally elevated; inspired or made happier."
      },
      %{
        number: "7.",
        term: "Effervescent",
        description:
          "Bubbly inside, like soda fizz. Joy rising in your chest like tiny fireworks, spark after spark.",
        definition: "Vivacious and enthusiastic; bubbling over with high energy."
      },
      %{
        number: "8.",
        term: "Giddy",
        description:
          "Head spinning with delight, laughter sneaking out in bursts. You can’t contain the excitement, and you don’t want to.",
        definition: "Lightheartedly silly; elated to the point of disorientation or laughter."
      },
      %{
        number: "9.",
        term: "Sunny",
        description:
          "Bright, warm, welcoming. Your presence feels like a smile. You light up spaces just by showing up.",
        definition: "Cheerful and optimistic in disposition or outlook."
      },
      %{
        number: "10.",
        term: "Buoyant",
        description:
          "Weightless and lifted, like floating in warm water. The heaviness has left. Your spirit floats.",
        definition: "Cheerfully resilient; able to stay afloat emotionally."
      },
      %{
        number: "11.",
        term: "Elated",
        description:
          "Big joy. A personal celebration in your soul. You’ve just gotten the yes, and everything feels right.",
        definition: "Ecstatically happy or proud; in high spirits."
      },
      %{
        number: "12.",
        term: "Jubilant",
        description:
          "Like dancing in the street. Full-body joy. It wants movement, music, release.",
        definition: "Feeling or expressing great joy and triumph."
      },
      %{
        number: "13.",
        term: "Exuberant",
        description:
          "Overflowing. Too much joy to hold in—so it pours out through words, actions, expression.",
        definition: "Full of unrestrained enthusiasm or joy."
      },
      %{
        number: "14.",
        term: "Radiant",
        description:
          "Light pours from you. You shine with authenticity. Your joy becomes a beacon.",
        definition: "Emitting joy, love, or confidence strongly and clearly."
      },
      %{
        number: "15.",
        term: "Tickled",
        description:
          "Something about this moment strikes a funny, unexpected delight. A tiny laugh dances just beneath the surface.",
        definition: "Delighted or amused; pleased in a playful way."
      }
    ]
  end

  defp bliss_words do
    [
      %{
        number: "1.",
        term: "Serene",
        description:
          "Still water, a slow breath, nothing pulling at you. Your body releases its grip. All is well, exactly as it is.",
        definition: "Calm, peaceful, and untroubled."
      },
      %{
        number: "2.",
        term: "Ecstatic",
        description:
          "Your cells sing. It’s not just pleasure—it’s transcendence. A rush that dissolves your edges and connects you to everything.",
        definition: "Feeling overwhelming happiness or joyful excitement."
      },
      %{
        number: "3.",
        term: "Tranquil",
        description:
          "Gentle waves in a secluded cove. Thoughts slow, breath deepens. You're quietly euphoric.",
        definition: "Free from disturbance or turmoil; calm and quiet."
      },
      %{
        number: "4.",
        term: "Luminous",
        description:
          "Soft white light everywhere. There's clarity, and a quiet knowing. You are fully here—untouched by stress.",
        definition: "Radiating or reflecting light; clear and enlightening."
      },
      %{
        number: "5.",
        term: "Rapturous",
        description:
          "Overwhelmed in the best way. Music, beauty, nature—something bigger than you floods in and sweeps you away.",
        definition: "Characterized by, feeling, or expressing great pleasure or enthusiasm."
      },
      %{
        number: "6.",
        term: "Content",
        description:
          "Satisfaction without striving. A warm blanket, a full belly, no need for more. You are enough. This moment is enough.",
        definition: "In a state of peaceful happiness and satisfaction."
      },
      %{
        number: "7.",
        term: "Heavenly",
        description:
          "Soft clouds, divine stillness. It's more than comfort—it feels sacred, as if blessed by unseen hands.",
        definition: "Delightful or blissful to a sublime or divine degree."
      },
      %{
        number: "8.",
        term: "Ethereal",
        description:
          "You feel almost not of this world. Light and beautiful, touched by something celestial.",
        definition: "Extremely delicate and light; seemingly not of this world."
      },
      %{
        number: "9.",
        term: "Weightless",
        description:
          "All burdens released. Body and mind feel suspended in ease—timeless and serene.",
        definition: "Free from heaviness or burden; light in sensation or emotional tone."
      },
      %{
        number: "10.",
        term: "Sanctified",
        description: "A deep, holy calm. Your inner space feels consecrated. Bliss as reverence.",
        definition: "Made sacred or set apart; often connoting inner peace or purity."
      },
      %{
        number: "11.",
        term: "Open",
        description:
          "Nothing guarded, nothing hiding. Your chest and mind wide like the sky—ready to receive.",
        definition: "Receptive and unguarded; emotionally accessible."
      },
      %{
        number: "12.",
        term: "Whole",
        description: "No missing pieces. No lack. Bliss as unity with yourself.",
        definition: "Complete; free of fragmentation or lack."
      },
      %{
        number: "13.",
        term: "Melted",
        description: "Tension evaporated. You feel soft, pliable, gently dissolved into the now.",
        definition: "Relaxed and softened emotionally or physically."
      },
      %{
        number: "14.",
        term: "Gentle",
        description:
          "Tenderness without fragility. Soft tones, soft light, soft breath. The world touches you kindly.",
        definition: "Mild in temperament or behavior; soft and soothing."
      },
      %{
        number: "15.",
        term: "Glowing (Bliss version)",
        description:
          "Not active, but radiant from stillness. Like embers of joy resting in your soul.",
        definition: "Radiantly calm or happy; emitting a soft light or joy."
      }
    ]
  end

  defp power_words do
    [
      %{
        number: "1.",
        term: "Empowered",
        description:
          "Feet firm, heart steady, voice clear. You know your worth—and it radiates. You're not waiting for permission.",
        definition: "Given the strength and confidence to take control or make decisions."
      },
      %{
        number: "2.",
        term: "Fierce",
        description:
          "Sharp focus, unwavering will. You protect what matters. Power as clarity, not aggression.",
        definition: "Showing a heartfelt and powerful intensity."
      },
      %{
        number: "3.",
        term: "Magnetic",
        description:
          "People lean in. Your energy is compelling, confident. You attract what aligns.",
        definition: "Having an attractive personal quality; drawing others in."
      },
      %{
        number: "4.",
        term: "Commanding",
        description:
          "Your presence fills a room. You lead without saying much—your energy speaks first.",
        definition: "Having a strong presence or authority that elicits respect or attention."
      },
      %{
        number: "5.",
        term: "Resilient",
        description:
          "Like a diamond formed under pressure. You bend, but never break. Strength with grace.",
        definition: "Able to recover quickly from adversity or setbacks."
      },
      %{
        number: "6.",
        term: "Sovereign",
        description:
          "You are the ruler of your realm. Calm. Grounded. Unshakably in charge of your inner world.",
        definition: "Possessing supreme power or authority over one’s self or domain."
      },
      %{
        number: "7.",
        term: "Focused",
        description:
          "Laser clarity. All distractions dissolve. You know exactly what you’re doing—and why.",
        definition: "Directing all attention and energy toward a specific goal or task."
      },
      %{
        number: "8.",
        term: "Determined",
        description:
          "Unshakable direction. Obstacles become steps. You move forward no matter what.",
        definition: "Firm in purpose; resolved and unwavering."
      },
      %{
        number: "9.",
        term: "Aligned",
        description:
          "Your inner truth and outer actions are one. No friction, no hiding. Power through harmony.",
        definition: "In harmony or agreement; internally congruent."
      },
      %{
        number: "10.",
        term: "Courageous",
        description: "Fear met with forward motion. Your heart is racing, but you go anyway.",
        definition: "Showing bravery in facing fear or difficulty."
      },
      %{
        number: "11.",
        term: "Anchored",
        description: "Rooted deep. No storm can pull you up. You are centered, stable, sure.",
        definition: "Firmly rooted; emotionally stable and grounded."
      },
      %{
        number: "12.",
        term: "Bold",
        description:
          "You speak the truth, take the leap, wear the red lipstick. Audacity with elegance.",
        definition: "Showing willingness to take risks; confident and daring."
      },
      %{
        number: "13.",
        term: "Intentional",
        description: "Nothing random here. Each move is a message. Your choices shape reality.",
        definition: "Done with awareness and purpose."
      },
      %{
        number: "14.",
        term: "Electric",
        description:
          "Crackling energy, high voltage. Your presence charges the space around you.",
        definition: "Exciting and full of energy; charged with intensity."
      },
      %{
        number: "15.",
        term: "Limitless",
        description:
          "No ceiling, no borders. You can see beyond the edge—and you’re walking toward it.",
        definition: "Without bounds or restrictions; infinite potential."
      }
    ]
  end

  defp crystal_config("sad") do
    %{
      img: "/images/crystals-sad.png",
      label: "Delight",
      color: "text-[#ff8c3e]"
    }
  end

  defp crystal_config("angry") do
    %{
      img: "/images/crystals-anger.png",
      label: "Gratitude",
      color: "text-[#5c3178]"
    }
  end

  defp crystal_config("afraid") do
    %{
      img: "/images/crystals-fear.png",
      label: "Eternity",
      color: "text-[#05615b]"
    }
  end
end
