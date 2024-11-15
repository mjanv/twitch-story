defmodule TwitchStory.Twitch.Api.ChannelApiTest do
  use ExUnit.Case

  alias TwitchStory.Twitch.Api.ChannelApi

  @moduletag :api

  test "reverse_search/1" do
    assert ChannelApi.reverse_search("flonflon") == {:ok, 468_884_133}
    assert ChannelApi.reverse_search("giregejrigjeorig") == {:error, :not_found}
  end

  test "emotes/1" do
    {:ok, emotes} = ChannelApi.emotes(468_884_133)

    assert length(emotes) == 39

    assert List.first(emotes) == %{
             "channel_id" => "468884133",
             "emote_set_id" => "300667317",
             "format" => ["static"],
             "emote_id" => "emotesv2_99b8a71a7de54664a489953555c6a596",
             "name" => "flonflFCana",
             "scale" => ["1.0", "2.0", "3.0"],
             "theme_mode" => ["light", "dark"]
             # "images" => %{"url_1x" => "https://static-cdn.jtvnw.net/emoticons/v2/emotesv2_99b8a71a7de54664a489953555c6a596/static/light/1.0", "url_2x" => "https://static-cdn.jtvnw.net/emoticons/v2/emotesv2_99b8a71a7de54664a489953555c6a596/static/light/2.0", "url_4x" => "https://static-cdn.jtvnw.net/emoticons/v2/emotesv2_99b8a71a7de54664a489953555c6a596/static/light/3.0"},
           }
  end

  test "channel/1" do
    {:ok, channel} = ChannelApi.channel(468_884_133)

    assert channel == %{
             "broadcaster_id" => "468884133",
             "broadcaster_language" => "fr",
             "broadcaster_login" => "flonflon",
             "broadcaster_name" => "Flonflon",
             "description" =>
               "Une chaine qui parle de musique : des émissions d'actu musicale, des playlists thématiques collaboratives, des interviews, des react Star Academy...",
             "tags" => [
               "Français",
               "fr",
               "actualités",
               "musique",
               "react",
               "music",
               "culture",
               "NewMusicFriday"
             ],
             "thumbnail_url" =>
               "https://static-cdn.jtvnw.net/jtv_user_pictures/27d0d345-fa19-4f06-ad53-94a955d85f54-profile_image-300x300.png"
           }
  end

  test "schedule/1" do
    {:ok, segments} = ChannelApi.schedule(468_884_133)

    for segment <- segments do
      assert is_binary(segment.id)
      assert is_binary(segment.title)
      assert is_binary(segment.category)
      assert is_binary(DateTime.to_string(segment.start_time))
      assert is_binary(DateTime.to_string(segment.end_time))
      assert is_boolean(segment.is_recurring)
      assert is_boolean(segment.is_canceled)
    end
  end

  test "clips/1" do
    {:ok, clips} = ChannelApi.clips(468_884_133)

    for clip <- clips do
      assert Enum.sort(Map.keys(clip)) ==
               Enum.sort([
                 :id,
                 :video_id,
                 :title,
                 :url,
                 :duration,
                 :created_at,
                 :broadcaster_id,
                 :broadcaster_name,
                 :embed_url,
                 :thumbnail_url,
                 :view_count
               ])

      assert clip.created_at.__struct__ == DateTime
    end
  end
end
