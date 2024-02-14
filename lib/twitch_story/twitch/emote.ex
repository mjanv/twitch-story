defmodule TwitchStory.Twitch.Emote do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "emotes" do
    field :name, :string
    field :emote_set_id, :string
    field :channel_id, :id
    field :formats, {:array, :string}
    field :scales, {:array, :string}
    field :themes, {:array, :string}
    field :thumbnail_url, :string
    field :thumbnail, :binary

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(emote, attrs) do
    emote
    |> cast(attrs, [
      :name,
      :emote_set_id,
      :formats,
      :scales,
      :themes,
      :thumbnail_url,
      :thumbnail
    ])
    |> validate_required([
      :name,
      :emote_set_id,
      :formats,
      :scales,
      :themes,
      :thumbnail_url,
      :thumbnail
    ])
  end

  import Ecto.Query, warn: false

  alias TwitchStory.Repo

  def list, do: Repo.all(__MODULE__)
  def get!(id), do: Repo.get!(__MODULE__, id)
  def create(attrs \\ %{}), do: Repo.insert(__MODULE__.changeset(%__MODULE__{}, attrs))

  def update(%__MODULE__{} = emote, attrs), do: Repo.update(__MODULE__.changeset(emote, attrs))

  def delete(%__MODULE__{} = emote), do: Repo.delete(emote)
  def change(%__MODULE__{} = emote, attrs \\ %{}), do: __MODULE__.changeset(emote, attrs)
end