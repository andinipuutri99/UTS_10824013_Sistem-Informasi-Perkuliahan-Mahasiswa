// lib/screens/register_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../constants/app_theme.dart';
import '../constants/mock_data.dart';
import '../widgets/app_card.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  String _error = '';
  String _selectedFaculty = '';

  final _fullNameCtrl = TextEditingController();
  final _nimCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _classCtrl = TextEditingController();
  final _studyProgramCtrl = TextEditingController();
  final _yearCtrl = TextEditingController(text: '2024');
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();

  @override
  void dispose() {
    _fullNameCtrl.dispose();
    _nimCtrl.dispose();
    _usernameCtrl.dispose();
    _emailCtrl.dispose();
    _classCtrl.dispose();
    _studyProgramCtrl.dispose();
    _yearCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    setState(() => _error = '');

    final isEmpty = [
      _fullNameCtrl,
      _nimCtrl,
      _usernameCtrl,
      _emailCtrl,
      _classCtrl,
      _studyProgramCtrl,
      _yearCtrl,
      _passwordCtrl,
      _confirmPasswordCtrl,
    ].any((c) => c.text.isEmpty) || _selectedFaculty.isEmpty;

    if (isEmpty) {
      setState(() => _error = 'Semua field wajib diisi.');
      return;
    }

    if (!_emailCtrl.text.contains('@') || !_emailCtrl.text.contains('.')) {
      setState(() => _error = 'Format email tidak valid.');
      return;
    }

    if (_passwordCtrl.text != _confirmPasswordCtrl.text) {
      setState(() => _error = 'Password tidak sama.');
      return;
    }

    setState(() => _loading = true);
    try {
      await context.read<UserProvider>().register(
            fullName: _fullNameCtrl.text,
            nim: _nimCtrl.text,
            username: _usernameCtrl.text,
            email: _emailCtrl.text,
            className: _classCtrl.text,
            studyProgram: _studyProgramCtrl.text,
            faculty: _selectedFaculty,
            yearOfEntry: _yearCtrl.text,
            password: _passwordCtrl.text,
          );
      if (mounted) {
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    } catch (e) {
      setState(() => _error = e.toString().replaceAll('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryCream,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              // Header
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 16,
                        )
                      ],
                    ),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.school_rounded,
                          size: 36, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Kampus!n',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primaryContainer,
                      letterSpacing: -1,
                    ),
                  ),
                  Text(
                    'STAY ON TRACK, STAY KAMPUS!N',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey[500],
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              AppCard(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Join your academic community today.',
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                    if (_error.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF5F5),
                          borderRadius: BorderRadius.circular(10),
                          border: const Border(
                            left: BorderSide(color: Colors.red, width: 4),
                          ),
                        ),
                        child: Text(
                          _error,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InputField(
                            label: 'Full Name',
                            hint: 'Enter your full name',
                            controller: _fullNameCtrl,
                            prefixIcon: const Icon(Icons.person_outline_rounded,
                                size: 20, color: Color(0xFF94A3B8)),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Expanded(
                                child: InputField(
                                  label: 'NIM',
                                  hint: '12345678',
                                  controller: _nimCtrl,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: InputField(
                                  label: 'Username',
                                  hint: '@student',
                                  controller: _usernameCtrl,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          InputField(
                            label: 'Campus Email',
                            hint: 'student@university.ac.id',
                            controller: _emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: const Icon(Icons.email_outlined,
                                size: 20, color: Color(0xFF94A3B8)),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Expanded(
                                child: InputField(
                                  label: 'Class',
                                  hint: '2023-A',
                                  controller: _classCtrl,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'FACULTY',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF94A3B8),
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(14),
                                        border: Border.all(
                                          color: const Color(0xFFE2E8F0),
                                          width: 1.5,
                                        ),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: _selectedFaculty.isEmpty
                                              ? null
                                              : _selectedFaculty,
                                          hint: const Text(
                                            'Select',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xFFCBD5E1),
                                            ),
                                          ),
                                          isExpanded: true,
                                          items: faculties
                                              .map((f) =>
                                                  DropdownMenuItem(
                                                    value: f,
                                                    child: Text(f,
                                                        style: const TextStyle(
                                                            fontSize: 12)),
                                                  ))
                                              .toList(),
                                          onChanged: (v) => setState(
                                              () => _selectedFaculty = v!),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          InputField(
                            label: 'Study Program',
                            hint: 'Informatics Engineering',
                            controller: _studyProgramCtrl,
                          ),
                          const SizedBox(height: 14),
                          InputField(
                            label: 'Password',
                            hint: '••••••••',
                            controller: _passwordCtrl,
                            obscureText: true,
                            prefixIcon: const Icon(Icons.lock_outline_rounded,
                                size: 20, color: Color(0xFF94A3B8)),
                          ),
                          const SizedBox(height: 14),
                          InputField(
                            label: 'Confirm Password',
                            hint: '••••••••',
                            controller: _confirmPasswordCtrl,
                            obscureText: true,
                            prefixIcon: const Icon(Icons.key_rounded,
                                size: 20, color: Color(0xFF94A3B8)),
                          ),
                          const SizedBox(height: 24),
                          PrimaryButton(
                            label: _loading ? 'Processing...' : 'Register',
                            isLoading: _loading,
                            onPressed: _handleSubmit,
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: RichText(
                                text: const TextSpan(
                                  text: 'Already have an account? ',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF64748B),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Login here',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
