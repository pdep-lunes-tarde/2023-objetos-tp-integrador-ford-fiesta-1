import wollok.game.*

object tpIntegrador 
{
	method jugar() 
	{
		game.title("Bomber Man")
  		game.height(11)
  		game.width(11)
  		game.boardGround("./imagenes/fondo.jpg")
  		game.addVisualCharacter(bombardero)
  		game.addVisualCharacter(golem)
  		game.addVisualCharacter(magnet)
		game.start()
	}
}

object bombardero
{
	var property enemigo = golem
	var property position = game.origin()
  
  method image() = "./imagenes/bombermanBlanco.png"
}

object golem
{
	var property personajePrincipal = bombardero
 	 var property position = game.origin()
  
  	method image() = "./imagenes/golem.png"
  	method position() = new Position(x = 10, y = 10)
}
object magnet
{
	var property personajePrincipal = bombardero
 	 var property position = game.origin()
  
  	method image() = "./imagenes/magnet.png"
  	method position() = new Position(x = 0, y = 10)
}
