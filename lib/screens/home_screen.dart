import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../widgets/product_card.dart';
import 'product_listing_screen.dart';
import 'product_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  List<Product> _filteredProducts = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredProducts = MockData.products.take(6).toList();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
      if (_searchQuery.isEmpty) {
        _filteredProducts = MockData.products.take(6).toList();
      } else {
        _filteredProducts = MockData.products.where((product) {
          return product.name.toLowerCase().contains(_searchQuery) ||
              product.category.toLowerCase().contains(_searchQuery);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          // AppBar
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: const Padding(
              padding: EdgeInsets.all(12),
              child: Icon(Icons.menu, color: AppTheme.textPrimary, size: 22),
            ),
            title: Text(
              'FASHION STORE',
              style: GoogleFonts.jost(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                letterSpacing: 3.0,
                color: AppTheme.textPrimary,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none, color: AppTheme.textPrimary, size: 22),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Container(
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: GoogleFonts.jost(fontSize: 14, color: AppTheme.textPrimary),
                      decoration: InputDecoration(
                        hintText: 'Search the collection...',
                        hintStyle: GoogleFonts.jost(fontSize: 13, color: AppTheme.textMuted),
                        prefixIcon: const Icon(Icons.search, size: 18, color: AppTheme.textMuted),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 11),
                        suffixIcon: _searchQuery.isNotEmpty 
                          ? GestureDetector(
                              onTap: () => _searchController.clear(),
                              child: const Icon(Icons.close, size: 16, color: AppTheme.textMuted),
                            )
                          : null,
                      ),
                    ),
                  ),
                ),

                if (_searchQuery.isEmpty) ...[
                  // Categories
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Categories',
                          style: GoogleFonts.jost(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'VIEW ALL',
                            style: GoogleFonts.jost(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primary,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Category pills
                  SizedBox(
                    height: 80,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _CategoryChip(
                          label: 'READY-TO-WEAR',
                          icon: Icons.checkroom_outlined,
                          onTap: () => _goToListing(context, 'READY-TO-WEAR'),
                        ),
                        _CategoryChip(
                          label: 'ACCESSORIES',
                          icon: Icons.watch_outlined,
                          onTap: () => _goToListing(context, 'ACCESSORIES'),
                        ),
                        _CategoryChip(
                          label: 'FOOTWEAR',
                          icon: Icons.ice_skating_outlined,
                          onTap: () => _goToListing(context, 'FOOTWEAR'),
                        ),
                        _CategoryChip(
                          label: 'KNITWEAR',
                          icon: Icons.dry_cleaning_outlined,
                          onTap: () => _goToListing(context, 'KNITWEAR'),
                        ),
                      ],
                    ),
                  ),

                  // Hero Banner
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: GestureDetector(
                      onTap: () => _goToListing(context, null),
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800',
                              fit: BoxFit.cover,
                              errorWidget: (c, u, e) => Container(color: AppTheme.darkGrey),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.black.withOpacity(0.75),
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
                                    'Midnight',
                                    style: GoogleFonts.cormorant(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      height: 1.1,
                                    ),
                                  ),
                                  Text(
                                    'Couture',
                                    style: GoogleFonts.cormorant(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      height: 1.1,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    color: AppTheme.primary,
                                    child: Text(
                                      'Explore Now',
                                      style: GoogleFonts.jost(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1.5,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 16,
                              right: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Alchemy',
                                    style: GoogleFonts.cormorant(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ),
                                  Text(
                                    'SUMMER WORK',
                                    style: GoogleFonts.jost(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: AppTheme.primary,
                                      letterSpacing: 2.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],

                // New Arrivals / Search Results
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _searchQuery.isEmpty ? 'New Arrivals' : 'Search Results',
                        style: GoogleFonts.jost(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      if (_searchQuery.isEmpty)
                        GestureDetector(
                          onTap: () => _goToListing(context, null),
                          child: const Icon(
                            Icons.grid_view_outlined,
                            size: 18,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                    ],
                  ),
                ),

                // Product Grid
                if (_filteredProducts.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Column(
                        children: [
                          const Icon(Icons.search_off, size: 48, color: AppTheme.lightGrey),
                          const SizedBox(height: 12),
                          Text(
                            'No products found.',
                            style: GoogleFonts.jost(color: AppTheme.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                              builder: (_) => ProductDetailsScreen(
                                product: _filteredProducts[index],
                              ),
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

  void _goToListing(BuildContext context, String? category) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ProductListingScreen(initialCategory: category)),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _CategoryChip({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppTheme.lightGrey, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: AppTheme.textPrimary),
            const SizedBox(height: 6),
            Text(
              label,
              style: GoogleFonts.jost(
                fontSize: 9, fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary, letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
