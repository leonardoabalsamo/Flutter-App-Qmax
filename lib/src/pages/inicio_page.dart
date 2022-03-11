import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qmax_inst/src/providers/seleccion_provider.dart';
import 'medio_page.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({
    Key? key,
  }) : super(key: key);

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  @override
  Widget build(BuildContext context) {
    var seleccionProvider = Provider.of<SeleccionProvider>(context);
    seleccionProvider.seleccionSeleccionada;
    //final List<Inversor> inv = creaInversores();
    // for (Inversor item in inv) {
    //   DBProvider.db.insertInversor(item);
    // }

    //final List<Bateria> bat = creaBaterias();
    // for (Bateria item in bat) {
    //   DBProvider.db.insertBateria(item);
    // }

    return Scaffold(
      body: Center(
        child: ListView(children: [
          Container(
            padding: const EdgeInsets.all(26.0),
          ),
          Column(
            children: [
              seleccionProvider.listaInversores(),
              Image.asset(
                "assets/images/inv.png",
                height: 200.0,
                width: 200.0,
              ),
              seleccionProvider.listaBaterias(),
              seleccionProvider.listaTensiones(),
              Image.asset(
                "assets/images/bateria.png",
                height: 200.0,
                width: 200.0,
              )
            ],
          ),
        ]),
      ),
      appBar: AppBar(
        title: const Text(
          'Selección de Modelo',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade600,
      ),
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (seleccionProvider.validacion()) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MedioPage()),
            );
          } else {
            await _showError(context);
            // print(seleccionProvider.bateriaSeleccionada.modeloBateria);
            // print(seleccionProvider.inversorSeleccionado.modeloInversor);
            // print(seleccionProvider.cantidadSeleccionada);
          }
        },
        backgroundColor: Colors.blue.shade600,
        label: const Text('Continuar',
            style: TextStyle(color: Colors.white, fontSize: 20.0)),
        icon: const Icon(Icons.arrow_forward),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // Inversor buscaInversor(List<Inversor> array, String? modelo) {
  //   return array.firstWhere((Inversor m) => m.modeloInversor == modelo);
  // }

  // Bateria buscaBateria(List<Bateria> array, String? bateria) {
  //   return array.firstWhere((Bateria b) => b.modeloBateria == bateria);
  // }

  // List<Inversor> creaInversores() {
  //   var inv = <Inversor>[];

  //   /**************Inversores 12V*************/
  //   inv.add(Inversor(1, 'QM-1212-SPD', 12, 1200));
  //   inv.add(Inversor(2, 'QM-2312-SPD', 12, 2300));
  //   /**************Inversores 24v*************/
  //   inv.add(Inversor(3, 'QM-1224-SPD', 24, 1200));
  //   inv.add(Inversor(4, 'QM-2324-SPD', 24, 2300));
  //   inv.add(Inversor(5, 'QM-3524-SPD', 24, 3500));
  //   /**************Inversores 48V*************/
  //   inv.add(Inversor(6, 'QM-1248-SPD', 48, 1200));
  //   inv.add(Inversor(7, 'QM-2348-SPD', 48, 2300));
  //   inv.add(Inversor(8, 'QM-4548-SPD', 48, 4500));

  //   return inv;
  // }

  // List<Bateria> creaBaterias() {
  //   var bat = <Bateria>[];

  //   bat.add(Bateria(
  //       id: 1,
  //       tipo: 'PLOMO ACIDO ',
  //       modelo: 'TROJAN T105',
  //       fondo: 7.25,
  //       flote: 6.8,
  //       capacidad: 225,
  //       tensionNominal: 6));
  //   bat.add(Bateria(
  //       id: 2,
  //       tipo: 'PLOMO ACIDO ',
  //       modelo: 'TROJAN T605',
  //       fondo: 7.25,
  //       flote: 6.8,
  //       capacidad: 210,
  //       tensionNominal: 6));
  //   bat.add(Bateria(
  //       id: 3,
  //       tipo: 'AGM',
  //       modelo: 'VISION 6FM100X',
  //       fondo: 7.25,
  //       flote: 6.8,
  //       capacidad: 100,
  //       tensionNominal: 12));
  //   bat.add(Bateria(
  //       id: 4,
  //       tipo: 'AGM',
  //       modelo: 'VISION 6FM200X',
  //       fondo: 7.25,
  //       flote: 6.8,
  //       capacidad: 200,
  //       tensionNominal: 12));

  //   return bat;
  // }

  Future _showError(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.all(13.0),
        content: Row(
          children: const <Widget>[
            Expanded(
              child: Text(
                "No es posible la combinación. Reintente",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
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
}

// class ListaInversores extends StatefulWidget {
//   const ListaInversores({Key? key}) : super(key: key);

//   @override
//   State<ListaInversores> createState() => _ListaInversores();
// }

// class _ListaInversores extends State<ListaInversores> {
//   String dropdownValue = 'SELECCIONE EL INVERSOR';

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       dropdownColor: Colors.black,
//       value: dropdownValue,
//       icon: const Icon(Icons.arrow_downward),
//       elevation: 16,
//       style: const TextStyle(
//         color: Colors.white,
//         backgroundColor: Colors.white,
//       ),
//       underline: Container(
//         height: 2,
//         color: Colors.blue.shade600,
//       ),
//       onChanged: (String? newValue) {
//         setState(() {
//           dropdownValue = newValue!;
//           Estatica.seleccionInversor = dropdownValue;
//         });
//       },
//       items: <String>[
//         'SELECCIONE EL INVERSOR',
//         'QM-1212-SPD',
//         'QM-2312-SPD',
//         'QM-1224-SPD',
//         'QM-2324-SPD',
//         'QM-1248-SPD',
//         'QM-2348-SPD',
//         'QM-3524-SPD',
//         'QM-4548-SPD'
//       ].map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Column(
//             children: [
//               Text(
//                 value,
//                 style: TextStyle(
//                     leadingDistribution: TextLeadingDistribution.even,
//                     color: Colors.white.withOpacity(0.8),
//                     backgroundColor: Colors.black,
//                     fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }
// }

// class ListaBaterias extends StatefulWidget {
//   const ListaBaterias({Key? key}) : super(key: key);

//   @override
//   State<ListaBaterias> createState() => _ListaBaterias();
// }

// class _ListaBaterias extends State<ListaBaterias> {
//   String dropdownValue = 'SELECCIONE LA BATERIA';
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       dropdownColor: Colors.black,
//       value: dropdownValue,
//       icon: const Icon(Icons.arrow_downward),
//       elevation: 16,
//       style: const TextStyle(
//         color: Colors.white,
//       ),
//       underline: Container(
//         height: 2,
//         color: Colors.black,
//       ),
//       onChanged: (String? newValue) {
//         setState(() {
//           dropdownValue = newValue!;
//           Estatica.seleccionBateria = newValue;
//         });
//       },
//       items: <String>[
//         'SELECCIONE LA BATERIA',
//         'TROJAN T105',
//         'TROJAN T605',
//         'VISION 6FM200X',
//         'VISION 6FM100X',
//       ].map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Column(
//             children: [
//               Text(
//                 value,
//                 style: TextStyle(
//                     leadingDistribution: TextLeadingDistribution.even,
//                     color: Colors.white.withOpacity(0.8),
//                     backgroundColor: Colors.black,
//                     fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }
// }

// class ListaTensiones extends StatefulWidget {
//   const ListaTensiones({Key? key}) : super(key: key);

//   @override
//   State<ListaTensiones> createState() => _ListaTensiones();
// }

// class _ListaTensiones extends State<ListaTensiones> {
//   final seleccionProvider = Provider.of<SeleccionProvider>;
//   String dropdownValue = 'SELECCIONE LA CANTIDAD';
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       dropdownColor: Colors.black,
//       value: dropdownValue,
//       icon: const Icon(Icons.arrow_downward),
//       elevation: 16,
//       style: const TextStyle(
//         color: Colors.white,
//         backgroundColor: Colors.white,
//       ),
//       underline: Container(
//         height: 2,
//         color: Colors.black,
//       ),
//       onChanged: (String? newValue) {
//         setState(() {
//           dropdownValue = newValue!;
//           Estatica.seleccionCantidad = dropdownValue;
//         });
//       },
//       items: <String>[
//         'SELECCIONE LA CANTIDAD',
//         '1',
//         '2',
//         '4',
//         '6',
//         '8',
//         '12',
//         '16',
//         '32'
//       ].map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Column(
//             children: [
//               Text(
//                 value,
//                 style: TextStyle(
//                     leadingDistribution: TextLeadingDistribution.even,
//                     color: Colors.white.withOpacity(0.8),
//                     backgroundColor: Colors.black,
//                     fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }
// }
