import wollok.game.*
import bomberman.*
import cajas.*
import rivales.*

object menu{
	var property image = "./imagenes/menu.png"
	var property position = game.origin()
}



object juego {
	
	var estaMenu = true
	var spawnRivales = false
	
	method jugar(){
		game.title("Bomberman")
		game.width(15)
		game.height(15)
		game.boardGround("./imagenes/fondo.png")
		zonaDeJuego.generarMapa()
		zonaDeJuego.generarCajas()
		game.addVisual(menu)
		keyboard.any().onPressDo{self.inicializarJugadores()}
		game.start()
	}
	
	method inicializarJugadores(){
			if(estaMenu){
				game.removeVisual(menu)
				estaMenu = false
				self.jugador1()
				self.jugador2()
			}
			
			if (!spawnRivales) {
                self.inicializarRivales()
                spawnRivales = true
            }
	}
	
	method inicializarRivales(){
		if(!game.hasVisual(menu)){
		const rivales = [new Rival(position = game.at(5,5)),
						new Rival(position = game.at(7,5)),
						new Rival(position = game.at(5,7)),
						new Rival(position = game.at(7,7))
		]
		rivales.forEach{rival => 
			game.addVisual(rival)
			game.onTick(1000, "movimiento", {rival.movimientoAleatorio()})
			}
		}
	}
	
	method jugador1(){
		keyboard.w().onPressDo({jugador1.irArriba()})
		keyboard.s().onPressDo({jugador1.irAbajo()})
		keyboard.a().onPressDo({jugador1.irIzquierda()})
		keyboard.d().onPressDo({jugador1.irDerecha()})
		game.addVisual(jugador1)
		keyboard.space().onPressDo({jugador1.ponerBomba()})
		game.onCollideDo(jugador1,{elemento => elemento.matar(jugador1)})
		game.onCollideDo(jugador1,{powerUp => powerUp.efecto(jugador1)})
	}
	
	method jugador2(){
		keyboard.up().onPressDo({jugador2.irArriba()})
		keyboard.down().onPressDo({jugador2.irAbajo()})
		keyboard.left().onPressDo({jugador2.irIzquierda()})
		keyboard.right().onPressDo({jugador2.irDerecha()})
		game.addVisual(jugador2)
		jugador2.moverse(game.at(13,13))
		keyboard.shift().onPressDo({jugador2.ponerBomba()})
		game.onCollideDo(jugador2,{elemento => elemento.matar(jugador2)})
		game.onCollideDo(jugador2,{powerUp => powerUp.efecto(jugador2)})
	}
	
}

object jugador1 inherits Bombardero{
	override method image(){return "./imagenes/bomberman1.png"}
}

object jugador2 inherits Bombardero{
	override method image(){return "./imagenes/bomberman2.png"}
}


object zonaDeJuego{
	var posicionesOcupadas = []
	var posicionesOcupadasCajas = []
	var posicionesNoRemovibles = []
	
	method agregarPos(posicion){
		posicionesOcupadas.add(posicion)
	}
	
	method sacarPos(posicion){
		posicionesOcupadas.remove(posicion)
	}
	
	method agregarCajaEn(posicion){
		posicionesOcupadasCajas.add(posicion)
	}
	
	method sacarCajaEn(posicion){
		posicionesOcupadasCajas.remove(posicion)
	}
	
	method sePuedeRomper(posicion){
		return !posicionesNoRemovibles.contains(posicion)
	}
	
	method estaOcupada(posicion){
		return posicionesOcupadas.contains(posicion) or 
		posicionesNoRemovibles.contains(posicion) or
		posicionesOcupadasCajas.contains(posicion)
	}
	
	method generarMapa(){
		6.times{ //Agrego bloques fijos en el mapa: una posicion sin bloque, una con
			i => 6.times{
				j => posicionesNoRemovibles.add(game.at(i*2,j*2))
			}
		}
		14.times{ //Agrego paredes del borde de mapa
			i =>
				posicionesNoRemovibles.add(game.at(i,0))
				posicionesNoRemovibles.add(game.at(i,14))
				posicionesNoRemovibles.add(game.at(0,i))
				posicionesNoRemovibles.add(game.at(14,i))
		}
		
	}

	
	method generarCajas(){
		var posDondeNoPuedeAparecer = [	game.at(1,1), game.at(1,2),game.at(2,1),				//Entorno de jugador1
										game.at(13,13), game.at(13,12), game.at(12,13),			//Entorno de jugador2
										game.at(5,5), game.at(5,7), game.at(7,5), game.at(7,7)]	//Posicion de enemigos
		14.times{
			i => 14.times{
				j => var probDeAparecer = 1.randomUpTo(10)
					if(probDeAparecer < 5 && !posicionesNoRemovibles.contains(game.at(i,j)) && !posDondeNoPuedeAparecer.contains(game.at(i,j)))
						new Caja(position = game.at(i,j)).ponerCaja()
			}
		}
	}
}