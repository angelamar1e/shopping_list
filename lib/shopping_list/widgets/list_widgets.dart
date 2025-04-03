import 'package:flutter/material.dart';
import 'package:shopping_list/shopping_list/models/item.dart';
import 'package:shopping_list/shopping_list/bloc/shopping_list_event.dart';
import 'package:shopping_list/shopping_list/widgets/dialog_widgets.dart';

Widget shoppingListItem({
  context,
  required Item item,
  required bloc,
  required shoppingList,
}) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            itemCard(
              itemDescription: item.description,
              itemQuantity: item.quantity.toString(),
            ),
            editListItemButton(
              context: context,
              itemToUpdate: item,
              bloc: bloc,
              listToUpdate: shoppingList,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget itemCard({
  required String itemDescription,
  required String itemQuantity,
}) {
  return Expanded(
    child: Card(
      child: ListTile(
        title: Text(itemDescription, style: TextStyle(fontSize: 20)),
        subtitle: RichText(
          textAlign: TextAlign.end,
          text: TextSpan(
            style: TextStyle(
              fontSize: 15,
              color: const Color.fromARGB(255, 79, 83, 85),
            ),
            children: [
              TextSpan(
                text: "Quantity: ",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              TextSpan(text: itemQuantity),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget editListItemButton({
  required BuildContext context,
  required Item itemToUpdate,
  required List<Item> listToUpdate,
  required bloc,
}) {
  return TextButton(
    onPressed: () async {
      final Item updatedItem =
          await openDialog(
                context,
                itemToUpdate.description,
                itemToUpdate.quantity.toString(),
              )
              as Item;
      bloc.add(ItemUpdated(listToUpdate.indexOf(itemToUpdate), updatedItem));
    },
    child: Icon(Icons.edit),
  );
}

Widget floatingAddListItemButton(context, {required bloc}) {
  return FloatingActionButton(
    child: Icon(Icons.add),
    onPressed: () async {
      final Item? newItem = await openDialog(context);

      bloc.add(ItemAdded(newItem!));
    },
  );
}

Widget dismissibleBackground({contentAlignment}) {
  return Container(
    color: Colors.red,
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: contentAlignment ?? MainAxisAlignment.start,
        children: [Icon(Icons.delete, size: 30)],
      ),
    ),
  );
}
