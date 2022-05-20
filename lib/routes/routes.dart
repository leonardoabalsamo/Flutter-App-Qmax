import 'package:flutter/material.dart';
import 'package:qmax_inst/src/pages/config_page.dart';
import 'package:qmax_inst/src/pages/home_page.dart';
import 'package:qmax_inst/src/pages/inicio_page.dart';
import 'package:qmax_inst/src/pages/medio_page.dart';

import '../src/pages/inicio_page_instalador.dart';
import '../src/pages/inicio_page_regulador.dart';
import '../src/pages/one_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'onePage': (BuildContext context) => const onePage(),
    'homePage': (BuildContext context) => const HomePage(),
    'inicioPage': (BuildContext context) => const InicioPage(),
    'inicioInstaladorPage': (BuildContext context) =>
        const InicioInstaladorPage(),
    'inicioPageRegulador': (BuildContext context) =>
        const InicioPageRegulador(),
    'medioPage': (BuildContext context) => const MedioPage(),
    'configPage': (BuildContext context) => const ConfigPage(),
  };
}
