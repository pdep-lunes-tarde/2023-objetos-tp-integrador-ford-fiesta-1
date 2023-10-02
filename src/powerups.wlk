import wollok.game.*

class UnaVidaExtra {
	var property position
	var property image = "./imagenes/vidaextra.png"
	method efecto(jugador){
		jugador.vidaExtra()
		game.removeVisual(self)
	}
	
	method aparecer(){
		game.addVisual(self)
	}
	
	method matar(noSeUsa){}
	method muere(){}
}
