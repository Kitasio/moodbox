defmodule MoodboxWeb.DonateLive do
  use MoodboxWeb, :live_view

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <.heading>Support the Shift: Keep the Vibes Flowing</.heading>
        <.subheading>When you give more, you get more.</.subheading>
        <div class="mt-4 md:mt-8 p-4 md:p-8 px-4 md:px-8 bg-white rounded-xl shadow-md">
          <.p class="text-left">
            Mood in a Box is designed to be free and accessible to anyone, anywhere—because we believe that good moods are contagious, creative, and catalytic. When even one person shifts into a better mood, it sparks a ripple effect: brighter thoughts, kinder choices, and more inspired action. Enough of those can light up the whole planet.
            <br /><br />
            If this experience has sparked even the slightest lightness or clarity—for you or someone you’re sharing it with—please consider making a donation.
            <br /><br /> Your gift directly supports: <br /> - Keeping this tool free and evergreen
            <br /> - Enhancing mood-shifting modules <br />
            - Creating new interactive experiences rooted in alchemy and wonder <br /><br />
            Every contribution, no matter the size, helps expand the ripple of positive transformation—across minds, moods, and the world we share.
            <br /><br />
            As a thank you for being awesome, we will be gifting you with a link to download your anchor song.
          </.p>

          <.p class="text-left mt-8 mb-2">Donate Now:</.p>
          <div class="flex flex-wrap gap-3">
            <.link href="https://buy.stripe.com/dRm3cu1Ee54Bcn7efR0RG00" target="_blank">
              <.button variant="outlined">$5</.button>
            </.link>
            <.link href="https://buy.stripe.com/9B6cN46Yy9kR9aV6Np0RG01" target="_blank">
              <.button variant="outlined">$10</.button>
            </.link>
            <.link href="https://buy.stripe.com/14AfZggz8eFb86RdbN0RG02" target="_blank">
              <.button variant="outlined">$20</.button>
            </.link>
            <.link href="https://buy.stripe.com/14A3cu2IieFbfzjefR0RG03" target="_blank">
              <.button variant="outlined">$50</.button>
            </.link>
            <.link href="https://buy.stripe.com/dRm6oG1EeaoV72N7Rt0RG04" target="_blank">
              <.button variant="outlined">Custom</.button>
            </.link>
          </div>
          <.p class="mt-8">✨ Thank you for uplifting the mission!</.p>
        </div>
      </.centered_block>

      <.base_bg />
    </.container>
    """
  end
end
