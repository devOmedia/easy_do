import 'package:easy_do/model/app_const/app_const.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_auth_top_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const id = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                        controller: _emailCtr,
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
                      GestureDetector(
                        onTap: () {
                          if (_formState.currentState!.validate()) {}
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
                          Text("Don't have an account?"),
                          TextButton(onPressed: () {}, child: Text("Sign up")),
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

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    super.key,
    required this.controller,
    required this.hint,
    this.inputAction = TextInputAction.next,
    this.inputType = TextInputType.text,
    required this.validator,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputAction inputAction;
  final TextInputType inputType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: inputAction,
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        // border: InputBorder.none,
       border: OutlineInputBorder(
          borderSide:  BorderSide(color: Colors.grey.shade100, width: 0.0),
          borderRadius: BorderRadius.circular(14),
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey.shade300,
        ),
      ),

      validator: validator,
    );
  }
}
