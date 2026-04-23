import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/product_card.dart';
import 'product_details_screen.dart';

class ProductListingScreen extends StatefulWidget {
  final String? initialCategory;

  const ProductListingScreen({super.key, this.initialCategory});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  String _selectedSort = 'SORT';
  String? _selectedCategory;
  String? _selectedSize;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
  }

  List<Product> get _filteredProducts {
    if (_selectedCategory == null || _selectedCategory == 'ALL') {
      return MockData.products;
    }
    return MockData.products
        .where((p) => p.category.contains(_selectedCategory!))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Icon(Icons.arrow_back_ios, size: 18, color: AppTheme.textPrimary),
              ),
            ),
            title: Text(
              'COLLECTIONS',
              style: GoogleFonts.jost(
                fontSize: 12, fontWeight: FontWeight.w700,
                letterSpacing: 2.5, color: AppTheme.textPrimary,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: AppTheme.textPrimary, size: 22),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero banner
                Container(
                  height: 140,
                  width: double.infinity,
                  color: AppTheme.darkGrey,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          'https://images.unsplash.com/photo-1445205170230-053b83016050?w=800',
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => Container(color: AppTheme.darkGrey),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Midnight\nCouture',
                              style: GoogleFonts.cormorant(
                                fontSize: 28, fontWeight: FontWeight.w700,
                                color: Colors.white, height: 1.1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Curated experiences for the modern atelier.',
                              style: GoogleFonts.jost(
                                fontSize: 10, color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Filter row
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      _FilterChip(
                        icon: Icons.tune,
                        label: '= FILTER',
                        onTap: () => _showFilterBottomSheet(context),
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        icon: Icons.swap_vert,
                        label: 'SORT: NEWEST',
                        onTap: () {},
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(label: 'SIZE', onTap: () {}),
                      const SizedBox(width: 8),
                      _FilterChip(label: 'PRICE', onTap: () {}),
                    ],
                  ),
                ),
                const Divider(height: 1, color: AppTheme.divider),

                // Products grid
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.58,
                    ),
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: _filteredProducts[index],
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailsScreen(product: _filteredProducts[index]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('FILTER', style: GoogleFonts.jost(
                  fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 1.5,
                )),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text('CATEGORY', style: GoogleFonts.jost(
              fontSize: 10, fontWeight: FontWeight.w600,
              color: AppTheme.textMuted, letterSpacing: 1.0,
            )),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8, runSpacing: 8,
              children: ['ALL', ...MockData.categories].map((cat) {
                final isSelected = _selectedCategory == cat || (cat == 'ALL' && _selectedCategory == null);
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedCategory = cat == 'ALL' ? null : cat);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.primary : Colors.transparent,
                      border: Border.all(
                        color: isSelected ? AppTheme.primary : AppTheme.lightGrey,
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text(
                      cat,
                      style: GoogleFonts.jost(
                        fontSize: 11, fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                        color: isSelected ? Colors.white : AppTheme.textPrimary,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onTap;

  const _FilterChip({required this.label, this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.lightGrey),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 12, color: AppTheme.textSecondary),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: GoogleFonts.jost(
                fontSize: 10, fontWeight: FontWeight.w600,
                color: AppTheme.textSecondary, letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
