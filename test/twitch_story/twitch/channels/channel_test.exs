defmodule TwitchStory.Twitch.Channels.ChannelTest do
  @moduledoc false

  use TwitchStory.DataCase

  alias TwitchStory.Twitch.Channels.Channel

  import TwitchStory.TwitchFixtures

  @invalid_attrs %{
    description: nil,
    broadcaster_id: nil,
    broadcaster_login: nil,
    broadcaster_name: nil,
    broadcaster_language: nil,
    tags: nil,
    thumbnail_url: nil,
    thumbnail: nil
  }

  test "all/0 returns all channels" do
    channel = channel_fixture()
    assert Channel.all() == [channel]
  end

  test "page/1 return paginated results" do
    channels =
      1..20
      |> Enum.map(fn _ -> channel_fixture() end)
      |> Enum.sort_by(&Map.fetch(&1, :broadcaster_id))

    pages = Enum.chunk_every(channels, 10)

    for n <- 1..2 do
      page = Channel.page(n)
      assert length(page) == 10
      assert page == Enum.at(pages, n - 1)
    end

    assert Channel.page(2) == Channel.page(3)
    assert Channel.page(2) == Channel.page(4)
  end

  test "get!/1 returns the channel with given id" do
    channel = channel_fixture()
    assert Channel.get(broadcaster_id: channel.broadcaster_id) == channel
  end

  test "create/1 with valid data creates a channel" do
    valid_attrs = %{
      description: "some description",
      broadcaster_id: "some broadcaster_id",
      broadcaster_login: "some broadcaster_login",
      broadcaster_name: "some broadcaster_name",
      broadcaster_language: "some broadcaster_language",
      tags: ["option1", "option2"],
      thumbnail_url: "some thumbnail_url",
      thumbnail: "some thumbnail"
    }

    assert {:ok, %Channel{} = channel} = Channel.create(valid_attrs)
    assert channel.description == "some description"
    assert channel.broadcaster_id == "some broadcaster_id"
    assert channel.broadcaster_login == "some broadcaster_login"
    assert channel.broadcaster_name == "some broadcaster_name"
    assert channel.broadcaster_language == "some broadcaster_language"
    assert channel.tags == ["option1", "option2"]
    assert channel.thumbnail_url == "some thumbnail_url"
    assert channel.thumbnail == "some thumbnail"
  end

  test "create/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Channel.create(@invalid_attrs)
  end

  test "update/2 with valid data updates the channel" do
    channel = channel_fixture()

    update_attrs = %{
      description: "some updated description",
      broadcaster_id: "some updated broadcaster_id",
      broadcaster_login: "some updated broadcaster_login",
      broadcaster_name: "some updated broadcaster_name",
      broadcaster_language: "some updated broadcaster_language",
      tags: ["option1"],
      thumbnail_url: "some updated thumbnail_url",
      thumbnail: "some updated thumbnail"
    }

    assert {:ok, %Channel{} = channel} = Channel.update(channel, update_attrs)
    assert channel.description == "some updated description"
    assert channel.broadcaster_id == "some updated broadcaster_id"
    assert channel.broadcaster_login == "some updated broadcaster_login"
    assert channel.broadcaster_name == "some updated broadcaster_name"
    assert channel.broadcaster_language == "some updated broadcaster_language"
    assert channel.tags == ["option1"]
    assert channel.thumbnail_url == "some updated thumbnail_url"
    assert channel.thumbnail == "some updated thumbnail"
  end

  test "update/2 with invalid data returns error changeset" do
    channel = channel_fixture()
    assert {:error, %Ecto.Changeset{}} = Channel.update(channel, @invalid_attrs)
    assert channel == Channel.get(broadcaster_id: channel.broadcaster_id)
  end

  test "delete/1 deletes the channel" do
    channel = channel_fixture()
    assert {:ok, %Channel{}} = Channel.delete(channel)
    assert Channel.get(broadcaster_id: channel.broadcaster_id) == nil
  end

  test "change/1 returns a channel changeset" do
    channel = channel_fixture()
    assert %Ecto.Changeset{} = Channel.change(channel)
  end
end
