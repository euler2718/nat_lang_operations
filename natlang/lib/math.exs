defmodule Math do
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

        True ->
          "(#{lhs} #{atoms} #{rhs})"
      end

    string =
      cond do
        is_tuple(rhs) && is_tuple(lhs) ->
          "(#{string} #{atoms} (#{Math.tupleString(rhs, string)}))"

        True ->
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

            True ->
              "#{lhs}"
          end
        )

      rhString =
        unquote(
          cond do
            is_tuple(rhs) ->
              Math.tupleString(rhs)

            True ->
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

  defmacro unsay({:plus, _, [lhs, rhs]}) do
    IO.inspect({:plus, [lhs, rhs]})

    quote do
      unquote(lhs + rhs)
    end
  end
end
