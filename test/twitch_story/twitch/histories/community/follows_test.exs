defmodule TwitchStory.Twitch.Histories.Community.FollowsTest do
  @moduledoc false

  use ExUnit.Case

  @moduletag :zip

  alias Support.ExplorerCase
  alias TwitchStory.Twitch.Histories.Community.Follows

  @zip "priv/static/request-1.zip"

  test "n/2" do
    follows = Follows.n(@zip)

    assert follows == 169
  end

  test "all/2" do
    follows = Follows.all(Follows.read(@zip))

    assert ExplorerCase.equal_master?(follows, "follows")
  end
end
