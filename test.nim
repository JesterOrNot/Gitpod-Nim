import std/[os, random, strutils, terminal]
randomize()
hideCursor()
var target, output: string
let color = rand(7)
case color:
    of 1:
        setForeGroundColor(fgGreen)
    of 2:
        setForeGroundColor(fgDefault)
    of 3:
        setForeGroundColor(fgMagenta)
    of 4:
        setForeGroundColor(fgCyan)
    of 5:
        setForeGroundColor(fgBlue)
    of 6:
        setForeGroundColor(fgYellow)
    of 7:
        setForeGroundColor(fgRed)
    else:
        setForeGroundColor(fgDefault)
target = "Hello World From Nim!"
output = spaces(target.len)
for i,x in target:
    while x != output[i]:
        output[i] = chr(rand(32..126))
        eraseLine()
        stdout.write(output)
        stdout.flushFile()
        sleep(3)
echo ""
showCursor()