defmodule MoodboxWeb.OutcomeLive do
  use MoodboxWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"mood" => mood, "intensity" => intensity}, uri, socket) do
    outcome = choose_outcome(mood, intensity |> String.to_integer())
    
    {:noreply, 
     socket 
     |> assign(:current_path, uri)
     |> assign(:outcome, outcome)}
  end

  def render(assigns) do
    ~H"""
    <.container>
      <.centered_block>
        <div class="bg-white p-10 rounded-[55px] shadow-lg">
          <h1 class="text-4xl sm:text-5xl w-full leading-tight sm:leading-snug text-[#6b2a6d] font-extrabold">
            <%= @outcome.header %>
          </h1>
          <p class="mt-4 sm:text-lg xl:text-xl text-[#383838] leading-relaxed sm:leading-relaxed xl:leading-relaxed font-medium">
            <%= @outcome.text %>
          </p>
        </div>

        <.link patch={@current_path <> "/classical"} class="mt-10">
          <.btn class="transition hover:scale-105 font-semibold px-10 py-5">
            <%= @outcome.link_text %>
          </.btn>
        </.link>
      </.centered_block>

      <img class="fixed inset-0 h-full w-full object-cover z-0" src={@outcome.bg_img} />
    </.container>
    """
  end

  defp choose_outcome(mood, intensity) do
    case {mood, intensity} do
      {"angry", intensity} when intensity <= 3 ->
        anger_low()

      {"angry", intensity} when intensity >= 4 and intensity <= 7 ->
        anger_mid()

      {"angry", intensity} when intensity >= 8 ->
        anger_high()

      {"sad", intensity} when intensity <= 3 ->
        sad_low()

      {"sad", intensity} when intensity >= 4 and intensity <= 7 ->
        sad_mid()

      {"sad", intensity} when intensity >= 8 ->
        sad_high()

      {"afraid", intensity} when intensity <= 3 ->
        fear_low()

      {"afraid", intensity} when intensity >= 4 and intensity <= 7 ->
        fear_mid()

      {"afraid", intensity} when intensity >= 8 ->
        fear_high()
    end
  end

  defp anger_low do
    %{
      header: "ANGER: Pesky Little Burn",
      text:
        "Something is irritating you or causing frustration. This may be a familiar feeling that seems tied to external circumstances. Managing minor frustrations can lead to a more peaceful and productive daily life.",
      bg_img: "https://ik.imagekit.io/soulgenesis/Moodinabox/anger1.webp?updatedAt=1733224679440",
      link_text: "RELEASE ANGER"
    }
  end

  defp anger_mid do
    %{
      header: "ANGER: An Unruly Flame",
      text:
        "Your anger is noticeable and might be impacting your interactions with others. Taking a break to cool down can be beneficial. Addressing this level of anger can improve your relationships and overall well-being.",
      bg_img:
        "https://ik.imagekit.io/soulgenesis/Moodinabox/Anger%202%201.webp?updatedAt=1733224908914",
      link_text: "RELEASE ANGER"
    }
  end

  defp anger_high do
    %{
      header: "ANGER: The Fire Within",
      text:
        "Your anger feels intense and powerful. This suggests an underlying frustration or unmet need. Your anger is meant to protect and serve you, but at times accumulates to bring you into a state of sensitivity and triggerability, pointing to a deeper underlying issue. Exploring and understanding your anger can lead to profound emotional healing and balance.",
      bg_img: "https://ik.imagekit.io/soulgenesis/Moodinabox/anger3.webp?updatedAt=1733225015401",
      link_text: "RELEASE ANGER"
    }
  end

  defp fear_low do
    %{
      header: "FEAR: A Restless Whisper",
      text:
        "You are experiencing a mild degree of fear that feels scattered or heavy. It’s uncomfortable but manageable. It’s time to feel better! Acknowledging and addressing mild fear can lead to a more relaxed and harmonious state of mind.",
      bg_img: "https://ik.imagekit.io/soulgenesis/Moodinabox/fear1.webp?updatedAt=1733223473541",
      link_text: "RELEASE FEAR"
    }
  end

  defp fear_mid do
    %{
      header: "FEAR: Echoes of Unease",
      text:
        "Your fear feels moderately uncomfortable and bothersome. You feel it in your body. The good news is, it’s active and ready to move. Engaging with this level of fear can lead to significant personal growth and emotional stability.",
      bg_img: "https://ik.imagekit.io/soulgenesis/Moodinabox/fear2.webp?updatedAt=1733224096715",
      link_text: "RELEASE FEAR"
    }
  end

  defp fear_high do
    %{
      header: "FEAR: Fight, Flight, or Freeze",
      text:
        "Your fear feels strong and potentially overwhelming. It can be difficult to think clearly and function normally with intense fear present. Your nervous system could use a little help. Following the trail of your fear may lead you to deep healing. Understanding and addressing your fear can pave the way to inner peace and resilience.",
      bg_img: "https://ik.imagekit.io/soulgenesis/Moodinabox/fear3.webp?updatedAt=1733224220497",
      link_text: "RELEASE FEAR"
    }
  end

  defp sad_low do
    %{
      header: "SADNESS: A Fleeting Shadow",
      text:
        "Your sadness feels present, but it’s not overwhelming. This sadness might be a passing trigger or a sign of needing some extra self-care. Addressing mild sadness with self-care can enhance your emotional well-being and overall happiness.",
      bg_img: "https://ik.imagekit.io/soulgenesis/Moodinabox/sad1.webp?updatedAt=1733225096813",
      link_text: "RELEASE SADNESS"
    }
  end

  defp sad_mid do
    %{
      header: "SADNESS: Lingering Loss",
      text:
        "Your sadness is a companion that colors your experience of life. Something has you down and it’s time for some relief. Engaging with moderate sadness can help restore emotional balance and bring a sense of relief.",
      bg_img: "https://ik.imagekit.io/soulgenesis/Moodinabox/sad2.webp?updatedAt=1733225157589",
      link_text: "RELEASE SADNESS"
    }
  end

  defp sad_high do
    %{
      header: "SADNESS: The Weight of Sorrow",
      text:
        "Your sadness feels heavy, like a burden pressing on your chest or a fog clouding your thoughts. It may stem from loss, disappointment, or unmet expectations. Sadness is your heart's way of signaling that something meaningful has been impacted or lost. While it can be tempting to suppress or avoid sadness, leaning into it with compassion can reveal its underlying truths.",
      bg_img: "https://ik.imagekit.io/soulgenesis/Moodinabox/sad3.webp?updatedAt=1733225225251",
      link_text: "RELEASE SADNESS"
    }
  end
end
