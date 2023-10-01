import wollok.game.*
import juego.*

class Caja{
	var property position
	var property image = "./imagenes/caja.png"
	
	method ponerCaja(){
		game.addVisual(self)
		zonaDeJuego.agregarPos(position)
	}
}