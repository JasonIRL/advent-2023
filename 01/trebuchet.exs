defmodule Calibration do
  @moduledoc """
  Day 1: Trebuchet Calibration Module

  --- Part One ---
  Parse the provided input file, and combine the first and last digits of each
  line. Then, sum the resulting list of numbers.

  --- Part Two ---
  Parse the provided input file, and replace the words "one" through "nine" with
  their corresponding digit. Then, combine the first and last digits of each
  line. Then, sum the resulting list of numbers.
  """

  @doc """
  Read the input file, and return a list of strings.
  """
  def read_input(path) do
    {:ok, contents} = File.read(path)
    contents |> String.split("\n")
  end

  @doc """
  Replace the words "one" through "nine" with their corresponding digit, leaving
  all other characters intact, incase there are other numbers in the string.
  """
  def convert_digits(data) do
    digit_map = %{
      "one" => "o1ne",
      "two" => "t2wo",
      "three" => "t3hree",
      "four" => "f4our",
      "five" => "f5ive",
      "six" => "s6ix",
      "seven" => "s7even",
      "eight" => "e8ight",
      "nine" => "n9ine"
    }

    data
    |> Enum.map(fn entry ->
      Enum.reduce(digit_map, entry, fn {word, digit}, acc ->
        String.replace(acc, word, digit)
      end)
    end)
  end

  @doc """
  Remove all non-digit characters from the provided list of strings.
  """
  def denoise(data) do
    data
    |> Enum.map(fn entry ->
      String.replace(entry, ~r/\D/, "")
    end)
  end

  @doc """
  Combine the first and last digits of each string, and convert the resulting
  string to an integer.
  """
  def concat(data) do
    data
    |> Enum.map(fn entry ->
      (String.first(entry) <> String.last(entry)) |> String.to_integer()
    end)
  end

  @doc """
  Solve part1 of the problem.
  """
  def part1(input) do
    read_input(input)
    |> denoise()
    |> concat()
    |> Enum.sum()
  end

  @doc """
  Solve part2 of the problem.
  """
  def part2(input) do
    read_input(input)
    |> convert_digits()
    |> denoise()
    |> concat()
    |> Enum.sum()
  end
end

Calibration.part1("input.txt") |> IO.puts()
Calibration.part2("input.txt") |> IO.puts()
