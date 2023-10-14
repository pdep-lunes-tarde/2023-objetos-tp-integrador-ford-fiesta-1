import wollok.game.*
import bomberman.*
import cajas.*
import rivales.*
import menues.*

object juego {
	
	const musicamenu = game.sound("./assets/sounds/music-menu.mp3")
	var estaMenu = true
	var spawnRivales = false
	var property rivales = [new Rival(position = game.at(5,5)),
						new Rival(position = game.at(7,5)),
						new Rival(position = game.at(5,7)),
						new Rival(position = game.at(7,7)),
						boss
		]
	
	method inicializar(){
		game.addVisual(background)
		zonaDeJuego.generarMapa()
		zonaDeJuego.generarCajas()
		game.addVisual(menu)
//		game.onTick(500, "animacion menu" ,{menu.animar()})
		if(estaMenu){
			keyboard.up().onPressDo({menu.arriba()})
			keyboard.down().onPressDo({menu.abajo()})
		}
		keyboard.enter().onPressDo{self.inicializarJugadores()}
	}
	
	method reiniciar(){
		estaMenu = true
    	spawnRivales = false
    	rivales = [new Rival(position = game.at(5,5)),
						new Rival(position = game.at(7,5)),
						new Rival(position = game.at(5,7)),
						new Rival(position = game.at(7,7)),
						boss
		]
    	
    	zonaDeJuego.reiniciarPosiciones()
		self.inicializar()
	}
	
	method jugar(){
		game.title("Bomberman")
		game.width(15)
		game.height(15)
		self.inicializar()
		game.schedule(500, {musicamenu.play()})
		game.start()
	}
	
	method inicializarJugadores(){
			if(estaMenu){
				if(!musicamenu.paused())
					musicamenu.pause()
				game.sound("./assets/sounds/stage-start.mp3").play()
				game.removeVisual(menu)
				estaMenu = false
				if(menu.seleccion() == 0)
					self.jugador1()
				if(menu.seleccion() == 1){
					self.jugador1()
					self.jugador2()
				}
				if(menu.seleccion() == 2)
					game.stop()
			}
			
			if (!spawnRivales) {
                self.inicializarRivales()
                spawnRivales = true
            }
	}
	
	method inicializarRivales(){
		if(!game.hasVisual(menu)){
		rivales.forEach{rival => 
			game.addVisual(rival)
			game.onTick(1000, "movimiento", {rival.movimientoAleatorio()})
			}
			boss.muestraVida()
		}
	}
	
	method jugador1(){
		keyboard.w().onPressDo({jugador1.irArriba()})
		keyboard.s().onPressDo({jugador1.irAbajo()})
		keyboard.a().onPressDo({jugador1.irIzquierda()})
		keyboard.d().onPressDo({jugador1.irDerecha()})
		game.addVisual(jugador1)
		jugador1.iniciarPropiedades()
		jugador1.muestraVida()
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
		jugador2.iniciarPropiedades()
		jugador2.muestraVida()
		keyboard.shift().onPressDo({jugador2.ponerBomba()})
		game.onCollideDo(jugador2,{elemento => elemento.matar(jugador2)})
		game.onCollideDo(jugador2,{powerUp => powerUp.efecto(jugador2)})
	}
	
}


object jugador1 inherits Bombardero (position = game.at(1,1), image = "./assets/bomberman1/bomberman1frente.png"){
	override method muestraVida(){
		const vidasAMostrar = new MostrarVidas(
			position = game.at(2,14),
			image = "./assets/corazones/" + self.vidas().toString() + "corazones.png"
		)
		game.addVisual(vidasAMostrar)
	}
	
	override method irDerecha(){super() image = "./assets/bomberman1/bomberman1derecha.png"}
	override method irIzquierda(){super() image = "./assets/bomberman1/bomberman1izquierda.png"}
	override method irAbajo(){super() image = "./assets/bomberman1/bomberman1frente.png"}
	override method irArriba(){super() image = "./assets/bomberman1/bomberman1dorso.png"}
}

object jugador2 inherits Bombardero (position = game.at(13,13), image = "./assets/bomberman2/bomberman2frente.png"){
	override method muestraVida(){
		const vidasAMostrar = new MostrarVidas(
			position = game.at(9,14),
			image = "./assets/corazones/" + self.vidas().toString() + "corazones.png"
		)
		game.addVisual(vidasAMostrar)
	}
	override method irDerecha(){super() image = "./assets/bomberman2/bomberman2derecha.png"}
	override method irIzquierda(){super() image = "./assets/bomberman2/bomberman2izquierda.png"}
	override method irAbajo(){super() image = "./assets/bomberman2/bomberman2frente.png"}
	override method irArriba(){super() image = "./assets/bomberman2/bomberman2dorso.png"}
}

object zonaDeJuego{
	var property posicionesOcupadas = []
	var property posicionesOcupadasCajas = []
	var property posicionesNoRemovibles = []
	
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
	
	method reiniciarPosiciones(){
		posicionesOcupadas = []
		posicionesOcupadasCajas = []
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
		const posDondeNoPuedeAparecer = [game.at(1,1), game.at(1,2),game.at(2,1),				//Entorno de jugador1
										game.at(13,13), game.at(13,12), game.at(12,13),			//Entorno de jugador2
										game.at(5,5), game.at(5,7), game.at(7,5), game.at(7,7)]	//Posicion de enemigos
		14.times{
			i => 14.times{
				j => const probDeAparecer = 1.randomUpTo(10)
					if(probDeAparecer < 5 && !posicionesNoRemovibles.contains(game.at(i,j)) && !posDondeNoPuedeAparecer.contains(game.at(i,j)))
						new Caja(position = game.at(i,j)).ponerCaja()
			}
		}
	}
}