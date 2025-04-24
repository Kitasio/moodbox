defmodule MoodboxWeb.RitualLive do
  use MoodboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, mood: "angry", current_path: nil)}
  end

  def handle_params(%{"mood" => mood, "ritual" => ritual}, uri, socket) do
    {:noreply,
     socket
     |> assign(:current_path, uri)
     |> assign(:mood, mood)
     |> assign(:ritual, ritual)}
  end

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
       <.power_poses_page mood={@mood} :if={@ritual == "power-poses"} />
      </.centered_block>
      <.base_bg />
    </.container>
    """
  end

  attr :mood, :string, required: true

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
        <% "sad" -> %>
          <.mood_specific_poses
            title="Bliss: Surrender & Serenity"
            power_pose="Victory Pose – Stand With Feet Grounded, Arms Raised Overhead In A 'V' Shape, Chin Slightly Lifted. This Posture Exudes Effortless Triumph And A Sense Of Ease."
            yoga_pose="Child’s Pose (Balasana) – A Deeply Restorative Posture That Invites Surrender, Safety, And Relaxation. Knees Wide, Forehead To The Ground, And Arms Stretched Forward, It Fosters A Sense Of Peace."
            alternative_pose="Reclined Butterfly (Supta Baddha Konasana) – Lying On Your Back With The Soles Of Your Feet Together, Knees Falling Open, This Gentle Heart-Opener Allows For Deep Relaxation And Release."
          />
        <% "angry" -> %>
          <.mood_specific_poses
            title="Power: Command & Strength"
            power_pose="Superhero Pose – Stand Tall With Feet Hip-Width Apart, Hands On Hips, And Chest Open. This Stance Signals Confidence, Resilience, And Readiness To Take On The World."
            yoga_pose="Warrior II (Virabhadrasana II) – A Powerful Stance That Channels Focus And Inner Strength. With Feet Grounded, Arms Extended, And Gaze Steady, You Embody Unwavering Determination."
            alternative_pose="Goddess Pose (Utkata Konasana) – A Strong, Grounded Stance With Knees Bent And Arms Raised Like A Fierce Warrior Queen. This Pose Ignites Your Inner Power And Stability."
          />
        <% "afraid" -> %>
          <.mood_specific_poses
            title="Joy: Expansion & Expression"
            power_pose="Expansive Star Pose – Stand With Feet Wide Apart, Arms Fully Outstretched, And Chest Lifted. This Pose Signals Openness, Excitement, And An Embrace Of Life’s Possibilities."
            yoga_pose="Backbend (Wheel Or Camel Pose) – Heart-Opening Postures That Create Space For Joy, Exhilaration, And Emotional Release. They Lift The Spirit And Energize The Body."
            alternative_pose="Wild Thing (Camatkarasana) – A Playful, Dynamic Backbend That Feels Like A Celebration. One Hand And Foot Remain Grounded While The Other Arm And Leg Extend, Creating A Sensation Of Freedom And Joy."
          />
      <% end %>
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
end
