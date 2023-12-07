defmodule CubeGame do
  @max_red 12
  @max_green 13
  @max_blue 14

  def read_input(path) do
    {:ok, contents} = File.read(path)
    contents |> String.split("\n")
  end

  def map_games(data) do
    data
    |> Enum.map(fn entry ->
      String.split(entry, ": ")
    end)
    |> Enum.into(%{}, fn [game, outcomes] ->
      game_key = String.replace(game, "Game ", "") |> String.to_integer()

      outcomes =
        String.split(outcomes, "; ")
        |> Enum.map(fn outcome ->
          String.split(outcome, ", ", trim: true)
        end)
        |> Enum.map(fn outcome ->
          Enum.reduce(outcome, %{}, fn element, acc ->
            [value, key] = String.split(element, " ")
            Map.put(acc, String.to_atom(key), String.to_integer(value))
          end)
        end)

      {game_key, outcomes}
    end)
  end

  def check_map(map) do
    red = Map.get(map, :red, 0)
    green = Map.get(map, :green, 0)
    blue = Map.get(map, :blue, 0)

    red <= @max_red && green <= @max_green && blue <= @max_blue
  end

  def part1(input) do
    read_input(input)
    |> map_games()
    |> Enum.filter(fn )
  end
end

CubeGame.part1("input.txt") |> IO.inspect()
