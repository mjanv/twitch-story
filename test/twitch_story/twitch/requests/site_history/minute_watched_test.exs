defmodule TwitchStory.Twitch.Requests.SiteHistory.MinuteWatchedTest do
  @moduledoc false

  use ExUnit.Case

  @moduletag :data

  alias Support.ExplorerCase
  alias TwitchStory.Twitch.Requests.SiteHistory.MinuteWatched

  @zip ~c"priv/static/request-1.zip"

  test "read/2" do
    minute_watched = MinuteWatched.read(@zip)

    assert ExplorerCase.equal_master?(minute_watched, "minute_watched")
  end
end
