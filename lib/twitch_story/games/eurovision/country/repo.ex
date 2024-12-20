defmodule TwitchStory.Games.Eurovision.Country.Repo do
  @moduledoc false

  @type country() :: %{
          required(:name) => String.t(),
          required(:code) => String.t()
        }

  @spec all :: [country()]
  def all do
    [
      %{name: "Albania", code: "AL"},
      %{name: "Andorra", code: "AD"},
      %{name: "Armenia", code: "AM"},
      %{name: "Australia", code: "AU"},
      %{name: "Austria", code: "AT"},
      %{name: "Azerbaijan", code: "AZ"},
      %{name: "Belarus", code: "BY"},
      %{name: "Belgium", code: "BE"},
      %{name: "Bosnia and Herzegovina", code: "BA"},
      %{name: "Bulgaria", code: "BG"},
      %{name: "Croatia", code: "HR"},
      %{name: "Cyprus", code: "CY"},
      %{name: "Czech Republic", code: "CZ"},
      %{name: "Denmark", code: "DK"},
      %{name: "Estonia", code: "EE"},
      %{name: "Finland", code: "FI"},
      %{name: "France", code: "FR"},
      %{name: "Georgia", code: "GE"},
      %{name: "Germany", code: "DE"},
      %{name: "Greece", code: "GR"},
      %{name: "Hungary", code: "HU"},
      %{name: "Iceland", code: "IS"},
      %{name: "Ireland", code: "IE"},
      %{name: "Israel", code: "IL"},
      %{name: "Italy", code: "IT"},
      %{name: "Kazakhstan", code: "KZ"},
      %{name: "Latvia", code: "LV"},
      %{name: "Liechtenstein", code: "LI"},
      %{name: "Lithuania", code: "LT"},
      %{name: "Luxembourg", code: "LU"},
      %{name: "Malta", code: "MT"},
      %{name: "Moldova", code: "MD"},
      %{name: "Monaco", code: "MC"},
      %{name: "Montenegro", code: "ME"},
      %{name: "Netherlands", code: "NL"},
      %{name: "North Macedonia", code: "MK"},
      %{name: "Norway", code: "NO"},
      %{name: "Poland", code: "PL"},
      %{name: "Portugal", code: "PT"},
      %{name: "Romania", code: "RO"},
      %{name: "San Marino", code: "SM"},
      %{name: "Serbia", code: "RS"},
      %{name: "Slovakia", code: "SK"},
      %{name: "Slovenia", code: "SI"},
      %{name: "Spain", code: "ES"},
      %{name: "Sweden", code: "SE"},
      %{name: "Switzerland", code: "CH"},
      %{name: "Turkey", code: "TR"},
      %{name: "Ukraine", code: "UA"},
      %{name: "United Kingdom", code: "GB"}
    ]
  end

  @spec codes :: [String.t()]
  def codes, do: Enum.map(all(), & &1.code)

  @spec names :: [String.t()]
  def names, do: Enum.map(all(), & &1.name)
end
