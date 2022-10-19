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
    var dP = Provider.of<DimensionamientoProvider>(context, listen: true);

    return SwitchListTile(
      title: Text('¿Tiene Grupo?'),
      subtitle: Text('Indique si cuenta con Grupo Electrógeno'),
      value: dP.Grupo,
      activeTrackColor: Color.fromARGB(255, 131, 207, 242),
      activeColor: Colors.blue,
      inactiveTrackColor: Colors.grey,
      onChanged: (bool value) {
        setState(() {
          dP.Grupo = value;
          dP.Red = false;
          dP.notificar(context);
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
    var dP = Provider.of<DimensionamientoProvider>(context, listen: true);

    return SwitchListTile(
      title: Text('¿Tiene Red?'),
      subtitle: Text('Indique si cuenta con Red Eléctrica'),
      value: dP.Red,
      activeTrackColor: Color.fromARGB(255, 131, 207, 242),
      activeColor: Colors.blue,
      inactiveTrackColor: Colors.grey,
      onChanged: (bool value) {
        setState(() {
          dP.Red = value;
          dP.Grupo = false;
          dP.notificar(context);
        });
      },
      secondary: const Icon(Icons.lightbulb_outline),
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
  String? dropdownValue = 'Buenos Aires';
  @override
  Widget build(BuildContext context) {
    var dP = Provider.of<DimensionamientoProvider>(context, listen: true);

    return DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.lightBlue,
            border: Border.all(color: Colors.black38, width: 3),
            borderRadius: BorderRadius.circular(30),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.57), blurRadius: 5)
            ]),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: DropdownButton<String>(
              //hint: Center(child: Text('Seleccione la Provincia')),
              style: TextStyle(
                  color: Colors.white,
                  leadingDistribution: TextLeadingDistribution.proportional,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.bold),
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
                  dP.UbicacionSeleccionada = newValue;
                  for (String key in dP.hsSolaresJson.keys) {
                    if (key == dP.UbicacionSeleccionada) {
                      dP.Insolacion = dP.hsSolaresJson[key]?.toDouble();
                    }
                    ;
                  }
                  dP.notificar(context);
                });
              },
              items: dP.Ubicaciones //Lista de Ubicaciones (Provincias)
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
            )));
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
    var dP = Provider.of<DimensionamientoProvider>(context, listen: true);
    return Column(children: [
      Slider(
        activeColor: Colors.blue.shade300,
        inactiveColor: Colors.blue.shade100,
        value: dP.valorFactura,
        max: 1000,
        divisions: 20,
        label: dP.valorFactura.round().toString() + ' kWh',
        onChanged: (double value) {
          setState(() {
            dP.valorFactura = value;
            dP.notificar(context);
          });
        },
      ),
      Text(
        '${dP.valorFactura} kWh / Mes',
        style: TextStyle(fontSize: 18),
      ),
    ]);
  }
}

class slideBarMeta extends StatefulWidget {
  const slideBarMeta({Key? key}) : super(key: key);

  @override
  State<slideBarMeta> createState() => _slideBarMeta();
}

class _slideBarMeta extends State<slideBarMeta> {
  double valor = 10;
  @override
  Widget build(BuildContext context) {
    var dP = Provider.of<DimensionamientoProvider>(context, listen: true);
    return Column(
      children: [
        Slider(
          activeColor: Colors.blue.shade300,
          inactiveColor: Colors.blue.shade100,
          value: valor,
          max: 80,
          divisions: 8,
          label: valor.round().toString() + '%',
          onChanged: (double value) {
            setState(() {
              valor = value;
              dP.meta = value / 100;
              dP.notificar(context);
            });
          },
        ),
        Text(
          '  ${valor} % Ahorro',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

class slideBarPanel extends StatefulWidget {
  const slideBarPanel({Key? key}) : super(key: key);

  @override
  State<slideBarPanel> createState() => _slideBarPanel();
}

class _slideBarPanel extends State<slideBarPanel> {
  double valor = 270;
  @override
  Widget build(BuildContext context) {
    var dP = Provider.of<DimensionamientoProvider>(context, listen: true);
    return Column(
      children: [
        Slider(
          activeColor: Colors.blue.shade300,
          inactiveColor: Colors.blue.shade100,
          value: valor,
          min: 260,
          max: 500,
          divisions: 24,
          label: valor.round().toString() + 'Wp',
          onChanged: (double value) {
            setState(() {
              valor = value;
              dP.PanelSeleccionado = value.toInt();

              dP.notificar(context);
            });
          },
        ),
        Text(
          '  ${valor.toInt()} Wp Panel',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

// class ListaMeta extends StatefulWidget {
//   const ListaMeta({Key? key}) : super(key: key);

//   @override
//   State<ListaMeta> createState() => _ListaMeta();
// }

// class _ListaMeta extends State<ListaMeta> {
//   int dropdownValue = 0;

//   var meta = <int>[0, 10, 20, 30, 40, 50, 60, 70, 80];

//   @override
//   Widget build(BuildContext context) {
//     var dP = Provider.of<DimensionamientoProvider>(context, listen: true);
//     return DropdownButton<int>(
//       style: const TextStyle(fontSize: 20, color: Colors.white),
//       alignment: AlignmentDirectional.centerStart,
//       value: dropdownValue,
//       isDense: true,
//       underline: SizedBox(),
//       icon: Row(children: [
//         const Text(
//           '%',
//           style: TextStyle(fontSize: 20),
//         ),
//         SizedBox(
//           width: 10,
//         ),
//         Icon(
//           Icons.arrow_circle_down_rounded,
//           size: 30,
//         ),
//       ]),
//       borderRadius: BorderRadius.circular(10),
//       onChanged: (int? newValue) {
//         setState(() {
//           dropdownValue = newValue!;
//           //meta seleccionada al provider
//           dP.meta = (newValue / 100).toDouble();
//           dP.notifyListeners();
//         });
//       },
//       items: meta.map<DropdownMenuItem<int>>((int value) {
//         return DropdownMenuItem<int>(
//           value: value,
//           child: SizedBox(
//               child: Text(
//             value.toString(),
//             textAlign: TextAlign.center,
//           )),
//         );
//       }).toList(),
//     );
//   }
// }
