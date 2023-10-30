import wollok.game.*
import juego.*

const dirmenu = "./assets/menues/"

object selector{
	var property position = game.origin()
	var property image = dirmenu + "menu-seleccion-normal.png"
	
	method normal(){image = dirmenu + "menu-seleccion-normal.png"}
	method coop(){image = dirmenu + "menu-seleccion-coop.png"}
	method salir(){image = dirmenu + "menu-seleccion-salir.png"}
}

object menu{
	var property image = dirmenu + "menu-base.png"
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
		if(image == dirmenu + "menu-base.png")
			image = dirmenu + "menu-base2.png"
		else
			image = dirmenu + "menu-base.png"
	}
}

class Menuesfin {
	var property image = dirmenu + "menu" + estado +"1.png"
	var property position = game.origin()
	var estado
	
	method animar(){
	if(image == dirmenu + "menu" + estado +"1.png")
		image = dirmenu + "menu" + estado +"2.png"
	else
		image = dirmenu + "menu" + estado+ "1.png"
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
	var property image = dirmenu + "background.png"
	var property position = game.origin()
}