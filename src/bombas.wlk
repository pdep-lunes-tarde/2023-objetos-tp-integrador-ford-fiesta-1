import wollok.game.*
import juego.*
import cajas.*

class Bomba
{
	var property position
	var bombardero
	var tamanio
	var atraviesanParedes
	var property image = "./assets/bombas/bombachica.png"
	
	method colocarBomba(){
		game.addVisual(self)
		game.schedule(800, {image ="./assets/bombas/bombamediana.png"})
		game.schedule(1700, {image ="./assets/bombas/bombagrande.png"})
		game.schedule(2500,{self.eliminar() game.sound("./assets/sounds/bomb-explodes.mp3").play()})
		zonaDeJuego.agregarPos(position)
	}
	
	method explota(){
		bombardero.sacarBomba(self)
		self.aparecerFuego()
	}
	
	method eliminar(){
		zonaDeJuego.sacarPos(position)
		game.removeVisual(self)
		self.explota()
	}
	
	method aparecerFuego(){
		const fuego = new Fuego(position = position,
								tamanio = tamanio,
								direcciones = [position.down(1), position.up(1), position.left(1), position.right(1)],
								atraviesanParedes = atraviesanParedes
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
	var property image = "./assets/fuegos/fuego.png"
	var property direcciones
	var atraviesanParedes
	
	method generarFuego(){
		game.addVisual(self)
		game.schedule(600, {game.removeVisual(self)})
		if(tamanio > 0)
			self.expandirse()
		game.onCollideDo(self, {algo => algo.muere()})
	}
	
	method matar(algo){
		algo.muere()
	}
	
	method puedeExpandirse(posicion){
		if(zonaDeJuego.sePuedeRomper(posicion))
			position = posicion
	}
	
	method expandirse(){
		direcciones.forEach{
			direccion =>
			const siguienteDireccionX = (2 * direccion.x()) - position.x()
			const siguienteDireccionY = (2 * direccion.y()) - position.y()
			const siguienteDireccion = game.at(siguienteDireccionX,siguienteDireccionY)
			
			// Inicio calaculo de imagen para animacion
			var imagen
			var auxiliar = ""
			var direc
			
			if(tamanio == 1){auxiliar = "fin"}
			
			if (siguienteDireccionX == position.x()){
				if (siguienteDireccionY > position.y()) direc = "arriba"
				else direc = "abajo"
			}
			if (siguienteDireccionY == position.y()){
				if(siguienteDireccionX > position.x()) direc = "derecha"
				else direc = "izquierda"
			}
			
			imagen = "./assets/fuegos/fuego" + direc + auxiliar + ".png"
			// Fin de calculo de imagen para animacion
			
			var nuevotamanio = tamanio -1
			
			if(zonaDeJuego.sePuedeRomper(direccion)){
				if(!atraviesanParedes && zonaDeJuego.posicionesOcupadasCajas().contains(direccion)){nuevotamanio = 0}
				const otroFuego = new Fuego(
								position = direccion,
								tamanio = nuevotamanio,
								direcciones = [siguienteDireccion],
								image = imagen, // Indico la imagen que calcule antes
								atraviesanParedes = atraviesanParedes
				)
				otroFuego.generarFuego()
			}
		}
	}
	
	method muere(){}
	method efecto(jugador){}
}
