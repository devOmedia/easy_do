import 'package:flutter/material.dart';

class CustomAuthTopBar extends StatelessWidget {
  const CustomAuthTopBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.35,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        gradient: LinearGradient(
          colors: [
            Color(0xffD2DDFD),
            Color(0xffF7E1E4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: SizedBox(
          height: size.height * 0.12,
          child: Image.asset('assets/logo.png'),
        ),
      ),
    );
  }
}