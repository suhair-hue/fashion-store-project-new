import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../models/cart_provider.dart';
import 'checkout_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String? _selectedSize;
  String? _selectedColor;
  bool _isWishlisted = false;

  Product get product => widget.product;

  @override
  void initState() {
    super.initState();
    // Start with no selections to force user action as requested
  }

  @override
  Widget build(BuildContext context) {
    final relatedProducts = MockData.products
        .where((p) => p.id != product.id)
        .take(2)
        .toList();

    return Scaffold(
      backgroundColor: AppTheme.white,
      body: CustomScrollView(
        slivers: [
          // Hero image with app bar
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.55,
            pinned: true,
            backgroundColor: Colors.white,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppTheme.textPrimary),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.all(8),
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: IconButton(
                  icon: const Icon(Icons.more_vert, size: 20, color: AppTheme.textPrimary),
                  onPressed: () {},
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Container(color: AppTheme.lightGrey),
                  ),
                  // Wishlist button
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: GestureDetector(
                      onTap: () => setState(() => _isWishlisted = !_isWishlisted),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: Icon(
                          _isWishlisted ? Icons.favorite : Icons.favorite_border,
                          size: 18,
                          color: _isWishlisted ? AppTheme.error : AppTheme.darkGrey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Product details
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Collection tag
                  if (product.collection != null)
                    Text(
                      product.collection!,
                      style: GoogleFonts.jost(
                        fontSize: 10, fontWeight: FontWeight.w600,
                        color: AppTheme.textMuted, letterSpacing: 1.5,
                      ),
                    ),
                  const SizedBox(height: 4),
                  // Product name & price row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: GoogleFonts.cormorant(
                            fontSize: 24, fontWeight: FontWeight.w700,
                            color: AppTheme.textPrimary, height: 1.2,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'LKR ${product.price.toStringAsFixed(0)}.00',
                            style: GoogleFonts.jost(
                              fontSize: 16, fontWeight: FontWeight.w700,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          Text(
                            'Midnight Noir',
                            style: GoogleFonts.jost(
                              fontSize: 10, color: AppTheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: AppTheme.divider),
                  const SizedBox(height: 16),

                  // Color selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('SELECT COLOR', style: GoogleFonts.jost(
                        fontSize: 10, fontWeight: FontWeight.w700,
                        color: AppTheme.textSecondary, letterSpacing: 1.0,
                      )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: product.colors.map((colorHex) {
                      Color color;
                      try {
                        color = Color(int.parse(colorHex.replaceFirst('#', '0xFF')));
                      } catch (_) {
                        color = Colors.black;
                      }
                      final isSelected = _selectedColor == colorHex;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedColor = colorHex),
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: isSelected
                                ? Border.all(color: AppTheme.primary, width: 2)
                                : Border.all(color: AppTheme.lightGrey, width: 1),
                            boxShadow: isSelected
                                ? [BoxShadow(color: AppTheme.primary.withOpacity(0.3), blurRadius: 4, spreadRadius: 1)]
                                : null,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // Size selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('SELECT SIZE', style: GoogleFonts.jost(
                        fontSize: 10, fontWeight: FontWeight.w700,
                        color: AppTheme.textSecondary, letterSpacing: 1.0,
                      )),
                      Text('Size Guide', style: GoogleFonts.jost(
                        fontSize: 10, color: AppTheme.primary,
                        decoration: TextDecoration.underline,
                      )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: product.sizes.map((size) {
                      final isSelected = _selectedSize == size;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedSize = size),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isSelected ? AppTheme.primary : Colors.transparent,
                            border: Border.all(
                              color: isSelected ? AppTheme.primary : AppTheme.lightGrey,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              size,
                              style: GoogleFonts.jost(
                                fontSize: 11, fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.white : AppTheme.textPrimary,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Product details
                  Text('PRODUCT DETAILS', style: GoogleFonts.jost(
                    fontSize: 10, fontWeight: FontWeight.w700,
                    color: AppTheme.textSecondary, letterSpacing: 1.0,
                  )),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: GoogleFonts.jost(
                      fontSize: 12, color: AppTheme.textSecondary,
                      height: 1.7,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _DetailBadge(icon: Icons.phone_outlined, label: '800-CENTRAL546'),
                      const SizedBox(width: 12),
                      _DetailBadge(icon: Icons.handyman_outlined, label: 'HANDCRAFTED IN ITALY'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Divider(color: AppTheme.divider),

                  // The Atelier Look
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('THE ATELIER LOOK', style: GoogleFonts.jost(
                        fontSize: 11, fontWeight: FontWeight.w700,
                        letterSpacing: 1.0, color: AppTheme.textPrimary,
                      )),
                      Text('SHOP THE EDIT', style: GoogleFonts.jost(
                        fontSize: 10, fontWeight: FontWeight.w600,
                        color: AppTheme.primary, letterSpacing: 0.5,
                      )),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: relatedProducts.length,
                      itemBuilder: (context, index) {
                        final rp = relatedProducts[index];
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: rp)),
                          ),
                          child: Container(
                            width: 90,
                            margin: const EdgeInsets.only(right: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.network(
                                      rp.imageUrl, fit: BoxFit.cover,
                                      width: 90,
                                      errorBuilder: (c, e, s) => Container(color: AppTheme.lightGrey),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'LKR ${rp.price.toStringAsFixed(0)}',
                                  style: GoogleFonts.jost(fontSize: 10, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppTheme.divider)),
      ),
      child: Row(
        children: [
          // Cart icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.lightGrey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(Icons.shopping_bag_outlined, size: 20, color: AppTheme.textPrimary),
          ),
          const SizedBox(width: 12),
          // Add to cart button
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (_selectedColor == null && _selectedSize == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please select size and color', style: GoogleFonts.jost()),
                      backgroundColor: AppTheme.error,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  return;
                }
                if (_selectedSize == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please select a size', style: GoogleFonts.jost()),
                      backgroundColor: AppTheme.error,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  return;
                }
                if (_selectedColor == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please select a color', style: GoogleFonts.jost()),
                      backgroundColor: AppTheme.error,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  return;
                }
                context.read<CartProvider>().addItem(product, _selectedSize!, _selectedColor!);
                
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                  builder: (context) => Container(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 48, height: 48,
                          decoration: const BoxDecoration(color: AppTheme.primary, shape: BoxShape.circle),
                          child: const Icon(Icons.check, color: Colors.white, size: 28),
                        ),
                        const SizedBox(height: 16),
                        Text('Added to Cart', style: GoogleFonts.cormorant(fontSize: 22, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 8),
                        Text('${product.name} has been added to your curated collection.', 
                          style: GoogleFonts.jost(fontSize: 13, color: AppTheme.textSecondary),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context); // Close sheet
                              Navigator.push(context, MaterialPageRoute(builder: (_) => CheckoutScreen()));
                            },
                            child: Text('SECURE CHECKOUT →', style: GoogleFonts.jost(fontWeight: FontWeight.w700)),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('CONTINUE SHOPPING', style: GoogleFonts.jost(color: AppTheme.textMuted, letterSpacing: 1.0, fontSize: 11)),
                        ),
                      ],
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'ADD TO CART →',
                style: GoogleFonts.jost(
                  fontSize: 13, fontWeight: FontWeight.w700,
                  letterSpacing: 1.5, color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailBadge extends StatelessWidget {
  final IconData icon;
  final String label;

  const _DetailBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 12, color: AppTheme.textMuted),
        const SizedBox(width: 4),
        Text(label, style: GoogleFonts.jost(
          fontSize: 9, color: AppTheme.textMuted, letterSpacing: 0.5,
        )),
      ],
    );
  }
}
