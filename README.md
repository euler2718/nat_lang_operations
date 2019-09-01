"# nat_lang_operations" 

convert math expressions to natural language:

iex(1)> c "lib/math.exs", "."\n
[Math]\n
iex(2)> require Math\n
Math\n
iex(3)> Math.say (5/4)+8/2\n
1.25 plus 4.0 equals 5.25\n
(5 divided by 4) plus (8 divided by 2) equals 5.25\n
:ok