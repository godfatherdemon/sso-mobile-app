import 'package:flutter/material.dart';
import 'package:usluge_client/model/list_item.dart';

class ListItemWidget extends StatelessWidget {
  final ListItem item;
  final Animation<double> animation;
  final VoidCallback? onClicked;

  const ListItemWidget(
      {super.key, required this.item, required this.animation, this.onClicked});

  @override
  Widget build(BuildContext context) => buildItem();

  Widget buildItem() => Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.lightBlue.shade50,
      ),
      child: ListTile(
        // ignore: prefer_const_constructors
        contentPadding: EdgeInsets.all(16),
        leading: Text("${item.owner}",
            style: const TextStyle(fontSize: 20, color: Colors.black)),
        title: Text(
          "${item.title}",
          style: const TextStyle(fontSize: 15, color: Colors.black),
        ),
        trailing: IconButton(
            onPressed: onClicked,
            icon: const Icon(Icons.delete, color: Colors.red, size: 32)),
      ));
}
