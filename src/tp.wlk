import wollok.game.*

object bombardero
{
	var property position = game.origin()
	var vidas = 4
	var property image = "./imagenes/bombermanBlanco.png"
	
	method cuantasVidas() = vidas.toString()
	
	method posicion() = position
		
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
	method text() {
		return "\n\n\nVidas: " + self.cuantasVidas()
	}
	
	method poner(bomba){
		bomba.colocar(position)
	}
	
}
