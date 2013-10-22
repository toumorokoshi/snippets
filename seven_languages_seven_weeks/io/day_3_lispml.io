// first, adding the curly bracket syntax
OperatorTable addAssignOperator(":", "atPutColon")

// modifies curly bracket to create a map
curlyBrackets := method(
    r := Map clone
    call message arguments foreach(arg,
        key_value_pair := arg asSimpleString split(":")
        r atPut(
            key_value_pair at(0) strip(" \""),
            key_value_pair at(1) strip(" \"")
        )
    )
    r
)

Builder := Object clone
Builder _spaces := 0
Builder forward := method(
        _spaces repeat(" " print)
        write("<", call message name)
        // logic to add attributes
        first_arg := call message argAt(0)
        if (first_arg and first_arg name == "curlyBrackets",
            write(" ")
            attributes := self doMessage(call message argAt(0))
            attributes keys foreach(key,
                write(key, "=", "\"", attributes at(key), "\"")
            )
        )
        writeln(">")
        // logic to recursively add child elements
        _spaces = _spaces + 4
        call message arguments foreach(arg,
            content := self doMessage(arg)
            if (content type == "Sequence", 
                  _spaces repeat(" " print)
                  writeln(content))
        )
        _spaces = _spaces - 4
        _spaces repeat(" " print)
        writeln("</", call message name, ">")
)

a := {"test": "value"}
a keys println
Builder ul(li({"test": "value"}), li("Lua"), li("Javascript"))
