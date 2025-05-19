defmodule MoodboxWeb.Router do
  use MoodboxWeb, :router

  import MoodboxWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {MoodboxWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MoodboxWeb do
    pipe_through :browser

    live "/", HomeLive
    live "/moods", MoodLive
    live "/moods/not-sure", FeelingCheckLive
    live "/moods/numb", NumbLive
    live "/moods/overwhelmed", OverwhelmedLive
    live "/moods/emotions-education", EmotionsEducationLive
    live "/moods/emotions-temperature", EmotionsTemperatureLive
    live "/moods/:mood", IntensityLive
    live "/crisis-support/:mood", CrisisSupportLive
    live "/moods/:mood/:intensity", TextureLive
    live "/moods/:mood/:intensity/:texture", ColorLive
    live "/moods/:mood/:intensity/:texture/:color", TemperatureLive
    live "/moods/:mood/:intensity/:texture/:color/:temperature", LocationLive
    live "/moods/:mood/:intensity/:texture/:color/:temperature/:location", DescriptionLive

    live "/moods/:mood/:intensity/:texture/:color/:temperature/:location/:description",
         GetEmailLive

    live "/moods/:mood/:intensity/:texture/:color/:temperature/:location/:description/outcome",
         OutcomeLive

    live "/moods/:mood/:intensity/:texture/:color/:temperature/:location/:description/outcome/classical",
         ClassicalPlaylistLive

    live "/moods/:mood/:intensity/:texture/:color/:temperature/:location/:description/outcome/classical/revision",
         RevisionLive

    live "/moods/:mood/:intensity/:texture/:color/:temperature/:location/:description/outcome/classical/revision/:score",
         RevisionOutcomeLive

    live "/moods/:mood/:intensity/:texture/:color/:temperature/:location/:description/outcome/classical/revision/:score/explanation",
         MoodShiftExplanationLive

    live "/moods/:mood/:intensity/:texture/:color/:temperature/:location/:description/outcome/classical/revision/:score/explanation/further-boost",
         FurtherBoostLive

    live "/moods/:mood/:intensity/:texture/:color/:temperature/:location/:description/outcome/classical/revision/:score/explanation/further-boost/create-ritual",
         CreateRitualLive

    live "/moods/:mood/:intensity/:texture/:color/:temperature/:location/:description/outcome/classical/revision/:score/explanation/further-boost/create-ritual/:ritual",
         RitualLive

    live "/root", RootLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", MoodboxWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:moodbox, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: MoodboxWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", MoodboxWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{MoodboxWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", MoodboxWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{MoodboxWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
    end
  end

  scope "/", MoodboxWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{MoodboxWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end
end
