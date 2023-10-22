import wollok.game.*
import juego.*

object selector{
	var property position = game.origin()
	var property image = "./assets/menues/menu-seleccion-normal.png"
	
	method normal(){image = "./assets/menues/menu-seleccion-normal.png"}
	method coop(){image = "./assets/menues/menu-seleccion-coop.png"}
	method salir(){image = "./assets/menues/menu-seleccion-salir.png"}
}

object menu{
	var property image = "./assets/menues/menu-base.png"
	var property position = game.origin()
	var property seleccion = 0
	
	method abajo(){
		seleccion++
		self.actualizarmenu()
	}
	
	method arriba(){
		seleccion--
		self.actualizarmenu()
	}
	
	method actualizarmenu(){
		if(seleccion > 2)
			seleccion = 0
		if(seleccion < 0)
			seleccion = 2

		if(seleccion == 0)
			self.normal()
		if(seleccion == 1)
			self.coop()
		if(seleccion == 2)
			self.salir()
	}
	
	method normal(){selector.normal()}
	method coop(){selector.coop()}
	method salir(){selector.salir()}
	
	method animar(){
		if(image == "./assets/menues/menu-base.png")
			image = "./assets/menues/menu-base2.png"
		else
			image = "./assets/menues/menu-base.png"
	}
}

class Menuesfin {
	var property image = "./assets/menues/menu" + estado +"1.png"
	var property position = game.origin()
	var estado
	
	method animar(){
	if(image == "./assets/menues/menu" + estado +"1.png")
		image = "./assets/menues/menu" + estado +"2.png"
	else
		image = "./assets/menues/menu" + estado+ "1.png"
	}
	
	method mostrar(){
		if(juego.rivales().isEmpty()){
			game.sound("./assets/sounds/stage-clear.mp3").play()
			game.clear()
			game.addVisual(self)
			game.onTick(500, "animacion menu" + estado ,{self.animar()})
			keyboard.r().onPressDo({
				game.removeVisual(self)
				juego.reiniciar()
			})
			}
		}
}

object menuganaste inherits Menuesfin(estado = "ganaste"){}

object menuperdiste inherits Menuesfin(estado = "perdiste") {
	override method mostrar(){
		if(juego.jugadores().isEmpty()){
			game.sound("./assets/sounds/enemy-dies.mp3").play()
			game.clear()
			game.addVisual(self)
			game.onTick(500, "animacion menuperdiste" ,{self.animar()})
			keyboard.r().onPressDo({
				game.removeVisual(self)
				juego.reiniciar()
			})
			}
		}
}

object background{
	var property image = "./assets/menues/background.png"
	var property position = game.origin()
}