class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final String imageUrl;
  final String description;
  final List<String> sizes;
  final List<String> colors;
  final bool isNew;
  final String? collection;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.description,
    this.sizes = const [],
    this.colors = const [],
    this.isNew = false,
    this.collection,
  });
}

class CartItem {
  final Product product;
  final String selectedSize;
  final String selectedColor;
  int quantity;

  CartItem({
    required this.product,
    required this.selectedSize,
    required this.selectedColor,
    this.quantity = 1,
  });

  double get totalPrice => product.price * quantity;
}

class Order {
  final String id;
  final List<CartItem> items;
  final double total;
  final String status;
  final DateTime date;

  const Order({
    required this.id,
    required this.items,
    required this.total,
    required this.status,
    required this.date,
  });
}

// Mock data matching Figma design
class MockData {
  static const List<String> categories = [
    'READY-TO-WEAR',
    'ACCESSORIES',
    'FOOTWEAR',
    'KNITWEAR',
  ];

  static final List<Product> products = [
    Product(
      id: '1',
      name: 'Architectural Blazer',
      category: 'OUTERWEAR',
      price: 2299.00,
      imageUrl: 'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=400',
      description: 'Crafted from 100% Italian heavy-weight silk. This floor-length slip dress features back or placement neckline that drapes effortlessly over the silhouette. Finished with hand-rolled hems and discreet French works.',
      sizes: ['XS', 'S', 'M', 'L'],
      colors: ['#0A0A0A', '#6B6B6B', '#C4A35A'],
      isNew: true,
      collection: 'MIDNIGHT COLLECTION',
    ),
    Product(
      id: '2',
      name: 'Silk Drape Gown',
      category: 'BRANDS',
      price: 1999.00,
      imageUrl: 'https://images.unsplash.com/photo-1566206091558-7f218b696731?w=400',
      description: 'An elegant evening gown with flowing silk drape.',
      sizes: ['XS', 'S', 'M', 'L'],
      colors: ['#D4A017', '#0A0A0A'],
      isNew: false,
    ),
    Product(
      id: '3',
      name: 'Midnight Coat',
      category: 'OUTERWEAR',
      price: 3999.00,
      imageUrl: 'https://images.unsplash.com/photo-1539109136881-3be0616acf4b?w=400',
      description: 'Luxurious midnight coat for formal occasions.',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['#0A0A0A'],
      isNew: true,
      collection: 'ALCHEMY SUMMER',
    ),
    Product(
      id: '4',
      name: 'Saffron Drape Gown',
      category: 'ACCESSORIES',
      price: 2999.00,
      imageUrl: 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=400',
      description: 'A stunning saffron colored drape gown.',
      sizes: ['XS', 'S', 'M'],
      colors: ['#D4A017'],
      isNew: false,
    ),
    Product(
      id: '5',
      name: 'Atelier Frame Bag',
      category: 'LEATHER GOODS',
      price: 1299.00,
      imageUrl: 'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=400',
      description: 'Handcrafted leather frame bag.',
      sizes: ['ONE SIZE'],
      colors: ['#8B6914', '#0A0A0A'],
      isNew: false,
    ),
    Product(
      id: '6',
      name: 'Geometric Silk Foulard',
      category: 'SILK ACCESSORIES',
      price: 999.00,
      imageUrl: 'https://images.unsplash.com/photo-1601924994987-69e26d50dc26?w=400',
      description: 'Elegant geometric pattern silk foulard.',
      sizes: ['ONE SIZE'],
      colors: ['#D4A017', '#0A0A0A'],
      isNew: false,
    ),
    Product(
      id: '7',
      name: 'Atelier Trainer',
      category: 'FOOTWEAR',
      price: 899.00,
      imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400',
      description: 'Premium leather atelier trainers.',
      sizes: ['38', '39', '40', '41', '42'],
      colors: ['#FFFFFF', '#0A0A0A'],
      isNew: false,
    ),
    Product(
      id: '8',
      name: 'Cashmere Blend Polo',
      category: 'KNITWEAR',
      price: 1609.00,
      imageUrl: 'https://images.unsplash.com/photo-1518770660439-4636190af475?w=400',
      description: 'Luxurious cashmere blend polo sweater.',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['#C4A35A', '#0A0A0A', '#6B6B6B'],
      isNew: false,
    ),
    // Featured products for hero
    Product(
      id: '9',
      name: 'Couture Silk Slip Gown',
      category: 'MIDNIGHT COLLECTION',
      price: 4250.00,
      imageUrl: 'https://images.unsplash.com/photo-1566206091558-7f218b696731?w=600',
      description: 'Crafted from 100% Italian heavy-weight silk. This floor-length slip dress features back placement neckline that drapes effortlessly.',
      sizes: ['XS', 'S', 'M', 'L'],
      colors: ['#0A0A0A', '#2C2C2C', '#C4A35A'],
      isNew: false,
      collection: 'MIDNIGHT COLLECTION',
    ),
    Product(
      id: '10',
      name: 'Silk Evening Blazer',
      category: 'SILK COLLECTION',
      price: 3999.00,
      imageUrl: 'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=400',
      description: 'Exquisite silk evening blazer.',
      sizes: ['S', 'M', 'L'],
      colors: ['#0A0A0A'],
      isNew: false,
    ),
    Product(
      id: '11',
      name: 'Polished Chelsea Boot',
      category: 'FOOTWEAR',
      price: 999.00,
      imageUrl: 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?w=400',
      description: 'Classic polished Chelsea boots in premium leather.',
      sizes: ['37', '38', '39', '40', '41'],
      colors: ['#0A0A0A', '#8B4513'],
      isNew: false,
    ),
    Product(
      id: '12',
      name: 'Gold Helix Necklace',
      category: 'ACCESSORIES',
      price: 3999.00,
      imageUrl: 'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=400',
      description: '18k gold helix necklace, artisan crafted.',
      sizes: ['ONE SIZE'],
      colors: ['#D4A017'],
      isNew: false,
    ),
  ];

  static List<Product> getByCategory(String category) {
    return products.where((p) => p.category == category).toList();
  }

  static final List<Order> orders = [
    Order(
      id: 'AT-88291',
      items: [],
      total: 3999.00,
      status: 'DELIVERED',
      date: DateTime(2023, 10, 14),
    ),
    Order(
      id: 'AT-89104',
      items: [],
      total: 13999.00,
      status: 'PROCESSING',
      date: DateTime(2023, 10, 9),
    ),
    Order(
      id: 'AT-89002',
      items: [],
      total: 10399.00,
      status: 'PROCESSING',
      date: DateTime(2023, 10, 9),
    ),
  ];
}
