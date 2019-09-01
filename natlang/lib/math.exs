defmodule Math do

  @moduledoc """
    use: 
    c "math.exs", "."
    
    to store the bytecode in cur dir and use the docs here...
  """
  def atoms(atom) do
    case atom do
      :+ -> "plus"
      :* -> "times"
      :- -> "minus"
      :/ -> "divided by"
      _ -> "no clause"
    end
  end

  def tupleString({atom, _, [lhs, rhs]}, string \\ "") do
    atoms = Math.atoms(atom)

    string =
      cond do
        is_tuple(lhs) ->
          "(#{string} (#{Math.tupleString(rhs, string)}))"

        is_tuple(rhs) ->
          "(#{lhs} #{atoms} (#{Math.tupleString(rhs, string)}))"

        true ->
          "(#{lhs} #{atoms} #{rhs})"
      end

    _string =
      cond do
        is_tuple(rhs) && is_tuple(lhs) ->
          "(#{string} #{atoms} (#{Math.tupleString(rhs, string)}))"

        true ->
          "#{string}"
      end
  end

  defmacro say({atom, whatever, [lhs, rhs]}) do
    quote do
      atoms = Math.atoms(unquote(atom))

      lhString =
        unquote(
          cond do
            is_tuple(lhs) ->
              Math.tupleString(lhs)

            true ->
              "#{lhs}"
          end
        )

      rhString =
        unquote(
          cond do
            is_tuple(rhs) ->
              Math.tupleString(rhs)

            true ->
              "#{rhs}"
          end
        )

      result = unquote({atom, whatever, [lhs, rhs]})
      lhs2 = unquote(lhs)
      rhs2 = unquote(rhs)
      IO.puts("#{lhs2} #{atoms} #{rhs2} equals #{result}")
      IO.puts("#{lhString} #{atoms} #{rhString} equals #{result}")
    end
  end
  @doc """
  split like this without parens

  iex(49)> Regex.split(~r{(?=plus|minus)}, "one plus two minus three plus four")
    ["one ", "plus two ", "minus three ", "plus four"]
  
  or maybe:

  iex(51)> Regex.split(~r{(?=plus|minus)\w+}, "one plus two minus three plus four", include_captures: true)
    ["one ", "plus", " two ", "minus", " three ", "plus", " four"]
  """
  defmacro unsay(str) do
    IO.inspect(str)
    
    # quote do
    #   unquote(lhs + rhs)
    # end
  end
end
