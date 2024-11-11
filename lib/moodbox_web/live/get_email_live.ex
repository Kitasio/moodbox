defmodule MoodboxWeb.GetEmailLive do
  alias Moodbox.Accounts.User
  alias Moodbox.Accounts
  use MoodboxWeb, :live_view

  def mount(params, _session, socket) do
    mood = params["mood"]
    intensity = params["intensity"]
    texture = params["texture"]
    location = params["location"]
    description = params["description"]

    changeset = Accounts.change_user_nopass_registration(%User{})

    {:ok,
     socket
     |> assign(mood: mood)
     |> assign(intensity: intensity)
     |> assign(texture: texture)
     |> assign(location: location)
     |> assign(description: description)
     |> assign(check_errors: false)
     |> assign_form(changeset)}
  end

  def handle_params(_params, uri, socket) do
    socket = assign(socket, uri: uri)
    {:noreply, socket}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    form = to_form(changeset, as: "user")

    if changeset.valid? do
      assign(socket, form: form, check_errors: false)
    else
      assign(socket, form: form)
    end
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset = Accounts.change_user_nopass_registration(%User{}, user_params)
    {:noreply, assign_form(socket, Map.put(changeset, :action, :validate))}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    case Accounts.add_user(user_params) do
      {:ok, _user} ->
        %URI{path: path} = URI.parse(socket.assigns.uri)

        socket =
          push_navigate(socket,
            to: "#{path}/outcome"
          )

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign(check_errors: true) |> assign_form(changeset)}
    end
  end

  def render(assigns) do
    ~H"""
    <.simple_form class="container mx-auto" for={@form} phx-change="validate" phx-submit="save">
      <.error :if={@check_errors}>
        Oops, something went wrong! Please check the errors below.
      </.error>
      <.input field={@form[:name]} label="Name" />
      <.input field={@form[:email]} label="Email" />
      <:actions>
        <.button>Save</.button>
      </:actions>
    </.simple_form>
    """
  end
end
