ExUnit.start()

defmodule CubeGameTest do
  use ExUnit.Case, async: true

  Code.load_file("cube_conundrum.exs")

  test "returns true if the game is possible" do
    test_data = %{
      red: 12,
      green: 13,
      blue: 14
    }

    assert CubeGame.check_map(test_data) == true
  end

  test "returns false if the game is not possible" do
    test_data = %{
      red: 13,
      green: 13,
      blue: 14
    }

    assert CubeGame.check_map(test_data) == false
  end

  test "maps a game as expected" do
    test_data = "Game 1: 1 red, 4 green, 2 blue; 13 red, 8 green, 17 blue"

    expected = %{
      1 => [
        %{red: 1, green: 4, blue: 2},
        %{red: 13, green: 8, blue: 17}
      ]
    }

    assert CubeGame.map_games([test_data]) == expected
  end

  test "returns a list of possible games" do
    test_data = %{
      1 => [
        %{red: 1, green: 2, blue: 3},
        %{red: 12, green: 13, blue: 14}
      ],
      2 => [
        %{red: 1, green: 2, blue: 3},
        %{red: 14, green: 15, blue: 16},
      ],
      3 => [
        %{red: 13, green: 3, blue: 3},
        %{red: 12, green: 13, blue: 14}
      ],
      4 => [
        %{red: 1, green: 2, blue: 3}
      ]
    }

    assert CubeGame.possible_games(test_data) == [4, 1]
  end

  test "should return the minimum qty of each color required to play the game" do
    test_data = [
      %{red: 10, green: 2, blue: 3},
      %{red: 4, green: 13, blue: 14},
      %{red: 6, green: 7, blue: 18}
    ]

    assert CubeGame.min_of_color_required(test_data) == [10, 13, 18]
  end

  test "should calculate the power of a list" do
    test_data = [1, 2, 3]

    assert CubeGame.power(test_data) == 6
  end
end
