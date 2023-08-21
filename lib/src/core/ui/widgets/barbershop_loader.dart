import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../constants/constants_colors.dart';

class BarbershopLoader extends StatelessWidget {
  const BarbershopLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.threeArchedCircle(
        color: ConstantsColors.brow,
        size: 60,
      ),
    );
  }
}
