import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/bateria_model.dart';
import '../models/inversor_model.dart';
import '../models/seleccion_model.dart';
import '../providers/seleccion_provider.dart';
import 'inicio_page.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({
    Key? key,
  }) : super(key: key);

  @override
  _ConfigPage createState() => _ConfigPage();
}

class _ConfigPage extends State<ConfigPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var seleccionProvider = Provider.of<SeleccionProvider>(context);

    return Scaffold(
        body: Center(
          child: ListView(children: [
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Image.asset(
                  "assets/images/inv.png",
                  height: 280.0,
                  width: 280.0,
                ),
                SizedBox(
                    height: 600,
                    child: ListView(
                        padding: const EdgeInsets.all(20.0),
                        scrollDirection: Axis.vertical,
                        children: _verificaConfiguracion(
                            seleccionProvider.getInversor(),
                            seleccionProvider.getBateria)))
              ],
            ),
          ]),
        ),
        appBar: AppBar(
          title: const Text(
            'CONFIGURACIÓN RECOMENDADA',
            style: TextStyle(fontSize: 16),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const InicioPage()));
          },
          icon: const Icon(Icons.arrow_back),
          label: const Text('Regresar', style: TextStyle(fontSize: 20.0)),
        ));
  }

  List<Widget> _verificaConfiguracion(Inversor inv, Bateria bat) {
    var retorno = <Widget>[];
    int cant = Seleccion.cantidad;

    num aux, banco, finalbanco;
    aux = inv.tensionNominalInversor / bat.tensionNominalBateria;
    banco = cant / aux;
    finalbanco = bat.capacidadBateria * banco;

    num retornored;
    retornored = (bat.fondo * aux) - 0.3;

    num pasored;
    pasored = (bat.tensionNominalBateria * aux);

    if (Seleccion.tipoInstalacion == "ESTACIONARIA") {
      if (Seleccion.red == "SI") {
        if (Seleccion.tipoSolucion == "BACKUP") {
          retorno.add(const Text("MODO DE FUNCIONAMIENTO:   INVERSOR-CARGADOR ",
              style: TextStyle(color: Colors.white)));
          retorno.add(const Divider());
          retorno.add(const Text("PERFIL DE ENTRADA:   ESTRICTA ",
              style: TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Colors.white,
                  fontSize: 18,
                  leadingDistribution: TextLeadingDistribution.proportional)));
          retorno.add(const Divider());
          retorno.add(Text(
              'CAPACIDAD DEL BANCO:   ' + finalbanco.toString() + ' Ah',
              style: const TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Colors.white,
                  fontSize: 18,
                  leadingDistribution: TextLeadingDistribution.proportional)));
          retorno.add(const Divider());

          retorno.add(Text('PERFIL BATERIA:   ' + bat.modeloBateria,
              style: const TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Colors.white,
                  fontSize: 18,
                  leadingDistribution: TextLeadingDistribution.proportional)));
          retorno.add(const Divider());
        } else {
          retorno.add(const Text("MODO: AUTOCONSUMO ",
              style: TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Colors.white,
                  fontSize: 18,
                  leadingDistribution: TextLeadingDistribution.proportional)));
          retorno.add(const Divider());

          retorno.add(Text(
              "TENSION DE BATERIA DE CIERRE DERIVACION:  " +
                  pasored.toString() +
                  ' V',
              style: const TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Colors.white,
                  fontSize: 18,
                  leadingDistribution: TextLeadingDistribution.proportional)));
          retorno.add(const Divider());

          retorno.add(Text(
              "TENSION DE BATERIA PARA APERTURA DE DERIVACION:  " +
                  retornored.toString() +
                  ' V',
              style: const TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Colors.white,
                  fontSize: 18,
                  leadingDistribution: TextLeadingDistribution.proportional)));
          retorno.add(const Divider());

          retorno.add(const Text("PERFIL DE ENTRADA: ESTRICTA ",
              style: TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Colors.white,
                  fontSize: 18,
                  leadingDistribution: TextLeadingDistribution.proportional)));
          retorno.add(const Divider());

          retorno.add(Text(
              'CAPACIDAD DEL BANCO:  ' + finalbanco.toString() + ' Ah',
              style: const TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Colors.white,
                  fontSize: 18,
                  leadingDistribution: TextLeadingDistribution.proportional)));
          retorno.add(const Divider());

          retorno.add(Text('PERFIL BATERIA:   ' + bat.modeloBateria,
              style: const TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Colors.white,
                  fontSize: 18,
                  leadingDistribution: TextLeadingDistribution.proportional)));
          retorno.add(const Divider());
        }
      } else {
        retorno.add(const Text("MODO: INVERSOR-CARGADOR ",
            style: TextStyle(
                fontFamily: 'Ubuntu',
                color: Colors.white,
                fontSize: 18,
                leadingDistribution: TextLeadingDistribution.proportional)));
        retorno.add(const Divider());

        retorno.add(const Text("PERFIL DE ENTRADA: TOLERANTE ",
            style: TextStyle(
                fontFamily: 'Ubuntu',
                color: Colors.white,
                fontSize: 18,
                leadingDistribution: TextLeadingDistribution.proportional)));
        retorno.add(const Divider());

        retorno.add(Text('PERFIL BATERIA:  ' + bat.modeloBateria + ' Ah',
            style: const TextStyle(
                fontFamily: 'Ubuntu',
                color: Colors.white,
                fontSize: 18,
                leadingDistribution: TextLeadingDistribution.proportional)));
        retorno.add(const Divider());
      }
    } else {
      retorno.add(const Text("MODO: SOLO CARGADOR ",
          style: TextStyle(
              fontFamily: 'Ubuntu',
              color: Colors.white,
              fontSize: 18,
              leadingDistribution: TextLeadingDistribution.proportional)));
      retorno.add(const Divider());

      retorno.add(const Text("PERFIL DE ENTRADA: TOLERANTE ",
          style: TextStyle(
              fontFamily: 'Ubuntu',
              color: Colors.white,
              fontSize: 18,
              leadingDistribution: TextLeadingDistribution.proportional)));
      retorno.add(const Divider());

      retorno.add(Text('PERFIL BATERIA:  ' + bat.modeloBateria + ' Ah',
          style: const TextStyle(
              fontFamily: 'Ubuntu',
              color: Colors.white,
              fontSize: 18,
              leadingDistribution: TextLeadingDistribution.proportional)));
      retorno.add(const Divider());
    }
    return retorno;
  }
}
