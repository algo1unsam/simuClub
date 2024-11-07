object municipio{
	const property clubes = #{}
	const property valorTope = 50000

	method addClub(club) { clubes.add(club) }	

	method club(socio) = clubes.find({club => club.socios().contains(socio)})

	method equiposMismoClub(equipoOrigen, equipoDestino) = clubes.any({club => club.tieneEste(equipoOrigen) and club.tieneEste(equipoDestino)})
	
	method removerDeActividadesYEquiposA(jugador, equipoOrigen) { self.clubQueTiene(equipoOrigen).removerDeTodasLasActividadesAl(jugador)}
	
	method clubQueTiene(equipo) = clubes.find({club => club.actividades().contains(equipo)})
	
	method agregar(jugador, equipoDestino) { equipoDestino.integrantes(jugador)	}
	
	method quitarSocioClub(jugador, equipoOrigen) { self.clubQueTiene(equipoOrigen).remover(jugador)	}
	
	method agregarSocioClub(jugador, equipoDestino) { self.clubQueTiene(equipoDestino).socios(jugador)	}
	
	method esDestacado(jugador, equipoOrigen) = self.clubQueTiene(equipoOrigen).sociosDestacados().contains(jugador)  //method esDestacado(jugador, equipoOrigen) = equipoOrigen.destacado() === jugador
	
	method resetPartidos(jugador) {jugador.partidos(0)}	
}

class Club {
	var property calidad = 0
	const property socios = #{}
	const property actividades = #{}
	var property gastoMensual = 0
//Consultas simples
	method socios(socio){	socios.add(socio)}//if(not municipio.club(socio)) socios.add(socio)	}
   //1.a
	method socios() = socios	 //Saber todos los socios de un club
	//1.b
	method socioMasAntiguo() =	socios.max({socio => socio.antiguedad()})
	//1.c
	method sociosDestacados() = actividades.map({actividad => actividad.destacado()})   //esSocioOrganizador() or socio.esCapitan()})
//Estrella
	//2A
	method esEstrella(socio)
	//2B
	method sociosDestacadosYEstrellas() = self.sociosDestacados().filter({socio => self.esEstrella(socio)})
	
	
	method cantidadActividades(jugador) = actividades.count({actividad => actividad.participa(jugador)})	

	method cantidadDeSocios() = socios.size()
	
	method evaluar() = self.evaluacionBruta() / self.cantidadDeSocios()
	
	method evaluacionBruta() = self.sumaEvaluacionesActividades()
	
	method sumaEvaluacionesActividades() = actividades.sum({actividad => actividad.evaluar()})
	
	method esPrestigioso() = actividades.any({actividad => actividad.prestigiosa()})
	
	method tieneEste(equipo) = actividades.contains(equipo)
	
	method actividadesQueParticipa(socio) = actividades.filter({actividad => actividad.participa(socio)})

	method removerDeTodasLasActividadesAl(socio) {self.actividadesQueParticipa(socio).forEach({actividad => actividad.remover(socio)})}//{ self.actividadesQueParticipa(socio).forEach({actividad => actividad.remover(socio)})}

	method remover(socio) { socios.remove(socio)}
}

class Tradicional inherits Club{
	//2A
	override method esEstrella(jugador) =  jugador.superaValorDePase() or jugador.participaMucho()
	
	//override method evaluacionBruta() = self.sumaEvaluacionesActividades() - gastoMensual
	override method evaluacionBruta() = super() - gastoMensual
	
}
class Comunitario inherits Club{
	//2A
	override method esEstrella(jugador) = jugador.participaMucho()	
	
	//override method evaluacionBruta() = self.sumaEvaluacionesActividades()
}
class Profesional inherits Club{
	override method esEstrella(jugador) = jugador.superaValorDePase()

	//override method evaluacionBruta() = 2 * self.sumaEvaluacionesActividades() - 5 * gastoMensual
	override method evaluacionBruta() = 2 * super() - 5 * gastoMensual
}

class Socio{
	var property antiguedad = 0
	
	method esEstrella() = antiguedad > 20
}

class Jugador inherits Socio{
	var property pase = 0
	var property partidos = 0
	//2A
	override method esEstrella() = partidos >= 50 or self.club().esEstrella(self)
	method superaValorDePase() = pase > municipio.valorTope()
	method participaMucho() = self.cantidadActividades() >= 3
	method cantidadActividades() = self.club().cantidadActividades(self)
	method club() = municipio.club(self)
	
	method esExperimentado() = partidos >= 10
}

class Actividad{
	const property integrantes = #{}
	var property destacado
	
	method integrantes(socio){ integrantes.add(socio) }

	method todos() = integrantes	//todos los jugadores/socios de un equipo 
	
	method participa(socio) = integrantes.contains(socio)
	
	method evaluar()
	
	method prestigiosa()
	
	method remover(socio) { integrantes.remove(socio)}
	
	method cantidadIntegrantesEstrellas() = integrantes.count({integrante => integrante.esEstrella()})
}

class Equipo inherits Actividad {
	
	var property cantidadSanciones = 0
	var property campeonatos = 0
	var property descuento = 20
	
	method evaluar() =  self.puntosPorCampeonatos() + self.puntosPorIntegrantes() + self.puntosPorEstrellaDestacado()
	
	method puntosPorCampeonatos() = campeonatos * 5
	method puntosPorIntegrantes() = 2 * integrantes.size()
	method puntosPorEstrellaDestacado() = (if(self.capitanEsEstrella()) 5 else 0)
	method capitanEsEstrella() =  destacado.esEstrella()
	
	method experimentado() = integrantes.all({integrante => integrante.esExperimentado()})
	
	override method prestigiosa() = self.experimentado()
}

class Futbol inherits Equipo {
	
	override method descuento() = 30
		
	override method evaluar() = super() + 5 * self.cantidadIntegrantesEstrellas()   //.max(0) Si no queremos numeros negativos
	
	//method cantidadDeEstrellasEquipo() = integrantes.count({ jugador => jugador.esEstrella()})
}

class ActividadSocial inherits Actividad{

	var property valor = 0

	override method evaluar() =  valor
	
	override method prestigiosa() = self.cantidadIntegrantesEstrellas() >= 5

	//method muchosParticipantesEstrellas() = integrantes.count({integrante => integrante.esEstrella()}) >= 5
}


