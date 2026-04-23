import 'package:flutter/foundation.dart';
import 'models.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  final List<Order> _orders = [];

  List<CartItem> get items => List.unmodifiable(_items);
  List<Order> get orders => List.unmodifiable(_orders);

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => _items.fold(0, (sum, item) => sum + item.totalPrice);

  double get shippingCost => subtotal > 0 ? 400.0 : 0.0;

  double get total => subtotal + shippingCost;

  void addItem(Product product, String size, String color) {
    final existingIndex = _items.indexWhere(
      (item) => item.product.id == product.id && item.selectedSize == size && item.selectedColor == color,
    );
    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(product: product, selectedSize: size, selectedColor: color));
    }
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void updateQuantity(int index, int quantity) {
    if (quantity <= 0) {
      removeItem(index);
    } else {
      _items[index].quantity = quantity;
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  void placeOrder() {
    if (_items.isEmpty) return;
    
    final newOrder = Order(
      id: 'AT-${88000 + _orders.length + 100}',
      items: List.from(_items),
      total: total,
      status: 'PROCESSING',
      date: DateTime.now(),
    );
    
    _orders.insert(0, newOrder);
    _items.clear();
    notifyListeners();
  }
}
