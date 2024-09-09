import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import 'custom_checked_icon.dart';
import 'custom_dashed_line.dart';
import 'custom_half_circle.dart';
import 'thank_you_card.dart';

class ThankYouViewBody extends StatelessWidget {
  const ThankYouViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const ThankYouCard(),
          Positioned(
            bottom: MediaQuery.sizeOf(context).height * 0.2 + 20,
            left: 20 + 8,
            right: 20 + 8,
            child: const CustomDashedLine(),
          ),
          CustomHalfCircle(
            left: -20,
          ),
          CustomHalfCircle(
            right: -20,
          ),
          const Positioned(
            top: -50,
            left: 0,
            right: 0,
            child: CustomCheckedIcon(),
          )
        ],
      ),
    );
  }
}
