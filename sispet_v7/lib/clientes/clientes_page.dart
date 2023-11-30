import 'package:flutter/material.dart';
import 'package:gestor_market/clientes/clientes_controller.dart';
import 'package:provider/provider.dart';

import '../util/valor_util.dart';
import '../widgets/default_card_list.dart';

class ClientesPage extends StatefulWidget {

  const ClientesPage({ super.key });

  @override
  State<ClientesPage> createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {

  @override
  void initState()  {
     final controller = Provider.of<ClientesController>(context, listen: false);
     controller.buscaTodos();
    super.initState();
  }
  

   @override
   Widget build(BuildContext context) {
    final controller = Provider.of<ClientesController>(context);

       return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
         await Navigator.of(context).pushNamed('/home/clientes/register');
         await controller.buscaTodos();
        },
      ),
      body: ListView.builder(
        itemCount: controller.clientes.length,
        itemBuilder: (context, index) {
          final cli = controller.clientes[index];
          return DefaultCardList(
            icon: Icons.circle,
            title:  "${cli.id} - ${cli.nome}",
            subtitle: cli.email,
            onDelete: (context) async {
              await controller.delete(codigo: cli.id!);
            },
            onEdit: (context) async {
              await Navigator.of(context).pushNamed('/home/clientes/register', arguments: cli);
            },
          );
        },
      ),
    );
  }
}