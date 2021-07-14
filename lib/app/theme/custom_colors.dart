import 'package:flutter/material.dart';

class CustomColors {
  Color _activePrimaryButton = Color(0xff0A6D92);
  Color _activeSecondaryButton = Color(0xff655a58);
  Color _gradientMainColor = Color(0xfff9b11f);
  Color _gradientSecColor = Color(0xff692107);
  Color _appBarMainColor = Color(0xff92450E);

  Color getActivePrimaryButtonColor() {
    return _activePrimaryButton;
  }

  Color getActiveSecondaryButton() {
    return _activeSecondaryButton;
  }

  Color getGradientMainColor() {
    return _gradientMainColor;
  }

  Color getGradientSecondaryColor() {
    return _gradientSecColor;
  }

  Color getAppBarMainColor() {
    return _appBarMainColor;
  }
}
