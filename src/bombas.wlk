import wollok.game.*
import juego.*
import cajas.*

class Bomba
{
	var property position
	var bombardero
	var tamanio
	var property image = "./assets/bombas/bombachica.png"
	
	method colocarBomba(){
		game.addVisual(self)
		game.onTick(800,"bomba mediana", {image ="./assets/bombas/bombamediana.png"})
		game.onTick(1700,"bomba grande", {image ="./assets/bombas/bombagrande.png"})
		game.onTick(2500,"aparece la bomba y desaparece a los 2,5 seg" ,{self.eliminar()})
		zonaDeJuego.agregarPos(position)
	}
	
	method explota(){
		bombardero.sacarBomba(self)
		self.aparecerFuego()
	}
	
	method eliminar(){
		zonaDeJuego.sacarPos(position)
		game.removeTickEvent("aparece la bomba y desaparece a los 2,5 seg")
		game.removeTickEvent("bomba mediana")
		game.removeTickEvent("bomba grande")
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
	var property image = "./assets/fuegos/fuego.png"
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
			
			// Claculo de imagen para animacion
			var imagen
			//TAMANIO DE FUEGO 1
			if(tamanio == 1){
				if ((2 * direccion.x()) - position.x() == position.x() && (2 * direccion.y()) - position.y() > position.y())
					imagen = "./assets/fuegos/fuegoarribafin.png"
				if ((2 * direccion.x()) - position.x() == position.x() && (2 * direccion.y()) - position.y() < position.y())
					imagen = "./assets/fuegos/fuegoabajofin.png"
				if ((2 * direccion.x()) - position.x() > position.x() && (2 * direccion.y()) - position.y() == position.y())
					imagen = "./assets/fuegos/fuegoderechafin.png"
				if ((2 * direccion.x()) - position.x() < position.x() && (2 * direccion.y()) - position.y() == position.y())
					imagen = "./assets/fuegos/fuegoizquierdafin.png"
			}
			//TAMANIO DE FUEGO 2
			if(tamanio == 2){
				if ((2 * direccion.x()) - position.x() == position.x() && (2 * direccion.y()) - position.y() > position.y())
					imagen = "./assets/fuegos/fuegoarriba.png"
				if ((2 * direccion.x()) - position.x() == position.x() && (2 * direccion.y()) - position.y() < position.y())
					imagen = "./assets/fuegos/fuegoabajo.png"
				if ((2 * direccion.x()) - position.x() > position.x() && (2 * direccion.y()) - position.y() == position.y())
					imagen = "./assets/fuegos/fuegoderecha.png"
				if ((2 * direccion.x()) - position.x() < position.x() && (2 * direccion.y()) - position.y() == position.y())
					imagen = "./assets/fuegos/fuegoizquierda.png"
			}
			// Fin de calculo de imagen para animacion
			
			if(zonaDeJuego.sePuedeRomper(direccion)){
				const otroFuego = new Fuego(
								position = direccion,
								tamanio = tamanio -1,
								direcciones = [siguienteDireccion],
								image = imagen // Indico la imagen que calcule antes
				)
				otroFuego.generarFuego()
			}
		}
	}
	
	method muere(){}
	method efecto(jugador){}
}
