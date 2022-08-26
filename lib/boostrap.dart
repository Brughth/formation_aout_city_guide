import 'package:city_guide/shared/service_locator.dart';
import 'package:flutter/material.dart';

bootstrap(Widget Function() builder) async {
  setupLocator();

  return runApp(builder());
}
