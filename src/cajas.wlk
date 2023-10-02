import wollok.game.*
import juego.*
import powerups.*

class Caja{
	var property position
	var property image = "./imagenes/caja.png"
	
	method ponerCaja(){
		game.addVisual(self)
		zonaDeJuego.agregarCajaEn(position)
	}
	
	method muere(){
		game.removeVisual(self)
		self.posibilidadDePowerUp()
	}
	
	method posibilidadDePowerUp(){
		var probabilidad = 1.randomUpTo(10)
		if(probabilidad < 10)
			new UnaVidaExtra(position = position).aparecer()
	}

	method efecto(jugador){}
	
}