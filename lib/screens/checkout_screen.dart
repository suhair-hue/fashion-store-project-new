import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../models/cart_provider.dart';
import 'main_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _currentStep = 0; // 0=shipping, 1=payment, 2=review
  final _nameController = TextEditingController(text: 'Home – Sungawila');
  final _addressController = TextEditingController(
    text: '117 Jayapura, Sungawila\nPolonnaruwa, Sri Lanka',
  );
  int _selectedCard = -1; // -1 = none, 0 = Visa, 1 = COD

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: AppTheme.textPrimary,
          ),
        ),
        title: Text(
          'Checkout',
          style: GoogleFonts.cormorant(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              size: 20,
              color: AppTheme.textPrimary,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Step indicator
          _StepIndicator(currentStep: _currentStep),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rendering based on _currentStep
                  if (_currentStep == 0) ...[
                    // Step 0: Shipping Address
                    _SectionHeader(
                      title: 'Shipping Address',
                      actionLabel: 'CHANGE',
                      onAction: () => _showAddressDialog(),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.divider),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: AppTheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(
                              Icons.location_on_outlined,
                              size: 18,
                              color: AppTheme.primary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _nameController.text,
                                  style: GoogleFonts.jost(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                                Text(
                                  _addressController.text,
                                  style: GoogleFonts.jost(
                                    fontSize: 11,
                                    color: AppTheme.textSecondary,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: AppTheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_nameController.text.isEmpty ||
                              _addressController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter name and address'),
                              ),
                            );
                            return;
                          }
                          setState(() => _currentStep = 1);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'CONTINUE TO PAYMENT →',
                          style: GoogleFonts.jost(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ] else if (_currentStep == 1) ...[
                    // Step 1: Payment Method
                    _SectionHeader(
                      title: 'Payment Method',
                      actionLabel: null,
                      onAction: null,
                    ),
                    const SizedBox(height: 12),
                    _PaymentCard(
                      label: 'VISA',
                      subtitle: '**** **** **** 2342',
                      icon: Icons.credit_card,
                      isSelected: _selectedCard == 0,
                      onTap: () => setState(() => _selectedCard = 0),
                    ),
                    const SizedBox(height: 12),
                    _PaymentCard(
                      label: 'CASH ON DELIVERY',
                      subtitle: 'Pay when your order arrives',
                      icon: Icons.payments_outlined,
                      isSelected: _selectedCard == 1,
                      onTap: () => setState(() => _selectedCard = 1),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_selectedCard == -1) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select a payment method'),
                              ),
                            );
                            return;
                          }
                          setState(() => _currentStep = 2);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'CONTINUE TO REVIEW →',
                          style: GoogleFonts.jost(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: TextButton(
                        onPressed: () => setState(() => _currentStep = 0),
                        child: Text(
                          'BACK TO SHIPPING',
                          style: GoogleFonts.jost(
                            fontSize: 11,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ] else if (_currentStep == 2) ...[
                    // Step 2: Order Review
                    _SectionHeader(
                      title: 'Order Summary',
                      actionLabel: null,
                      onAction: null,
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F8F8),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.local_shipping_outlined,
                            size: 16,
                            color: AppTheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Tracking: 1299...742',
                            style: GoogleFonts.jost(
                              fontSize: 11,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'STANDARD SHIPPING',
                            style: GoogleFonts.jost(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.primary,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _SummaryRow(
                      label: 'Subtotal (${cart.itemCount} items)',
                      value: 'LKR ${cart.subtotal.toStringAsFixed(0)}.00',
                    ),
                    const SizedBox(height: 8),
                    const _SummaryRow(
                      label: 'Shipping Charges',
                      value: 'LKR 400',
                    ),
                    const SizedBox(height: 8),
                    const _SummaryRow(
                      label: 'Import Duties',
                      value: 'Included',
                    ),
                    const Divider(color: AppTheme.divider, height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount',
                          style: GoogleFonts.jost(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        Text(
                          'LKR ${cart.total.toStringAsFixed(0)}.00',
                          style: GoogleFonts.jost(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _placeOrder(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'PLACE ORDER →',
                          style: GoogleFonts.jost(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: TextButton(
                        onPressed: () => setState(() => _currentStep = 1),
                        child: Text(
                          'BACK TO PAYMENT',
                          style: GoogleFonts.jost(
                            fontSize: 11,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  // Info box (visible on all steps or just final? let's keep on final)
                  if (_currentStep == 2)
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Every piece is hand-selected from premier artisan collections under precise color calibration for you to purchase with confidence.',
                        style: GoogleFonts.jost(
                          fontSize: 11,
                          color: AppTheme.textSecondary,
                          height: 1.6,
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                  Center(
                    child: Text(
                      'Secure checkout. All major cards accepted.',
                      style: GoogleFonts.jost(
                        fontSize: 10,
                        color: AppTheme.textMuted,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddressDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Edit Shipping Address',
          style: GoogleFonts.cormorant(fontWeight: FontWeight.w700),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name/Title',
                labelStyle: GoogleFonts.jost(fontSize: 12),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _addressController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Full Address',
                labelStyle: GoogleFonts.jost(fontSize: 12),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'CANCEL',
              style: GoogleFonts.jost(color: AppTheme.textMuted),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {});
              Navigator.pop(context);
            },
            child: Text(
              'SAVE',
              style: GoogleFonts.jost(
                color: AppTheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _placeOrder(BuildContext context) {
    if (_currentStep == 1 && _selectedCard == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a payment method')),
      );
      return;
    }

    // Create the order in session before showing dialog
    context.read<CartProvider>().placeOrder();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: AppTheme.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 28),
            ),
            const SizedBox(height: 16),
            Text(
              'Order Placed!',
              style: GoogleFonts.cormorant(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your order has been successfully placed. We\'ll notify you when it ships.',
              style: GoogleFonts.jost(
                fontSize: 12,
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.read<CartProvider>().clear();
                  // Return to the main screen (shopping)
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => MainScreen()),
                    (route) => false,
                  );
                },
                child: Text(
                  'CONTINUE SHOPPING',
                  style: GoogleFonts.jost(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final int currentStep;

  const _StepIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          _Step(label: 'SHIPPING', index: 0, currentStep: currentStep),
          _StepLine(isActive: currentStep >= 1),
          _Step(label: 'PAYMENT', index: 1, currentStep: currentStep),
          _StepLine(isActive: currentStep >= 2),
          _Step(label: 'REVIEW', index: 2, currentStep: currentStep),
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  final String label;
  final int index;
  final int currentStep;

  const _Step({
    required this.label,
    required this.index,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = index <= currentStep;
    return Column(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: isActive ? AppTheme.primary : AppTheme.lightGrey,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: GoogleFonts.jost(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: isActive ? Colors.white : AppTheme.textMuted,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.jost(
            fontSize: 8,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
            color: isActive ? AppTheme.primary : AppTheme.textMuted,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

class _StepLine extends StatelessWidget {
  final bool isActive;

  const _StepLine({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 1,
        margin: const EdgeInsets.only(bottom: 18, left: 4, right: 4),
        color: isActive ? AppTheme.primary : AppTheme.lightGrey,
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _SectionHeader({required this.title, this.actionLabel, this.onAction});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.jost(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
            letterSpacing: 0.3,
          ),
        ),
        if (actionLabel != null)
          GestureDetector(
            onTap: onAction,
            child: Text(
              actionLabel!,
              style: GoogleFonts.jost(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppTheme.primary,
                letterSpacing: 1.0,
              ),
            ),
          ),
      ],
    );
  }
}

class _PaymentCard extends StatelessWidget {
  final String label;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentCard({
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppTheme.primary : AppTheme.divider,
            width: isSelected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.primary.withOpacity(0.1)
                    : AppTheme.lightGrey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                icon,
                size: 20,
                color: isSelected ? AppTheme.primary : AppTheme.textMuted,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.jost(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.jost(
                      fontSize: 11,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: AppTheme.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 12, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.jost(fontSize: 12, color: AppTheme.textSecondary),
        ),
        Text(
          value,
          style: GoogleFonts.jost(
            fontSize: 12,
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
