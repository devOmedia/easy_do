import 'package:easy_do/model/app_const/app_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  static const id = "/homeScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              "Hello!",
              style: TextStyle(
                fontSize: size.width * 0.08,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "What's you plan for today?",
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: size.width * 0.045,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Task Summary",
              style: TextStyle(
                fontSize: size.width * 0.056,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: size.height * 0.25,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: size.height * 0.25,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
