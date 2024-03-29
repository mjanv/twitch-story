import Config

if System.get_env("PHX_SERVER") do
  config :twitch_story, TwitchStoryWeb.Endpoint, server: true
end

if config_env() == :prod do
  config :twitch_story,
    files: System.get_env("FILES_PATH") || raise("FILES_PATH missing.")

  config :twitch_story, TwitchStory.Repo,
    database: System.get_env("DATABASE_PATH") || raise("DATABASE_PATH missing."),
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "5")

  config :twitch_story, :dns_cluster_query, System.get_env("DNS_CLUSTER_QUERY")

  config :twitch_story, TwitchStoryWeb.Endpoint,
    url: [host: System.get_env("PHX_HOST") || "example.com", port: 443, scheme: "https"],
    http: [
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: String.to_integer(System.get_env("PORT") || "4000")
    ],
    secret_key_base: System.get_env("SECRET_KEY_BASE") || raise("SECRET_KEY_BASE missing")
end
