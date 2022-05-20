import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:qmax_inst/src/providers/seleccion_provider.dart';

import '../models/inversor_model.dart';

class InicioInstaladorPage extends StatefulWidget {
  const InicioInstaladorPage({
    Key? key,
  }) : super(key: key);

  @override
  _InicioPageInstaladorState createState() => _InicioPageInstaladorState();
}

class _InicioPageInstaladorState extends State<InicioInstaladorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.all(30)),
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => const HomePage()));
                },
                child: FittedBox(
                  child: Image.asset(
                    'assets/images/logogris.png',
                    height: 120,
                  ),
                )),
            const SizedBox(
              height: 5,
            ),
            slideBarEnergia(),
            const SizedBox(
              width: 10,
              height: 10,
            ),
            Expanded(
              child: Image.asset(
                'assets/images/logo_consumo_t.png',
                height: 140,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ListaConsumos(),
            Expanded(
              child: Image.asset(
                'assets/images/logo_consumo_t.png',
                height: 140,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ListaCantidad(),
            Expanded(
              child: Image.asset(
                'assets/images/flecha_larga_top.png',
                height: 120,
              ),
            ),
            const Expanded(
              child: SizedBox(
                height: 10,
              ),
            )
          ],
        )),
        appBar: AppBar(
          title: const Text(
            'DIMENSIONAMIENTO',
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
                              "La energía diaria consumida depende de la potencia (W) y tiempo de uso (kWh)",
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
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {},
          label: const Text(
            'Continuar',
          ),
          icon: const Icon(Icons.arrow_forward),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}

Future _showError(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      contentPadding: const EdgeInsets.all(10.0),
      content: Row(
        children: const <Widget>[
          Expanded(
            child: Text(
              "No es posible la combinación indicada. Reintente",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
            child: const Text('Aceptar'),
            onPressed: () {
              Navigator.pop(context);
            }),
      ],
    ),
  );
}

class slideBarEnergia extends StatefulWidget {
  const slideBarEnergia({Key? key}) : super(key: key);

  @override
  State<slideBarEnergia> createState() => _slideBarEnergia();
}

class _slideBarEnergia extends State<slideBarEnergia> {
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _currentSliderValue,
      max: 100,
      divisions: 5,
      label: _currentSliderValue.round().toString(),
      onChanged: (double value) {
        setState(() {
          _currentSliderValue = value;
        });
      },
    );
  }
}

class ListaConsumos extends StatefulWidget {
  const ListaConsumos({Key? key}) : super(key: key);

  @override
  State<ListaConsumos> createState() => _ListaConsumos();
}

class _ListaConsumos extends State<ListaConsumos> {
  String dropdownValue = 'SELECCIONE EL CONSUMO';

  @override
  Widget build(BuildContext context) {
    var seleccionProvider =
        Provider.of<SeleccionProvider>(context, listen: true);
    var invBusca = Inversor(id: 0, modelo: "", tensionNominal: 0, potencia: 0);
    return DropdownButton<String>(
      style: const TextStyle(fontSize: 20, color: Colors.white),
      value: dropdownValue,
      isDense: true,
      borderRadius: BorderRadius.circular(10),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          seleccionProvider.inversor = newValue;
          seleccionProvider.setInversor = invBusca.buscaInversor(newValue);
        });
      },
      items: <String>[
        'SELECCIONE EL CONSUMO',
        'LAMPARA LED',
        'BOMBA 3/4HP',
        'NOTEBOOK',
        'HELADERA',
        'LAVARROPAS',
        'AIRE 2500FG',
        'TV LED',
        'CAFETERA'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: SizedBox(
              child: Text(
            value,
            textAlign: TextAlign.center,
          )),
        );
      }).toList(),
    );
  }
}

class ListaCantidad extends StatefulWidget {
  const ListaCantidad({Key? key}) : super(key: key);

  @override
  State<ListaCantidad> createState() => _ListaCantidad();
}

class _ListaCantidad extends State<ListaCantidad> {
  String dropdownValue = 'SELECCIONE LA CANTIDAD';

  @override
  Widget build(BuildContext context) {
    var seleccionProvider =
        Provider.of<SeleccionProvider>(context, listen: true);
    var invBusca = Inversor(id: 0, modelo: "", tensionNominal: 0, potencia: 0);
    return DropdownButton<String>(
      style: const TextStyle(fontSize: 20, color: Colors.white),
      value: dropdownValue,
      isDense: true,
      borderRadius: BorderRadius.circular(10),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          seleccionProvider.inversor = newValue;
          seleccionProvider.setInversor = invBusca.buscaInversor(newValue);
        });
      },
      items: <String>[
        'SELECCIONE LA CANTIDAD',
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: SizedBox(
              child: Text(
            value,
            textAlign: TextAlign.center,
          )),
        );
      }).toList(),
    );
  }
}
