import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qmax_inst/src/widgets/error_combinacion.dart';
import '../providers/seleccion_provider.dart';
import 'config_page.dart';

class MedioPage extends StatefulWidget {
  const MedioPage({
    Key? key,
  }) : super(key: key);

  @override
  _MedioPage createState() => _MedioPage();
}

class _MedioPage extends State<MedioPage> {
  @override
  Widget build(BuildContext context) {
    var seleccionProvider =
        Provider.of<SeleccionProvider>(context, listen: true);
    if (seleccionProvider.tipoInstalacion != 'TIPO DE INSTALACION') {
      //Indica que el usuario realizó una selección

      if (seleccionProvider.red != 'RED ELECTRICA') {
        //Indica que el usuario realizó una selección
        return verificaRed(context);
      } else {
        return Scaffold(
          body: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                const ListaTipo(),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                    child: Image.asset(
                  "assets/images/instalacion.png",
                )),
                const SizedBox(
                  height: 5,
                ),
                const ListaRed(),
                Expanded(
                    child: Image.asset(
                  "assets/images/inversor_iq.png",
                )),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                    child: Image.asset(
                  "assets/images/logo_bateria_t.png",
                )),
                const SizedBox(
                  height: 55,
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: const Text('SOLUCION PLANTEADA',
                style: TextStyle(fontSize: 12)),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              bool check = validaInst();
              if (check == true) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ConfigPage()),
                );
              } else {
                showError(context);
              }
            },
            label: const Text('Obtener Configuración'),
            icon: const Icon(Icons.arrow_forward),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      }
    } else {
      return Scaffold(
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              const ListaTipo(),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                  child: Image.asset(
                "assets/images/instalacion.png",
              )),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                  child: Image.asset(
                "assets/images/inversor_iq.png",
              )),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                  child: Image.asset(
                "assets/images/logo_bateria_t.png",
              )),
              const SizedBox(
                height: 55,
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title:
              const Text('SOLUCION PLANTEADA', style: TextStyle(fontSize: 12)),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            bool check = validaInst();
            if (check == true) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ConfigPage()),
              );
            } else {
              showError(context);
            }
          },
          label: const Text('Obtener Configuración'),
          icon: const Icon(Icons.arrow_forward),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    }
  }

  bool validaInst() {
    bool check = true;

    var seleccionProvider =
        Provider.of<SeleccionProvider>(context, listen: false);

    switch (seleccionProvider.tipoInstalacion) {
      case 'ESTACIONARIA':
        switch (seleccionProvider.red) {
          case 'SI':
            switch (seleccionProvider.tipoSolucion) {
              case 'BACKUP':
                return check;
              case 'AUTOCONSUMO':
                return check;
              default:
                check = false;
                return check;
            }
          case 'NO':
            return check;
          default:
            check = false;
            return check;
        }
      case 'VEHICULOS':
        return check;
      default:
        check = false;
        return check;
    }
  }

  Scaffold verificaRed(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            const ListaTipo(),
            const SizedBox(
              height: 5,
            ),
            Expanded(
                child: Image.asset(
              "assets/images/instalacion.png",
            )),
            const SizedBox(
              height: 5,
            ),
            const ListaRed(),
            Expanded(
                child: Image.asset(
              "assets/images/inversor_iq.png",
            )),
            const ListaSolucion(),
            const SizedBox(
              height: 5,
            ),
            Expanded(
                child: Image.asset(
              "assets/images/logo_bateria_t.png",
            )),
            const SizedBox(
              height: 55,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('SOLUCION PLANTEADA', style: TextStyle(fontSize: 12)),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          bool check = validaInst();
          if (check == true) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ConfigPage()),
            );
          } else {
            showError(context);
          }
        },
        label: const Text('Obtener Configuración'),
        icon: const Icon(Icons.arrow_forward),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class ListaTipo extends StatefulWidget {
  const ListaTipo({Key? key}) : super(key: key);

  @override
  State<ListaTipo> createState() => _ListaTipo();
}

class _ListaTipo extends State<ListaTipo> {
  String dropdownValue = 'TIPO DE INSTALACION';
  @override
  Widget build(BuildContext context) {
    var sP = Provider.of<SeleccionProvider>(context, listen: true);
    return DropdownButton<String>(
      style: const TextStyle(fontSize: 20, color: Colors.white),
      borderRadius: BorderRadius.circular(10),
      value: dropdownValue,
      isDense: true,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          sP.tipoInstalacion = newValue;
          sP.notificar(context);
        });
      },
      items: <String>[
        'TIPO DE INSTALACION',
        'VEHICULOS',
        'ESTACIONARIA',
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

class ListaRed extends StatefulWidget {
  const ListaRed({Key? key}) : super(key: key);

  @override
  State<ListaRed> createState() => _ListaRed();
}

class _ListaRed extends State<ListaRed> {
  String dropdownValue = 'RED ELECTRICA';
  @override
  Widget build(BuildContext context) {
    var sP = Provider.of<SeleccionProvider>(context, listen: true);
    String tipoinst = sP.tipoInstalacion;

    if (tipoinst == 'VEHICULOS') {
      return DropdownButton(
        items: <String>['..'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: SizedBox(
                child: Text(
              value,
              textAlign: TextAlign.center,
            )),
          );
        }).toList(),
        onChanged: null,
        disabledHint: Text('CONTINUA VEHICULOS'),
      );
    }
    if (tipoinst == 'ESTACIONARIA') {
      return DropdownButton<String>(
        style: const TextStyle(fontSize: 20, color: Colors.white),
        borderRadius: BorderRadius.circular(10),
        value: dropdownValue,
        isDense: true,
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
            sP.red = newValue;
            sP.notificar(context);
          });
        },
        items: <String>[
          'RED ELECTRICA',
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
      );
    } else {
      //No seleccionó
      return DropdownButton(
        items: <String>['..'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: SizedBox(
                child: Text(
              value,
              textAlign: TextAlign.center,
            )),
          );
        }).toList(),
        onChanged: null,
        disabledHint: Text(' SELECCIONE TIPO DE INSTALACION'),
      );
    }
  }
}

class ListaSolucion extends StatefulWidget {
  const ListaSolucion({Key? key}) : super(key: key);

  @override
  State<ListaSolucion> createState() => _ListaSolucion();
}

class _ListaSolucion extends State<ListaSolucion> {
  String dropdownValue = 'TIPO DE SOLUCION';
  @override
  Widget build(BuildContext context) {
    var sP = Provider.of<SeleccionProvider>(context, listen: true);
    String tipoinst = sP.tipoInstalacion;
    String red = sP.red;
    DropdownButton desplegable;

    if (tipoinst == 'TIPO DE INSTALACION') {
      desplegable = DropdownButton(
        items: <String>['..'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: SizedBox(
                child: Text(
              value,
              textAlign: TextAlign.center,
            )),
          );
        }).toList(),
        onChanged: null,
        disabledHint: Text(' SELECCIONE TIPO DE INSTALACION'),
      );
      if (red == 'RED ELECTRICA') {
        desplegable = DropdownButton(
          items: <String>['..'].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: SizedBox(
                  child: Text(
                value,
                textAlign: TextAlign.center,
              )),
            );
          }).toList(),
          onChanged: null,
          disabledHint: Text('SELECCIONE RED ELECTRICA'),
        );
      }
    }

    if (red == 'NO') {
      desplegable = DropdownButton(
        items: <String>['..'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: SizedBox(
                child: Text(
              value,
              textAlign: TextAlign.center,
            )),
          );
        }).toList(),
        onChanged: null,
        disabledHint: Text('CONTINUA GRUPO ELECTROGENO'),
      );
    }

    if (tipoinst == 'VEHICULOS') {
      desplegable = DropdownButton(
        items: <String>['..'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: SizedBox(
                child: Text(
              value,
              textAlign: TextAlign.center,
            )),
          );
        }).toList(),
        onChanged: null,
        disabledHint: Text('CONTINUA VEHICULOS'),
      );
    }
    if (tipoinst == 'ESTACIONARIA' && red == 'SI') {
      //Estacionaria + red
      desplegable = DropdownButton<String>(
        style: const TextStyle(fontSize: 20, color: Colors.white),
        borderRadius: BorderRadius.circular(10),
        value: dropdownValue,
        isDense: true,
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
            sP.tipoSolucion = dropdownValue;
            sP.notificar(context);
          });
        },
        items: <String>[
          'TIPO DE SOLUCION',
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
      );
    } else {
      //No seleccionó
      desplegable = DropdownButton(
        items: <String>['..'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: SizedBox(
                child: Text(
              value,
              textAlign: TextAlign.center,
            )),
          );
        }).toList(),
        onChanged: null,
        disabledHint: Text(' SELECCIONE TIPO DE INSTALACION'),
      );
    }

    return desplegable;
  }
}
