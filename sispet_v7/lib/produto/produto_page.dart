import 'package:flutter/material.dart';
import 'package:gestor_market/produto/produto_controller.dart';
import 'package:gestor_market/rotas.dart';
import 'package:gestor_market/util/valor_util.dart';
import 'package:provider/provider.dart';

import '../widgets/default_card_list.dart';

class ProdutoPage extends StatefulWidget {
  const ProdutoPage({super.key});

  @override
  State<ProdutoPage> createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {
  @override
  void initState() {
    final controller = Provider.of<ProdutoController>(context, listen: false);
    controller.buscaTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProdutoController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos setor Petshop'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).pushNamed('/home/produto/register');
          await controller.buscaTodos();
        },
      ),
      body: ListView.builder(
        itemCount: controller.produtos.length,
        itemBuilder: (context, index) {
          final prod = controller.produtos[index];
          return DefaultCardList(
            icon: Icons.circle,
            title: prod.nome,
            subtitle: prod.setor,
            trailing: 'R\$ ${ValorUtil.convertDoubleToString(prod.preco)}',
            onDelete: (context) async {
              await controller.delete(codigo: prod.id!);
            },
            onEdit: (context) async {
              await Navigator.of(context)
                  .pushNamed('/home/produto/register', arguments: prod);
            },
          );
        },
      ),
    );
  }
}
