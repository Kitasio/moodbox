defmodule MoodboxWeb.DonateLive do
  use MoodboxWeb, :live_view

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <.heading>Support the Shift: Keep the Vibes Flowing</.heading>
        <.subheading>When you give more, you get more.</.subheading>
        <.p class="text-left mt-4 md:mt-8 px-4 md:px-8 bg-white rounded-xl shadow-md whitespace-pre-line">
          Mood in a Box is designed to be free and accessible to anyone, anywhere—because we believe that good moods are contagious, creative, and catalytic. When even one person shifts into a better mood, it sparks a ripple effect: brighter thoughts, kinder choices, and more inspired action. Enough of those can light up the whole planet.

          If this experience has sparked even the slightest lightness or clarity—for you or someone you’re sharing it with—please consider making a donation.

          Your gift directly supports:
          - Keeping this tool free and evergreen
          - Enhancing mood-shifting modules
          - Creating new interactive experiences rooted in alchemy and wonder

          Every contribution, no matter the size, helps expand the ripple of positive transformation—across minds, moods, and the world we share.

          As a thank you for being awesome, we will be gifting you with a link to download your anchor song.

          Donate Now [Button]

          ✨ Thank you for uplifting the mission!
        </.p>
      </.centered_block>

      <.base_bg />
    </.container>
    """
  end
end
