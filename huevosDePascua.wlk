////////////CACERIA//////////////////////////
object ana{
    const property huevosComidos = []

    method comer(unHuevo){huevosComidos.add(unHuevo)}

    method comerVarios(listaHuevos){huevosComidos.addAll(listaHuevos)}

    method comioMucho() = huevosComidos.sum({x=>x.calorias()}) >= 5000

    method comioBlanco() = huevosComidos.map({x=>x.ingredientes()}).flatten().contains(chocolateBlanco)

    method estaEnfermo() = self.comioMucho() or self.comioBlanco()
}

object jose{
    const property huevosComidos = [null]

    method comer(unHuevo){
        huevosComidos.clear()
        huevosComidos.add(unHuevo)
    }

    method comerVarios(listaHuevos){
        huevosComidos.clear()
        huevosComidos.add(listaHuevos.last())
    }

    method estaEnfermo() = huevosComidos.map({x=>x.ingredientes()}).flatten().contains(chocolateAmargo)
}

object tito{
    const property huevosComidos = [null]

    method comer(unHuevo){huevosComidos.add(unHuevo)}

    method comerVarios(listaHuevos){huevosComidos.addAll(listaHuevos)}

    method estaEnfermo() = false
}


object caseria{
    const chicos = #{ana, jose, tito}

    const property huevos = [huevoRepostero, huevoMixto, conejo, blisterHuevitos, matrioshka]

    method huevosPorEncontrar() = huevos.size()

    method cantConBlanco() = self.huevosConChocolateBlanco().size()

    method fueEncontrado(unHuevo) = huevos.contains(unHuevo).negate()

    method comerHuevo(unChico, unHuevo) {
        if(huevos.contains(unHuevo)){
            unChico.comer(unHuevo)
            huevos.remove(unHuevo)
        }
    }

    method comerPrimerHuevo(unChico) {
        if(not huevos.isEmpty()){
            self.comerHuevo(unChico, huevos.first())
            huevos.remove(huevos.first())
        }
    }

    method comerLosRestantes(unChico){
        unChico.comerVarios(huevos)
    }

    method comerLosRestantes2(unChico){
        huevos.forEach({x=>self.comerHuevo(unChico, x)})
    }

    method estaEnfermo(unChico) = unChico.estaEnfermo()

    method huevosConChocolateBlanco() = huevos.filter({x=>x.ingredientes().contains(chocolateBlanco)})

    method masCalorias() = huevos.max({x=>x.calorias()})
}



////////////HUEVOS//////////////////////////

object huevoRepostero {
    const property ingredientes = #{chocolateBlanco}

    method calorias() = 750
}

object huevoMixto {
  const property ingredientes = #{chocolateBlanco, chocolateNegro}

  method calorias() = 900
}

object conejo {
  const property ingredientes = #{chocolateAmargo}

  var property peso = 120

  method calorias() = peso / 10
}

object blisterHuevitos {
  var property cantHuevos = 14

  method cantChoB() = cantHuevos.div(5)

  method ingredientes() {
    if(cantHuevos >= 5){
        return #{chocolateConLeche, chocolateBlanco}
    } else{
        return #{chocolateConLeche}
    }
  }

  method calorias() = (100 * cantHuevos) + (150 * self.cantChoB())
}

object matrioshka {
  method calorias() = 3000 + contiene.calorias() + decoracion.calorias()

  const property ingredientes = #{chocolateAmargo, chocolateConLeche}.addAll(contiene.ingredientes())

  const contiene = blisterHuevitos

  var decoracion = flor
}

////////////INGREDIENTES//////////////////////////

object chocolateBlanco{

}

object chocolateNegro{

}

object chocolateAmargo{

}

object chocolateConLeche{

}

object arbol{
    method calorias() = 150
}

object flor{
    var property cantPetalos = 7

    method calorias() = 100 * cantPetalos
}