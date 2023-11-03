import juego.*
import wollok.game.*
import menues.*
import bomberman.*

class Rival {
	var property position
	var property image = "./assets/rivales/rivalfrente.png"
	
	method moverse(posicion){
		if(!zonaDeJuego.estaOcupada(posicion))
			position = posicion
	}
	
	method movimientoAleatorio() {
        const direccionesPosibles = [position.up(1), position.down(1), position.left(1), position.right(1)]
        const direccionAleatoria = direccionesPosibles.anyOne()
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

object boss inherits Rival(position = game.at(5,5),image = "./assets/rivales/bossfrente.png"){
	
	var property vidas = 5	
	
	override method moverse(posicion){
		if(zonaDeJuego.sePuedeRomper(posicion))
			position = posicion
	}
	
	override method movimientoAleatorio() {
        const direccionesPosibles = [position.up(1), position.down(1), position.left(1), position.right(1)]
        const direccionAleatoria = direccionesPosibles.anyOne()
        if(direccionAleatoria == position.up(1))
        	image = "./assets/rivales/bossdorso.png"
        if(direccionAleatoria == position.down(1))
        	image = "./assets/rivales/bossfrente.png"
        if(direccionAleatoria == position.right(1))
        	image = "./assets/rivales/bossderecha.png"
        if(direccionAleatoria == position.left(1))
        	image = "./assets/rivales/bossizquierda.png"
        self.moverse(direccionAleatoria)
    }
    override method muere(){
		game.sound("./assets/sounds/enemy-dies.mp3").play()
		if(vidas > 1){
			vidas--
			position = zonaDeJuego.posicionesOcupadasCajas().anyOne()
			}
		else{
			game.removeVisual(self)
			juego.rivales().remove(self)
			game.schedule(500, {menuganaste.mostrar()})
			}
		self.muestraVida()
	}
	method muestraVida(){
		const vidasAMostrar = new MostrarVidas(
			position = game.at(5,0),
			image = "./assets/corazones/bossvida" + self.vidas().toString() + ".png"
		)
		game.addVisual(vidasAMostrar)
	}
}