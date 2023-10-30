import wollok.game.*
import bombas.*
import juego.*
import menues.*

class Bombardero
{
	var property vidas = 3
	var property position
	var property image
	var property capacidadDeBombas = 1
	var property bombas = []
	var property tamanioDeBomba = 1
	const posicionInicial = position
	var property estaVivo = true
	const num
	const posVidas
	var bombasAtraviesanParedes = false
	
	method iniciarPropiedades(){
		vidas = 3
		capacidadDeBombas = 1
		tamanioDeBomba = 1
		estaVivo = true
		position = posicionInicial
	}	
	
	method irArriba(){
		self.moverse(position.up(1))
		image = "./assets/bomberman"+ num + "/bomberman"+ num + "dorso.png"
	}
	
	method irAbajo(){
		self.moverse(position.down(1))
		image = "./assets/bomberman"+ num + "/bomberman"+ num + "frente.png"
	}
	method irDerecha(){
		self.moverse(position.right(1))
		image = "./assets/bomberman"+ num + "/bomberman"+ num + "derecha.png"
	}
	method irIzquierda(){
		self.moverse(position.left(1))
		image = "./assets/bomberman"+ num + "/bomberman"+ num + "izquierda.png"
	}
	
	method moverse(posicion){
		if(!zonaDeJuego.estaOcupada(posicion))
			position = posicion
	}
	
	method ponerBomba(){
		if(!zonaDeJuego.estaOcupada(position) && bombas.size() < capacidadDeBombas && estaVivo){
			game.sound("./assets/sounds/place-bomb.mp3").play()
			const bomba = new Bomba(position = position, bombardero = self, tamanio = tamanioDeBomba, atraviesanParedes = bombasAtraviesanParedes)
			bombas.add(bomba)
			bomba.colocarBomba()
		}
	}
	
	method sacarBomba(bomb){
		bombas.remove(bomb)
	}
	
	method muere(){
		if(self.vidas() > 1){
			vidas = vidas -1
			game.removeVisual(self)
			estaVivo = false
			game.schedule(1000, {
				game.addVisual(self)
				position = posicionInicial
				estaVivo = true
			})
			}
		else{
			vidas = 0
			juego.jugadores().remove(self)
			game.removeVisual(self)
			estaVivo = false
			game.schedule(500, {menuperdiste.mostrar()})
			}
		self.muestraVida()
	}
	
	method vidaExtra(){
		if(vidas < 5)
			vidas++
		self.muestraVida()
	}

	method muestraVida(){
		const vidasAMostrar = new MostrarVidas(
			position = posVidas,
			image = "./assets/corazones/" + self.vidas().toString() + "corazones.png"
		)
		game.addVisual(vidasAMostrar)
	}

	method bombaAtraviesaParedes(){bombasAtraviesanParedes = true}
	method bombaExtra(){capacidadDeBombas = 2}
	method bombaMasGrande(){tamanioDeBomba = 2}
	method efecto(a){}
	method matar(a){
		const frases = ["Hola!", "Tengo "+ self.vidas() +" vidas!","Movete!", "Quedan "+ juego.rivales().size() + "rivales."]
		const frase = frases.anyOne()
		game.say(self,frase)
	}
}


class MostrarVidas{
	var property position
	var property image
}