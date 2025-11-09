import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;

  const ResponsiveWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWeb = kIsWeb;
        final maxWidth = 430.0; // typical mobile width

        return Center(
          child: Container(
            width: isWeb ? maxWidth : double.infinity,
            child: child,
          ),
        );
      },
    );
  }
}
