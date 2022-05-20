import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qmax_inst/src/pages/one_page.dart';
import 'package:qmax_inst/theme/theme.dart';

import 'package:qmax_inst/routes/routes.dart';
import 'package:qmax_inst/src/providers/bateria_provider.dart';
import 'package:qmax_inst/src/providers/inversor_provider.dart';
import 'package:qmax_inst/src/providers/seleccion_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          /*Providers*/
          ChangeNotifierProvider(create: (_) => InversorProvider()),
          ChangeNotifierProvider(create: (_) => BateriaProvider()),
          ChangeNotifierProvider(create: (_) => SeleccionProvider()),
        ],
        child: MaterialApp(
            theme: defaultTheme,
            debugShowCheckedModeBanner: false,
            initialRoute: 'onePage',
            routes: getApplicationRoutes(),
            onGenerateRoute: (RouteSettings settings) {
              return MaterialPageRoute(builder: (context) => const onePage());
            }));
  }
}
