import 'package:flutter/material.dart';
import 'package:konnecti/components/cards/ForgotPasswordScreen.dart';
import 'package:konnecti/components/components.dart';
import 'package:konnecti/l10n/app_localizations.dart';
import 'package:konnecti/providers/AuthProvider.dart';
import 'package:konnecti/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _authService = AuthService();

  bool isLoading = false;
  bool rememberMe = false;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  void _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email');
    final savedPassword = prefs.getString('password');

    if (savedEmail != null && savedPassword != null) {
      setState(() {
        emailController.text = savedEmail;
        passwordController.text = savedPassword;
        rememberMe = true;
      });
    }
  }

  void handleLogin() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    final result = await _authService.login(
      context,
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    setState(() => isLoading = false);

    if (result['success']) {
      final token = result['token'];
      final userId = result['id']; // <-- correspond à ton backend

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', token);
      await prefs.setString('user_id', userId);

      // ✅ mettre aussi à jour AuthProvider
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.setAccessToken(token);
      await authProvider.setUserId(userId);

      if (rememberMe) {
        await prefs.setString('email', emailController.text.trim());
        await prefs.setString('password', passwordController.text.trim());
      } else {
        await prefs.remove('email');
        await prefs.remove('password');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.loginSuccess)),
      );

      print("✅ ID utilisateur: $userId");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BottomBarOnlyPage()),
      );
    } else {
      setState(() {
        error = result['message'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    double heightScreen = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          showCursor: true,
          cursorColor: Colors.black,
          cursorOpacityAnimates: true,
          controller: emailController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.withOpacity(0.15),
            hintText: tr.enterEmail,
            suffixIcon: const Icon(Icons.email_outlined),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          cursorColor: Colors.black,
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.withOpacity(0.15),
            hintText: tr.password,
            suffixIcon: const Icon(Icons.lock_outline),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: rememberMe,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  side: BorderSide(color: Colors.grey.withOpacity(0.5)),
                  activeColor: Colors.blue,
                  checkColor: Colors.white,
                  onChanged: (val) {
                    setState(() {
                      rememberMe = val!;
                    });
                  },
                ),
                Text(tr.rememberMe),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ForgotPasswordScreen(),
                  ),
                );
              },
              child: Text(
                tr.forgetPassword,
                style: const TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              error!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
        SizedBox(height: heightScreen * 0.15),
        SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: isLoading ? null : handleLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff0076F7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child:
                isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                      tr.login,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
          ),
        ),
      ],
    );
  }
}
