import 'package:flutter/material.dart';
import 'package:qmax_inst/src/pages/config_page.dart';
import 'package:qmax_inst/src/pages/home_page.dart';
import 'package:qmax_inst/src/pages/inicio_page.dart';
import 'package:qmax_inst/src/pages/medio_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'homePage': (BuildContext context) => const HomePage(),
    'inicioPage': (BuildContext context) => const InicioPage(),
    'medioPage': (BuildContext context) => const MedioPage(),
    'configPage': (BuildContext context) => const ConfigPage(),
  };
}
