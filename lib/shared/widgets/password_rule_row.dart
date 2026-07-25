import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';

/// A single password rule row with a dot indicator and label.
/// Color is green when [isPassing] is true, red otherwise.
class PasswordRuleRow extends StatelessWidget {
  final String label;
  final bool isPassing;

  const PasswordRuleRow({
    super.key,
    required this.label,
    required this.isPassing,
  });

  @override
  Widget build(BuildContext context) {
    final color = isPassing ? AppColors.validationPass : AppColors.validationFail;
    return Row(
      children: [
        Container(
          width: 5.r,
          height: 5.r,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          label,
          style: AppFonts.bodySmall.copyWith(
            fontSize: 9.sp,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}
