import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DefaultCardList extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String? subtitle;
  final String? trailing;
  final SlidableActionCallback? onDelete;
  final SlidableActionCallback? onEdit;

  const DefaultCardList(
      {super.key, this.icon, required this.title, this.subtitle, this.onDelete, this.onEdit, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: onEdit,
            backgroundColor: const Color.fromARGB(255, 73, 150, 223),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Editar',
          ),
          SlidableAction(
            onPressed: onDelete,
            backgroundColor: const Color.fromARGB(255, 243, 82, 82),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Excluir',
          ),
        ],
      ),
      child: ListTile(
        leading: icon == null ? null : Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle ?? ''),
        trailing: Text(trailing ?? '', style: const TextStyle(fontSize: 18),),
      ),
    );
  }
}
