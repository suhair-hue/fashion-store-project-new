import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../models/cart_provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionOrders = context.watch<CartProvider>().orders;
    final allOrders = [...sessionOrders, ...MockData.orders];

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: const Padding(
          padding: EdgeInsets.all(12),
          child: Icon(Icons.menu, size: 22, color: AppTheme.textPrimary),
        ),
        title: Text('FASHION STORE', style: GoogleFonts.jost(
          fontSize: 13, fontWeight: FontWeight.w800,
          letterSpacing: 3.0, color: AppTheme.textPrimary,
        )),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 22, color: AppTheme.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: Text('Your Orders', style: GoogleFonts.cormorant(
              fontSize: 30, fontWeight: FontWeight.w700, color: AppTheme.textPrimary,
            )),
          ),
          Expanded(
            child: allOrders.isEmpty 
              ? Center(child: Text('No orders yet.', style: GoogleFonts.jost(color: AppTheme.textSecondary)))
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: allOrders.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return _OrderCard(order: allOrders[index]);
                  },
                ),
          ),
        ],
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Order order;

  const _OrderCard({required this.order});

  Color get _statusColor {
    switch (order.status) {
      case 'DELIVERED': return AppTheme.success;
      case 'PROCESSING': return AppTheme.primary;
      default: return AppTheme.textMuted;
    }
  }

  String get _statusText {
    switch (order.status) {
      case 'DELIVERED': return '✓ Delivered';
      case 'PROCESSING': return '⟳ Preparing for dispatch';
      default: return order.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppTheme.divider, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order #${order.id}', style: GoogleFonts.jost(
                      fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.textPrimary,
                    )),
                    const SizedBox(height: 2),
                    Text(
                      '${order.date.day} Oct ${order.date.year}',
                      style: GoogleFonts.jost(fontSize: 10, color: AppTheme.textMuted),
                    ),
                  ],
                ),
                Text('LKR ${order.total.toStringAsFixed(0)}.00', style: GoogleFonts.jost(
                  fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.textPrimary,
                )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                ...order.items.take(3).map((item) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _ProductThumb(url: item.product.imageUrl),
                )).toList(),
                if (order.items.length > 3)
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppTheme.lightGrey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text('+${order.items.length - 3}', style: GoogleFonts.jost(
                        fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.textSecondary,
                      )),
                    ),
                  ),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Text('VIEW DETAILS', style: GoogleFonts.jost(
                    fontSize: 9, fontWeight: FontWeight.w700,
                    color: AppTheme.primary, letterSpacing: 1.0,
                  )),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Divider(color: AppTheme.divider, height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      order.status == 'DELIVERED' ? Icons.check_circle_outline : Icons.pending_outlined,
                      size: 14,
                      color: _statusColor,
                    ),
                    const SizedBox(width: 6),
                    Text(_statusText, style: GoogleFonts.jost(
                      fontSize: 11, fontWeight: FontWeight.w600,
                      color: _statusColor,
                    )),
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.lightGrey),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text('VIEW', style: GoogleFonts.jost(
                      fontSize: 9, fontWeight: FontWeight.w700,
                      color: AppTheme.textSecondary, letterSpacing: 1.0,
                    )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductThumb extends StatelessWidget {
  final String url;

  const _ProductThumb({required this.url});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Image.network(
        url,
        width: 56,
        height: 56,
        fit: BoxFit.cover,
        errorBuilder: (c, e, s) => Container(
          width: 56, height: 56,
          decoration: BoxDecoration(
            color: AppTheme.lightGrey,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
