import 'package:flutter/material.dart';
import 'package:konnecti/l10n/app_localizations.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  String? message;
  bool success = false;

  void handleReset() async {
    if (emailController.text.trim().isEmpty) {
      setState(() => message = "Please enter your email");
      return;
    }

    setState(() {
      isLoading = true;
      message = null;
    });

    // 🔹 TODO: Connect with backend reset endpoint
    await Future.delayed(const Duration(seconds: 2)); // Mock delay

    setState(() {
      isLoading = false;
      success = true;
      message = "Password reset link sent to your email.";
    });
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(tr.forgetPassword),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.lock_reset, size: 90, color: Colors.blue),
            const SizedBox(height: 30),

            Text(
              tr.forgetPassword,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),
            Text(
              "Enter your email and we will send you a reset link",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),
            TextField(
              cursorColor: Colors.black,
              controller: emailController,
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.withOpacity(0.15),
                hintText: tr.enterEmail,
                suffixIcon: const Icon(Icons.lock_outline),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            if (message != null)
              Text(
                message!,
                style: TextStyle(
                  color: success ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),

            SizedBox(height: h * 0.12),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : handleReset,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff0076F7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child:
                    isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                          "Send Reset Link",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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
