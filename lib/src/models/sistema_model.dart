import 'bateria_model.dart';
import 'inversor_model.dart';

class Sistema {
  final _listaBateria = <Bateria>[];
  final _listaInversor = <Inversor>[];
  var _listaCantidad = <int>[];

  Sistema() {
    /*Creamos las baterías*/
    _listaBateria.add(Bateria("PbAcido", "TROJAN T105", 7.41, 6.75, 225, 6));
    _listaBateria.add(Bateria("PbAcido", "TROJAN T605", 7.41, 6.75, 225, 6));
    _listaBateria.add(Bateria("AGM", "Vision 6FM200X", 14.7, 13.6, 200, 12));
    _listaBateria.add(Bateria("AGM", "Vision 6FM100X", 14.7, 13.6, 200, 12));

    /*Creamos los inversores*/
    _listaInversor.add(Inversor("QM-1212-SPD", 12, 1200));
    _listaInversor.add(Inversor("QM-2312-SPD", 12, 2300));
    _listaInversor.add(Inversor("QM-1224-SPD", 24, 1200));
    _listaInversor.add(Inversor("QM-2324-SPD", 24, 2300));
    _listaInversor.add(Inversor("QM-1248-SPD", 48, 1200));
    _listaInversor.add(Inversor("QM-2348-SPD", 48, 2300));
    _listaInversor.add(Inversor("QM-3524-SPD", 24, 3500));
    _listaInversor.add(Inversor("QM-4548-SPD", 48, 4500));

    _listaCantidad = [1, 2, 4, 6, 8, 12, 16, 32];
  }

  // metodo para cargar una nueva instancia de baterias
  void cargaNuevaBateria(String tipo, String modelo, double fondo, double flote,
      int capacidad, int nominal) {
    _listaBateria.add(Bateria(tipo, modelo, fondo, flote, capacidad, nominal));
  }

  // metodo para cargar una nueva instancia de inversores
  void cargaNuevoInversor(String modelo, int nominal, int potencia) {
    _listaInversor.add(Inversor(modelo, nominal, potencia));
  }

  List<int> cargaTensiones() {
    final listaTension = <int>[];

    for (var item in _listaCantidad) {
      listaTension.add(item);
    }

    return listaTension;
  }

  List<String> cargaInversores() {
    final modelos = <String>[];

    for (var item in _listaInversor) {
      modelos.add(item.modeloInversor);
    }

    return modelos;
  }

  List<String> cargaBaterias() {
    final modelos = <String>[];

    for (var item in _listaBateria) {
      modelos.add(item.modeloBateria);
    }
    return modelos;
  }

  /* Metodo que recibe un string y retorna el inversor*/
  Inversor verificaInversor(String inv) {
    Inversor aux = Inversor("", 0, 0);
    for (var item in _listaInversor) {
      if (inv == item.modeloInversor) {
        aux = item; // retorno el inversor
      }
    }
    return aux;
  }

  /* Metodo que recibe un string y retorna la batería */
  Bateria verificaBateria(String bat) {
    Bateria aux = Bateria("", "", 0, 0, 0, 0);
    for (var item in _listaBateria) {
      if (bat == item.modeloBateria) {
        aux = item; // retorno la bateria
      }
    }
    return aux;
  }
}
