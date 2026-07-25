import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppFonts {
  static TextStyle get headingLarge => GoogleFonts.dmSerifDisplay(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.textDark,
      );

  static TextStyle get headingMedium => GoogleFonts.dmSerifDisplay(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      );

  static TextStyle get bodyLarge => GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textDark,
      );

  static TextStyle get bodyMedium => GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textDark,
      );

  static TextStyle get bodySmall => GoogleFonts.poppins(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textDark,
      );

  static TextStyle get buttonText => GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );

  // Specific styles for Login Screen from Figma
  static TextStyle get loginTitle => GoogleFonts.dmSerifDisplay(
        fontSize: 38.sp,
        color: Colors.black,
      );

  static TextStyle get inputLabel => GoogleFonts.poppins(
        fontSize: 16.sp,
        color: const Color(0xFF505050),
      );

  static TextStyle get inputHint => GoogleFonts.poppins(
        fontSize: 12.sp,
        color: AppColors.hintText,
      );

  static TextStyle get passwordHint => GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF686F80),
      );
      
  // Splash screen "ANIMOOO" text — Figma: Original Surfer, 24px, #04332D
  static TextStyle get logoText => GoogleFonts.originalSurfer(
        fontSize: 24.sp,
        color: const Color(0xFF04332D),
      );
}
