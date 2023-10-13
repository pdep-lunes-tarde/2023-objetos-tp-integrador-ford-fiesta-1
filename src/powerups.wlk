import wollok.game.*

class PowerUp{
	var property position
	
	method efecto(jugador){game.removeVisual(self)}
	
	method aparecer(){
		game.addVisual(self)
	}

	method matar(noSeUsa){}
	method muere(){}
}

class UnaVidaExtra inherits PowerUp{
	var property image = "./assets/powerups/vidaextra.png"
	override method efecto(jugador){
		jugador.vidaExtra()
		super(jugador)
	}
}

class UnaBombaExtra inherits PowerUp{
	var property image = "./assets/powerups/bombaextra.png"
	override method efecto(jugador){
		jugador.bombaExtra()
		super(jugador)
	}
}

class BombaMasGrande inherits PowerUp{
	var property image = "./assets/powerups/bombamasgrande.png"
	override method efecto(jugador){
		jugador.bombaMasGrande()
		super(jugador)
	}
}