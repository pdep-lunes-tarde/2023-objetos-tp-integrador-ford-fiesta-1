import juego.*
import wollok.game.*

class Rival {
	var property position
	var property image = "./imagenes/golem.png"
	
	method moverse(posicion){
		if(!zonaDeJuego.estaOcupada(posicion))
			position = posicion
	}
	
	method movimientoAleatorio() {
        var direccionesPosibles = [position.up(1), position.down(1), position.left(1), position.right(1)]
        var direccionAleatoria = direccionesPosibles.anyOne()
        self.moverse(direccionAleatoria)
    }
    
    method matar(jugador){
		jugador.muere()
	}
	
	method muere(){
		game.removeVisual(self)
		juego.rivales().remove(self)
		game.schedule(500, {menuganaste.mostrar()})
	}
	
	method efecto(jugador){}

}
