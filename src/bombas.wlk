import wollok.game.*
import juego.*
import cajas.*

class Bomba
{
	var property position
	var bombardero
	var tamanio
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
		const fuego = new Fuego(position = position,
								tamanio = tamanio,
								direcciones = [position.down(1), position.up(1), position.left(1), position.right(1)]
		)
		fuego.generarFuego()
	}
	
	method matar(alguien){}
	method muere(){}
	method efecto(jugador){}
	
}

class Fuego{
	var property position
	var tamanio
	var property image = "./imagenes/fuego.png"
	var property direcciones
	
	method generarFuego(){
		game.addVisual(self)
		game.schedule(600, {game.removeVisual(self)})
		if(tamanio > 0)
			self.expandirse()
		game.onCollideDo(self, {caja => caja.muere() zonaDeJuego.sacarCajaEn(position)})
	}
	
	method matar(jugador){
		jugador.muere()
	}
	
	method puedeExpandirse(posicion){
		if(zonaDeJuego.sePuedeRomper(posicion))
			position = posicion
	}
	
	method expandirse(){
		direcciones.forEach{
			direccion => 
			const siguienteDireccion = game.at((2 * direccion.x()) - position.x(),(2 * direccion.y()) - position.y())
			if(zonaDeJuego.sePuedeRomper(direccion)){
				const otroFuego = new Fuego(
								position = direccion,
								tamanio = tamanio -1,
								direcciones = [siguienteDireccion]
				)
				otroFuego.generarFuego()
			}
		}
	}
	
	method muere(){}
	method efecto(jugador){}
}
