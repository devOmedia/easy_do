import 'package:easy_do/controller/authentication_controller.dart';
import 'package:easy_do/view/screens/home_screen.dart';
import 'package:easy_do/view/screens/login_screen.dart';
import 'package:easy_do/view/widgets/custom_auth_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/app_const/app_const.dart';
import '../widgets/custom_input_fields.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});
  static const id = '/signup';
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _nameCtr;
  late TextEditingController _emailCtr;
  late TextEditingController _passwordCtr;
  late TextEditingController _confirmPasswordCtr;

  @override
  void initState() {
    _formKey = GlobalKey();
    _nameCtr = TextEditingController();
    _emailCtr = TextEditingController();
    _passwordCtr = TextEditingController();
    _confirmPasswordCtr = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _nameCtr.dispose();
    _emailCtr.dispose();
    _passwordCtr.dispose();
    _confirmPasswordCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAuthTopBar(size: size),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign up',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: size.width * 0.08,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Name",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: size.width * 0.045,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomInputField(
                        controller: _nameCtr,
                        hint: "Type name here...",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter an user name";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Email",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: size.width * 0.045,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomInputField(
                        controller: _emailCtr,
                        hint: "Type email here...",
                        inputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a valid email address";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Password",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: size.width * 0.045,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomInputField(
                        controller: _passwordCtr,
                        hint: "Type password here...",
                        inputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a valid password";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Retype Password",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: size.width * 0.045,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomInputField(
                        controller: _confirmPasswordCtr,
                        hint: "Type password here...",
                        inputType: TextInputType.visiblePassword,
                        inputAction: TextInputAction.done,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a valid password";
                          } else if (_passwordCtr.text != value) {
                            return "password does not matched";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                      ref.watch(authenticationProvider).isSignupLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  final data = await ref
                                      .read(authenticationProvider)
                                      .getUserSignUp({
                                    "name": _nameCtr.text,
                                    "email": _emailCtr.text,
                                    "password": _passwordCtr.text,
                                  });

                                  if (data != null) {
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushReplacementNamed(
                                        context, HomeScreen.id);
                                  }
                                }
                              },
                              child: Container(
                                height: size.height * 0.07,
                                width: size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: AppColors.primaryColor,
                                ),
                                child: Center(
                                  child: Text(
                                    "Sign in",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.width * 0.05),
                                  ),
                                ),
                              ),
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, LoginScreen.id);
                              },
                              child: const Text("Sign in")),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
