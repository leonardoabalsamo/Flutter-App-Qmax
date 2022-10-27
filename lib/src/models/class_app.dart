import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qmax_inst/src/providers/seleccion_provider.dart';
import 'package:qmax_inst/src/providers/dimensionamiento_provider.dart';

import '../models/inversor_model.dart';
import 'bateria_model.dart';

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

class ListaUbicaciones extends StatefulWidget {
  const ListaUbicaciones({Key? key}) : super(key: key);

  @override
  State<ListaUbicaciones> createState() => _ListaUbicaciones();
}

class _ListaUbicaciones extends State<ListaUbicaciones> {
  String? dropdownValue = 'SELECCIONE';
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
                  if (newValue != 'SELECCIONE') {
                    dropdownValue = newValue!;
                    dP.UbicacionSeleccionada = newValue;
                    for (String key in dP.hsSolaresJson.keys) {
                      if (key == dP.UbicacionSeleccionada) {
                        dP.Insolacion = dP.hsSolaresJson[key]?.toDouble();
                      }
                      ;
                    }
                    dP.notificar(context);
                  }
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

//INVERSOR
class ListaInversores extends StatefulWidget {
  const ListaInversores({Key? key}) : super(key: key);

  @override
  State<ListaInversores> createState() => _ListaInversores();
}

class _ListaInversores extends State<ListaInversores> {
  String dropdownValue = 'SELECCIONE';

  @override
  Widget build(BuildContext context) {
    var sP = Provider.of<SeleccionProvider>(context, listen: true);
    var invBusca = Inversor(id: 0, modelo: "", tensionNominal: 0, potencia: 0);
    return DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(color: Colors.black38, width: 3),
            borderRadius: BorderRadius.circular(30),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.57), blurRadius: 5)
            ]),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: DropdownButton<String>(
              underline: SizedBox(),
              style: const TextStyle(fontSize: 20, color: Colors.white),
              value: dropdownValue,
              isDense: true,
              borderRadius: BorderRadius.circular(10),
              onChanged: (String? newValue) {
                setState(() {
                  if (newValue != 'SELECCIONE') {
                    dropdownValue = newValue!;
                    sP.inversor = newValue;
                    sP.setInversor = invBusca.buscaInversor(newValue);
                  }
                });
              },
              items: <String>[
                'SELECCIONE',
                'QM-1212-SPD',
                'QM-2312-SPD',
                'QM-1224-SPD',
                'QM-2324-SPD',
                'QM-1248-SPD',
                'QM-2348-SPD',
                'QM-3524-SPD',
                'QM-4548-SPD'
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
            )));
  }
}

class ListaBaterias extends StatefulWidget {
  const ListaBaterias({Key? key}) : super(key: key);

  @override
  State<ListaBaterias> createState() => _ListaBaterias();
}

class _ListaBaterias extends State<ListaBaterias> {
  String dropdownValue = 'SELECCIONE';

  @override
  Widget build(BuildContext context) {
    var sP = Provider.of<SeleccionProvider>(context, listen: true);

    var buscaBat = Bateria(
        id: 0,
        capacidad: 0,
        flote: 0,
        fondo: 0,
        modelo: "",
        tensionNominal: 0,
        tipo: "");

    return DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(color: Colors.black38, width: 3),
            borderRadius: BorderRadius.circular(30),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.57), blurRadius: 5)
            ]),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: DropdownButton<String>(
              underline: SizedBox(),
              style: const TextStyle(fontSize: 20, color: Colors.white),
              value: dropdownValue,
              isDense: true,
              borderRadius: BorderRadius.circular(10),
              onChanged: (String? newValue) {
                setState(() {
                  if (newValue != 'SELECCIONE') {
                    dropdownValue = newValue!;
                    sP.bateria = newValue;
                    sP.setBateria = buscaBat.buscaBateria(newValue);
                  }
                });
              },
              items: <String>[
                //'SELECCIONE LA BATERIA',
                'SELECCIONE',
                'TROJAN T105',
                'TROJAN T605',
                'TROJAN 27TMX',
                'VISION 6FM200X',
                'VISION 6FM100X',
                'PYLONTECH US2000C',
                'PYLONTECH US3000C',
                'PYLONTECH PHANTOM-S',
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
            )));
  }
}

class ListaTensiones extends StatefulWidget {
  const ListaTensiones({Key? key}) : super(key: key);

  @override
  State<ListaTensiones> createState() => _ListaTensiones();
}

class _ListaTensiones extends State<ListaTensiones> {
  String dropdownValue = 'SELECCIONE';

  @override
  Widget build(BuildContext context) {
    var sP = Provider.of<SeleccionProvider>(context, listen: true);

    return DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(color: Colors.black38, width: 3),
            borderRadius: BorderRadius.circular(30),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.57), blurRadius: 5)
            ]),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: DropdownButton<String>(
              underline: SizedBox(),
              style: const TextStyle(fontSize: 20, color: Colors.white),
              value: dropdownValue,
              isDense: true,
              borderRadius: BorderRadius.circular(10),
              onChanged: (String? newValue) {
                setState(() {
                  if (newValue != 'SELECCIONE') {
                    dropdownValue = newValue!;
                    sP.cantBat = newValue;
                  }
                });
              },
              items: <String>[
                'SELECCIONE',
                '1',
                '2',
                '4',
                '6',
                '8',
                '12',
                '16',
                '32'
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
            )));
    //}
  }
}

//INSTALACION
class ListaTipo extends StatefulWidget {
  const ListaTipo({Key? key}) : super(key: key);

  @override
  State<ListaTipo> createState() => _ListaTipo();
}

class _ListaTipo extends State<ListaTipo> {
  String dropdownValue = 'SELECCIONE';
  @override
  Widget build(BuildContext context) {
    var sP = Provider.of<SeleccionProvider>(context, listen: true);
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
              underline: SizedBox(),
              style: const TextStyle(fontSize: 20, color: Colors.white),
              borderRadius: BorderRadius.circular(10),
              value: dropdownValue,
              isDense: true,
              onChanged: (String? newValue) {
                setState(() {
                  if (newValue != 'SELECCIONE') {
                    dropdownValue = newValue!;
                    sP.tipoInstalacion = newValue;
                    sP.notificar(context);
                  }
                  if (newValue == 'EMBARCACIONES/VEHICULOS') {
                    sP.red = '';
                    sP.tipoSolucion = '';
                  }
                });
              },
              items: <String>[
                //'TIPO DE INSTALACION',
                'SELECCIONE',
                'ESTACIONARIA', 'EMBARCACIONES/VEHICULOS',
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
            )));
  }
}

class ListaRed extends StatefulWidget {
  const ListaRed({Key? key}) : super(key: key);

  @override
  State<ListaRed> createState() => _ListaRed();
}

class _ListaRed extends State<ListaRed> {
  String dropdownValue = 'SELECCIONE';
  @override
  Widget build(BuildContext context) {
    var sP = Provider.of<SeleccionProvider>(context, listen: true);

    return DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(color: Colors.black38, width: 3),
            borderRadius: BorderRadius.circular(30),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.57), blurRadius: 5)
            ]),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: DropdownButton<String>(
              underline: SizedBox(),
              style: const TextStyle(fontSize: 20, color: Colors.white),
              borderRadius: BorderRadius.circular(10),
              value: dropdownValue,
              isDense: true,
              onChanged: (String? newValue) {
                setState(() {
                  if (newValue != 'SELECCIONE') {
                    dropdownValue = newValue!;
                    sP.red = newValue;
                    sP.notificar(context);
                  }
                });
              },
              items: <String>[
                //'RED ELECTRICA',
                'SELECCIONE',
                'SI',
                'NO',
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
            )));
  }
}

class ListaSolucion extends StatefulWidget {
  const ListaSolucion({Key? key}) : super(key: key);

  @override
  State<ListaSolucion> createState() => _ListaSolucion();
}

class _ListaSolucion extends State<ListaSolucion> {
  String dropdownValue = 'SELECCIONE';
  @override
  Widget build(BuildContext context) {
    var sP = Provider.of<SeleccionProvider>(context, listen: true);

    return DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(color: Colors.black38, width: 3),
            borderRadius: BorderRadius.circular(30),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.57), blurRadius: 5)
            ]),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: DropdownButton<String>(
              underline: SizedBox(),
              style: const TextStyle(fontSize: 20, color: Colors.white),
              borderRadius: BorderRadius.circular(10),
              value: dropdownValue,
              isDense: true,
              onChanged: (String? newValue) {
                setState(() {
                  if (newValue != 'SELECCIONE') {
                    dropdownValue = newValue!;
                    sP.tipoSolucion = dropdownValue;
                    sP.notificar(context);
                  }
                });
              },
              items: <String>[
                //'TIPO DE SOLUCION',
                'SELECCIONE',
                'BACKUP',
                'AUTOCONSUMO',
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
            )));
  }
}

//REGULADOR
class ListaCantidadBat extends StatefulWidget {
  const ListaCantidadBat({Key? key}) : super(key: key);

  @override
  State<ListaCantidadBat> createState() => _ListaCantidadBat();
}

class _ListaCantidadBat extends State<ListaCantidadBat> {
  String dropdownValue = 'SELECCIONE';
  @override
  Widget build(BuildContext context) {
    var sP = Provider.of<SeleccionProvider>(context, listen: true);

    return DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(color: Colors.black38, width: 3),
            borderRadius: BorderRadius.circular(30),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.57), blurRadius: 5)
            ]),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: DropdownButton<String>(
              underline: SizedBox(),
              style: const TextStyle(fontSize: 20, color: Colors.white),
              value: dropdownValue,
              isDense: true,
              borderRadius: BorderRadius.circular(10),
              onChanged: (String? newValue) {
                setState(() {
                  if (newValue != 'SELECCIONE') {
                    dropdownValue = newValue!;
                    sP.cantBat = dropdownValue;
                    sP.notificar(context);
                  }
                });
              },
              items: <String>[
                'SELECCIONE',
                '1',
                '2',
                '4',
                '6',
                '8',
                '12',
                '16',
                '32'
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
            )));
  }
}

class ListaNominal extends StatefulWidget {
  const ListaNominal({Key? key}) : super(key: key);

  @override
  State<ListaNominal> createState() => _ListaNominal();
}

class _ListaNominal extends State<ListaNominal> {
  String dropdownValue = 'SELECCIONE';
  @override
  Widget build(BuildContext context) {
    var sP = Provider.of<SeleccionProvider>(context, listen: true);

    return DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(color: Colors.black38, width: 3),
            borderRadius: BorderRadius.circular(30),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.57), blurRadius: 5)
            ]),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: DropdownButton<String>(
              underline: SizedBox(),
              style: const TextStyle(fontSize: 20, color: Colors.white),
              value: dropdownValue,
              isDense: true,
              borderRadius: BorderRadius.circular(10),
              onChanged: (String? newValue) {
                setState(() {
                  if (newValue != 'SELECCIONE') {
                    dropdownValue = newValue!;
                    sP.tensionBanco = dropdownValue;
                    sP.notificar(context);
                  }
                });
              },
              items: <String>[
                'SELECCIONE',
                '12',
                '24',
                '48',
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
            )));
  }
}

class ListaBateriasReg extends StatefulWidget {
  const ListaBateriasReg({Key? key}) : super(key: key);

  @override
  State<ListaBateriasReg> createState() => _ListaBateriasReg();
}

class _ListaBateriasReg extends State<ListaBateriasReg> {
  String dropdownValue = 'SELECCIONE';

  @override
  Widget build(BuildContext context) {
    var sP = Provider.of<SeleccionProvider>(context, listen: true);

    var buscaBat = Bateria(
        id: 0,
        capacidad: 0,
        flote: 0,
        fondo: 0,
        modelo: "",
        tensionNominal: 0,
        tipo: "");

    return DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(color: Colors.black38, width: 3),
            borderRadius: BorderRadius.circular(30),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.57), blurRadius: 5)
            ]),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: DropdownButton<String>(
              underline: SizedBox(),
              style: const TextStyle(fontSize: 20, color: Colors.white),
              value: dropdownValue,
              isDense: true,
              borderRadius: BorderRadius.circular(10),
              onChanged: (String? newValue) {
                setState(() {
                  if (newValue != 'SELECCIONE') {
                    dropdownValue = newValue!;
                    sP.bateria = newValue;
                    sP.setBateria = buscaBat.buscaBateria(newValue);
                    sP.notificar(context);
                  }
                });
              },
              items: <String>[
                //'SELECCIONE LA BATERIA',
                'SELECCIONE',
                'TROJAN T105',
                'TROJAN T605',
                'TROJAN 27TMX',
                'VISION 6FM200X',
                'VISION 6FM100X',
                'PYLONTECH US2000C',
                'PYLONTECH US3000C',
                'PYLONTECH PHANTOM-S',
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
            )));
  }
}
