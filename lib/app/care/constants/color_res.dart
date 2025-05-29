import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  // Basic Colors
  static const Color black = Color(0xFF212121);   // dark text color
  static const Color white = Colors.white;

  // Brand Colors
  static const Color primary = Color(0xFF3B65D7);           // main logo blue
  static const Color primaryVariant = Color(0xFF2C4EB2);    // darker shade for variation
  static const Color onPrimary = Colors.white;              // white text on blue

  static const Color secondary = Color(0xFF5A87E8);         // lighter blue complement
  static const Color secondaryVariant = Color(0xFF3B65D7); // same as primary
  static const Color onSecondary = Colors.white;

  // Backgrounds & Surfaces
  static const Color background = Color(0xFFF5F5F5);        // very light blueish white
  static const Color backgroundLight = Colors.white;        // card backgrounds or light surfaces
  static const Color surface = Colors.white;
  static const Color onBackground = Color(0xFF212121);
  static const Color onSurface = Color(0xFF212121);

  // Status Colors (keep these or update slightly)
  static const Color error = Color(0xFFB00020);
  static const Color onError = Colors.white;

  static const Color success = Color(0xFF28A745);
  static const Color successBackground = Color(0xFFD4EDDA);

  static const Color warning = Color(0xFFFFC107);
  static const Color warningBackground = Color(0xFFFFF3CD);

  static const Color info = Color(0xFF17A2B8);
  static const Color infoBackground = Color(0xFFD1ECF1);

  // Borders & Dividers
  static const Color border = Color(0xFFD8E0F0);
  static const Color divider = Color(0xFFE4E6E8);

  // Disabled & Overlay
  static const Color disabled = Color(0x33000000);
  static const Color overlay = Color(0x193B65D7);  // subtle blue overlay using logo blue with ~10% opacity

  // Shadows
  static const Color shadow = Color(0x103B65D7);   // subtle blue shadow (~6% opacity)

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textDisabled = Color(0xFFA0A0A0);
  static const Color textHint = Color(0xFF9E9E9E);
  static const Color textError = Color(0xFFB00020);
  static const Color textLink = Color(0xFF3B65D7);  // changed to primary blue for links

  // Accent Colors
  static const Color accent = Color(0xFF3B65D7);         // blue accent consistent with logo
  static const Color accentVariant = Color(0xFF2C4EB2);

  // Focus & Hover (inputs, buttons)
  static const Color focus = Color(0xFF80A7F2);           // soft blue focus color
  static const Color hover = Color(0xFFE7EEFD);           // very light blue hover

  // Tooltip Colors
  static const Color tooltipBackground = Color(0xFF3B65D7);  // logo blue background
  static const Color tooltipText = Colors.white;

  // Transparent color
  static const Color transparent = Color(0x00000000);
}
