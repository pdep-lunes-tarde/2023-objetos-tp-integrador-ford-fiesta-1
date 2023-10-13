import juego.*
import wollok.game.*
import menues.*

class Rival {
	var property position
	var property image = "./assets/rivales/rivalfrente.png"
	
	method moverse(posicion){
		if(!zonaDeJuego.estaOcupada(posicion))
			position = posicion
	}
	
	method movimientoAleatorio() {
        var direccionesPosibles = [position.up(1), position.down(1), position.left(1), position.right(1)]
        var direccionAleatoria = direccionesPosibles.anyOne()
        if(direccionAleatoria == position.up(1))
        	image = "./assets/rivales/rivaldorso.png"
        if(direccionAleatoria == position.down(1))
        	image = "./assets/rivales/rivalfrente.png"
        if(direccionAleatoria == position.right(1))
        	image = "./assets/rivales/rivalderecha.png"
        if(direccionAleatoria == position.left(1))
        	image = "./assets/rivales/rivalizquierda.png"
        self.moverse(direccionAleatoria)
    }
    
    method matar(jugador){
		jugador.muere()
	}
	
	method muere(){
		game.sound("./assets/sounds/enemy-dies.mp3").play()
		game.removeVisual(self)
		juego.rivales().remove(self)
		game.schedule(500, {menuganaste.mostrar()})
	}
	
	method efecto(jugador){}

}
