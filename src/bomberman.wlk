import wollok.game.*
import bombas.*
import juego.*

class Bombardero
{
	var property position = game.at(1,1)
	var capacidadDeBombas = 1
	var bombas = []
	
	method irArriba(){
		self.moverse(position.up(1))
	}
	
	method irAbajo(){
		self.moverse(position.down(1))
	}
	method irDerecha(){
		self.moverse(position.right(1))
	}
	method irIzquierda(){
		self.moverse(position.left(1))
	}
	
	method moverse(posicion){
		if(!zonaDeJuego.estaOcupada(posicion))
			position = posicion
	}
	
	method ponerBomba(){
		if(!zonaDeJuego.estaOcupada(position) && bombas.size() < capacidadDeBombas){
			var bomba = new Bomba(position = position, bombardero = self)
			bombas.add(bomba)
			bomba.colocarBomba()
		}
	}
	
	method sacarBomba(bomb){
		bombas.remove(bomb)
	}
	
	method muere(){
		game.removeVisual(self)
	}
	
	
	method image()
	
}
