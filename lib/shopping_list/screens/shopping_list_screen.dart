import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list/shopping_list/bloc/shopping_list_bloc.dart';
import 'package:shopping_list/shopping_list/bloc/shopping_list_event.dart';
import 'package:shopping_list/shopping_list/bloc/shopping_list_state.dart';
import 'package:shopping_list/shopping_list/models/item.dart';
import 'package:shopping_list/shopping_list/widgets/list_widgets.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shoppingListBloc = context.read<ShoppingListBloc>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("My Shopping List"),
      ),
      body: Center(
        child: BlocBuilder<ShoppingListBloc, ShoppingListState>(
          builder: (context, state) {
            final shoppingList = state.shoppingList;

            return Column(
              children: [
                for (Item item in state.shoppingList.cast<Item>())
                  Dismissible(
                    key: Key(state.shoppingList.indexOf(item).toString()),
                    onDismissed: (direction) {
                      shoppingListBloc.add(
                        ItemRemoved(shoppingList.indexOf(item)),
                      );
                    },
                    background: dismissibleBackground(),
                    secondaryBackground: dismissibleBackground(
                      contentAlignment: MainAxisAlignment.end,
                    ),
                    child: shoppingListItem(
                      context: context,
                      bloc: shoppingListBloc,
                      shoppingList: shoppingList,
                      item: item,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: floatingAddListItemButton(
        context,
        bloc: shoppingListBloc,
      ),
    );
  }
}
