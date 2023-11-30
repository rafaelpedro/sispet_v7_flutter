import 'package:flutter/cupertino.dart';
import 'package:gestor_market/clientes/clientes_page.dart';
import 'package:gestor_market/clientes/register/clientes_register_page.dart';
import 'package:gestor_market/fornecedor/fornecedor_page.dart';
import 'package:gestor_market/fornecedor/registrar/fornecedor_register_page.dart';
import 'package:gestor_market/home/home_page.dart';
import 'package:gestor_market/models/clientes_model.dart';
import 'package:gestor_market/models/fornecedor_model.dart';
import 'package:gestor_market/models/produto_model.dart';
import 'package:gestor_market/models/user_model.dart';
import 'package:gestor_market/produto/produto_page.dart';
import 'package:gestor_market/produto/register/produto_register.dart';
import 'package:gestor_market/registrar/registrar_page.dart';

import 'login/login_page.dart';

class Rotas {

  static const String splash = '/splash';

  static const String login = '/login';
  static const String register = '/login/register';

  static const String home = '/home';
  static const String produtos = '/home/produto/';
  static const String registerProdutos = '/home/produto/register';

  static const String clientes = '/home/clientes/';
  static const String registerClientes = '/home/clientes/register';

  static const String fornecedores = '/home/fornecedor/';
  static const String registerFornecedor = '/home/fornecedor/register';


  static Map<String, WidgetBuilder> widgetsMap() {
    return {
      login: (context) => const LoginPage(),
      register: (context) => const RegistrarPage(),
      home: (context) {
        final args = ModalRoute.of(context)?.settings.arguments as UserModel;
        return HomePage(user: args,);
      },
      produtos: (context) => const ProdutoPage(),
      registerProdutos: (context){
        final args = ModalRoute.of(context)?.settings.arguments as ProdutoModel?;
        return ProdutoRegister(produtoEdit: args,);
      },
      clientes: (context) => const ClientesPage(),
      registerClientes:(context){
        final args = ModalRoute.of(context)?.settings.arguments as ClientesModel?;
        return ClientesRegisterPage(clienteEdit: args);
      },
      fornecedores :(context) => const FornecedorPage(),
      registerFornecedor :(context){
        final args = ModalRoute.of(context)?.settings.arguments as FornecedorModel?;
        return  FornecedorRegisterPage(fornecedorEdit: args,);
      }
    };
  }
}
