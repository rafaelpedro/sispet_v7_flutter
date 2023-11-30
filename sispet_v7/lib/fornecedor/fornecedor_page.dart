import 'package:flutter/material.dart';
import 'package:gestor_market/fornecedor/fornecedor_controller.dart';
import 'package:provider/provider.dart';

import '../widgets/default_card_list.dart';

class FornecedorPage extends StatefulWidget {

  const FornecedorPage({ super.key });

  @override
  State<FornecedorPage> createState() => _FornecedorPageState();
}

class _FornecedorPageState extends State<FornecedorPage> {

  @override
  void initState()  {
     final controller = Provider.of<FornecedorController>(context, listen: false);
     controller.buscaTodos();
    super.initState();
  }

   @override
   Widget build(BuildContext context) {
    final controller =  Provider.of<FornecedorController>(context);

       return Scaffold(
      appBar: AppBar(
        title: const Text('Fornecedores'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
         await Navigator.of(context).pushNamed('/home/fornecedor/register');
         await controller.buscaTodos();
        },
      ),
      body: ListView.builder(
        itemCount: controller.fornecedores.length,
        itemBuilder: (context, index) {
          final forne = controller.fornecedores[index];
          return DefaultCardList(
            icon: Icons.circle,
            title:  "${forne.id} - ${forne.nome}",
            subtitle: forne.cnpj,
            onDelete: (context) async {
              await controller.delete(codigo: forne.id!);
            },
            onEdit: (context) async {
              await Navigator.of(context).pushNamed('/home/fornecedor/register', arguments: forne);
            },
          );
        },
      ),
    );
  }
}