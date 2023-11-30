import 'package:flutter/material.dart';
import 'package:gestor_market/clientes/clientes_controller.dart';
import 'package:gestor_market/fornecedor/fornecedor_controller.dart';
import 'package:gestor_market/home/home_controller.dart';
import 'package:gestor_market/login/login_controller.dart';
import 'package:gestor_market/produto/produto_controller.dart';
import 'package:gestor_market/registrar/registrar_controller.dart';
import 'package:gestor_market/rotas.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeController(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginController(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegistrarController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProdutoController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ClientesController(),
        ),
        ChangeNotifierProvider(
          create: (context) => FornecedorController(),
        )
      ],
      child: MaterialApp(
        initialRoute: '/login',
        title: 'Gestor Market',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.blue,
                titleTextStyle: TextStyle(color: Colors.black, fontSize: 16))),
        routes: Rotas.widgetsMap(),
      ),
    );
  }
}
