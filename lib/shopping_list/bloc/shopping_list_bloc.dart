import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_list/shopping_list/bloc/shopping_list_event.dart';
import 'package:shopping_list/shopping_list/bloc/shopping_list_state.dart';

class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState> {
  ShoppingListBloc() : super(ShoppingListState(shoppingList: [])) {
    on<ItemAdded>((event, emit) {
      state.shoppingList.add(event.newItem);
      emit(ShoppingListState(shoppingList: state.shoppingList));
    });

    on<ItemRemoved>((event, emit) {
      state.shoppingList.removeAt(event.itemIndex);
      emit(ShoppingListState(shoppingList: state.shoppingList));
    });

    on<ItemUpdated>((event, emit) {
      state.shoppingList[event.itemIndex] = event.updatedItem;
      emit(ShoppingListState(shoppingList: state.shoppingList));
    });
  }
}
