import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/assets/icons.dart';
import 'package:language/presentation/routes/routes_name.dart';
import 'package:language/presentation/views/home_view.dart';
import 'package:language/presentation/widgets/custom_text_field.dart';
import 'package:language/utils/formatters.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController controllerPhone;
  late TextEditingController controllerPassword;
  bool _showPassword = false;

  @override
  void initState() {
    controllerPhone = TextEditingController();
    controllerPassword = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 240,
              decoration: BoxDecoration(
                color: Colors.blueAccent[200],
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.elliptical(80, 80),
                ),
              ),
              child: Center(
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppIcons.quiz.svg(
                        height: 120,
                        width: 120,
                        color: white,
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 28,
                          color: white,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent[200],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.elliptical(80, 80),
                    topRight: Radius.elliptical(10, 10),
                    bottomLeft: Radius.elliptical(10, 10),
                    bottomRight: Radius.elliptical(80, 80),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 42, bottom: 8),
                      child: CustomTextField(
                        controller: controllerPhone,
                        hintText: "Enter phone number",
                        borderRadius: 20,
                        borderColor: white,
                        keyboardType: TextInputType.phone,
                        formatter: [Formatters.phoneFormatter],
                        enableBorderColor: white,
                        fillColor: white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 42, top: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          obscureText: !_showPassword,
                          controller: controllerPassword,
                          decoration: InputDecoration(
                            fillColor: white,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(12),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              icon: Icon(
                                Icons.remove_red_eye_outlined,
                                color: _showPassword
                                    ? Colors.blueAccent[200]
                                    : grey,
                              ),
                            ),
                            hintText: "Enter your password",
                            hintStyle: const TextStyle(
                              color: greyText,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeView(),
                  ),
                );
                // context.go(AppRouteName.home);
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.blueAccent[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Don't have an account?  ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: black,
                      ),
                    ),
                    TextSpan(
                      text: "Register",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueAccent[200],
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.go(AppRouteName.register);
                        },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
