defmodule TwitchStory.FeatureFlagTest do
  use TwitchStory.DataCase

  alias TwitchStory.FeatureFlag

  setup do
    user = user_fixture()
    user2 = user_fixture()

    {:ok, user: user, user2: user2}
  end

  test "enable/1 enable a feature globally" do
    before_flag = FunWithFlags.enabled?(:feature)

    :ok = FeatureFlag.enable(:feature)

    after_flag = FunWithFlags.enabled?(:feature)

    assert {before_flag, after_flag} == {false, true}
  end

  test "enable/2 enables a feature for a specific user", %{user: user, user2: user2} do
    FeatureFlag.disable(:feature5)
    before_flag = FeatureFlag.enabled?(:feature5, user)

    :ok = FeatureFlag.enable(:feature5, user)

    after_flag = FeatureFlag.enabled?(:feature5, user)

    assert FeatureFlag.enabled?(:feature5) == false
    assert FeatureFlag.enabled?(:feature5, user2) == false
    assert {before_flag, after_flag} == {false, true}
  end

  test "disable/1 disable a feature globally" do
    FeatureFlag.enable(:feature2)

    before_flag = FunWithFlags.enabled?(:feature2)

    :ok = FeatureFlag.disable(:feature2)

    after_flag = FunWithFlags.enabled?(:feature2)

    assert {before_flag, after_flag} == {true, false}
  end

  test "disable/2 disables a feature for a specific user", %{user: user, user2: user2} do
    FeatureFlag.enable(:feature6)
    before_flag = FeatureFlag.disabled?(:feature6, user)

    :ok = FeatureFlag.disable(:feature6, user)

    after_flag = FeatureFlag.disabled?(:feature6, user)

    assert FeatureFlag.disabled?(:feature6) == false
    assert FeatureFlag.disabled?(:feature6, user2) == false
    assert {before_flag, after_flag} == {false, true}
  end

  describe "enabled?/1" do
    test "returns true if the feature is enabled" do
      FeatureFlag.enable(:feature3)

      assert FeatureFlag.enabled?(:feature3) == true
    end

    test "returns false if the feature is disabled" do
      FeatureFlag.disable(:feature3)

      assert FeatureFlag.enabled?(:feature3) == false
    end
  end

  describe "disabled?/2" do
    test "returns false if the feature is enabled" do
      FeatureFlag.enable(:feature4)

      assert FeatureFlag.disabled?(:feature4) == false
    end

    test "returns true if the feature is disabled" do
      FeatureFlag.disable(:feature4)

      assert FeatureFlag.disabled?(:feature4) == true
    end
  end
end