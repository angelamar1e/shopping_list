import 'package:flutter/material.dart';
import 'package:shopping_list/shopping_list/models/item.dart';

Widget dialogWithTextFields({
  required BuildContext context,
  required String title,
  required String hintTextField1,
  required String hintTextField2,
  required TextEditingController textField1Controller,
  required TextEditingController textField2Controller,
}) {
  return AlertDialog(
    title: Text(title),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: textField1Controller,
          autofocus: true,
          decoration: InputDecoration(hintText: hintTextField1),
        ),
        TextField(
          controller: textField2Controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: hintTextField2),
        ),
      ],
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop(null); // Dismiss dialog without adding
        },
        child: Text('Cancel'),
      ),
      TextButton(
        onPressed: () {
          final String textField1Content = textField1Controller.text.trim();
          final int? textField2Content = int.tryParse(
            textField2Controller.text.trim(),
          );

          if (textField1Content.isNotEmpty && textField2Content != null) {
            Navigator.of(
              context,
            ).pop(Item(textField1Content, textField2Content));
          } else {
            // Handle validation errors (e.g., show a message to the user)
          }
        },
        child: Text('Add'),
      ),
    ],
  );
}

Future<Item?> openDialog(
  BuildContext context, [
  existingItemDescription,
  existingItemQuantity,
]) {
  final TextEditingController descriptionController = TextEditingController(
    text: existingItemDescription ?? '',
  );
  final TextEditingController quantityController = TextEditingController(
    text: existingItemQuantity ?? '',
  );

  return showDialog<Item>(
    context: context,
    builder: (context) {
      return dialogWithTextFields(
        context: context,
        title: 'Add a new shopping list item',
        hintTextField1: 'Item description',
        hintTextField2: 'Item quantity',
        textField1Controller: descriptionController,
        textField2Controller: quantityController,
      );
    },
  );
}
