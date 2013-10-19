
// two dimensional list
List2D := Object clone
List2D _data := list()

// data will be held in this list
List2D dim := method(x, y,
       _data = list()
       for(i, 1, x, 
           inner_list := list()
           for (j, 1, y,
               inner_list append(0))
           _data append(inner_list))
)

// get method 
List2D get := method(x, y, (_data at(x)) at(y))

// set method
List2D set := method(x, y, value, (_data at(x)) atPut(y, value))

// transpose method
List2D transpose := method(
       transposed := List2D()
       _new_data := list()
       for(i, (_data size) - 1, 0, -1, _new_data append((_data at(i)) reverse))
       transposed _data = _new_data
       transposed
)

// write to a file
List2D write := method(filename,
       file := File with(filename)
       file remove
       file openForUpdating
       for(i, 0, (_data size) - 1,
           for (j, 0, (_data at(i) size) - 1,
               el := _data at(i) at(j)
               file write("#{el} " interpolate)
           )
           file write("\n")
       ) 
       file close
)

List2D read := method(filename,
       file := File with(filename)
       file openForReading
       line := file readLine
       line split println
       _new_data := list()
       while(line, 
           _new_data append(line split)
           line = file readLine
       )
       read_l2d := List2D()
       read_l2d _data = _new_data
       read_l2d
)

l2d := List2D()
l2d dim(5, 5)
(l2d _data) println
(l2d set(1, 1, 3))
(l2d get(1, 1)) println
l2d _data println
l2d transpose _data println
l2d write("test.txt")
l2d_read := List2D read("test.txt")
l2d_read _data println
