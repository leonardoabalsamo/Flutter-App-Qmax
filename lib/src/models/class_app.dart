import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:qmax_inst/src/providers/seleccion_provider.dart';
import 'package:qmax_inst/src/providers/dimensionamiento_provider.dart';

import '../models/inversor_model.dart';

class checkGrupo extends StatefulWidget {
  checkGrupo({Key? key}) : super(key: key);

  @override
  State<checkGrupo> createState() => _checkGrupo();
}

class _checkGrupo extends State<checkGrupo> {
  @override
  Widget build(BuildContext context) {
    var dimensionamientoProvider =
        Provider.of<DimensionamientoProvider>(context, listen: true);

    return SwitchListTile(
      title: Text('¿Tiene Grupo?'),
      subtitle: Text('Indique si cuenta con Grupo Electrógeno'),
      value: dimensionamientoProvider.Grupo,
      activeTrackColor: Color.fromARGB(255, 131, 207, 242),
      activeColor: Colors.blue,
      inactiveTrackColor: Colors.grey,
      onChanged: (bool value) {
        setState(() {
          dimensionamientoProvider.Grupo = value;
          dimensionamientoProvider.Grupo = value;
          print(dimensionamientoProvider.Grupo);
          dimensionamientoProvider.notifyListeners();
        });
      },
      secondary: const Icon(Icons.ev_station_rounded),
    );
  }
}

class checkRed extends StatefulWidget {
  checkRed({Key? key}) : super(key: key);

  @override
  State<checkRed> createState() => _checkRed();
}

class _checkRed extends State<checkRed> {
  @override
  Widget build(BuildContext context) {
    var dimensionamientoProvider =
        Provider.of<DimensionamientoProvider>(context, listen: true);

    return SwitchListTile(
      title: Text('¿Tiene Red?'),
      subtitle: Text('Indique si cuenta con Red Eléctrica'),
      value: dimensionamientoProvider.Red,
      activeTrackColor: Color.fromARGB(255, 131, 207, 242),
      activeColor: Colors.blue,
      inactiveTrackColor: Colors.grey,
      onChanged: (bool value) {
        setState(() {
          dimensionamientoProvider.Red = value;
          dimensionamientoProvider.notifyListeners();
        });
      },
      secondary: const Icon(Icons.lightbulb_outline),
    );
  }
}

class slideBarEnergia extends StatefulWidget {
  const slideBarEnergia({Key? key}) : super(key: key);

  @override
  State<slideBarEnergia> createState() => _slideBarEnergia();
}

class _slideBarEnergia extends State<slideBarEnergia> {
  @override
  Widget build(BuildContext context) {
    var dimensionamientoProvider =
        Provider.of<DimensionamientoProvider>(context, listen: true);
    return Column(
      children: [
        Slider(
          activeColor: Colors.blue.shade300,
          inactiveColor: Colors.blue.shade100,
          value: dimensionamientoProvider.valorFactura,
          max: 1000,
          divisions: 20,
          label: dimensionamientoProvider.valorFactura.round().toString(),
          onChanged: (double value) {
            setState(() {
              dimensionamientoProvider.valorFactura = value;
              dimensionamientoProvider.notifyListeners();
            });
          },
        ),
        Text(
          'Valor Seleccionado:  ${dimensionamientoProvider.valorFactura} kWh / Mes',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class ListaConsumos extends StatefulWidget {
  const ListaConsumos({Key? key}) : super(key: key);

  @override
  State<ListaConsumos> createState() => _ListaConsumos();
}

class _ListaConsumos extends State<ListaConsumos> {
  String dropdownValue = 'CONSUMO';

  @override
  Widget build(BuildContext context) {
    var dimensionamientoProvider =
        Provider.of<DimensionamientoProvider>(context, listen: true);
    return DropdownButton<String>(
      style: const TextStyle(fontSize: 20, color: Colors.white),
      value: dropdownValue,
      isDense: true,
      borderRadius: BorderRadius.circular(10),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>[
        'CONSUMO',
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
  String dropdownValue = '1';

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
      items: <String>['1', '2', '3', '4', '5', '6', '7', '8']
          .map<DropdownMenuItem<String>>((String value) {
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

class ListaUbicaciones extends StatefulWidget {
  const ListaUbicaciones({Key? key}) : super(key: key);

  @override
  State<ListaUbicaciones> createState() => _ListaUbicaciones();
}

class _ListaUbicaciones extends State<ListaUbicaciones> {
  String dropdownValue = 'Buenos Aires';
  @override
  Widget build(BuildContext context) {
    var dimensionamientoProvider =
        Provider.of<DimensionamientoProvider>(context, listen: true);

    return DropdownButton<String>(
      style: const TextStyle(
        color: Colors.white,
        leadingDistribution: TextLeadingDistribution.proportional,
        height: 0,
        letterSpacing: 1.0,
      ),
      itemHeight: kMinInteractiveDimension,
      alignment: AlignmentDirectional.center,
      icon: const Icon(
        Icons.arrow_circle_down_sharp,
      ),
      iconSize: 30,
      underline: SizedBox(),
      iconEnabledColor: Colors.white,
      value: dropdownValue,
      isDense: true,
      borderRadius: BorderRadius.circular(10),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          dimensionamientoProvider.UbicacionSeleccionada = newValue;
          for (String key in dimensionamientoProvider.hsSolaresJson.keys) {
            if (key == dimensionamientoProvider.UbicacionSeleccionada) {
              dimensionamientoProvider.Insolacion =
                  dimensionamientoProvider.hsSolaresJson[key]?.toDouble();
            }
            ;
          }
          //dimensionamientoProvider.kitRed();
          dimensionamientoProvider.notifyListeners();
        });
      },
      items: dimensionamientoProvider
              .Ubicaciones //Lista de Ubicaciones (Provincias)
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class ListadoConsumos extends StatefulWidget {
  const ListadoConsumos({Key? key}) : super(key: key);

  @override
  State<ListadoConsumos> createState() => _ListadoConsumos();
}

class _ListadoConsumos extends State<ListadoConsumos> {
  bool? valor = false;
  @override
  Widget build(BuildContext context) {
    var dimensionamientoProvider =
        Provider.of<DimensionamientoProvider>(context, listen: true);
    return CheckboxListTile(
      tileColor: Colors.amber,
      title: const Text('Heladera'),
      value: valor, //timeDilation != 1.0,
      checkColor: Colors.blue,
      selectedTileColor: Colors.blue,
      onChanged: (bool? value) {
        setState(() {
          //timeDilation = value! ? 10.0 : 1.0;
          valor = value;
        });
      },
      secondary: const Icon(Icons.refresh),
    );
  }
}


/*

ListView.builder(
          itemCount: _categories['responseTotalResult'],
          itemBuilder: (BuildContext context, int index) {
            return CheckboxListTile(
              value: _selecteCategorys
                  .contains(_categories['responseBody'][index]['category_id']),
              onChanged: (bool selected) {
                _onCategorySelected(selected,
                    _categories['responseBody'][index]['category_id']);
              },
              title: Text(_categories['responseBody'][index]['category_name']),
            );


*/