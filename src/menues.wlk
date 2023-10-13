import wollok.game.*
import juego.*

object menu{
	var property image = "./assets/menues/menu1normal.png"
	var property position = game.origin()
	var property seleccion = 0
	
//	method animar(){
//	if(image == "./assets/menues/menu1coop.png")
//		image = "./assets/menues/menu2coop.png"
//	if(image == "./assets/menues/menu2coop.png")
//		image = "./assets/menues/menu1coop.png"
//	
//	if(image == "./assets/menues/menu1normal.png")
//		image = "./assets/menues/menu2normal.png"
//	if(image == "./assets/menues/menu2normal.png")
//		image = "./assets/menues/menu1normal.png"
//	
//	if(image == "./assets/menues/menu1salir.png")
//		image = "./assets/menues/menu2salir.png"
//	if(image == "./assets/menues/menu2salir.png")
//		image = "./assets/menues/menu1salir.png"
//	}
	
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
	
	method normal(){
		image = "./assets/menues/menu1normal.png"
	}
	method coop(){
		image = "./assets/menues/menu1coop.png"
	}
	method salir(){
		image = "./assets/menues/menu1salir.png"
	}
}

object menuganaste {
	var property image = "./assets/menues/menuganaste1.png"
	var property position = game.origin()
	
	method animar(){
	if(image == "./assets/menues/menuganaste1.png")
		image = "./assets/menues/menuganaste2.png"
	else
		image = "./assets/menues/menuganaste1.png"
	}
	
	method mostrar(){
		if(juego.rivales() == []){
			game.sound("./assets/sounds/stage-clear.mp3").play()
			game.clear()
			game.addVisual(self)
			game.onTick(500, "animacion menuganaste" ,{self.animar()})
			keyboard.r().onPressDo({
				game.clear()
				juego.reiniciar()
			})
			}
		}
}

object background{
	var property image = "./assets/menues/background.png"
	var property position = game.origin()
}