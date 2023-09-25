import wollok.game.*

class Rival
{
	var property position
	var positionPrev = position
  
	var property image = "./imagenes/golem.png"
	
	method buscarA(alguien){
		const otroPosicion = alguien.position()
		var newX = position.x() + if (otroPosicion.x() > position.x()) 1 else -1
		var newY = position.y() + if (otroPosicion.y() > position.y()) 1 else -1
		newX = newX.max(0).min(game.width() - 1)
		newY = newY.max(0).min(game.height() - 1)
		positionPrev = position
		position = game.at(newX, newY)
	}
	
	method volverAInicio(){
		position = game.at(3,3)
	}
	
	method volverAPosAnterior(){
		position = positionPrev
	}
	
	method colisionarCon(alguien){
		self.volverAInicio()
	}
	
}
