defmodule TwitchStory.PubSub do
  @moduledoc """
  PubSub functions

  This module provides functions to broadcast and subscribe to Phoenix PubSub events.
  """

  @pubsub TwitchStory.PubSub

  @type topic() :: String.t()
  @type event() :: map() | atom() | {atom(), map()}

  @doc "Broadcast events on the pubsub broker"
  @spec broadcast(String.t(), event()) :: :ok
  def broadcast(topic, event) do
    Phoenix.PubSub.broadcast(@pubsub, topic, event)
  end

  @doc "Subscribe to a topic of the pubsub broker"
  @spec subscribe(topic()) :: :ok
  def subscribe(topic) do
    Phoenix.PubSub.subscribe(@pubsub, topic)
  end
end
