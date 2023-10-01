import wollok.game.*
import juego.*

class Bomba
{
	var property position
	var fuegos = []
	var bombardero
	var property image = "./imagenes/bomb.png"
	
	method colocarBomba(){
		game.onTick(2500,"aparece la bomba y desaparece a los 2,5 seg" ,{self.eliminar()})
		game.addVisual(self)
		zonaDeJuego.agregarPos(position)
	}
	
	method explota(){
		bombardero.sacarBomba(self)
		self.aparecerFuego()
	}
	
	method eliminar(){
		zonaDeJuego.sacarPos(position)
		game.removeTickEvent("aparece la bomba y desaparece a los 2,5 seg")
		game.removeVisual(self)
		self.explota()
	}
	
	method aparecerFuego(){
		//fuegos.add(position)
		const fuego = new Fuego(position = position)
		fuego.generarFuego()
	}
	
}

class Fuego{
	var property position
	var property imgage = "./imagenes/fuego.png"
	
	method generarFuego(){
		game.addVisual(self)
		game.schedule(300, {game.removeVisual(self)})
	}
}
