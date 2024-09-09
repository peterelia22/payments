import 'package:flutter/material.dart';

class CustomHalfCircle extends StatelessWidget {
  final double? left;
  final double? right;

  CustomHalfCircle({
    super.key,
    this.left,
    this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      right: right,
      bottom: MediaQuery.sizeOf(context).height * 0.2,
      child: const CircleAvatar(
        backgroundColor: Colors.white,
      ),
    );
  }
}
