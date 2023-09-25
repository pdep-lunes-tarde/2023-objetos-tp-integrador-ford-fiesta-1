import wollok.game.*

object bombardero
{
	var property position = game.origin()
	var vidas = 4
	
	method cuantasVidas() = vidas.toString()
		
	method terminaJuego() = vidas == 0
	
	method volverAInicio(){
		position = game.origin()
	}
	
	method colisionarCon(rival){
		vidas = vidas -1
		self.volverAInicio()
		if(self.terminaJuego()){
			game.stop()
		}
	}
	
	method image() = "./imagenes/bombermanBlanco.png"
}


class Bomba
{
	var property position
	
	method image()= "./imagenes/bomb.png"
}

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

