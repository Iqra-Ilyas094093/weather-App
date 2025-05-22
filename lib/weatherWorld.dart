import 'package:flutter/material.dart';

class weatherWorld extends StatelessWidget {
  const weatherWorld({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Here you go',
              ),
            )
          ],
        ),
      ),
    );
  }
}
