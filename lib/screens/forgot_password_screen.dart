// lib/screens/forgot_password_screen.dart

import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import '../widgets/app_card.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  int _step = 1;
  bool _loading = false;
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnim =
        CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _nextStep() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (mounted) {
      setState(() {
        _step++;
        _loading = false;
      });
      _animCtrl.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryCream,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Text(
                  'Kampus!n',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryContainer,
                    letterSpacing: -1,
                  ),
                ),
                const Text(
                  'RESET ACCESS',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF94A3B8),
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 32),
                FadeTransition(
                  opacity: _fadeAnim,
                  child: AppCard(
                    padding: const EdgeInsets.all(28),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, anim) => SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.3, 0),
                          end: Offset.zero,
                        ).animate(anim),
                        child: FadeTransition(opacity: anim, child: child),
                      ),
                      child: _buildStep(),
                    ),
                  ),
                ),
                if (_step < 4) ...[
                  const SizedBox(height: 16),
                  TextButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.chevron_left_rounded,
                        color: Color(0xFF94A3B8)),
                    label: const Text(
                      'Back to Login',
                      style: TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStep() {
    switch (_step) {
      case 1:
        return _StepWidget(
          key: const ValueKey(1),
          title: 'Forgot Password?',
          subtitle: 'Enter your campus email to receive a reset token.',
          child: Column(
            children: [
              InputField(
                label: 'Campus Email',
                hint: 'student@university.ac.id',
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email_outlined,
                    size: 20, color: Color(0xFF94A3B8)),
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                label: 'Send Logic Token',
                isLoading: _loading,
                onPressed: _nextStep,
                icon: const Icon(Icons.send_rounded,
                    size: 18, color: Colors.white),
              ),
            ],
          ),
        );
      case 2:
        return _StepWidget(
          key: const ValueKey(2),
          title: 'Verify Identity',
          subtitle: "We've sent a 6-digit code to your email.",
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6,
                  (i) => SizedBox(
                    width: 44,
                    height: 56,
                    child: TextFormField(
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.darkBlue,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color(0xFFE2E8F0), width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color(0xFFE2E8F0), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: AppColors.primaryContainer, width: 2),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                label: 'Verify Code',
                isLoading: _loading,
                onPressed: _nextStep,
              ),
              const SizedBox(height: 12),
              Center(
                child: RichText(
                  text: const TextSpan(
                    text: "Didn't receive? ",
                    style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                    children: [
                      TextSpan(
                        text: 'Resend',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      case 3:
        return _StepWidget(
          key: const ValueKey(3),
          title: 'New Password',
          subtitle: 'Create a strong password to secure your account.',
          child: Column(
            children: [
              InputField(
                label: 'New Password',
                hint: '••••••••',
                controller: _passwordCtrl,
                obscureText: true,
                prefixIcon: const Icon(Icons.key_rounded,
                    size: 20, color: Color(0xFF94A3B8)),
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                label: 'Reset Password',
                isLoading: _loading,
                onPressed: _nextStep,
              ),
            ],
          ),
        );
      case 4:
        return _SuccessWidget(
          key: const ValueKey(4),
          onLoginTap: () => Navigator.of(context)
              .popUntil((route) => route.isFirst),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class _StepWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const _StepWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: AppColors.darkBlue,
          ),
        ),
        const SizedBox(height: 6),
        Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
        const SizedBox(height: 24),
        child,
      ],
    );
  }
}

class _SuccessWidget extends StatelessWidget {
  final VoidCallback onLoginTap;

  const _SuccessWidget({super.key, required this.onLoginTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xFFDCFCE7),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_circle_rounded,
              size: 44, color: AppColors.primary),
        ),
        const SizedBox(height: 20),
        const Text(
          'Success!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: AppColors.darkBlue,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Your password has been successfully updated.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, color: Colors.grey[500]),
        ),
        const SizedBox(height: 24),
        PrimaryButton(
          label: 'Back to Login',
          onPressed: onLoginTap,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
