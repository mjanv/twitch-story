defmodule TwitchStory.MixProject do
  @moduledoc false

  use Mix.Project

  def project do
    [
      app: :twitch_story,
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_options: [warnings_as_errors: true],
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      compilers: [] ++ Mix.compilers(),
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [
      mod: {TwitchStory.Application, []},
      extra_applications: [:logger, :runtime_tools, :os_mon, :set_locale]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      # Web
      {:phoenix, "~> 1.7.10"},
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.10"},
      {:ecto_sqlite3, ">= 0.0.0"},
      {:phoenix_html, "~> 3.3"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.20.5"},
      {:floki, ">= 0.30.0", only: :test},
      {:phoenix_live_dashboard, "~> 0.8.2"},
      {:esbuild, "~> 0.8", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.2.0", runtime: Mix.env() == :dev},
      {:gettext, "~> 0.20"},
      {:dns_cluster, "~> 0.1.1"},
      {:bandit, ">= 0.0.0"},
      {:bcrypt_elixir, "~> 3.0"},
      {:ueberauth, "~> 0.10.7"},
      {:ueberauth_twitch, "~> 0.1.0"},
      {:set_locale, "~> 0.2.1"},
      # Backend
      {:req, "~> 0.4.9"},
      {:timex, "~> 3.7"},
      {:jason, "~> 1.2"},
      {:oban, "~> 2.16"},
      {:explorer, "~> 0.8.0"},
      {:vega_lite, "~> 0.1.8"},
      {:swoosh, "~> 1.4"},
      # Monitoring
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      # Development tools
      {:credo, "~> 1.7"},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:boundary, "~> 0.10", runtime: false}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "assets.setup", "assets.build"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      quality: ["format", "credo --strict", "dialyzer"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      start: ["phx.server"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["tailwind default", "esbuild default"],
      "assets.deploy": ["tailwind default --minify", "esbuild default --minify", "phx.digest"],
      env: [fn _ -> Mix.shell().cmd("export $(cat .env)") end],
      deploy: [fn _ -> Mix.shell().cmd("fly deploy") end],
      translate: [
        "gettext.extract",
        "gettext.merge priv/gettext --locale en",
        "gettext.merge priv/gettext --locale fr"
      ]
    ]
  end
end
