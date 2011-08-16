#!/usr/bin/env ruby

# block
bflag = true
# array 入れ子表現のため数値
aflag = 0
# line number
lnum = 0

pIndent = 0

IO.foreach('sample.coffee') { |line|
  lnum += 1

  # indentの計算処理がどのケースでも行われるようにここに書く
  indent = line.match(/[ \t]*/)[0].length
  sIndent = " " * [indent, pIndent].max
  pIndent = indent

  if line =~ /^\s*#/ #comment
    # nop
  elsif line =~ /^\s*\n$/ #blank line
    # nop
  elsif line =~ /else/
    # nop
  else
    comment = "###-#{lnum}-###"
    puts "#{sIndent}#{comment}" if bflag and aflag == 0

    bflag = !bflag if line =~ /'''/ or line =~ /"""/ or line =~ /\/\/\//
    aflag += 1 if line =~ /\[/
    aflag -= 1 if line =~ /\]/
  end
  puts line
}
