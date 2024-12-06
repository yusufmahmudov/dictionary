import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:language/application/user/user_bloc.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/assets/icons.dart';
import 'package:language/data/register.dart';
import 'package:language/presentation/routes/routes_name.dart';
import 'package:language/presentation/widgets/custom_text_field.dart';
import 'package:language/utils/custom_toast_bar.dart';
import 'package:language/utils/formatters.dart';
import 'package:language/utils/generate_random.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController controllerPhone;
  late TextEditingController controllerPassword;
  late TextEditingController controllerName;

  bool _showPassword = false;
  bool hasUpperCase = false;
  bool hasLowerCase = false;
  bool hasMinLength = false;
  bool hasCorrectText = false;

  @override
  void initState() {
    controllerName = TextEditingController();
    controllerPassword = TextEditingController();
    controllerPhone = TextEditingController();
    super.initState();
  }

  void validatePassword(String value) {
    setState(() {
      hasUpperCase = value.contains(RegExp(r'[A-Z]'));
      hasLowerCase = value.contains(RegExp(r'[a-z]'));
      hasMinLength = value.length >= 8;
      hasCorrectText = value.contains(' ') == true ? false : true;
    });
  }

  int _submitForm() {
    if (controllerPassword.text.isEmpty ||
        controllerPhone.text.isEmpty ||
        controllerName.text.isEmpty) {
      return -1; // -1 Ba'zi maydonlar bo'sh
    } else if (controllerPassword.text.isNotEmpty &&
        controllerPhone.text.isNotEmpty) {
      if (!hasUpperCase && !hasLowerCase && !hasMinLength) {
        return -2; // -2 - Password talablari bajarilmagan
      } else if (!hasUpperCase) {
        return -3; // -3 - hasUpperCase
      } else if (!hasLowerCase) {
        return -4; // -4 - hasLowerCase
      } else if (!hasMinLength) {
        return -5; // -5 - minLength
      } else if (!hasCorrectText) {
        return -7;
      }
      if (controllerPhone.text.length != 19) {
        return -6; // -6 telefon raqamni to'g'riligini tekshirish
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          // BLoC holatiga qarab turli reaktsiyalarni ko'rsatish
          if (state.statusUser == FormzSubmissionStatus.success) {
            // Register muvaffaqiyatli bo'lsa
            showCustomToast(
              context: context,
              message: "Welcome to the quiz!",
              time: 4,
              color: green,
            );
            context.go(AppRouteName.home);
          } else if (state.statusUser == FormzSubmissionStatus.failure) {
            // serverdan qaytgan xatolik
            showCustomToast(
                context: context,
                message: "Error adding, please try again later");
          } else if (state.statusUser == FormzSubmissionStatus.canceled) {
            // Bu raqam allaqachon mavjud
            showCustomToast(
                context: context, message: "This number already exists");
          }
        },
        child: SingleChildScrollView(
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
                          "Register",
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
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 8),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 42, bottom: 8),
                        child: CustomTextField(
                          controller: controllerName,
                          hintText: "Enter your name",
                          borderRadius: 20,
                          borderColor: white,
                          enableBorderColor: white,
                          fillColor: white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 8, top: 8),
                        child: CustomTextField(
                          controller: controllerPhone,
                          keyboardType: TextInputType.phone,
                          formatter: [Formatters.phoneFormatter],
                          hintText: "+998 (**) *** ** **",
                          borderRadius: 20,
                          borderColor: white,
                          enableBorderColor: white,
                          fillColor: white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 4, top: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextField(
                            obscureText: !_showPassword,
                            controller: controllerPassword,
                            onChanged: validatePassword,
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
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 8, top: 0),
                        child: TextButton(
                          onPressed: () {
                            controllerPassword.text = generatePassword();
                          },
                          child: const Text(
                            "Password generator",
                            style: TextStyle(
                              color: white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
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
                  int i = _submitForm();
                  if (i == -1) {
                    showCustomToast(
                        context: context, message: "Fill in all fields!");
                  } else if (i == -2) {
                    showCustomToast(
                        context: context,
                        message:
                            "Must contain uppercase and lowercase letters and at least 8 characters");
                  } else if (i == -3) {
                    showCustomToast(
                        context: context, message: "Uppercase letter!");
                  } else if (i == -4) {
                    showCustomToast(
                        context: context, message: "Lowercase letter!");
                  } else if (i == -5) {
                    showCustomToast(
                        context: context,
                        message: "Must be at least 8 characters long!");
                  } else if (i == -6) {
                    showCustomToast(
                        context: context,
                        message: "Please enter the correct phone number!");
                  } else if (i == -7) {
                    showCustomToast(
                        context: context,
                        message: "Password must not contain spaces!");
                  }
                  if (i == 0) {
                    final register = Register(
                      name: controllerName.text,
                      phone: controllerPhone.text,
                      password: controllerPassword.text,
                    );
                    context.read<UserBloc>().add(
                          CheckRegisterEvent(
                            register: register,
                          ),
                        );
                  }
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
                      "Register",
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
                        text: "Already have an account?  ",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: black,
                        ),
                      ),
                      TextSpan(
                        text: "Login",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueAccent[200],
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.go(AppRouteName.login);
                          },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
