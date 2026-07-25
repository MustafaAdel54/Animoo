# ANIMOOO App - Theme & UI Guidelines

## 1. Color Palette (`core/theme/app_colors.dart`)
Define static constants for raw colors, then map them to `ThemeData.light()` and `ThemeData.dark()`.

**Light Mode / Core Colors:**
*   `primaryAccent`: `#03362E` (Deep Forest Teal)
*   `backgroundLight`: `#FFFFFF`
*   `surfaceFill`: `#F5F5F5` (or `#F7F7F8`)
*   `textDark`: `#1A1A1A`
*   `textSubtitle`: `#666666`
*   `validationPass`: `#1E8E3E`
*   `validationFail`: `#D32F2F`
*   `borderDashed`: `#CCCCCC`

**Dark Mode Mapping:**
*   `primaryAccent`: `#00B092`
*   `backgroundDark`: `#121212`
*   `surfaceFill`: `#1E1E1E`
*   `textLight`: `#F5F5F5`
*   `textSubtitle`: `#A0A0A0`

## 2. Typography (`core/theme/app_fonts.dart`)
Implement fonts using `flutter_screenutil` extension `.sp`.

*   `headingLarge` (Playfair Display / DM Serif Display): 28.sp, Bold
*   `headingMedium` (Playfair Display / DM Serif Display): 20.sp, SemiBold
*   `bodyLarge` (Poppins / Inter): 16.sp, Medium
*   `bodyMedium` (Poppins / Inter): 14.sp, Regular
*   `bodySmall` (Poppins / Inter): 12.sp, Regular
*   `buttonText` (Poppins / Inter): 16.sp, SemiBold, Color: White

## 3. Shared Widgets (`shared/widgets/`)
Abstract the following elements from the design into parameterized reusable widgets:

1.  **`CustomTextField`**: Parameters: label, hint, controller, isObscured, validator. Style: 10.r radius, filled background.
2.  **`CustomButton`**: Parameters: text, onPressed, isLoading. Style: primaryAccent fill, 10.r radius.
3.  **`DashedImagePickerBox`**: Dotted border container for image selection (Profile, Category, Animal).
4.  **`AnimalCard`**: Displays full-width image, title, price, creator. Used in Feed and Favorites.
5.  **`CategoryCircleAvatar`**: Circular image with count badge and text label underneath.
6.  **`PasswordValidationList`**: Live UI checklist for password constraints (12+ chars, uppercase, lowercase, special, number).
7.  **`OtpInputField`**: Row of square input boxes for OTP.
8.  **`EmptyStateWidget`**: Illustration + text for empty lists.
9.  **`NoInternetWidget`**: Overlay for network failure.

## 4. Localization (l10n)
No hardcoded text allowed in UI. Use ARB files (e.g., `app_en.arb`) and access strings via `context.l10n.stringName`.
