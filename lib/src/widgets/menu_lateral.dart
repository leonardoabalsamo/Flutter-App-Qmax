import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:qmax_inst/src/pages/home_page.dart';
import 'package:qmax_inst/src/pages/inicio_page_instalador.dart';

import '../pages/config_page.dart';

class menuLateral extends StatelessWidget {
  const menuLateral({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Expanded(
                      child: Image.asset(
                    'assets/images/logoblanco.jpg',
                    scale: 2.2,
                  )),
                ],
              )),
          ListTile(
            leading: Icon(Icons.settings_outlined),
            title: Text("Configuración de Equipos"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.account_tree_sharp),
            title: Text("Dimensionamiento de Sistemas"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InicioInstaladorPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.library_books_outlined),
            title: Text("Manual Regulador MPPT"),
            onTap: () async {
              var file = await getAssetByName("manual_regulador_mppt.pdf");
              OpenFile.open(file.path, type: "application/pdf");
            },
          ),
          ListTile(
            leading: Icon(Icons.library_books_outlined),
            title: Text("Manual Inversor SPD"),
            onTap: () async {
              var file = await getAssetByName("manual_inversor_spd.pdf");
              OpenFile.open(file.path, type: "application/pdf");
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle_sharp),
            title: Text("Politicas de Privacidad"),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  contentPadding: const EdgeInsets.all(25.0),
                  scrollable: true,
                  content: Text(
                    "Cuando descarga, instala y utiliza nuestras aplicaciones móviles, recopilamos información automáticamente sobre el tipo de dispositivo que usa, la versión del sistema operativo y el identificador del dispositivo (o “UDID”)."
                    "Le enviamos notificaciones automáticas de vez en cuando para informarle sobre cualquier evento o promoción que podamos estar ejecutando. "
                    "Si ya no desea recibir este tipo de comunicaciones, puede desactivarlas a nivel de dispositivo. Para garantizar que reciba las notificaciones adecuadas, necesitaremos recopilar cierta información sobre su dispositivo, como el sistema operativo y la información de identificación del usuario."
                    "Recopilamos su información basada en la ubicación con el fin de ubicar un lugar que pueda estar buscando en su área. Solo compartiremos esta información con nuestro proveedor de mapas con el único propósito de brindarle este servicio."
                    "Puede optar por no recibir servicios basados ​​en la ubicación en cualquier momento cambiando la configuración en el nivel del dispositivo.Usamos Analytics para permitirnos comprender mejor la funcionalidad de nuestra aplicación móvil en su dispositivo móvil o de mano. "
                    "Esta aplicación móvil puede registrar información, como la frecuencia con la que utiliza la aplicación móvil, los eventos que ocurren dentro de la aplicación móvil, el uso agregado, los datos de rendimiento y desde dónde se descargó la aplicación móvil."
                    "No vinculamos la información que almacenamos en el software de análisis con ninguna información personal que envíe dentro de la Aplicación móvil.",
                    style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
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
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("Acerca de la Aplicación"),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  contentPadding: const EdgeInsets.all(20.0),
                  content: Row(
                    children: const <Widget>[
                      Expanded(
                        child: Text(
                          "Version de App: 1.0",
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
            },
          )
        ],
      ),
    );
  }
}
