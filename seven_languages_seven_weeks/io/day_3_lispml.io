Builder := Object clone
Builder _spaces := 0
Builder forward := method(
        _spaces repeat(" " print)
        writeln("<", call message name, ">")
        _spaces = _spaces + 4
        call message arguments foreach(arg,
            content := self doMessage(arg)
            if (content type == "Sequence", 
                  _spaces repeat(" " print)
                  writeln(content)
                )
        )
        _spaces = _spaces - 4
        _spaces repeat(" " print)
        writeln("</", call message name, ">")
)

Builder ul(li("Io"), li("Lua"), li("Javascript"))
