import scala.io._
import scala.actors._
import scala.xml.XML

import Actor._

object PageLoader {

	val linkMatch = "href=\"([^\"]*)\"".r

	def getPageSize(url: String) = Source.fromURL(url).mkString.length

	def getPageCount(url: String) = linkMatch.findAllIn(Source.fromURL(url).mkString).length

	def getPageLinks(url: String) = linkMatch.findAllIn(
		Source.fromURL(url).mkString).matchData.foldLeft(List[String]())((matches, link) => matches ++ List(link.group(1))
	)

	def getPageSizesRecursively(url: String) =
		getPageLinks(url).foldLeft(List[(String, Int)]())((sizes, url) => {
			if (url.startsWith("http://")) {
				sizes ++ List((url, getPageSize(url)))
			} else {
				sizes
			}
		})
}

object Day3 extends App {

	def timeMethod(method: () => Unit) = {
		val start = System.nanoTime
		method()
		val end = System.nanoTime
		println("Method took " + (end - start) / 1000000000.0 + " seconds.")
	}

	var urls = List(
		"http://www.twitter.com/",
		"http://www.google.com/"
	)

	def getPageSizeConcurrently() = {
		val caller = self
		for (url <- urls) {
			actor { caller ! (url, PageLoader.getPageSizesRecursively(url)) }
		}

		for (i <- 1 to urls.size) {
			receive {
				case (url, result) => result match {
					case x: List[(String, Int)] => x.foreach((pair) => println("Size for " + pair._1 + ": " + pair._2))
				}
			}
		}
	}

	def getPageLinksConcurrently() = {
		val caller = self
		for (url <- urls) {
			actor { caller ! (url, PageLoader.getPageLinks(url)) }
		}

		for (i <- 1 to urls.size) {
			receive {
				case (url, links) => println(links)
			}
		}
	}

	timeMethod { getPageSizeConcurrently }
}
