import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String message;
  const ErrorScreen({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19.0),
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Container(
            height: 330,
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23),
              image: const DecorationImage(
                  image: AssetImage('assets/error_screen_bg.jpeg'),
                  fit: BoxFit.fill),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
