import 'package:flutter/material.dart';
import 'package:payment/core/widgets/cusotm_app_bar.dart';
import 'package:payment/features/checkout%20features/presentation/views/widgets/thank_you_view_body.dart';

class ThankYou extends StatelessWidget {
  const ThankYou({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(),
      backgroundColor: Colors.white,
      body: Transform.translate(
          offset: const Offset(0, -16), child: const ThankYouViewBody()),
    );
  }
}
