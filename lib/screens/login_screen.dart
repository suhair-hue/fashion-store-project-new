import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'register_screen.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  final _formKey = GlobalKey<FormState>();
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    setState(() {
      _emailError = _emailController.text.isEmpty ? 'Please enter email' : null;
      _passwordError = _passwordController.text.isEmpty ? 'Please enter password' : null;
    });

    if (_emailError == null && _passwordError == null) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const MainScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 48),
                  // Logo
                  _buildLogo(),
                  const SizedBox(height: 40),
                  // Welcome text
                  Text(
                    'Welcome Back to the\nGallery',
                    style: GoogleFonts.cormorant(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign in to access your curated collection.',
                    style: GoogleFonts.jost(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 36),
                  // Email field
                  _buildLabel('EMAIL ADDRESS'),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: GoogleFonts.jost(fontSize: 14, color: AppTheme.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'suhair@email.com',
                      errorText: _emailError,
                      hintStyle: GoogleFonts.jost(
                        fontSize: 13,
                        color: AppTheme.textMuted,
                      ),
                      enabledBorder: _emailError != null 
                        ? OutlineInputBorder(borderSide: const BorderSide(color: AppTheme.error), borderRadius: BorderRadius.circular(4))
                        : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Password field
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildLabel('PASSWORD'),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Forgot?',
                          style: GoogleFonts.jost(
                            fontSize: 11,
                            color: AppTheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: GoogleFonts.jost(fontSize: 14, color: AppTheme.textPrimary),
                    decoration: InputDecoration(
                      hintText: '••••••••',
                      errorText: _passwordError,
                      enabledBorder: _passwordError != null 
                        ? OutlineInputBorder(borderSide: const BorderSide(color: AppTheme.error), borderRadius: BorderRadius.circular(4))
                        : null,
                      suffixIcon: GestureDetector(
                        onTap: () =>
                            setState(() => _obscurePassword = !_obscurePassword),
                        child: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 18,
                          color: AppTheme.textMuted,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 28),
                // Login button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _login,
                    child: Text(
                      'LOGIN',
                      style: GoogleFonts.jost(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Divider
                Row(
                  children: [
                    const Expanded(child: Divider(color: AppTheme.lightGrey)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'or',
                        style: GoogleFonts.jost(
                          fontSize: 12,
                          color: AppTheme.textMuted,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider(color: AppTheme.lightGrey)),
                  ],
                ),
                const SizedBox(height: 20),
                // Create account button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'CREATE ACCOUNT',
                      style: GoogleFonts.jost(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2.0,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'By signing in you agree to our Terms of Service and Privacy Policy.',
                  style: GoogleFonts.jost(
                    fontSize: 10,
                    color: AppTheme.textMuted,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: GoogleFonts.jost(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: AppTheme.textSecondary,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.primary, width: 1.5),
          ),
          child: const Center(
            child: Icon(
              Icons.diamond_outlined,
              color: AppTheme.primary,
              size: 22,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'FASHION STORE',
          style: GoogleFonts.jost(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 3.0,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }
}
