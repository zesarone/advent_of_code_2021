defmodule DaySix do
  @moduledoc """
  Documentation for `DaySix`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> DaySix.hello()
      :world

  """
  def tick(fishes) do
    fishes
    |> Enum.reduce(
      [],
      fn
        0, fishes -> [8, 6 | fishes]
        fish, fishes -> [fish - 1 | fishes]
      end
    )
    |> Enum.reverse()
  end

  def count_fish_after(days) do
    1..days
    |> Enum.reduce(testData(), fn _i, fishes ->
      tick(fishes)
    end)
    |> length
  end


  def smartTick(fishes) do
    zeros = fishes.zero
    fishes = %{fishes | :zero => fishes.one}
    fishes = %{fishes | :one => fishes.two}
    fishes = %{fishes | :two => fishes.three}
    fishes = %{fishes | :three => fishes.four}
    fishes = %{fishes | :four => fishes.five}
    fishes = %{fishes | :five => fishes.six}
    fishes = %{fishes | :six => fishes.seven + zeros}
    fishes = %{fishes | :seven => fishes.eight}
    fishes = %{fishes | :eight => zeros}
    fishes
  end
  def smartCount(days) do
    1..days
    |> Enum.reduce(createFreqTable(), fn _i, fishes ->
      smartTick(fishes)
    end)
    |> Enum.reduce(0, fn {_, num}, tot ->
      num + tot
    end)
  end

  def createFreqTable do
    data()
    |> Enum.reduce(
      %{zero: 0, one: 0, two: 0, three: 0, four: 0, five: 0, six: 0, seven: 0, eight: 0},
      fn fish, table ->
        case fish do
          0 -> %{table | :zero => table.zero + 1}
          1 -> %{table | :one => table.one + 1}
          2 -> %{table | :two => table.two + 1}
          3 -> %{table | :three => table.three + 1}
          4 -> %{table | :four => table.four + 1}
          5 -> %{table | :five => table.five + 1}
          6 -> %{table | :six => table.six + 1}
          7 -> %{table | :seven => table.seven + 1}
          8 -> %{table | :eight => table.eight + 1}
          _ -> table
        end
      end
    )
  end

  def testData do
    [3, 4, 3, 1, 2]
  end

  def data do
    [
      5,
      1,
      2,
      1,
      5,
      3,
      1,
      1,
      1,
      1,
      1,
      2,
      5,
      4,
      1,
      1,
      1,
      1,
      2,
      1,
      2,
      1,
      1,
      1,
      1,
      1,
      2,
      1,
      5,
      1,
      1,
      1,
      3,
      1,
      1,
      1,
      3,
      1,
      1,
      3,
      1,
      1,
      4,
      3,
      1,
      1,
      4,
      1,
      1,
      1,
      1,
      2,
      1,
      1,
      1,
      5,
      1,
      1,
      5,
      1,
      1,
      1,
      4,
      4,
      2,
      5,
      1,
      1,
      5,
      1,
      1,
      2,
      2,
      1,
      2,
      1,
      1,
      5,
      3,
      1,
      2,
      1,
      1,
      3,
      1,
      4,
      3,
      3,
      1,
      1,
      3,
      1,
      5,
      1,
      1,
      3,
      1,
      1,
      4,
      4,
      1,
      1,
      1,
      5,
      1,
      1,
      1,
      4,
      4,
      1,
      3,
      1,
      4,
      1,
      1,
      4,
      5,
      1,
      1,
      1,
      4,
      3,
      1,
      4,
      1,
      1,
      4,
      4,
      3,
      5,
      1,
      2,
      2,
      1,
      2,
      2,
      1,
      1,
      1,
      2,
      1,
      1,
      1,
      4,
      1,
      1,
      3,
      1,
      1,
      2,
      1,
      4,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      2,
      2,
      1,
      1,
      5,
      5,
      1,
      1,
      1,
      5,
      1,
      1,
      1,
      1,
      5,
      1,
      3,
      2,
      1,
      1,
      5,
      2,
      3,
      1,
      2,
      2,
      2,
      5,
      1,
      1,
      3,
      1,
      1,
      1,
      5,
      1,
      4,
      1,
      1,
      1,
      3,
      2,
      1,
      3,
      3,
      1,
      3,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      2,
      3,
      1,
      5,
      1,
      4,
      1,
      3,
      5,
      1,
      1,
      1,
      2,
      2,
      1,
      1,
      1,
      1,
      5,
      4,
      1,
      1,
      3,
      1,
      2,
      4,
      2,
      1,
      1,
      3,
      5,
      1,
      1,
      1,
      3,
      1,
      1,
      1,
      5,
      1,
      1,
      1,
      1,
      1,
      3,
      1,
      1,
      1,
      4,
      1,
      1,
      1,
      1,
      2,
      2,
      1,
      1,
      1,
      1,
      5,
      3,
      1,
      2,
      3,
      4,
      1,
      1,
      5,
      1,
      2,
      4,
      2,
      1,
      1,
      1,
      2,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      4,
      1,
      5
    ]
  end
end
