defmodule RockPaperScissors do
  @lose "X"
  @draw "Y"
  @win "Z"

  @rock "X"
  @paper "Y"
  @scissors "Z"

  @shapes %{
    "A" => :rock,
    "B" => :paper,
    "C" => :scissors
  }

  @play_score %{
    :player => 6,
    :opponent => 0,
    nil => 3
  }

  @shape_score %{
    @rock => 1,
    @paper => 2,
    @scissors => 3
  }

  def get_player_score(winner, player) do
    @play_score[winner] + @shape_score[player]
  end

  def calculate_score({opponent, player}, :part_1) do
    winner =
      case {opponent, player} do
        {:rock, @scissors} -> :opponent
        {:rock, @paper} -> :player
        {:scissors, @rock} -> :player
        {:scissors, @paper} -> :opponent
        {:paper, @scissors} -> :player
        {:paper, @rock} -> :opponent
        _ -> nil
      end

    get_player_score(winner, player)
  end

  def calculate_score({opponent, result}, :part_2) do
    player =
      case {opponent, result} do
        {:rock, @win} -> @paper
        {:rock, @lose} -> @scissors
        {:rock, @draw} -> @rock
        {:scissors, @win} -> @rock
        {:scissors, @lose} -> @paper
        {:scissors, @draw} -> @scissors
        {:paper, @win} -> @scissors
        {:paper, @lose} -> @rock
        {:paper, @draw} -> @paper
      end

    winner =
      case result do
        @win -> :player
        @lose -> :opponent
        @draw -> nil
      end

    get_player_score(winner, player)
  end

  def play_game(filename, mode \\ :part_1) do
    case File.read(filename) do
      {:ok, file_contents} ->
        lines = String.split(file_contents, "\n")

        Enum.reduce(lines, 0, fn line, total ->
          [first_column, second_column] = String.split(line, " ")
          total + calculate_score({@shapes[first_column], second_column}, mode)
        end)

      {:error, reason} ->
        IO.puts("Error: Could not read the file #{filename}. Reason #{reason}")
    end
  end
end

# input_test.txt = 15
score_part1 = RockPaperScissors.play_game("input.txt")
IO.puts("Player score part1: #{score_part1}")

# input_test.txt = 12
score_part2 = RockPaperScissors.play_game("input.txt", :part_2)
IO.puts("Player score part2: #{score_part2}")
