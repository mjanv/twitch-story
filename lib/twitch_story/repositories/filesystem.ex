defmodule TwitchStory.Repositories.Filesystem do
  @moduledoc false

  def folder(request) do
    :twitch_story
    |> Application.get_env(:files)
    |> case do
      nil -> Application.app_dir(:twitch_story, "priv/static/uploads")
      path -> path
    end
    |> Path.join(request)
    |> then(fn dest -> dest <> ".zip" end)
  end
end
