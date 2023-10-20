import 'package:flutter/material.dart';
import '../Pages/item_details.dart';

class TodoCard extends StatelessWidget {
  final int index;
  final Map item;
  final Function(Map) navigateToEditPage;
  final Function(String) deleteById;
  final String id;
  const TodoCard({
    super.key,
    required this.index,
    required this.item,
    required this.navigateToEditPage,
    required this.deleteById,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ItemDetail(index: index, item: item)));
        },
        leading: CircleAvatar(child: Text("${index + 1}")),
        title: Text(
          item["title"],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          item["description"],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: PopupMenuButton(
          onSelected: (value) {
            if (value == "Edit") {
              //Open Edit Page
              navigateToEditPage(item);
            } else if (value == "Delete") {
              //Delete And Remove this Item
              deleteById(id);
            }
          },
          itemBuilder: (context) {
            return [
              const PopupMenuItem(
                value: "Edit",
                child: Text("Edit"),
              ),
              const PopupMenuItem(
                value: "Delete",
                child: Text("Delete"),
              ),
            ];
          },
        ),
      ),
    );
  }
}
