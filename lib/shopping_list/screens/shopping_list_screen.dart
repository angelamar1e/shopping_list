import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list/shopping_list/bloc/shopping_list_bloc.dart';
import 'package:shopping_list/shopping_list/bloc/shopping_list_event.dart';
import 'package:shopping_list/shopping_list/bloc/shopping_list_state.dart';
import 'package:shopping_list/shopping_list/models/item.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({super.key});

  Widget dissmissibleBackground({contentAlignment}) {
    return Container(
      color: Colors.red,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: contentAlignment,
          children: [Icon(Icons.delete, size: 30)],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final shoppingListBloc = context.read<ShoppingListBloc>();

    Future<Item?> openDialog([Item? existingItem]) {
      final TextEditingController descriptionController = TextEditingController(
        text: existingItem?.itemDescription ?? '',
      );
      final TextEditingController quantityController = TextEditingController(
        text: existingItem?.quantity.toString() ?? '',
      );

      return showDialog<Item>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add a new shopping list item"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: descriptionController,
                  autofocus: true,
                  decoration: InputDecoration(hintText: 'Item description'),
                ),
                TextField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Item quantity'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pop(null); // Dismiss dialog without adding
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  final String description = descriptionController.text.trim();
                  final int? quantity = int.tryParse(
                    quantityController.text.trim(),
                  );

                  if (description.isNotEmpty && quantity != null) {
                    Navigator.of(context).pop(Item(description, quantity));
                  } else {
                    // Handle validation errors (e.g., show a message to the user)
                  }
                },
                child: Text('Add'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("My Shopping List"),
      ),
      body: Center(
        child: BlocBuilder<ShoppingListBloc, ShoppingListState>(
          builder: (context, state) {
            return Column(
              children: [
                for (Item item in state.shoppingList.cast<Item>())
                  Dismissible(
                    key: Key(state.shoppingList.indexOf(item).toString()),
                    onDismissed: (left) {
                      shoppingListBloc.add(
                        ItemRemoved(state.shoppingList.indexOf(item)),
                      );
                    },
                    background: dissmissibleBackground(
                      contentAlignment: MainAxisAlignment.start,
                    ),
                    secondaryBackground: dissmissibleBackground(
                      contentAlignment: MainAxisAlignment.end,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Card(
                                  child: ListTile(
                                    title: Text(
                                      item.itemDescription,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: RichText(
                                      textAlign: TextAlign.end,
                                      text: TextSpan(
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: const Color.fromARGB(
                                            255,
                                            79,
                                            83,
                                            85,
                                          ),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "Quantity: ",
                                            style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: item.quantity.toString(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  final Item updatedItem =
                                      await openDialog(item) as Item;
                                  shoppingListBloc.add(
                                    ItemUpdated(
                                      state.shoppingList.indexOf(item),
                                      updatedItem,
                                    ),
                                  );
                                },
                                child: Icon(Icons.edit),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final Item newItem = await openDialog() as Item;

          shoppingListBloc.add(ItemAdded(newItem));
        },
      ),
    );
  }
}
