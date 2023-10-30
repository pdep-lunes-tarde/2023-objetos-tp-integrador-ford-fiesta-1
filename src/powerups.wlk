import wollok.game.*

class PowerUp{
	var property position
	
	method efecto(jugador){game.removeVisual(self) game.sound("./assets/sounds/item-get.mp3").play()}
	
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

class BombaAtraviesaParedes inherits PowerUp{
	var property image = "./assets/powerups/bombaatraviesaparedes.png"
	override method efecto(jugador){
		jugador.bombaAtraviesaParedes()
		super(jugador)
	}
}