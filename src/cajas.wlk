import wollok.game.*
import juego.*
import powerups.*

class Caja{
	var property position
	var property image = "./assets/muros/murodestructible.png"
	
	method ponerCaja(){
		game.addVisual(self)
		zonaDeJuego.agregarCajaEn(position)
	}
	
	method muere(){
		game.removeVisual(self)
		self.posibilidadDePowerUp()
	}
	
	method posibilidadDePowerUp(){
		const probabilidad = 1.randomUpTo(10)
		const powerups = [
						new UnaVidaExtra(position = position),
						new UnaBombaExtra(position = position),
						new BombaMasGrande(position = position),
						new BombaAtraviesaParedes(position = position)
		]
		if(probabilidad < 3){
			const powerupAleatorio = powerups.anyOne()
			powerupAleatorio.aparecer()
			}
	}

	method efecto(jugador){}
	
}