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
    //Tiene datos muestra kits
    return Scaffold(
        body: Center(
          child: ListView(
            padding: const EdgeInsets.all(30),
            children: [
              ListViewConsumos(),
            ],
          ),
        ),
        appBar: dimAppBar(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {},
          label: const Text(
            'Continuar',
          ),
          icon: const Icon(Icons.arrow_forward),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }

  AppBar dimAppBar() {
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
    );
  }
}

class ListViewConsumos extends StatefulWidget {
  const ListViewConsumos({Key? key}) : super(key: key);

  @override
  State<ListViewConsumos> createState() => _ListViewConsumos();
}

enum SingingCharacter {
  LamparaLed,
  Bomba,
  Notebook,
  Heladera,
  Freezer,
  Lavarropas,
  Aire2200FG,
  Aire3500FG,
  TvLed,
  Cafetera,
  CargadorCel,
  RouterWifi,
  VentiladorTecho,
  VentiladorPie,
}

class _ListViewConsumos extends State<ListViewConsumos> {
  SingingCharacter? _character = SingingCharacter.LamparaLed;
  int? grupo1, grupo2, grupo3, grupo4, grupo5, grupo6, grupo7, grupo8;
  int? grupo9, grupo10, grupo11, grupo12, grupo13, grupo14;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(),
        ListTile(
          title: const Text('Lampara'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.LamparaLed,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        Divider(),
        ListTile(
          title: const Text('Bomba 3/4 HP'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.Bomba,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        Divider(),
        ListTile(
          title: const Text('Notebook'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.Notebook,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        Divider(),
        ListTile(
          title: const Text('Heladera'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.Heladera,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        Divider(),
        ListTile(
          title: const Text('Freezer'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.Freezer,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        Divider(),
        ListTile(
          title: const Text('Lavarropas'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.Lavarropas,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        Divider(),
        ListTile(
          title: const Text('Aire 2200 FG'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.Aire2200FG,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        Divider(),
        ListTile(
          title: const Text('Aire 3500 FG'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.Aire3500FG,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        Divider(),
        ListTile(
          title: const Text('Tv Led'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.TvLed,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        Divider(),
        ListTile(
          title: const Text('Cafetera'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.Cafetera,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        Divider(),
        ListTile(
          title: const Text('Cargador Cel'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.CargadorCel,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        Divider(),
        ListTile(
          title: const Text('Router Wifi'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.RouterWifi,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        Divider(),
        ListTile(
          title: const Text('Ventilador Techo'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.VentiladorTecho,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        Divider(),
        ListTile(
          title: const Text('Ventilador Pie'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.VentiladorPie,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
