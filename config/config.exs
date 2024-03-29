import Config

config :twitch_story, :twitch_api,
  id_api_url: "https://id.twitch.tv",
  api_url: "https://api.twitch.tv",
  client_id: System.get_env("TWITCH_CLIENT_ID"),
  client_secret: System.get_env("TWITCH_CLIENT_SECRET")

config :ueberauth, Ueberauth,
  providers: [
    twitch: {
      Ueberauth.Strategy.Twitch,
      [
        default_scope: "user:read:email user:read:follows user:read:subscriptions",
        ignores_csrf_attack: true
      ]
    }
  ]

config :ueberauth, Ueberauth.Strategy.Twitch.OAuth,
  client_id: System.get_env("TWITCH_CLIENT_ID"),
  client_secret: System.get_env("TWITCH_CLIENT_SECRET"),
  redirect_uri: System.get_env("TWITCH_REDIRECT_URI")

config :twitch_story,
  ecto_repos: [TwitchStory.Repo],
  generators: [timestamp_type: :utc_datetime]

config :twitch_story, TwitchStoryWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: TwitchStoryWeb.Errors.ErrorHTML, json: TwitchStoryWeb.Errors.ErrorJSON],
    layout: false
  ],
  pubsub_server: TwitchStory.PubSub,
  live_view: [signing_salt: "c73B9kuB"]

config :twitch_story, TwitchStory.Notifications.Mailer, adapter: Swoosh.Adapters.Local

config :twitch_story, Oban,
  engine: Oban.Engines.Lite,
  repo: TwitchStory.Repo,
  plugins: [
    {Oban.Plugins.Lifeline, rescue_after: :timer.minutes(30)},
    {Oban.Plugins.Pruner, max_age: 60 * 60 * 24}
  ],
  queues: [default: 10]

config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :tailwind,
  version: "3.3.2",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

config :twitch_story, TwitchStoryWeb.Gettext,
  locales: ~w(en fr),
  default_locale: "en"

import_config "#{config_env()}.exs"
