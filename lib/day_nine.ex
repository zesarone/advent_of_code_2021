defmodule DayNine do
  @moduledoc """
  Documentation for `DayNine`.
  """

  def lowPoints do
    d = data()
    0..length(d)-1
    |> Enum.reduce(0,fn y,tot ->
      prevRow = Enum.at(d,y-1,[])
      currentRow = Enum.at(d,y,[])
      nextRow = Enum.at(d,y+1,[])
      0..length(currentRow)-1
      |> Enum.reduce(0,fn x, tota ->

        if isLow(
          Enum.at(currentRow, x),
          Enum.at(prevRow, x),
          Enum.at(nextRow, x),
          Enum.at(currentRow, x-1),
          Enum.at(currentRow, x+1)
          ) do
            IO.inspect(x)
            IO.inspect(y)
            Enum.at(currentRow, x) + 1 + tota
          else
            tota
          end

      end)
      |> Kernel.+(tot)

    end)
  end


  def basins do
    d = data()
    0..length(d)-1
    |> Enum.reduce([],fn y,lows ->
      prevRow = Enum.at(d,y-1,[])
      currentRow = Enum.at(d,y,[])
      nextRow = Enum.at(d,y+1,[])
      0..length(currentRow)-1
      |> Enum.reduce(lows,fn x, lowpoints ->

        if isLow(
          Enum.at(currentRow, x),
          Enum.at(prevRow, x),
          Enum.at(nextRow, x),
          Enum.at(currentRow, x-1),
          Enum.at(currentRow, x+1)
          ) do
            [{x,y}|lowpoints]
          else
            lowpoints
          end
      end)
    end)
    |> Enum.map(& floodFill(d,&1,%{})|>map_size())
    |> Enum.sort
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.reduce(1,&Kernel.*/2)
  end

  def floodFill(map,pos = {x,y},added) do

    cond do
      Map.get(added,String.to_atom("#{x}#{y}")) != nil -> added
      length(map) <= y or y < 0 -> added
      length(Enum.at(map,y)) <= x or x < 0 -> added
      isBorder(map,pos) -> added
      true ->
        added = Map.put(added,String.to_atom("#{x}#{y}"),pos)
        added = floodFill(map,{x-1,y},added)
        added = floodFill(map,{x+1,y},added)
        added = floodFill(map,{x,y-1},added)
        floodFill(map,{x,y+1},added)
    end
  end


  def isBorder(map,{x,y}) do
    Enum.at(map,y)
    |> Enum.at(x)
    |> Kernel.>=(9)
  end

  def isLow(pos, above,below,leftof,rightof) do

      above > pos
      &&
      below > pos
      &&
      leftof > pos
      &&
      rightof > pos
  end

  def testData do
    [
[2,1,9,9,9,4,3,2,1,0],
[3,9,8,7,8,9,4,9,2,1],
[9,8,5,6,7,8,9,8,9,2],
[8,7,6,7,8,9,6,7,8,9],
[9,8,9,9,9,6,5,6,7,8]
    ]
  end

  def data do
[[8,6,5,6,4,5,6,7,8,9,4,3,2,1,2,9,8,7,6,5,3,2,3,5,6,7,8,9,8,9,9,9,9,8,7,5,4,3,2,0,1,4,6,7,8,9,7,6,7,8,9,3,2,1,3,4,6,8,9,5,3,2,0,5,4,5,9,3,2,3,9,9,7,6,7,8,9,0,1,9,9,7,6,5,5,4,2,3,5,6,7,7,9,7,6,5,5,6,6,7],
[6,5,4,5,3,4,5,9,9,6,5,4,3,2,3,4,9,8,7,3,2,1,5,6,7,8,9,6,7,9,8,7,4,9,8,8,6,5,3,1,2,3,5,6,9,7,6,5,7,9,9,9,3,0,4,9,8,9,7,6,4,3,1,2,3,7,8,9,9,9,8,8,6,5,6,7,8,9,9,8,7,6,5,4,3,2,1,2,3,4,5,6,7,9,5,4,3,1,5,6],
[5,4,3,1,2,3,9,8,7,9,6,9,4,3,4,9,8,7,6,4,3,2,3,9,8,9,4,5,9,7,6,5,3,2,9,9,7,7,8,2,3,5,6,7,8,9,5,4,7,8,9,8,9,1,9,8,9,8,7,6,5,4,3,4,5,6,7,9,8,8,7,6,5,4,5,6,7,8,9,9,9,7,6,5,4,3,2,3,4,5,6,7,8,9,6,5,4,3,4,5],
[6,5,2,0,1,3,9,7,6,8,9,8,9,5,5,6,9,8,7,5,4,3,4,9,9,2,3,9,8,5,4,3,2,1,0,9,8,9,9,3,7,6,8,9,9,6,5,3,6,5,8,7,9,9,8,7,8,9,8,7,6,5,9,7,6,7,9,8,7,6,5,4,4,2,4,5,6,9,0,1,9,8,9,6,5,6,5,4,5,6,7,8,9,9,8,7,5,4,5,6],
[7,6,3,1,2,9,7,6,5,7,6,7,9,6,9,7,9,9,8,7,5,6,7,8,9,3,4,9,7,6,5,4,3,2,1,2,9,6,5,4,8,7,9,7,9,7,6,2,7,4,5,6,7,8,9,6,7,8,9,9,7,6,9,8,7,8,9,9,9,7,4,3,2,1,3,6,7,8,9,9,9,9,8,7,6,7,6,5,6,9,8,9,6,9,9,8,7,8,8,7],
[9,7,9,9,9,8,9,8,4,4,5,6,8,9,8,9,8,6,9,8,9,7,9,9,6,4,5,9,8,7,6,5,4,3,4,3,9,8,6,5,9,9,4,5,9,9,2,1,0,2,3,5,8,9,3,4,5,9,9,9,8,8,9,9,9,9,5,9,8,6,5,4,3,5,4,5,6,9,9,8,8,8,9,8,9,8,7,6,8,9,9,4,5,8,9,9,8,9,9,8],
[9,8,9,8,7,6,6,5,3,2,3,4,5,6,7,8,9,5,4,9,9,8,9,8,7,9,6,8,9,8,9,6,7,5,6,4,9,8,7,6,7,8,9,9,8,7,4,2,1,3,4,6,9,3,2,3,9,8,8,9,9,9,4,2,1,3,4,9,8,7,6,5,4,6,7,6,7,8,9,7,6,7,8,9,1,9,8,7,8,9,4,3,5,7,8,9,9,9,9,9],
[5,9,9,9,8,5,4,3,2,1,2,3,4,7,9,9,1,2,3,4,5,9,9,9,9,8,9,9,6,9,9,8,7,6,7,8,9,9,8,9,8,9,9,8,7,6,5,3,2,4,5,7,8,9,1,9,8,7,6,7,8,9,9,1,0,1,3,4,9,8,7,6,7,8,9,8,8,9,6,5,5,6,7,9,0,1,9,8,9,6,5,4,5,6,7,8,9,8,9,9],
[4,5,9,8,7,6,5,3,1,0,1,3,8,9,2,1,0,1,4,9,6,8,9,9,8,7,9,9,5,4,3,9,8,7,8,9,3,2,9,8,9,6,4,9,8,9,5,4,7,5,9,8,9,2,0,9,8,6,5,9,8,9,8,9,1,3,9,9,9,9,8,7,8,9,9,9,9,6,4,3,4,6,8,9,1,2,4,9,8,7,6,5,9,7,8,9,8,7,9,8],
[3,4,5,9,9,7,7,7,3,1,2,5,7,8,9,3,9,2,9,8,9,9,9,8,7,5,7,8,9,3,2,4,9,8,9,3,2,1,2,7,8,9,3,4,9,9,9,8,7,6,9,9,4,3,9,8,7,7,4,8,7,5,6,8,9,9,8,8,9,9,9,8,9,9,9,8,8,9,4,2,3,4,9,7,9,9,5,7,9,8,7,9,8,9,9,8,7,6,6,7],
[1,3,4,9,9,9,8,6,4,3,4,6,7,8,9,9,8,9,6,7,9,8,7,9,5,4,6,7,8,9,0,2,3,9,6,4,3,4,5,6,7,8,9,9,8,9,9,9,8,7,8,9,9,4,9,7,6,5,3,2,6,4,8,9,9,8,7,6,8,8,9,9,3,9,8,6,7,8,9,1,2,4,5,6,7,8,9,9,2,9,9,8,7,8,9,7,5,5,5,8],
[2,4,9,8,9,9,7,6,5,4,9,8,9,9,9,8,7,6,5,9,8,7,6,5,4,3,5,6,7,8,9,3,4,9,9,5,4,6,7,7,9,9,9,8,7,8,9,9,9,8,9,9,8,9,9,8,7,4,2,1,2,3,7,8,9,9,6,5,7,7,9,9,2,9,7,5,5,6,9,0,1,2,3,9,8,9,6,5,4,9,9,7,6,7,8,9,4,3,4,6],
[3,9,8,7,8,9,8,7,7,5,8,9,4,3,5,9,9,7,9,8,7,9,8,6,4,2,3,6,7,8,9,9,9,8,7,6,6,7,8,9,9,9,8,7,6,7,9,9,9,9,9,8,7,9,9,7,6,3,1,0,4,5,6,9,9,8,7,4,5,6,7,8,9,8,6,4,3,9,8,9,2,3,5,7,9,8,9,6,9,8,7,6,5,6,7,8,9,2,3,5],
[9,8,7,6,7,6,9,9,8,6,7,8,9,4,6,9,8,9,8,7,6,5,4,3,2,0,4,5,8,9,8,8,8,9,8,9,8,9,9,9,9,8,7,6,5,8,9,8,9,9,8,7,6,9,8,6,5,4,3,2,3,7,7,9,5,9,4,3,5,7,8,9,7,9,5,3,2,8,7,8,9,9,7,9,8,7,8,9,1,9,9,8,6,7,8,9,0,1,2,3],
[9,9,6,5,4,5,4,5,9,9,8,9,7,6,9,8,7,5,9,9,7,9,5,6,4,1,5,7,9,7,6,7,7,8,9,9,9,5,4,9,8,7,6,5,4,7,6,7,9,9,9,7,5,6,9,9,7,6,4,5,7,8,9,9,4,9,2,1,6,6,9,8,6,5,4,1,0,2,6,6,7,8,9,8,7,6,7,9,0,1,3,9,7,9,9,8,9,2,4,5],
[9,8,9,5,3,2,3,4,5,7,9,9,8,9,8,7,6,4,6,8,9,8,7,8,3,2,9,8,9,6,5,7,6,7,8,8,9,6,9,8,9,8,4,3,2,8,4,5,6,7,8,9,6,7,8,9,9,8,5,6,9,9,7,8,9,8,9,2,3,4,5,9,8,6,3,2,1,3,4,5,6,7,8,9,6,5,8,9,9,9,9,9,8,9,5,6,9,3,4,6],
[9,7,8,9,9,1,2,3,4,5,6,8,9,8,6,5,4,3,5,7,8,9,8,9,4,3,6,9,8,9,3,4,5,3,9,7,8,9,8,7,6,5,3,2,1,2,3,5,9,8,9,9,8,9,9,6,5,9,6,9,8,7,6,7,8,7,8,9,4,5,9,8,7,6,5,4,3,4,6,8,8,9,9,9,5,4,5,9,8,8,7,6,9,4,4,5,8,9,5,6],
[4,5,6,7,8,9,5,4,5,6,7,9,2,9,7,9,5,2,4,6,9,9,9,6,5,4,5,6,7,9,2,0,1,2,3,6,7,9,9,8,8,6,4,4,3,4,5,7,8,9,5,6,9,9,9,5,4,3,9,8,7,6,5,4,6,6,7,8,9,6,8,9,9,8,6,5,4,5,6,7,9,9,9,8,4,3,4,9,7,6,5,5,3,2,3,4,7,8,9,7],
[3,4,5,8,9,7,6,5,6,9,8,9,1,2,9,8,9,1,2,3,4,9,8,7,6,7,6,8,9,4,3,2,2,4,4,5,9,8,9,9,9,7,6,6,4,6,7,8,9,6,4,3,5,9,8,7,5,9,8,7,6,5,4,3,4,5,6,7,8,9,9,4,2,9,8,7,8,6,9,8,9,9,8,7,3,2,9,8,6,5,4,3,2,1,2,3,6,8,9,8],
[4,5,6,7,8,9,8,6,7,8,9,3,2,9,8,7,8,9,9,4,5,7,9,8,9,8,7,9,6,5,4,5,6,9,5,9,8,7,6,5,9,8,7,7,5,7,8,9,9,6,5,6,9,9,9,9,7,8,9,6,5,4,3,2,3,4,6,7,8,9,3,2,1,0,9,8,9,8,9,9,9,8,7,6,4,4,5,9,8,7,6,4,3,4,3,4,5,7,8,9],
[5,6,7,8,9,7,9,9,8,9,7,4,3,9,7,6,7,9,8,9,6,7,8,9,9,9,8,9,9,7,5,9,9,8,9,4,9,6,5,4,5,9,8,8,6,8,9,9,8,9,7,9,8,8,9,8,9,9,9,7,6,3,2,1,2,4,5,6,7,8,9,9,3,1,2,9,8,9,4,3,2,9,8,7,8,6,8,9,9,9,9,5,4,5,4,5,7,8,9,0],
[7,9,8,9,4,6,7,9,9,9,6,5,4,9,8,4,6,7,6,9,7,8,9,7,9,9,9,5,9,8,9,8,7,7,9,2,9,0,1,2,6,7,9,9,7,9,9,8,7,9,9,8,7,7,5,6,6,7,8,9,5,4,5,2,3,5,6,7,9,9,7,8,9,2,9,8,7,8,9,2,1,2,9,9,9,8,9,4,2,9,8,9,5,6,5,6,7,8,9,1],
[8,9,9,2,3,4,6,8,9,8,7,9,5,9,9,3,2,3,5,8,9,9,7,6,7,8,9,4,5,9,8,7,6,5,6,9,8,9,3,4,5,6,7,8,9,9,8,7,6,7,9,8,6,5,4,3,5,6,7,8,9,6,7,3,4,5,9,8,9,5,6,7,8,9,9,9,6,7,8,9,2,3,4,5,7,9,9,6,9,8,7,8,9,9,6,7,8,9,4,3],
[9,3,2,1,4,5,6,7,8,9,9,8,9,8,9,2,1,2,4,6,8,8,9,5,6,9,4,3,9,8,7,6,5,4,5,6,7,8,9,6,9,8,9,9,9,8,7,5,4,9,8,7,6,5,4,2,3,4,6,7,8,9,8,4,5,7,8,9,5,4,5,6,9,9,8,7,5,4,6,8,9,4,6,7,8,9,8,9,9,7,6,7,7,8,9,9,9,8,9,4],
[5,4,3,2,3,5,7,8,9,9,8,7,7,7,8,9,0,1,3,4,6,7,8,9,7,8,9,9,8,7,6,5,4,3,4,5,8,9,8,7,9,9,9,9,8,6,5,4,3,4,9,9,8,7,5,3,4,5,6,8,9,8,7,5,6,9,9,8,7,5,9,7,9,8,7,6,4,3,5,6,8,9,7,8,9,9,7,6,5,6,4,5,6,9,9,8,6,7,8,9],
[6,6,4,3,5,6,7,9,9,8,7,6,5,6,7,8,9,2,5,6,7,8,9,9,8,9,2,1,9,6,5,4,3,2,3,5,6,8,9,9,9,9,8,7,7,5,4,3,2,9,8,6,9,8,5,4,5,6,7,8,9,9,9,6,9,8,9,9,8,9,8,9,8,9,8,6,5,4,6,7,9,8,9,9,8,7,6,5,4,2,3,6,7,8,9,6,5,7,9,9],
[7,6,5,6,7,9,8,9,8,9,8,7,4,5,6,7,8,9,9,7,8,9,2,3,9,9,3,9,9,5,4,3,2,1,2,4,5,6,8,9,9,8,7,6,5,4,3,0,1,9,9,5,4,9,6,6,7,7,8,9,9,9,8,9,8,7,9,9,9,8,7,8,7,8,9,7,6,5,7,9,5,6,8,7,9,8,7,6,5,3,4,5,6,9,7,5,4,5,8,9],
[8,7,9,9,9,8,9,8,7,8,9,6,5,6,7,8,9,6,9,8,9,9,1,9,7,8,9,8,7,6,5,5,3,4,3,4,5,7,9,6,9,7,6,5,4,3,2,1,9,8,7,6,3,9,8,8,8,9,9,9,9,9,7,6,7,6,7,9,8,7,6,5,6,7,8,9,8,7,8,9,4,5,2,6,5,9,8,7,8,7,5,6,7,8,9,2,3,5,7,8],
[9,9,8,8,6,7,9,7,6,9,8,7,6,7,8,9,3,5,4,9,9,8,9,7,6,9,8,9,9,7,7,5,4,5,6,5,6,8,9,5,9,8,7,6,5,4,3,2,3,9,8,1,2,3,9,9,9,5,5,9,8,7,6,5,4,5,9,9,8,7,5,4,5,8,7,9,9,8,9,4,3,2,1,2,3,4,9,8,9,7,6,7,9,9,9,9,9,9,8,9],
[9,8,7,6,5,4,4,3,4,6,9,8,9,9,9,2,1,2,3,9,8,7,7,5,5,6,7,8,9,8,9,6,5,6,7,6,7,9,7,6,7,9,8,7,6,5,5,4,9,8,5,4,3,4,6,8,9,4,3,9,8,8,5,3,2,9,8,7,6,6,4,3,4,5,6,8,9,9,6,5,5,3,4,6,4,5,6,9,9,8,9,8,9,5,8,7,8,9,9,9],
[8,7,6,5,3,2,1,2,3,5,8,9,8,7,6,5,0,1,9,9,8,6,5,4,3,5,6,7,9,9,8,7,8,7,8,8,9,9,8,9,8,9,9,8,7,6,8,9,8,7,6,5,5,5,7,9,9,5,9,8,7,6,3,2,1,2,9,8,5,4,3,2,3,7,9,9,9,9,8,7,7,9,8,7,8,9,7,8,9,9,9,9,6,4,5,6,7,8,9,8],
[9,8,6,5,2,1,0,7,5,6,7,8,9,6,5,4,1,9,8,7,6,4,3,3,2,4,5,6,7,8,9,8,9,8,9,9,5,4,9,9,9,8,6,9,8,9,9,6,9,8,8,6,7,6,8,9,8,9,9,7,6,5,4,3,2,9,8,7,6,5,5,4,5,6,7,8,9,8,9,8,9,0,9,8,9,9,8,9,9,8,7,6,5,3,4,5,6,7,9,6],
[9,9,5,4,3,3,1,9,8,7,8,9,6,5,4,3,2,3,9,9,5,4,2,1,0,1,6,7,8,9,9,9,4,9,5,4,3,2,9,8,7,6,5,4,9,7,6,5,6,9,9,8,8,7,9,8,7,6,9,8,7,6,5,5,6,8,9,8,7,6,6,7,7,8,9,9,6,7,8,9,4,1,2,9,3,2,9,3,4,9,6,5,4,2,3,9,7,8,9,5],
[9,8,7,8,5,4,3,4,9,9,9,8,7,6,5,4,5,4,9,8,6,5,4,2,3,4,5,6,7,8,9,4,3,4,9,5,6,0,9,9,9,7,9,9,8,7,5,4,2,1,0,9,9,8,9,7,6,5,7,9,9,8,7,6,7,9,6,9,9,7,7,9,8,9,7,5,5,6,8,9,3,2,9,9,9,1,0,1,9,8,7,9,2,1,7,8,9,9,5,4],
[0,9,8,7,6,5,4,5,6,7,8,9,9,7,6,5,6,6,9,8,7,6,5,3,4,6,6,7,8,9,4,3,2,9,8,9,9,9,8,9,9,9,8,6,9,9,6,6,7,8,2,5,6,9,9,9,2,4,6,7,8,9,8,7,8,9,5,4,9,8,9,9,9,5,4,4,4,5,6,8,9,9,7,8,8,9,9,2,4,9,8,9,3,2,6,7,8,9,6,5],
[1,2,9,8,7,7,6,7,7,8,9,6,9,8,9,6,7,8,9,9,8,7,6,4,5,7,8,9,9,8,7,4,9,8,7,8,8,7,7,8,9,8,7,5,7,9,8,7,8,4,3,4,5,7,8,9,1,2,4,5,7,8,9,9,9,8,9,3,9,9,9,8,7,7,3,2,3,4,5,9,8,7,6,5,6,7,8,9,5,9,8,7,5,3,4,8,9,9,9,9],
[2,3,9,9,8,9,7,8,8,9,7,5,9,9,9,7,8,9,8,9,9,8,7,5,6,8,9,9,8,7,6,5,6,9,6,7,9,5,6,7,8,9,8,4,3,4,9,8,9,5,4,5,6,7,8,9,0,1,2,3,8,9,9,8,7,7,7,9,8,9,9,9,6,5,4,3,4,6,9,8,9,8,7,4,5,5,7,8,9,7,9,7,6,7,5,9,8,9,7,7],
[3,9,8,9,9,5,9,9,9,9,8,9,8,7,8,9,9,9,7,8,9,9,7,6,8,9,6,5,9,8,9,6,9,8,5,4,6,4,5,6,7,8,9,0,2,3,4,9,7,6,7,6,9,8,9,8,9,3,3,4,9,8,9,7,6,6,5,6,7,8,9,8,7,6,7,4,5,7,9,7,6,4,3,2,3,4,9,9,7,6,7,9,7,8,7,9,7,8,6,6],
[9,8,7,9,9,4,3,2,0,9,9,8,6,5,7,7,9,7,6,7,8,9,9,7,9,5,5,4,6,9,8,9,8,7,6,3,5,3,4,9,8,9,2,1,4,4,9,9,8,9,8,9,8,9,9,7,9,9,5,9,9,7,8,6,5,6,4,5,6,7,9,9,8,7,9,9,6,9,9,9,8,7,6,3,5,7,8,9,9,4,5,9,8,9,9,7,6,5,4,5],
[8,9,6,7,8,9,4,3,9,8,9,9,5,4,5,6,8,9,5,6,7,8,9,8,9,3,2,3,5,9,7,6,5,4,3,2,1,2,9,8,9,4,3,3,5,9,8,8,9,9,9,8,7,8,9,6,8,8,9,8,7,6,5,5,4,4,3,4,6,8,8,9,9,9,8,7,9,8,9,9,9,6,5,4,6,8,9,9,8,9,6,7,9,9,7,6,5,4,3,4],
[6,4,5,6,8,8,9,9,8,7,6,5,4,3,2,9,9,2,3,4,9,9,9,9,4,3,1,2,3,9,8,9,8,7,3,1,0,9,8,7,8,9,4,4,9,8,7,6,7,8,9,9,6,4,3,5,6,7,8,9,8,5,4,3,3,1,2,3,5,6,7,8,9,8,7,6,4,7,8,9,8,7,7,5,6,7,8,9,7,8,9,8,9,9,8,7,6,3,2,3],
[4,3,4,5,6,7,9,2,9,8,7,9,9,4,9,8,9,3,6,5,6,7,8,9,2,1,0,1,2,6,9,8,7,6,4,9,9,8,9,6,7,8,9,5,9,7,6,5,6,9,7,8,9,4,2,4,5,6,7,9,8,6,5,2,1,0,1,2,3,5,7,9,9,9,8,5,3,5,6,8,9,9,8,7,7,8,9,7,6,7,9,9,9,8,7,6,4,2,1,2],
[6,4,5,6,7,9,2,1,3,9,8,9,8,9,6,7,8,9,7,6,7,8,9,4,3,2,4,2,4,5,6,9,8,7,9,8,7,6,8,5,6,7,8,9,7,6,5,4,5,7,6,7,8,9,6,5,9,9,8,9,9,9,6,4,2,1,4,5,4,6,9,8,7,8,7,6,2,3,7,9,7,8,9,9,8,9,4,3,5,8,9,9,8,7,6,7,3,1,0,1],
[6,5,9,7,8,9,1,0,9,8,9,8,7,8,5,6,7,8,9,9,8,9,6,5,5,4,4,3,9,9,9,9,9,8,9,9,8,5,3,4,8,8,9,9,9,5,4,3,4,4,5,6,7,8,9,6,7,8,9,9,9,8,7,6,3,2,3,4,5,9,8,7,6,4,3,2,1,2,3,4,6,7,8,9,9,5,3,2,3,5,9,8,7,6,5,4,3,2,1,2],
[7,9,8,9,9,8,9,9,8,7,9,8,6,5,3,7,8,9,2,1,9,8,9,8,7,6,7,9,8,7,8,9,9,9,3,5,9,6,7,6,8,9,9,8,7,6,2,1,2,3,4,7,8,9,8,7,8,9,9,9,8,7,6,5,4,5,9,6,9,8,7,6,5,4,2,1,0,1,2,3,4,6,7,8,9,6,4,3,4,6,9,9,8,8,6,5,4,3,5,7],
[9,8,7,5,7,7,8,9,7,6,8,9,7,4,2,9,7,9,9,0,9,7,8,9,9,7,9,8,7,6,7,8,9,3,2,9,8,7,8,7,9,7,6,9,9,8,4,5,5,4,5,6,7,8,9,8,9,7,8,9,9,8,8,7,6,7,8,7,8,9,8,8,6,5,3,2,3,2,6,4,5,9,8,9,9,8,6,4,5,7,8,9,9,8,7,9,5,4,6,9],
[8,7,3,4,5,6,7,8,9,5,9,7,6,5,3,5,6,7,8,9,8,6,7,8,9,9,9,9,6,5,6,9,3,2,1,0,9,8,9,9,9,5,4,5,9,7,5,6,8,5,6,7,8,9,3,9,5,6,9,8,9,9,9,8,7,8,9,8,9,2,9,9,8,6,9,3,4,3,4,6,6,7,8,9,9,9,7,5,6,8,9,6,5,9,9,8,6,7,7,8],
[7,6,2,3,4,7,8,9,9,7,8,9,8,5,4,5,7,8,9,7,6,5,9,9,9,9,7,8,9,4,6,8,9,3,9,1,9,9,7,6,8,9,5,6,9,8,9,7,8,8,7,9,9,1,2,3,4,5,6,7,8,9,9,9,9,9,9,9,5,3,4,8,9,7,8,4,5,4,6,8,9,9,9,6,9,8,7,6,7,8,9,5,4,5,6,9,8,9,8,9],
[9,5,3,7,8,8,9,4,2,9,9,8,7,6,6,7,8,9,3,9,8,6,7,9,8,7,6,7,8,3,5,6,7,9,8,9,8,9,6,5,9,9,8,7,8,9,9,8,9,9,8,9,8,9,5,4,5,6,9,8,9,9,8,8,9,9,8,7,6,4,5,6,9,8,7,5,6,5,7,8,9,4,3,5,6,9,9,7,8,9,6,4,3,2,1,2,9,6,9,9],
[7,5,4,5,7,8,9,5,1,2,3,9,9,8,7,8,9,1,2,4,9,8,9,9,6,5,5,3,1,2,4,5,9,8,7,8,7,9,9,6,7,8,9,8,9,9,9,9,9,9,9,6,7,8,9,5,6,7,8,9,9,8,7,6,7,8,9,8,9,7,6,7,9,9,9,7,7,9,8,9,6,5,7,6,7,9,9,8,9,5,4,3,2,1,0,1,3,5,7,8],
[8,6,5,7,8,9,7,6,2,3,9,4,3,9,8,9,9,9,3,5,6,9,9,8,7,4,3,1,0,1,3,9,8,7,6,7,6,7,8,9,9,9,9,9,9,8,9,9,9,8,7,5,6,7,9,6,7,9,9,9,8,6,8,5,6,7,9,9,9,9,7,8,9,8,9,8,8,9,9,9,9,9,8,7,9,3,2,9,7,6,5,4,3,2,1,2,5,6,8,9],
[9,7,6,7,8,9,8,9,3,9,8,9,4,5,9,9,9,8,9,6,8,9,8,7,6,5,4,8,9,2,3,9,7,6,4,6,5,6,7,8,9,9,9,9,8,7,8,9,9,7,5,4,5,7,9,9,9,9,9,9,7,5,4,4,3,3,4,9,8,9,8,9,8,7,8,9,9,3,9,8,7,9,9,9,8,9,1,9,8,7,6,6,5,4,3,4,5,6,7,8],
[9,8,7,9,9,9,9,8,9,8,7,8,9,7,9,8,8,6,8,9,9,9,9,8,7,8,5,7,5,4,9,8,7,5,3,3,4,5,8,9,9,9,8,9,6,5,9,9,9,8,4,3,2,6,7,8,9,9,8,7,6,4,3,2,1,2,3,7,7,8,9,8,7,6,7,9,5,4,9,9,6,7,8,9,7,8,9,9,9,8,8,7,6,5,4,5,7,9,9,9],
[0,9,8,9,9,8,7,6,5,6,6,7,8,9,8,7,6,5,6,9,9,9,8,9,8,9,6,7,6,5,9,8,5,4,2,1,3,6,9,9,9,8,7,9,5,4,8,8,9,9,5,4,3,4,5,9,1,3,9,8,7,6,2,1,0,1,4,5,6,9,8,7,6,5,7,8,9,9,8,7,5,6,7,8,6,9,8,9,9,9,9,8,9,6,7,6,9,9,9,9],
[1,9,9,5,4,9,5,4,3,4,5,8,9,9,9,8,7,4,5,7,9,9,7,6,9,8,7,9,8,9,8,7,6,2,1,0,4,7,8,9,9,8,6,3,1,3,7,6,7,8,9,5,8,7,6,7,9,9,5,9,9,7,3,7,1,2,3,4,9,8,7,8,7,3,6,6,7,9,9,5,4,6,5,6,5,6,7,9,9,5,3,9,8,7,8,7,9,9,8,9],
[9,8,9,6,9,8,9,2,1,3,4,7,8,9,9,9,8,5,6,9,8,7,6,5,6,9,9,1,9,9,9,8,7,3,2,1,5,6,7,8,9,6,5,3,0,1,4,5,6,7,8,9,9,8,9,8,9,7,4,9,8,9,7,6,5,4,4,9,8,7,6,4,3,2,4,5,6,7,8,9,3,1,3,4,4,5,6,7,8,9,4,5,9,9,9,9,8,7,6,7],
[8,7,8,9,8,7,8,9,2,3,5,6,8,9,9,8,7,6,7,8,9,7,5,4,3,2,1,0,1,9,7,6,5,4,3,2,3,4,8,9,9,8,7,2,1,2,3,4,5,7,8,9,9,9,8,9,9,6,5,9,7,8,9,9,6,5,6,7,9,9,7,3,2,1,2,4,5,7,8,9,2,0,1,2,3,4,5,6,7,8,9,9,9,9,9,8,7,5,4,3],
[7,6,7,8,9,6,9,8,9,4,5,6,7,8,9,9,8,9,8,9,8,7,6,5,4,3,2,1,2,9,8,7,7,6,5,6,4,5,9,9,6,5,4,3,2,3,4,5,6,7,9,9,9,8,6,5,7,9,9,8,6,7,9,8,9,6,7,8,9,9,5,4,1,0,1,3,4,6,7,8,9,4,2,3,4,5,6,7,8,9,6,7,8,9,1,9,5,4,3,2],
[6,5,6,9,5,4,8,7,8,9,8,7,8,9,9,9,9,7,9,8,9,8,7,6,7,4,3,5,3,4,9,9,8,7,6,7,6,6,7,8,9,9,8,7,6,4,6,7,8,9,1,9,8,7,7,4,9,8,7,6,5,6,7,7,8,9,8,9,8,7,6,4,3,1,4,4,5,8,8,9,8,6,7,8,5,7,9,8,9,3,5,6,9,1,0,1,9,5,4,1],
[5,4,7,8,9,3,4,6,7,8,9,9,9,2,9,8,7,6,5,7,8,9,9,9,8,5,7,6,4,6,7,8,9,8,8,8,7,7,8,9,9,9,9,8,7,5,7,9,9,1,0,1,9,5,4,3,2,9,8,5,4,3,5,6,7,9,9,0,9,9,6,5,3,2,3,4,6,7,9,9,9,7,9,9,6,7,9,9,1,2,3,8,9,9,9,9,8,6,5,2],
[6,5,6,9,3,2,5,4,6,6,7,8,9,3,9,8,7,5,4,6,7,9,4,5,9,9,8,8,5,6,8,9,8,9,9,9,8,9,9,9,9,8,7,9,8,6,9,4,5,9,1,9,9,7,6,5,9,8,7,5,4,2,4,5,6,8,9,1,9,8,7,5,4,5,5,6,7,8,9,9,9,8,9,8,7,8,9,3,2,5,4,5,6,7,8,9,9,7,6,8],
[7,6,7,8,9,1,2,3,4,5,6,9,6,4,9,7,6,4,3,4,9,6,5,7,8,9,9,8,6,7,9,6,7,8,9,9,9,2,4,9,8,7,6,5,9,7,8,9,6,8,9,8,8,9,9,9,8,7,5,4,3,1,3,4,5,6,8,9,7,9,8,7,7,6,6,7,8,9,7,8,9,9,9,9,8,9,1,9,8,7,5,6,7,8,9,9,9,8,7,9],
[8,8,8,9,1,0,1,2,3,6,7,9,7,9,8,9,8,2,1,9,8,9,6,7,9,9,9,9,8,9,3,4,7,9,8,9,2,1,2,9,7,6,5,4,3,9,9,8,7,9,8,7,6,7,8,9,9,8,6,2,1,0,1,2,7,9,9,4,5,6,9,9,8,9,8,8,9,4,5,6,9,7,9,8,9,3,2,3,9,9,7,8,9,9,9,9,9,9,8,9],
[9,9,9,3,2,5,7,3,4,5,8,9,9,8,7,8,9,9,2,9,7,8,9,8,9,9,8,7,9,3,2,3,5,6,7,8,9,9,3,4,9,8,4,3,2,1,0,9,9,9,3,4,5,8,9,9,8,7,5,4,2,1,3,3,7,8,9,3,4,9,8,9,9,3,9,9,2,3,9,9,7,6,8,7,8,9,3,4,9,9,8,9,2,1,9,8,9,8,9,2],
[7,6,5,4,3,4,7,8,6,7,8,9,8,7,6,8,7,8,9,7,6,7,8,9,2,1,9,6,5,4,4,5,7,7,8,9,7,8,9,6,9,7,6,4,3,9,1,9,8,7,5,5,6,9,8,9,9,9,6,5,3,2,3,4,6,7,9,2,9,8,7,8,9,2,1,0,1,9,8,7,6,5,7,6,7,8,9,5,7,8,9,9,9,9,8,7,6,7,9,1],
[9,9,8,7,6,5,6,7,8,9,9,9,9,6,5,4,5,7,8,9,5,7,8,9,9,9,8,7,6,6,6,7,9,8,9,3,5,6,7,9,8,9,7,5,9,8,9,9,9,9,7,8,7,9,7,8,4,9,7,9,6,5,4,6,8,9,2,9,8,7,6,7,8,9,2,1,3,4,9,8,6,4,6,5,6,8,9,9,8,9,9,9,8,9,9,6,5,6,8,9],
[4,6,9,8,7,9,8,8,9,8,9,9,8,7,6,7,6,8,9,4,3,7,5,7,8,9,9,8,9,7,7,8,9,9,2,1,9,7,8,9,7,8,9,9,8,7,8,9,0,9,8,9,9,7,5,4,3,5,9,8,7,6,9,8,9,2,1,0,9,7,5,8,6,8,9,3,9,9,8,9,5,3,2,4,5,6,9,9,9,9,9,8,7,8,4,5,4,5,9,7],
[2,7,8,9,9,8,9,9,9,7,8,9,9,8,9,8,9,9,2,1,2,6,4,5,9,8,9,9,9,9,8,9,5,4,3,9,8,9,9,8,6,7,8,9,5,6,9,2,1,2,9,8,7,6,5,4,2,4,6,9,8,7,8,9,9,9,2,9,7,5,4,3,5,6,8,9,8,9,7,9,6,5,3,6,9,7,8,9,9,9,9,9,6,7,3,2,3,4,5,6],
[0,2,9,9,8,7,8,8,7,6,7,8,9,9,3,9,9,8,7,0,1,2,3,4,6,7,8,9,8,7,9,8,9,5,9,9,7,8,7,9,5,6,7,8,9,7,9,3,2,3,9,8,6,5,4,3,1,3,7,9,9,9,9,6,7,8,9,9,8,7,6,4,5,7,9,6,7,5,6,8,9,6,8,7,8,9,9,9,9,8,9,6,5,4,2,1,2,3,5,9],
[1,9,9,8,7,6,5,6,5,5,6,7,8,9,2,1,0,9,6,5,4,3,4,5,8,9,9,3,4,5,6,7,8,9,8,7,6,5,6,5,4,5,6,7,8,9,5,4,5,4,5,9,4,3,2,1,0,2,9,8,7,4,3,5,6,7,8,9,9,9,8,5,6,9,6,5,9,4,5,8,9,9,9,8,9,6,5,9,8,7,6,5,3,2,1,0,3,4,9,8],
[9,8,9,8,7,5,4,4,3,4,5,8,9,4,3,2,9,8,7,6,7,8,9,6,7,9,1,2,3,4,5,6,7,8,9,8,5,4,3,4,2,3,4,6,9,8,9,5,7,8,9,7,6,4,3,2,1,9,8,7,6,3,2,3,8,9,9,8,9,9,7,6,7,8,9,3,1,2,6,7,8,8,9,9,4,3,4,5,9,8,7,6,7,8,9,2,4,9,9,7],
[9,7,6,9,9,6,3,1,2,4,6,7,8,9,4,3,4,9,8,7,8,9,9,7,8,9,0,1,9,5,6,7,8,9,9,7,6,3,2,1,0,1,2,5,6,7,8,9,8,9,9,8,7,5,5,6,9,8,7,6,5,4,3,9,9,8,8,7,9,9,8,9,8,9,4,1,0,1,2,7,6,7,8,9,8,6,5,9,9,9,8,7,9,9,8,9,9,8,6,5],
[8,7,5,4,3,2,1,0,2,4,5,6,9,6,5,4,5,7,9,8,9,9,9,8,9,2,1,9,8,9,7,8,9,8,7,6,5,4,6,2,1,3,3,4,5,6,7,8,9,2,3,9,9,7,6,9,9,9,8,7,6,5,9,8,7,6,7,6,7,8,9,8,9,4,3,2,1,2,3,4,5,6,9,9,8,7,6,7,8,9,9,9,8,7,6,7,8,9,4,3],
[9,8,6,5,5,4,2,1,4,7,6,7,9,7,6,5,9,8,9,9,9,9,9,9,8,9,9,8,7,9,8,9,2,9,8,7,6,8,7,3,2,3,5,5,7,8,9,9,5,3,4,6,9,8,9,8,9,9,9,8,9,9,8,7,6,5,4,5,5,7,9,7,6,5,5,3,3,4,9,5,6,7,8,9,9,8,7,9,9,9,4,5,9,8,9,8,9,4,3,2],
[7,9,8,7,6,5,3,2,6,7,8,8,9,8,7,6,7,9,4,6,7,8,9,8,7,6,5,7,6,8,9,0,1,2,9,8,9,9,8,9,3,5,6,7,8,9,9,9,6,4,5,9,8,9,7,6,8,9,9,9,8,6,9,8,8,4,2,3,4,6,8,9,8,7,6,4,4,9,8,9,7,8,9,7,8,9,9,8,9,8,9,9,8,9,9,9,6,5,2,1],
[6,6,9,9,8,7,9,8,7,9,9,9,9,9,8,7,9,1,2,4,5,9,8,7,6,5,4,3,5,7,9,9,3,4,5,9,7,6,9,9,8,6,8,9,9,6,7,8,9,5,9,8,6,5,6,5,7,9,9,9,7,5,6,9,9,7,6,4,5,6,7,9,9,8,7,9,5,9,7,8,9,9,5,6,9,9,8,7,8,7,9,9,7,9,7,8,9,6,3,2],
[5,4,2,0,9,8,9,9,9,8,9,9,9,9,9,8,9,2,3,4,6,8,9,8,7,6,3,2,4,5,6,8,9,5,9,8,7,4,3,4,9,8,9,8,6,5,6,7,8,9,8,7,6,4,3,4,5,6,8,9,6,4,3,4,9,8,8,9,6,8,8,9,9,9,9,7,9,8,6,9,6,5,4,9,8,7,6,5,4,6,8,9,6,7,5,7,9,5,4,4],
[6,5,3,2,3,9,9,9,8,7,8,8,8,9,9,9,4,3,6,5,6,7,8,9,9,8,5,4,6,6,7,9,8,9,8,7,6,4,2,5,6,9,8,9,5,4,5,9,9,9,8,6,5,3,2,3,9,7,8,9,5,4,2,3,4,9,9,8,7,9,9,7,9,9,9,6,5,6,5,8,9,4,3,4,9,8,7,6,5,7,9,6,5,6,4,9,8,9,6,5],
[7,6,8,3,4,6,9,8,8,5,4,6,7,9,9,7,5,9,8,7,9,8,9,9,8,7,6,8,7,8,8,9,7,9,6,5,4,2,1,4,5,6,7,8,9,5,7,8,9,9,9,7,7,1,0,1,4,5,6,9,4,3,1,2,3,4,5,9,8,9,7,6,7,9,8,6,4,3,4,6,8,9,4,5,6,9,8,7,8,9,6,4,3,2,3,6,7,8,9,6],
[9,7,9,4,9,9,8,7,6,4,3,4,6,7,8,9,6,7,9,9,1,9,3,4,9,8,8,9,8,9,9,8,6,8,9,6,5,3,2,3,5,7,8,9,7,6,8,9,9,8,6,5,4,3,1,2,3,6,7,8,9,1,0,3,4,6,6,7,9,7,6,5,6,9,7,5,4,2,6,8,9,6,5,6,7,8,9,8,9,5,4,5,2,1,3,5,6,7,8,9],
[8,9,9,9,8,9,9,6,5,3,2,3,5,6,7,8,9,8,9,4,0,1,2,3,9,9,9,9,9,8,7,6,5,4,5,9,6,6,5,4,5,6,7,8,9,7,9,4,6,9,7,6,6,4,2,3,4,5,6,7,8,9,9,4,5,6,7,8,9,8,9,4,3,9,7,6,5,4,5,6,7,9,8,7,8,9,3,9,8,6,3,2,1,0,1,4,5,7,9,9],
[7,8,9,8,7,6,5,4,3,2,1,2,3,4,9,9,9,9,5,3,1,9,3,9,8,9,8,9,9,9,8,7,6,8,7,8,9,7,8,5,7,8,9,9,8,9,0,2,3,4,9,7,6,5,6,4,6,6,7,8,9,7,8,9,6,7,8,9,8,9,9,9,1,2,9,7,6,7,6,7,8,9,9,9,9,3,2,9,9,7,4,3,2,1,2,3,4,8,8,9],
[6,7,9,9,8,9,9,8,4,3,4,3,5,6,8,9,9,8,9,4,9,8,9,8,7,8,7,8,9,9,9,8,7,8,9,9,9,8,9,7,8,9,4,5,6,9,1,9,9,9,9,8,7,8,7,9,7,8,9,9,7,6,7,8,9,9,9,8,7,8,9,8,9,3,9,8,9,8,8,9,9,7,9,8,8,9,9,8,7,6,5,4,3,3,4,4,5,6,7,8],
[5,6,7,9,9,9,8,6,5,6,7,4,6,7,9,7,8,7,8,9,8,7,6,5,6,7,6,7,9,9,9,9,8,9,9,9,7,9,5,9,9,2,3,4,7,8,9,8,7,8,9,9,9,9,8,9,8,9,8,9,9,7,8,9,2,3,4,5,6,9,9,7,8,9,8,9,8,9,9,6,5,6,8,6,7,8,9,9,9,7,6,5,8,7,6,7,6,7,9,9],
[4,5,9,8,7,8,9,7,6,7,8,9,9,8,9,6,5,6,9,8,7,6,6,4,5,4,5,6,7,8,9,9,9,5,9,8,6,5,4,3,2,0,5,5,8,9,8,7,6,5,4,5,6,7,9,9,9,8,7,8,9,8,9,0,1,2,4,8,7,9,7,6,7,5,6,6,7,9,8,7,4,5,5,5,6,7,8,9,5,9,7,6,9,8,7,8,7,8,9,3],
[3,2,8,6,5,6,9,8,9,8,9,9,9,9,5,4,3,9,8,7,6,5,4,3,2,3,6,7,9,9,9,7,6,4,6,9,8,9,9,6,4,5,6,9,9,1,9,8,5,4,3,4,5,8,9,9,8,8,6,7,9,9,3,2,4,3,8,9,9,8,7,5,4,3,7,5,7,8,9,4,3,2,3,4,6,9,9,3,4,5,9,7,8,9,8,9,8,9,3,2],
[3,1,2,3,4,8,9,9,9,9,9,8,9,6,5,4,2,4,9,8,6,4,3,2,1,2,7,8,9,9,8,6,5,3,4,9,9,8,8,9,5,9,9,8,9,0,9,9,7,5,9,5,6,9,9,8,7,5,4,9,7,6,5,3,5,4,6,7,9,9,6,6,3,2,3,4,5,9,8,9,2,1,2,6,8,9,3,2,4,9,9,9,9,1,9,9,9,3,2,1],
[1,0,1,2,6,7,9,9,9,9,8,7,9,9,5,3,1,9,8,7,6,5,4,3,8,9,8,9,9,9,9,7,6,7,9,8,9,7,7,8,9,8,7,6,4,9,8,9,8,9,8,9,9,9,9,9,5,4,3,1,9,8,6,5,6,7,8,9,8,7,5,4,2,1,5,9,9,8,7,9,9,2,3,5,7,9,2,1,9,8,9,4,3,2,9,8,7,9,9,0],
[4,3,2,3,5,7,8,9,8,8,7,6,7,8,9,3,2,3,9,8,7,9,5,6,7,8,9,9,8,9,9,8,7,9,8,6,5,6,5,9,8,9,7,4,3,5,7,8,9,8,7,9,8,8,7,8,9,5,4,0,2,9,7,6,7,9,9,9,9,9,5,3,1,0,9,8,9,7,6,7,8,9,4,6,7,8,9,9,8,7,8,9,4,9,8,7,6,7,8,9],
[5,4,3,4,9,8,9,9,7,6,4,5,8,9,9,4,3,4,5,9,9,8,6,7,8,9,5,8,7,8,9,9,9,8,7,6,4,3,4,9,7,6,5,3,2,4,6,7,9,6,6,4,7,6,5,9,8,6,5,1,4,9,8,7,8,9,9,9,7,6,5,4,2,9,8,7,8,9,5,6,7,8,9,8,9,9,9,8,7,6,7,8,9,5,4,6,5,9,7,7],
[6,5,6,5,7,8,9,9,9,3,2,5,6,7,8,9,4,6,9,8,9,9,9,8,9,3,4,5,6,7,8,9,9,8,7,6,5,2,3,9,8,9,6,2,1,3,4,6,9,5,4,3,2,2,4,9,9,8,6,9,5,6,9,8,9,8,9,9,8,7,6,6,9,8,7,6,4,7,4,7,8,8,9,9,9,9,8,7,6,5,6,7,8,9,2,1,3,4,5,6],
[7,6,7,9,8,9,9,8,6,4,3,4,5,8,9,6,5,9,8,7,5,4,5,9,1,2,5,7,9,9,9,9,8,7,6,5,4,3,4,5,9,8,9,3,0,4,6,7,8,9,4,2,1,0,5,7,8,9,9,8,9,9,9,9,6,7,8,9,9,8,7,9,8,7,6,5,3,5,3,5,6,7,8,9,9,9,8,6,5,4,8,6,7,8,9,0,2,8,7,8],
[8,7,9,8,9,9,8,9,7,9,6,5,6,7,8,9,6,8,9,6,4,3,2,1,0,4,5,6,8,9,7,8,9,9,7,6,5,7,6,9,8,7,8,9,1,3,5,6,7,8,9,3,9,8,7,8,9,9,8,7,9,8,9,6,5,4,5,9,9,9,8,9,9,9,8,6,2,1,2,3,6,8,8,9,8,7,6,5,4,3,4,5,7,9,9,2,4,5,6,7],
[9,9,8,7,8,9,7,8,9,8,7,6,7,9,9,8,7,9,8,7,5,4,3,2,1,5,6,7,9,7,6,7,8,8,9,7,8,9,9,8,7,6,7,8,9,4,5,7,9,9,5,4,5,9,8,9,9,9,9,6,5,6,8,9,6,5,9,8,9,8,9,9,9,8,7,5,4,3,3,4,5,6,7,8,9,9,7,6,7,5,5,9,8,9,8,9,5,6,9,9],
[8,6,5,6,4,5,6,7,8,9,8,7,8,9,3,9,8,9,9,8,9,6,4,3,2,3,7,8,9,6,5,5,6,7,8,9,9,8,9,2,4,5,9,9,6,5,6,7,8,9,6,7,9,9,9,7,8,9,8,9,7,7,9,9,9,9,8,7,6,7,8,7,9,9,7,6,5,5,7,6,7,7,8,9,9,9,8,8,7,6,7,8,9,8,7,9,9,7,8,9],
[6,5,4,3,2,3,6,9,8,9,9,8,9,9,2,1,9,9,8,9,8,9,5,4,3,5,9,9,4,3,4,4,5,8,9,9,9,7,5,1,3,4,6,7,9,8,7,8,9,8,7,8,9,9,7,6,6,8,7,9,9,9,9,8,7,5,4,3,5,4,5,6,7,9,8,7,6,6,7,7,8,9,9,6,8,9,9,9,9,7,8,9,8,7,6,8,8,9,9,1],
[7,6,5,4,3,4,5,6,7,8,9,9,7,8,9,2,9,8,7,9,7,8,9,9,4,6,7,8,9,1,2,3,4,9,9,9,8,5,4,0,1,2,5,6,8,9,8,9,8,9,8,9,7,8,6,5,5,4,6,7,7,8,9,7,6,4,3,2,6,3,5,6,6,7,9,9,7,8,9,8,9,3,4,5,7,9,4,3,9,8,9,7,6,8,4,5,7,9,9,0],
[8,7,6,7,6,5,6,8,9,9,5,6,6,7,8,9,9,7,6,5,6,7,7,8,9,8,9,9,1,0,1,2,5,7,9,8,7,6,3,1,2,3,4,5,9,9,9,5,7,8,9,7,6,5,4,3,2,3,4,5,6,9,8,6,5,3,2,1,0,2,3,4,5,8,9,9,8,9,9,9,5,4,5,6,7,8,9,1,0,9,8,6,5,4,3,4,5,7,8,9],
[9,8,8,8,9,8,7,9,1,0,3,4,5,6,7,8,9,8,5,4,3,5,6,7,8,9,4,3,2,1,2,3,4,6,7,9,9,7,3,2,5,4,5,6,7,8,9,4,5,6,9,8,9,8,6,4,3,4,6,7,8,9,9,9,5,4,3,3,1,3,4,7,6,7,8,9,9,2,9,8,7,7,6,7,8,9,3,2,1,3,9,7,6,5,4,5,6,9,9,1],
[9,9,9,9,9,9,8,9,3,1,2,3,4,5,8,9,9,9,7,5,2,3,5,6,7,8,9,4,3,2,4,5,7,8,9,9,9,8,4,3,7,5,6,7,8,9,2,3,4,5,7,9,9,9,7,8,7,6,8,9,9,9,8,7,6,5,4,5,7,4,5,9,7,8,9,4,2,1,2,9,9,8,9,8,9,6,5,3,3,4,5,9,8,9,9,8,7,8,9,0]]

  end
end