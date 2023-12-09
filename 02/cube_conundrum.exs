defmodule CubeGame do
  @moduledoc """
  Day 2: Cube Conundrum

  --- Part One ---
  Parse the provided input file, and determine which games are possible to play
  with the provided cubes. Then, sum the resulting list of numbers.

  --- Part Two ---
  Parse the provided input file, and determine the minimum number of cubes of
  each color required to play each game. Then, multiply the resulting list of
  numbers.
  """

  @max_red 12
  @max_green 13
  @max_blue 14

  def read_input(path) do
    {:ok, contents} = File.read(path)
    contents |> String.split("\n")
  end

  @doc """
  Parse the provided list of strings, and return a map of games to outcomes.
  """
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

  @doc """
  Check if the provided map of cubes is valid for the game.
  """
  def check_map(map) do
    red = Map.get(map, :red, 0)
    green = Map.get(map, :green, 0)
    blue = Map.get(map, :blue, 0)

    red <= @max_red && green <= @max_green && blue <= @max_blue
  end

  @doc """
  Return a list of games that are possible to play with the provided cubes.
  """
  def possible_games(map) do
    Enum.reduce(map, [], fn {key, list_of_maps}, acc ->
      if Enum.all?(list_of_maps, &check_map/1) do
        [key | acc]
      else
        acc
      end
    end)
  end

  @doc """
  Return the minimum number of cubes of each color required to play each game.
  """
  def min_of_color_required(list_of_games) do
    colors = Enum.reduce(list_of_games, {[], [], []}, fn game, {reds, greens, blues} ->
      reds = [Map.get(game, :red, 0) | reds]
      greens = [Map.get(game, :green, 0) | greens]
      blues = [Map.get(game, :blue, 0) | blues]

      {reds, greens, blues}
    end)

    Tuple.to_list(colors) |> Enum.map(fn list ->
      Enum.max(list)
    end)
  end

  @doc """
  Return the product of the provided list of integers.
  """
  def power(list) do
    Enum.reduce(list, 1, fn element, acc ->
      acc * element
    end)
  end

  @doc """
  Solve part1 of the problem.
  """
  def part1(input) do
    read_input(input)
    |> map_games()
    |> possible_games()
    |> Enum.sum()
  end

  @doc """
  Solve part2 of the problem.
  """
  def part2(input) do
    read_input(input)
    |> map_games()
    |> Enum.map(fn {_, list_of_games} ->
      min_of_color_required(list_of_games)
    end)
    |> Enum.map(fn list ->
      power(list)
    end)
    |> Enum.sum()
  end
end

CubeGame.part1("input.txt") |> IO.inspect(label: "Part 1")
CubeGame.part2("input.txt") |> IO.inspect(label: "Part 2")
