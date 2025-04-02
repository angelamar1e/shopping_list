import 'package:shopping_list/shopping_list/models/item.dart';

abstract class ShoppingListEvent {}

class ItemAdded extends ShoppingListEvent {
  final Item newItem;

  ItemAdded(this.newItem);
}

class ItemRemoved extends ShoppingListEvent {
  final int itemIndex;

  ItemRemoved(this.itemIndex);
}

class ItemUpdated extends ShoppingListEvent {
  final int itemIndex;
  final Item updatedItem;

  ItemUpdated(this.itemIndex, this.updatedItem);
}
