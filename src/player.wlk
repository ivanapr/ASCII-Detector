import wollok.game.*
import config.*

object detector {
	var property image = "assets/detector2.png"
	
	var property position = game.center()
	
	var property elemToFind = #{elem1, elem2, elem3, elem4, elem5}
	
	var property backgrounds = #{back1, back2, back3, back4, back5}
	
	method addRef () {
		cell.ref(reference)
		game.addVisualIn(cell.image(), cell.position())
	}
		
	method reset(){
		position = game.center()
		elemToFind = #{elem1, elem2, elem3, elem4, elem5}
	}

	method goToIfStaysOnScreen(newPosition) {
		if (self.isInsideScreen(newPosition) and not self.isForbiddenPosition(newPosition)) {
			self.goTo(newPosition)
		}
	}
	
	method goTo(newPosition){
		position = newPosition
	}
	
	method isForbiddenPosition(newPosition){
		return mainScreen.isForbiddenPosition(newPosition)
	}
	
	method isInsideScreen(newPosition) {
		return 	newPosition.x().between(0, game.width() - 1)
		and		newPosition.y().between(0, game.height() - 1)
	}
}


object counter {
	method position() {
		return game.at(14,12)
	}
	
	method image() {
		return "assets/number/number_" + detector.elemToFind().size().toString() + ".png" 
	}
}

object time {
	var seconds
	method position() {
		return game.at(14,8)
	}
	
	method image() {
		return "assets/number/number_" + self.sec() + ".png" 
	}
	
	method sec() {
		return seconds
	}
	method sec(_seconds) {
		seconds = _seconds
	}
}

object cell {
	var ref
	method position() {
		return game.at(14,4)
	}
	method image() {
		return "assets/cell" + self.ref() + ".png" 
	}
	method ref() {
		return ref
	}
	method ref(_ref) {
		ref = _ref
	}
}

class Element {
	const property position
	const property image
	const property reference
}


const elem1 = new Element(position = game.at(4,5), image = "assets/elem1.png", reference = 1)
const elem2 = new Element(position = game.at(9,2), image = "assets/elem2.png", reference = 2)
const elem3 = new Element(position = game.at(7,10), image = "assets/elem3.png", reference = 3)
const elem4 = new Element(position = game.at(4,7), image = "assets/elem4.png", reference = 4)
const elem5 = new Element(position = game.at(10,3), image = "assets/elem5.png", reference = 5)


class Background {
	const property image
	method position() {
		return game.origin()
	}
}

const back1 = new Background(image = "assets/back1.png")
const back2 = new Background(image = "assets/back2.png")
const back3 = new Background(image = "assets/back3.png")
const back4 = new Background(image = "assets/back4.png")
const back5 = new Background(image = "assets/back5.png")