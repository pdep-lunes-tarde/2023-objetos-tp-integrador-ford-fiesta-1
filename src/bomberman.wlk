import wollok.game.*
import bombas.*
import juego.*

class Bombardero
{
	var property vidas = 3
	var property position
	var property image
	var property capacidadDeBombas = 1
	var property bombas = []
	var property tamanioDeBomba = 1
	const posicionInicial = position
	
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
			var bomba = new Bomba(position = position, bombardero = self, tamanio = tamanioDeBomba)
			bombas.add(bomba)
			bomba.colocarBomba()
		}
	}
	
	method sacarBomba(bomb){
		bombas.remove(bomb)
	}
	
	method muere(){
		if(self.vidas() > 0){
			position = posicionInicial
			vidas = vidas -1
			}
		else
			game.removeVisual(self)
	}
	
	
	method vidaExtra(){
		if(vidas < 5)
			vidas++
	}
	method bombaExtra(){capacidadDeBombas = 2}
	method bombaMasGrande(){tamanioDeBomba = 2}
	
}
