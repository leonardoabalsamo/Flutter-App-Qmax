import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qmax_inst/src/providers/dimensionamiento_provider.dart';
import '../models/class_app.dart';

class KitPage extends StatefulWidget {
  const KitPage({
    Key? key,
  }) : super(key: key);

  @override
  _KitPage createState() => _KitPage();
}

class _KitPage extends State<KitPage> {
  @override
  Widget build(BuildContext context) {
    var dimensionamientoProvider =
        Provider.of<DimensionamientoProvider>(context, listen: true);

    var contadorItem = dimensionamientoProvider.texto.length;
    //Tiene datos muestra kits
    return Scaffold(
        body: Center(
          child: ListView(
              padding: const EdgeInsets.all(20.0),
              scrollDirection: Axis.vertical,
              children: dimensionamientoProvider.texto),
        ),
        appBar: dimAppBar());
  }

  AppBar dimAppBar() {
    var dimensionamientoProvider =
        Provider.of<DimensionamientoProvider>(context, listen: true);
    return AppBar(
      title: const Text(
        'DIMENSIONAMIENTO KITPAGE',
        style: TextStyle(fontSize: 12),
      ),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  contentPadding: const EdgeInsets.all(10.0),
                  content: Row(
                    children: const <Widget>[
                      Expanded(
                        child: Text(
                          "El kit recomendado es orientativo. Comunicarse para obtener una cotización final",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                        child: const Text('Continuar'),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.help))
      ],
      leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
            dimensionamientoProvider.texto.clear();
            dimensionamientoProvider.UbicacionSeleccionada = '';
            dimensionamientoProvider.PotenciaPaneles = 0;
            dimensionamientoProvider.BancoBateria = 0;
            dimensionamientoProvider.totalEnergia = 0;
            dimensionamientoProvider.EnergiaDiaria = 0;
            dimensionamientoProvider.valorFactura = 0;
          }),
    );
  }
}
