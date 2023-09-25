import wollok.game.*

class Bomba
{
	var property position
	var property image = "./imagenes/bomb.png"
	
	method colocar(posicion){
		position = posicion		
	}
	
	method colisionarCon(rival){
		
	}
	
	method explota(){
		image = "./imagenes/fuego.png"
	}
}
