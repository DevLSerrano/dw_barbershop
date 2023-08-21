import 'package:flutter/material.dart';

class BarbershopNavGlobalKey {
  static BarbershopNavGlobalKey? _instance;
  BarbershopNavGlobalKey._();
  static BarbershopNavGlobalKey get instance =>
      _instance ??= BarbershopNavGlobalKey._();

  final navigatorKey = GlobalKey<NavigatorState>();
}
