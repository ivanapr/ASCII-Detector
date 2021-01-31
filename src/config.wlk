import wollok.game.*
import player.*

class Screen {
	
	method start() { 
		game.clear()
		game.addVisual(self)
		self.configKeys()
		jukebox.changeTrack(self.music())
	}
	
	method position(){ return game.origin() }
	
	method image()
	
	method configKeys()
	
	method music()

}

object mainMenu inherits Screen {
	
	override method image(){ return "assets/mainMenu.png"}
	
	override method configKeys() {
		keyboard.num1().onPressDo({ mainScreen.start() })
		keyboard.num2().onPressDo({ tutorialScreen.start() })
		keyboard.num3().onPressDo({ creditsScreen.start() })
	}
	
	override method music() { return menuMusic }
}

object tutorialScreen inherits Screen {
	
	override method image() { return "assets/tutorialScreen.png"}
	
	override method configKeys() {
		keyboard.any().onPressDo({ mainMenu.start() })
	}
	
	override method music() { return menuMusic }
}

object creditsScreen inherits Screen {
	
	override method image() { return "assets/creditsScreen.png"}
	
	override method configKeys() {
		keyboard.any().onPressDo({ mainMenu.start() })
	}
	
	override method music() { return menuMusic }
}


class FinalScreen inherits Screen {
	method endGame() {
		game.schedule(5000, { creditsScreen.start() })
		detector.reset()
	}
	
	override method start(){
		super()
		self.endGame()
	}
	
	override method configKeys(){}
	
}

object victoryScreen inherits FinalScreen {
	override method image(){ return "victoryScreen.png"}
	override method music() { return victoryMusic }
}

object defeatScreen inherits FinalScreen {
	override method image(){ return "defeatScreen.png"}
	override method music() { return defeatMusic }
}


object mainScreen inherits Screen {
	var background = detector.backgrounds().anyOne()
	const gameplaySoundsList = [scoreSound1, scoreSound2, scoreSound3, scoreSound4, scoreSound5]
	var gameplaySounds = gameplaySoundsList
	override method image() { return "assets/mainScreen.png" }
	
	override method music() { return gameMusic }
	
	override method start() {
		
		super()
		
		game.addVisual(detector)
		self.configCollition()
		game.addVisual(counter)
		game.addVisual(background)
		game.addVisual(detector.elemToFind().anyOne())
		self.timer()
	}
	
	method returnSound() {
		return gameplaySounds
	}
	method returnSound(_sound) {
		gameplaySounds = _sound
	}
	
	method timer() {
		time.sec(60)
		game.addVisual(time)
		game.onTick(1000, "gameTimer", { time.sec(time.sec() - 1)
		})
	}

	
	method isElemToFind(elem){
		return detector.elemToFind().contains(elem)
	}
	
	method elemFound(elem){
		if(self.isElemToFind(elem)){
			gameplaySounds.head().sound().play()
			game.removeVisual(elem)
			detector.elemToFind().remove(elem)
			game.removeVisual(background)
			detector.backgrounds().remove(background)
			gameplaySounds.remove(gameplaySounds.first())
		}
	}
	
	method isForbiddenPosition(posit){
		return self.forbiddenPositions().contains(posit)
	}
	
	method forbiddenPositions() {
		return #{ game.at(0,0), game.at(0,1), game.at(0,2), game.at(0,3), game.at(0,4),
					game.at(0,5), game.at(0,6), game.at(0,7), game.at(0,8), game.at(0,9),
					game.at(0,10), game.at(0,11), game.at(0,12), game.at(0,13), game.at(0,14),
					game.at(0,15), game.at(0,16), game.at(0,17), // (0,x)
					game.at(1,0), game.at(2,0), game.at(3,0), game.at(4,0), game.at(5,0),
					game.at(6,0), game.at(7,0), game.at(8,0), game.at(9,0), game.at(10,0),
					game.at(11,0), game.at(12,0), game.at(13,0), game.at(14,0), game.at(15,0),
					game.at(16,0), // (x,0) 
					game.at(16,17),// (x, 17)
					game.at(1,16), game.at(2,16), game.at(3,16), game.at(4,16), game.at(5,16), 
					game.at(6,16), game.at(7,16), game.at(8,16), game.at(9,16), game.at(10,16), 
					game.at(11,16), game.at(12,16), game.at(13,16), game.at(14,16), game.at(15,16), 
					game.at(16,16),
					game.at(1,15), game.at(2,15), game.at(3,15), game.at(4,15), game.at(5,15), 
					game.at(6,15), game.at(7,15), game.at(8,15), game.at(9,15), game.at(10,15), 
					game.at(11,15), game.at(12,15), game.at(13,16), game.at(14,15), game.at(15,15), 
					game.at(16,15),
					game.at(1,14), game.at(2,14), game.at(3,14), game.at(4,14), game.at(5,14), 
					game.at(6,14), game.at(7,14), game.at(8,14), game.at(9,14), game.at(10,14), 
					game.at(11,14), game.at(12,14), game.at(13,14), game.at(14,14), game.at(15,14), 
					game.at(16,14),
					game.at(1,13), game.at(2,13), game.at(3,13), game.at(4,13), game.at(5,13), 
					game.at(6,13), game.at(7,13), game.at(8,13), game.at(9,13), game.at(10,13), 
					game.at(11,13), game.at(12,13), game.at(13,13), game.at(14,13), game.at(15,13), 
					game.at(16,13),
					game.at(1,12), game.at(2,12), game.at(3,12), game.at(4,12), game.at(5,12), 
					game.at(6,12), game.at(7,12), game.at(8,12), game.at(9,12), game.at(10,12), 
					game.at(11,12), game.at(12,12), game.at(13,12), game.at(14,12), game.at(15,12), 
					game.at(16,12),
					//game.at(1,11), game.at(2,11), game.at(3,11), game.at(4,11), game.at(5,11), 
					//game.at(6,11), game.at(7,11), game.at(8,11), game.at(9,11), game.at(10,11), 
					//game.at(11,11), game.at(12,11), game.at(13,11), game.at(14,11), game.at(15,11), 
					//game.at(16,11),
					// MENU
					game.at(16,1), game.at(16,2), game.at(16,3), game.at(16,4), game.at(16,5),
					game.at(16,6), game.at(16,7), game.at(16,8), game.at(16,9), game.at(16,10),
					game.at(16,11), game.at(16,12), game.at(16,13), game.at(16,14), game.at(16,15),
					game.at(16,16),
					game.at(15,1), game.at(15,2), game.at(15,3), game.at(15,4), game.at(15,5),
					game.at(15,6), game.at(15,7), game.at(15,8), game.at(15,9), game.at(15,10),
					game.at(15,11), game.at(15,12), game.at(15,13), game.at(15,14), game.at(15,15),
					game.at(15,16),
					game.at(14,1), game.at(14,2), game.at(14,3), game.at(14,4), game.at(14,5),
					game.at(14,6), game.at(14,7), game.at(14,8), game.at(14,9), game.at(14,10),
					game.at(14,11), game.at(14,12), game.at(14,13), game.at(14,14), game.at(14,15),
					game.at(14,16),
					game.at(13,1), game.at(13,2), game.at(13,3), game.at(13,4), game.at(13,5),
					game.at(13,6), game.at(13,7), game.at(13,8), game.at(13,9), game.at(13,10),
					game.at(13,11), game.at(13,12), game.at(13,13), game.at(13,14), game.at(13,15),
					game.at(13,16),
					game.at(12,1), game.at(12,2), game.at(12,3), game.at(12,4), game.at(12,5),
					game.at(12,6), game.at(12,7), game.at(12,8), game.at(12,9), game.at(12,10),
					game.at(12,11), game.at(12,12), game.at(12,13), game.at(12,14), game.at(12,15),
					game.at(12,16)
		            }
	}
	
    override method configKeys() {
		keyboard.left().onPressDo({ detector.goToIfStaysOnScreen(detector.position().left(1)) })
		keyboard.right().onPressDo({ detector.goToIfStaysOnScreen(detector.position().right(1)) })
		keyboard.up().onPressDo({ detector.goToIfStaysOnScreen(detector.position().up(1)) })
		keyboard.down().onPressDo({ detector.goToIfStaysOnScreen(detector.position().down(1)) })
	}
	
	method configCollition() {
		game.onCollideDo(detector, { elem => 
			self.elemFound(elem)
			if (not detector.elemToFind().isEmpty()) {
				background = detector.backgrounds().anyOne() 
				game.addVisual(background)
				game.addVisual(detector.elemToFind().anyOne())
			} else { self.checkVictory() }
		})
	}

	method checkVictory() {
		if(detector.elemToFind().isEmpty()){
			game.say(detector,"We have a winner")
			//removeTickEvent("gameTimer")
			game.schedule(700,{ victoryScreen.start() })
		}
	}
}


object jukebox {
	
	var track = menuMusic.sound()
	
	method start(){
		track.shouldLoop(true)
		track.volume(0.2)
		game.schedule(100,{track.play()})
	}
	
	method changeTrack(music){
		if(self.trackPlaying()){
			if(self.isChangeOfTrack(music)){
				track.pause()
				track = music.sound()
				track.volume(0.2)
				track.shouldLoop(true)
				self.playTrack()
			}
		}else{
			self.start()
		}
	}
	
	method isChangeOfTrack(music) {
		return track != music.sound()
	}
	
	method trackPlaying(){
		return track.played() and not track.paused()
	}
	
	method trackPaused(){	
		return track.played() and track.paused()	
	}	

	method playTrack() {	
		if (self.trackPaused()) {	
			track.resume()	
		} else {	
			track.play()	
		}	
	}
}

object menuMusic {
	
	const property sound = game.sound("assets/sound/detector_tema1_menu.mp3")
}

object gameMusic {
	
	const property sound = game.sound("assets/sound/detector_tema3_gameplay.mp3")
}

object scoreSound1 {
	
	const property sound = game.sound("assets/sound/detector_sonido1.mp3") 
}

object scoreSound2 {
	
	const property sound = game.sound("assets/sound/detector_sonido2.mp3") 
}

object scoreSound3 {
	
	const property sound = game.sound("assets/sound/detector_sonido3.mp3") 
}

object scoreSound4 {
	
	const property sound = game.sound("assets/sound/detector_sonido4.mp3") 
}

object scoreSound5 {
	
	const property sound = game.sound("assets/sound/detector_sonido5.mp3") 
}


object victoryMusic {
	
	const property sound = game.sound("assets/sound/detector_tema5_victoria.mp3")
}

object defeatMusic {
	
	const property sound = game.sound("assets/sound/detector_tema4-derrota.mp3")
}