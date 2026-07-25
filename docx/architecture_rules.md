# ANIMOOO App - Architecture & Core Rules

## 1. Project Architecture (Feature-First Clean Architecture)
The project will strictly follow a Feature-First Clean Architecture pattern.

```
lib/
├── core/
│   ├── constants/       # App-wide constants (e.g., Firebase collections, API keys)
│   ├── errors/          # Failure classes, Exceptions, ErrorHandler (Crashlytics integration)
│   ├── localization/    # ARB files, Intl setup
│   ├── di/              # Dependency Injection setup (get_it, injectable)
│   ├── network/         # Network checkers (NoInternetWidget logic)
│   ├── theme/           # App colors, text styles (ScreenUtil), ThemeData
│   └── utils/           # Global helpers
│
├── shared/
│   ├── widgets/         # Reusable UI components (CustomButton, CustomTextField, etc.)
│   └── dialogs/         # Reusable dialogs/bottom sheets
│
├── features/
│   ├── auth/            # Login, SignUp, OTP, Reset Password
│   ├── home/            # Home Feed, Categories Carousel
│   ├── category/        # Create Category, Category List
│   ├── animal/          # Add Animal, Animal Detail
│   └── favorites/       # Saved Animals
```

Inside every feature directory (e.g., `lib/features/auth/`), structure as follows:
*   `data/`: Data Models (DTOs with fromJson/toJson for Firebase), Repositories implementations, Data Sources (Firebase).
*   `domain/`: Pure Dart Entities, Repository Interfaces (Abstract classes), Use Cases.
*   `presentation/`: Pages, Widgets specific to the feature, BLoC/Cubit state management.

## 2. SOLID & OOP Principles
*   **Single Responsibility:** UI draws pixels. State (BLoC/Cubit) manages logic. Repositories handle data formatting.
*   **Dependency Inversion:** BLoCs/Cubits depend on interfaces (e.g., `IAuthRepository`), injected via `get_it`.
*   **Liskov Substitution & Open/Closed:** Build extensible base classes for remote data sources.

## 3. State Management
*   **Global State (BLoC/Cubit):** Used for app-wide states.
    *   `AuthBloc`: Manages Auth state (Authenticated, Unauthenticated) and routes guards.
    *   `FavoritesBloc`: Syncs saved animals across Home, Detail, and Favorites screens.
    *   `ThemeCubit`: Reads from local storage and manages Light/Dark theme toggling globally.
*   **Local State (Cubit):** Used for localized screen states.
    *   `LoginCubit`, `SignUpCubit`, `AddAnimalCubit`, `CreateCategoryCubit`.

## 4. UI & Responsiveness Rules
*   **ScreenUtil Mandatory:** ALL dimensions must use `flutter_screenutil` (`.w`, `.h`, `.r`, `.sp`). Hardcoded pixels are strictly forbidden.
*   **Theme Integration:** ALL colors and fonts must reference `Theme.of(context)`. Hardcoded colors in UI files are forbidden.

## 5. Performance & Polish
*   **Pagination:** Firestore queries in `FeedBloc` and `AnimalRepository` must use `startAfterDocument` for batch loading (10-15 items).
*   **Image Optimization:** Compress images using `flutter_image_compress` before uploading to Firebase Storage. Display using `cached_network_image`.
