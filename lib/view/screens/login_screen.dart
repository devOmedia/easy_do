import 'package:easy_do/controller/authentication_controller.dart';
import 'package:easy_do/model/app_const/app_const.dart';
import 'package:easy_do/view/screens/home_screen.dart';
import 'package:easy_do/view/screens/signup_screen.dart';
import 'package:easy_do/view/widgets/custom_input_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/custom_auth_top_bar.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  static const id = "/login";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late GlobalKey<FormState> _formState;
  late TextEditingController _emailCtr;

  late TextEditingController _passwordCtr;

  @override
  void initState() {
    _formState = GlobalKey();
    _emailCtr = TextEditingController();
    _passwordCtr = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailCtr.clear();
    _passwordCtr.clear();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///top bar
              CustomAuthTopBar(size: size),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formState,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign in',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: size.width * 0.08,
                          fontWeight: FontWeight.w600,
                        ),
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
                        inputType: TextInputType.visiblePassword,
                        inputAction: TextInputAction.done,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a valid password";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 24),

                      ///SIGN IN BUTTON.
                      ref.watch(authenticationProvider).isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : GestureDetector(
                              onTap: () async {
                                if (_formState.currentState!.validate()) {
                                  final userData = await ref
                                      .read(authenticationProvider)
                                      .getUserLoggedIn({
                                    "email": _emailCtr.text,
                                    "password": _passwordCtr.text,
                                  });

                                  if (userData != null) {
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
                          const Text("Don't have an account?"),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, SignupScreen.id);
                              },
                              child: Text("Sign up")),
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
