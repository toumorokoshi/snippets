import scala.Console

class Board(board: Array[Array[Char]]) {

	var _xwon = false
	var _owon = false

	def printBoard() {
		(0 until 3).map(x => println(board(x).mkString))
	}

	def col(index : Int) = board.map(_(index))

	def row(index : Int) = board(index)

	def upperLeftLowerRight() = (0 until 3).map(x => board(x)(x)).toArray

	def upperRightLowerLeft() = (0 until 3).map(x => board(x)(2 - x)).toArray

	def _checkVictory(sequence : Array[Char]) {
		var set = sequence.toSet
		if (!set(' ') && !(set('X') && set('O'))) {
			if (set('X')) {
				_xwon = true;
			} else {
				_owon = true;
			}
		}
	}

	def won() = _xwon || _owon

	def state = {
		_xwon = false
		_owon = false
		(0 until 3).map(x => _checkVictory(col(x)))
		(0 until 3).map(x => _checkVictory(row(x)))
		_checkVictory(upperLeftLowerRight)
		_checkVictory(upperRightLowerLeft)
		if (_xwon) {
			"x won"
		} else if (_owon) {
			"o won"
		} else {
			"not won yet"
		}
	}
}


object HelloWorld extends App {
	var board = new Board(Array(
		Array(' ', ' ', ' '),
		Array(' ', ' ', ' '),
		Array(' ', ' ', ' ')
	))
	var result : String = null
	var remainingMoves = 9
	var xTurn = true;
	while (!board.won && remainingMoves > 0) {
		board.printBoard
		var moveString = { if (xTurn) 'X' else 'O' }
		var valid = false
		var x = 0
		var y = 0
		while (!valid) {
			println("Please enter row move for " + moveString + " > ")
			x = Console.readInt()
			println("Please enter column move for " + moveString + " > ")
			y = Console.readInt()
			valid = !Set('X', 'O')(board.row(x)(y))
			if (!valid) {
				println("That space is already taken! try again.")
			}
		}
		board.row(x)(y) = moveString
		result = board.state
		xTurn = !xTurn
		remainingMoves = remainingMoves - 1
	}
	board.printBoard
	if (board.won) {
		println(result)
	} else {
		println("tie!")
	}
}
