"# nat_lang_operations" 

convert math expressions to natural language:
```elixir
iex(1)> c "lib/math.exs", "."
[Math]
iex(2)> require Math
Math
iex(3)> Math.say (5/4)+8/2
1.25 plus 4.0 equals 5.25
(5 divided by 4) plus (8 divided by 2) equals 5.25
:ok
```