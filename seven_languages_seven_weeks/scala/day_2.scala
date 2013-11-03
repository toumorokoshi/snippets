import scala.io.Source

trait Censor {

	var censorMap = Map(
		"Shoot" -> "Pucky",
		"Darn" -> "Beans"
	)

	def censor(word: String) = censorMap.foldLeft(word)((word, entry) => word.replace(entry._1, entry._2))

	/* load the censor map from a file */
	def censorMapfromFile(fileName: String) {
		censorMap = Source.fromFile(fileName).getLines().foldLeft(censorMap.empty)(
			(map, line) => {
				var entries = line.split(",")
				map + (entries.head -> entries.last)
			}
		)
	}
}

class RadioPersonality extends Censor {
}

object Day2 extends App {
	// use foldLeft to compute the total size of a list of strings
	val names = Array("Yusuke", "Parisa")
	println(names.foldLeft(0)((totalLength, word) => totalLength + word.size))

	// censor string from a map
	val rd = new RadioPersonality()
	println(rd.censor("Shoot this Darn thing!"))
	rd.censorMapfromFile("censor.txt")
	println(rd.censor("Say No to the Moo!"))
}
