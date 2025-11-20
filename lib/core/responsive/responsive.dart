import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 600;
  static bool isTablet(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w >= 600 && w < 1024;
  }

  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1024;

  static double searchFieldWidth(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w < 340) return 170;   
    if (w < 380) return 185;   
    if (w < 420) return 200;   
    if (w < 480) return 215;   
    if (w < 560) return 230;   
    if (w < 640) return 245;   
    if (w < 720) return 265;   
    if (w < 840) return 285;   
    if (w < 960) return 300;   
    if (w < 1120) return 320;
    return 340;                
  }
}