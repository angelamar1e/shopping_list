import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list/shopping_list/bloc/shopping_list_bloc.dart';
import 'package:shopping_list/shopping_list/screens/shopping_list_screen.dart';

void main() {
  runApp(const ShoppingList());
}

class ShoppingList extends StatelessWidget {
  const ShoppingList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List',
      home: BlocProvider(
        create: (context) => ShoppingListBloc(),
        child: const ShoppingListScreen(),
      ),
    );
  }
}
