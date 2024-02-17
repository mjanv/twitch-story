defmodule TwitchStory.Accounts.UserTwitchTokens do
  @moduledoc false

  use Ecto.Schema

  schema "user_twitch_tokens" do
    field :token, :binary
    field :access_token, :binary
    field :refresh_token, :binary
    field :scope, {:array, :string}

    belongs_to :user, TwitchStory.Accounts.User

    timestamps(updated_at: false)
  end
end