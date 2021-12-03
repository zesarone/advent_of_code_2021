defmodule DayTwo do
  @moduledoc """
  Documentation for `DayTwo`.
  https://adventofcode.com/2021/day/2
  """

  @type dataList :: [
    {:down, 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9}
    | {:forward, 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9}
    | {:up, 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9},
    ...
  ]
  @doc """
  walk_path

  ## Examples

      iex> DayTwo.data |> DayTwo.walk_path()
      %{hori: 1990, verti: 1000}

  """
  @spec walk_path(dataList) :: %{verti: integer(), hori: integer()}
  def walk_path(data) do
    data
    |> Enum.reduce(%{hori: 0, verti: 0}, fn {direction, length}, %{hori: hori, verti: verti} ->
      case direction do
        :forward -> %{hori: hori + length, verti: verti}
        :down -> %{hori: hori, verti: verti + length}
        :up -> %{hori: hori, verti: verti - length}
      end
    end)
  end

  @doc """
  walk_path_2

  ## Examples

      iex> DayTwo.data |> DayTwo.walk_path_2()
      %{aim: 1000, depth: 992674, hori: 1990}

  """
  @spec walk_path_2(dataList) :: %{aim: integer(), depth: integer(), hori: integer()}
  def walk_path_2(data) do
    data
    |> Enum.reduce(
      %{hori: 0, aim: 0, depth: 0},
      fn {direction, length}, %{hori: hori, aim: aim, depth: depth} ->
        case direction do
          :forward -> %{hori: hori + length, aim: aim, depth: depth + length * aim}
          :down -> %{hori: hori, aim: aim + length, depth: depth}
          :up -> %{hori: hori, aim: aim - length, depth: depth}
        end
      end
    )
  end


  @spec data :: dataList
  def data do
    [
      {:forward, 7},
      {:down, 2},
      {:forward, 7},
      {:down, 6},
      {:forward, 1},
      {:forward, 7},
      {:down, 3},
      {:up, 5},
      {:forward, 7},
      {:forward, 6},
      {:down, 8},
      {:down, 1},
      {:up, 5},
      {:up, 1},
      {:down, 2},
      {:forward, 8},
      {:forward, 3},
      {:down, 8},
      {:down, 9},
      {:down, 1},
      {:forward, 4},
      {:down, 8},
      {:down, 7},
      {:forward, 3},
      {:up, 5},
      {:up, 3},
      {:forward, 9},
      {:forward, 5},
      {:forward, 5},
      {:down, 9},
      {:up, 2},
      {:down, 4},
      {:up, 4},
      {:down, 9},
      {:forward, 7},
      {:down, 9},
      {:up, 7},
      {:forward, 4},
      {:down, 2},
      {:down, 6},
      {:up, 3},
      {:down, 2},
      {:down, 4},
      {:up, 5},
      {:forward, 7},
      {:up, 8},
      {:down, 4},
      {:forward, 8},
      {:down, 5},
      {:forward, 1},
      {:forward, 3},
      {:up, 9},
      {:forward, 5},
      {:down, 4},
      {:forward, 6},
      {:forward, 2},
      {:up, 3},
      {:down, 5},
      {:down, 6},
      {:forward, 8},
      {:up, 6},
      {:up, 9},
      {:down, 8},
      {:down, 2},
      {:down, 6},
      {:forward, 2},
      {:forward, 8},
      {:forward, 1},
      {:forward, 5},
      {:forward, 3},
      {:down, 8},
      {:down, 5},
      {:forward, 3},
      {:up, 7},
      {:down, 9},
      {:up, 9},
      {:forward, 7},
      {:forward, 6},
      {:forward, 4},
      {:down, 5},
      {:forward, 1},
      {:down, 9},
      {:forward, 9},
      {:forward, 6},
      {:down, 8},
      {:down, 5},
      {:forward, 5},
      {:forward, 4},
      {:forward, 3},
      {:up, 6},
      {:up, 7},
      {:forward, 2},
      {:up, 2},
      {:up, 9},
      {:forward, 8},
      {:up, 3},
      {:forward, 8},
      {:down, 8},
      {:forward, 1},
      {:forward, 7},
      {:forward, 4},
      {:down, 5},
      {:forward, 8},
      {:down, 2},
      {:down, 2},
      {:down, 3},
      {:forward, 3},
      {:forward, 3},
      {:up, 3},
      {:forward, 4},
      {:up, 9},
      {:up, 8},
      {:forward, 1},
      {:down, 8},
      {:up, 6},
      {:down, 5},
      {:up, 3},
      {:up, 2},
      {:forward, 1},
      {:up, 8},
      {:down, 7},
      {:up, 5},
      {:down, 2},
      {:forward, 5},
      {:down, 3},
      {:down, 1},
      {:forward, 2},
      {:forward, 6},
      {:forward, 7},
      {:forward, 1},
      {:forward, 5},
      {:forward, 4},
      {:down, 9},
      {:forward, 6},
      {:down, 9},
      {:up, 8},
      {:forward, 9},
      {:forward, 5},
      {:up, 2},
      {:up, 7},
      {:up, 2},
      {:down, 1},
      {:down, 7},
      {:down, 1},
      {:forward, 2},
      {:down, 8},
      {:down, 3},
      {:forward, 1},
      {:down, 5},
      {:forward, 7},
      {:forward, 5},
      {:forward, 6},
      {:up, 6},
      {:forward, 6},
      {:forward, 1},
      {:down, 2},
      {:forward, 5},
      {:down, 7},
      {:up, 1},
      {:down, 5},
      {:down, 4},
      {:down, 8},
      {:up, 2},
      {:down, 2},
      {:up, 6},
      {:forward, 2},
      {:down, 2},
      {:up, 9},
      {:down, 7},
      {:down, 3},
      {:down, 6},
      {:forward, 5},
      {:up, 5},
      {:forward, 2},
      {:forward, 7},
      {:down, 9},
      {:up, 3},
      {:forward, 4},
      {:forward, 4},
      {:down, 6},
      {:down, 2},
      {:down, 4},
      {:forward, 6},
      {:down, 2},
      {:down, 8},
      {:up, 2},
      {:forward, 9},
      {:down, 8},
      {:forward, 4},
      {:down, 2},
      {:up, 4},
      {:down, 6},
      {:forward, 3},
      {:forward, 2},
      {:forward, 7},
      {:down, 7},
      {:forward, 3},
      {:forward, 7},
      {:down, 9},
      {:up, 6},
      {:down, 4},
      {:forward, 4},
      {:down, 6},
      {:down, 8},
      {:down, 4},
      {:forward, 3},
      {:up, 5},
      {:up, 4},
      {:up, 9},
      {:forward, 9},
      {:down, 1},
      {:forward, 3},
      {:forward, 9},
      {:up, 3},
      {:down, 5},
      {:forward, 2},
      {:down, 9},
      {:down, 9},
      {:forward, 1},
      {:forward, 4},
      {:forward, 8},
      {:forward, 9},
      {:down, 4},
      {:forward, 3},
      {:down, 3},
      {:forward, 9},
      {:down, 1},
      {:down, 3},
      {:down, 9},
      {:down, 3},
      {:down, 2},
      {:down, 1},
      {:up, 2},
      {:down, 3},
      {:up, 7},
      {:forward, 7},
      {:down, 9},
      {:up, 6},
      {:down, 1},
      {:down, 7},
      {:down, 7},
      {:up, 7},
      {:forward, 8},
      {:down, 1},
      {:down, 7},
      {:down, 8},
      {:up, 4},
      {:down, 6},
      {:down, 7},
      {:forward, 5},
      {:down, 9},
      {:forward, 2},
      {:down, 6},
      {:down, 8},
      {:down, 5},
      {:down, 4},
      {:forward, 8},
      {:down, 4},
      {:forward, 8},
      {:down, 3},
      {:down, 6},
      {:forward, 6},
      {:forward, 1},
      {:up, 5},
      {:down, 2},
      {:down, 2},
      {:forward, 7},
      {:forward, 1},
      {:up, 3},
      {:down, 6},
      {:down, 3},
      {:down, 9},
      {:up, 6},
      {:forward, 4},
      {:down, 1},
      {:forward, 4},
      {:up, 3},
      {:forward, 6},
      {:down, 7},
      {:down, 2},
      {:up, 3},
      {:down, 1},
      {:up, 7},
      {:down, 7},
      {:forward, 5},
      {:up, 9},
      {:up, 1},
      {:up, 2},
      {:forward, 4},
      {:forward, 9},
      {:up, 3},
      {:down, 8},
      {:up, 2},
      {:down, 9},
      {:forward, 8},
      {:up, 2},
      {:down, 5},
      {:up, 5},
      {:down, 2},
      {:up, 8},
      {:down, 6},
      {:down, 8},
      {:up, 7},
      {:forward, 9},
      {:forward, 6},
      {:forward, 5},
      {:forward, 8},
      {:forward, 7},
      {:down, 2},
      {:forward, 1},
      {:forward, 6},
      {:down, 3},
      {:down, 7},
      {:up, 1},
      {:forward, 7},
      {:up, 7},
      {:down, 2},
      {:down, 9},
      {:up, 4},
      {:forward, 2},
      {:down, 3},
      {:up, 8},
      {:up, 3},
      {:down, 9},
      {:down, 2},
      {:forward, 4},
      {:forward, 9},
      {:forward, 8},
      {:forward, 2},
      {:up, 2},
      {:forward, 3},
      {:forward, 8},
      {:down, 2},
      {:down, 4},
      {:up, 8},
      {:up, 2},
      {:forward, 4},
      {:forward, 7},
      {:up, 8},
      {:forward, 8},
      {:forward, 1},
      {:forward, 9},
      {:down, 9},
      {:up, 3},
      {:forward, 9},
      {:down, 5},
      {:down, 9},
      {:down, 2},
      {:forward, 1},
      {:forward, 6},
      {:forward, 3},
      {:up, 7},
      {:down, 8},
      {:down, 2},
      {:up, 6},
      {:down, 5},
      {:forward, 4},
      {:up, 7},
      {:down, 5},
      {:down, 3},
      {:forward, 5},
      {:forward, 5},
      {:up, 4},
      {:down, 7},
      {:down, 5},
      {:up, 1},
      {:down, 4},
      {:down, 6},
      {:forward, 6},
      {:forward, 3},
      {:down, 9},
      {:forward, 6},
      {:forward, 4},
      {:down, 8},
      {:up, 5},
      {:down, 7},
      {:forward, 6},
      {:forward, 7},
      {:down, 9},
      {:forward, 3},
      {:forward, 3},
      {:forward, 4},
      {:down, 6},
      {:forward, 2},
      {:forward, 9},
      {:up, 2},
      {:forward, 7},
      {:up, 5},
      {:forward, 6},
      {:down, 8},
      {:down, 7},
      {:forward, 1},
      {:down, 6},
      {:forward, 3},
      {:down, 9},
      {:forward, 7},
      {:forward, 2},
      {:forward, 1},
      {:down, 9},
      {:down, 2},
      {:up, 8},
      {:down, 1},
      {:down, 3},
      {:up, 6},
      {:down, 5},
      {:up, 2},
      {:down, 2},
      {:down, 8},
      {:forward, 7},
      {:down, 8},
      {:forward, 6},
      {:up, 5},
      {:down, 8},
      {:down, 4},
      {:down, 1},
      {:forward, 1},
      {:forward, 9},
      {:down, 3},
      {:forward, 9},
      {:up, 2},
      {:down, 2},
      {:forward, 9},
      {:up, 2},
      {:up, 2},
      {:down, 8},
      {:down, 1},
      {:up, 4},
      {:down, 9},
      {:down, 6},
      {:up, 7},
      {:down, 6},
      {:forward, 7},
      {:forward, 3},
      {:forward, 9},
      {:forward, 2},
      {:down, 9},
      {:down, 8},
      {:down, 5},
      {:forward, 4},
      {:forward, 1},
      {:forward, 3},
      {:forward, 3},
      {:forward, 1},
      {:forward, 6},
      {:forward, 7},
      {:down, 7},
      {:down, 1},
      {:up, 4},
      {:up, 2},
      {:forward, 9},
      {:up, 7},
      {:down, 1},
      {:forward, 5},
      {:down, 8},
      {:forward, 3},
      {:down, 9},
      {:up, 4},
      {:up, 1},
      {:forward, 7},
      {:down, 1},
      {:forward, 4},
      {:up, 6},
      {:down, 9},
      {:forward, 2},
      {:forward, 7},
      {:down, 1},
      {:forward, 2},
      {:forward, 1},
      {:down, 2},
      {:forward, 6},
      {:down, 4},
      {:up, 7},
      {:down, 6},
      {:forward, 1},
      {:down, 9},
      {:up, 8},
      {:up, 6},
      {:forward, 4},
      {:down, 5},
      {:up, 8},
      {:down, 5},
      {:up, 9},
      {:forward, 1},
      {:forward, 6},
      {:down, 4},
      {:up, 5},
      {:forward, 4},
      {:forward, 2},
      {:down, 6},
      {:forward, 9},
      {:down, 7},
      {:down, 2},
      {:forward, 1},
      {:up, 2},
      {:forward, 4},
      {:forward, 4},
      {:forward, 7},
      {:down, 5},
      {:up, 1},
      {:down, 7},
      {:down, 1},
      {:forward, 3},
      {:forward, 6},
      {:forward, 7},
      {:down, 5},
      {:down, 4},
      {:down, 2},
      {:down, 3},
      {:up, 3},
      {:forward, 7},
      {:down, 3},
      {:up, 2},
      {:forward, 7},
      {:down, 9},
      {:up, 4},
      {:forward, 9},
      {:forward, 4},
      {:forward, 2},
      {:down, 9},
      {:forward, 1},
      {:down, 5},
      {:forward, 3},
      {:forward, 5},
      {:up, 7},
      {:down, 9},
      {:up, 7},
      {:down, 5},
      {:down, 2},
      {:up, 5},
      {:up, 1},
      {:forward, 8},
      {:forward, 3},
      {:up, 5},
      {:forward, 2},
      {:down, 2},
      {:forward, 5},
      {:forward, 3},
      {:forward, 4},
      {:up, 4},
      {:forward, 3},
      {:up, 4},
      {:forward, 1},
      {:down, 2},
      {:forward, 5},
      {:down, 9},
      {:forward, 8},
      {:forward, 2},
      {:forward, 5},
      {:forward, 1},
      {:up, 3},
      {:up, 8},
      {:forward, 2},
      {:forward, 9},
      {:down, 7},
      {:up, 5},
      {:up, 2},
      {:forward, 1},
      {:forward, 4},
      {:up, 4},
      {:forward, 5},
      {:down, 5},
      {:forward, 5},
      {:down, 2},
      {:down, 8},
      {:forward, 4},
      {:down, 3},
      {:forward, 7},
      {:down, 7},
      {:forward, 6},
      {:down, 9},
      {:down, 2},
      {:up, 4},
      {:up, 5},
      {:down, 2},
      {:down, 7},
      {:forward, 3},
      {:down, 1},
      {:down, 5},
      {:down, 6},
      {:forward, 8},
      {:forward, 7},
      {:down, 3},
      {:forward, 4},
      {:forward, 8},
      {:forward, 2},
      {:down, 8},
      {:down, 3},
      {:forward, 8},
      {:down, 2},
      {:up, 2},
      {:forward, 3},
      {:up, 2},
      {:down, 7},
      {:down, 4},
      {:forward, 8},
      {:forward, 7},
      {:down, 9},
      {:forward, 7},
      {:down, 8},
      {:up, 3},
      {:forward, 1},
      {:up, 5},
      {:forward, 6},
      {:down, 7},
      {:forward, 8},
      {:forward, 3},
      {:forward, 1},
      {:forward, 5},
      {:down, 8},
      {:up, 8},
      {:forward, 9},
      {:down, 7},
      {:up, 8},
      {:up, 8},
      {:forward, 9},
      {:up, 6},
      {:forward, 2},
      {:down, 8},
      {:forward, 6},
      {:down, 6},
      {:down, 6},
      {:forward, 8},
      {:up, 9},
      {:forward, 9},
      {:down, 8},
      {:down, 8},
      {:forward, 3},
      {:forward, 3},
      {:down, 8},
      {:up, 7},
      {:down, 1},
      {:forward, 5},
      {:up, 6},
      {:forward, 6},
      {:up, 8},
      {:down, 7},
      {:down, 3},
      {:down, 4},
      {:forward, 7},
      {:down, 2},
      {:forward, 4},
      {:forward, 6},
      {:down, 2},
      {:down, 6},
      {:up, 2},
      {:down, 9},
      {:down, 8},
      {:forward, 6},
      {:up, 8},
      {:up, 4},
      {:forward, 1},
      {:forward, 2},
      {:down, 8},
      {:forward, 6},
      {:down, 2},
      {:down, 7},
      {:down, 1},
      {:down, 2},
      {:forward, 9},
      {:forward, 5},
      {:down, 2},
      {:down, 8},
      {:down, 9},
      {:up, 6},
      {:forward, 6},
      {:up, 2},
      {:down, 9},
      {:down, 4},
      {:down, 9},
      {:up, 7},
      {:forward, 2},
      {:up, 9},
      {:down, 7},
      {:forward, 2},
      {:down, 7},
      {:up, 6},
      {:down, 3},
      {:up, 1},
      {:down, 8},
      {:down, 4},
      {:forward, 1},
      {:up, 5},
      {:up, 4},
      {:down, 2},
      {:down, 8},
      {:forward, 8},
      {:forward, 7},
      {:up, 1},
      {:down, 8},
      {:forward, 2},
      {:forward, 7},
      {:down, 4},
      {:forward, 4},
      {:down, 3},
      {:down, 7},
      {:forward, 8},
      {:down, 7},
      {:down, 3},
      {:down, 3},
      {:forward, 8},
      {:forward, 8},
      {:up, 1},
      {:forward, 8},
      {:forward, 6},
      {:down, 9},
      {:up, 1},
      {:down, 7},
      {:down, 7},
      {:forward, 7},
      {:forward, 7},
      {:up, 5},
      {:down, 7},
      {:down, 6},
      {:down, 6},
      {:forward, 8},
      {:down, 3},
      {:forward, 8},
      {:down, 8},
      {:forward, 7},
      {:forward, 2},
      {:up, 6},
      {:down, 6},
      {:down, 8},
      {:forward, 1},
      {:forward, 8},
      {:down, 9},
      {:down, 7},
      {:up, 5},
      {:down, 1},
      {:forward, 6},
      {:down, 9},
      {:forward, 5},
      {:up, 2},
      {:up, 9},
      {:down, 6},
      {:down, 8},
      {:down, 6},
      {:up, 1},
      {:forward, 7},
      {:down, 9},
      {:up, 2},
      {:forward, 3},
      {:down, 7},
      {:up, 5},
      {:forward, 3},
      {:forward, 8},
      {:up, 2},
      {:forward, 1},
      {:down, 6},
      {:down, 7},
      {:up, 4},
      {:down, 5},
      {:up, 8},
      {:forward, 9},
      {:forward, 5},
      {:up, 7},
      {:down, 3},
      {:forward, 2},
      {:up, 7},
      {:up, 2},
      {:down, 3},
      {:up, 9},
      {:down, 9},
      {:down, 8},
      {:up, 8},
      {:down, 6},
      {:forward, 9},
      {:up, 7},
      {:forward, 4},
      {:forward, 7},
      {:up, 7},
      {:down, 6},
      {:forward, 5},
      {:up, 2},
      {:up, 4},
      {:down, 1},
      {:down, 2},
      {:down, 9},
      {:forward, 5},
      {:forward, 3},
      {:forward, 9},
      {:up, 7},
      {:forward, 7},
      {:down, 5},
      {:down, 2},
      {:up, 9},
      {:forward, 4},
      {:forward, 4},
      {:up, 5},
      {:up, 3},
      {:forward, 5},
      {:forward, 9},
      {:forward, 4},
      {:forward, 8},
      {:down, 2},
      {:up, 4},
      {:down, 1},
      {:forward, 9},
      {:forward, 9},
      {:up, 7},
      {:down, 3},
      {:forward, 2},
      {:forward, 4},
      {:down, 6},
      {:up, 1},
      {:forward, 6},
      {:down, 4},
      {:up, 9},
      {:down, 4},
      {:forward, 3},
      {:down, 9},
      {:up, 9},
      {:down, 8},
      {:up, 6},
      {:forward, 9},
      {:forward, 1},
      {:forward, 2},
      {:up, 2},
      {:forward, 8},
      {:forward, 9},
      {:forward, 3},
      {:forward, 5},
      {:down, 5},
      {:down, 7},
      {:forward, 7},
      {:forward, 5},
      {:down, 3},
      {:up, 2},
      {:forward, 4},
      {:down, 3},
      {:up, 6},
      {:down, 6},
      {:up, 6},
      {:forward, 1},
      {:forward, 2},
      {:down, 5},
      {:down, 8},
      {:down, 3},
      {:forward, 5},
      {:up, 4},
      {:forward, 6},
      {:forward, 9},
      {:forward, 6},
      {:forward, 1},
      {:forward, 4},
      {:up, 1},
      {:forward, 3},
      {:forward, 3},
      {:up, 3},
      {:forward, 9},
      {:forward, 1},
      {:forward, 7},
      {:forward, 8},
      {:forward, 1},
      {:forward, 9},
      {:forward, 7},
      {:up, 9},
      {:forward, 9},
      {:up, 4},
      {:down, 4},
      {:up, 9},
      {:down, 5},
      {:down, 8},
      {:down, 3},
      {:forward, 6},
      {:down, 7},
      {:forward, 5},
      {:forward, 6},
      {:forward, 8},
      {:forward, 7},
      {:down, 7},
      {:down, 5},
      {:forward, 4},
      {:down, 6},
      {:down, 4},
      {:down, 6},
      {:down, 1},
      {:forward, 3},
      {:down, 3},
      {:down, 7},
      {:forward, 6},
      {:forward, 3},
      {:up, 2},
      {:forward, 1},
      {:forward, 8},
      {:down, 9},
      {:down, 3},
      {:down, 3},
      {:up, 6},
      {:down, 7},
      {:down, 3},
      {:forward, 2},
      {:down, 7},
      {:down, 2},
      {:forward, 1},
      {:down, 7},
      {:down, 3},
      {:forward, 9},
      {:down, 4},
      {:down, 3},
      {:forward, 9},
      {:up, 2},
      {:up, 4},
      {:forward, 4},
      {:down, 4},
      {:up, 2},
      {:down, 2},
      {:forward, 8},
      {:down, 1},
      {:up, 9},
      {:down, 5},
      {:down, 7},
      {:forward, 3},
      {:forward, 9},
      {:forward, 7},
      {:forward, 1},
      {:forward, 7},
      {:forward, 1},
      {:forward, 7},
      {:up, 7},
      {:down, 6},
      {:forward, 6},
      {:forward, 4},
      {:forward, 6},
      {:up, 3},
      {:down, 5},
      {:down, 5},
      {:down, 3},
      {:down, 6},
      {:down, 3},
      {:down, 3},
      {:up, 2},
      {:down, 4},
      {:up, 8},
      {:down, 4},
      {:up, 2},
      {:down, 7},
      {:forward, 9},
      {:up, 9},
      {:down, 1},
      {:forward, 8},
      {:forward, 7},
      {:forward, 6},
      {:forward, 8},
      {:up, 6},
      {:up, 6},
      {:down, 5},
      {:forward, 6},
      {:down, 3},
      {:forward, 6},
      {:forward, 9},
      {:down, 2},
      {:down, 6},
      {:down, 4},
      {:down, 5},
      {:forward, 7},
      {:forward, 4},
      {:up, 3},
      {:down, 6},
      {:down, 6},
      {:forward, 1},
      {:forward, 4},
      {:down, 6},
      {:up, 3},
      {:forward, 1},
      {:down, 3},
      {:down, 7},
      {:down, 4},
      {:down, 8},
      {:down, 8},
      {:up, 8},
      {:down, 2},
      {:up, 8},
      {:down, 3},
      {:down, 3},
      {:forward, 3},
      {:down, 3},
      {:down, 7},
      {:up, 6},
      {:forward, 8},
      {:down, 4},
      {:forward, 1},
      {:down, 7},
      {:down, 3},
      {:forward, 5},
      {:forward, 8},
      {:up, 1},
      {:forward, 2},
      {:down, 7},
      {:down, 7},
      {:forward, 1},
      {:up, 7},
      {:down, 3},
      {:up, 3},
      {:forward, 5},
      {:forward, 9},
      {:down, 3},
      {:down, 7},
      {:down, 5},
      {:forward, 7}
    ]
  end
end
