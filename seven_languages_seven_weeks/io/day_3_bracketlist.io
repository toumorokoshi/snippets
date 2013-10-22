// list syntax with brackets
curlyBrackets := method(
    l := List clone
    call message arguments foreach(arg, l append(arg)) 
    l
)

l := {"I", "live", "for", "the", "applause"}
l println
