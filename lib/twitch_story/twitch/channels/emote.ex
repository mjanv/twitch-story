defmodule TwitchStory.Twitch.Channels.Emote do
  @moduledoc false

  use TwitchStory.Schema

  alias TwitchStory.Repo

  schema "emotes" do
    field :emote_id, :string
    field :name, :string
    field :channel_id, :string
    field :emote_set_id, :string
    field :formats, {:array, :string}
    field :scales, {:array, :string}
    field :themes, {:array, :string}
    field :thumbnail_url, :string
    field :thumbnail, :binary

    # belongs_to :channel, TwitchStory.Twitch.Channels.Channel, references: :broadcaster_id

    timestamps(type: :utc_datetime)
  end

  @attrs [
    :name,
    :channel_id,
    :emote_set_id,
    :formats,
    :scales,
    :themes,
    :thumbnail_url,
    :thumbnail
  ]

  def changeset(emote, attrs), do: emote |> cast(attrs, @attrs) |> validate_required(@attrs)
  def change(%__MODULE__{} = emote, attrs \\ %{}), do: __MODULE__.changeset(emote, attrs)

  def list, do: Repo.all(__MODULE__)
  def get!(id), do: Repo.get!(__MODULE__, id)
  def create(attrs \\ %{}), do: Repo.insert(__MODULE__.changeset(%__MODULE__{}, attrs))
  def update(%__MODULE__{} = emote, attrs), do: Repo.update(__MODULE__.changeset(emote, attrs))
  def delete(%__MODULE__{} = emote), do: Repo.delete(emote)
end
