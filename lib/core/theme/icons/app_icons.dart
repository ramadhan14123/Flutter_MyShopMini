import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';

/// Centralized icon mapping using Feather (outline, minimal, consistent stroke).
class AppIcons {
  static const IconData user = FeatherIcons.user;
  static const IconData cart = FeatherIcons.shoppingCart;
  static const IconData search = FeatherIcons.search;
  static const IconData close = FeatherIcons.x;
  static const IconData heart = FeatherIcons.heart;
  static const IconData filter = FeatherIcons.sliders;
  static const IconData category = FeatherIcons.grid;
  // Category specific
  static const IconData fashion = FeatherIcons.shoppingBag;
  static const IconData electronics = FeatherIcons.cpu; // or monitor
  static const IconData appliances = FeatherIcons.tool; // generic tools
  static const IconData beauty = FeatherIcons.droplet;
  static const IconData furniture = FeatherIcons.home;
  static const IconData sports = FeatherIcons.activity; // or target
}
