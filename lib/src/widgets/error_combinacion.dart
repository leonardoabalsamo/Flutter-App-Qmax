import 'package:flutter/material.dart';

Future showError(BuildContext context) {
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

Future errorCantBat(context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      contentPadding: const EdgeInsets.all(10.0),
      content: Row(
        children: const <Widget>[
          Expanded(
            child: Text(
              "La selección no puede superar los 4 bancos de baterías en paralelo por desbalance en carga y descarga. ",
              style: TextStyle(
                fontSize: 16,
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

Future errorSeleccion(context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      contentPadding: const EdgeInsets.all(10.0),
      content: Row(
        children: const <Widget>[
          Expanded(
            child: Text(
              "Debe seleccionar una opción",
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
              Navigator.of(context).pop();
            }),
      ],
    ),
  );
}
