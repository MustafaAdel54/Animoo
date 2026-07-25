# ANIMOOO App - Firebase & Core Implementations

## 1. Firebase Initialization & Analytics
*   Initialize Firebase Core in `main.dart`.
*   Initialize Firebase Crashlytics to catch all unhandled errors.
*   Implement a global `ErrorHandler` class to log specific caught errors to Crashlytics.
*   Initialize Firebase Analytics to track key events (Login, Signup, AddAnimal, AddCategory).

## 2. Native Splash Screen Setup
Configure `flutter_native_splash.yaml`:
*   Base config (Android < 12): specific image/color.
*   Override `ios:` specific image/color.
*   Override `android_12:` specific image/color.
*   In `main.dart`, use `FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding)` before app launch.
*   Call `FlutterNativeSplash.remove()` ONLY inside the `AuthBloc` listener when state transitions from `Initial` to `Authenticated` or `Unauthenticated`.

## 3. Routing (go_router)
Implement robust routing with redirect logic based on `AuthBloc` state:
*   Protect routes like `/add-animal`, `/create-category`, `/favorites`.
*   Redirect to `/login` if unauthenticated user attempts to access protected routes.
*   Redirect to `/home` if authenticated user attempts to access `/login` or `/signup`.

## 4. Repositories (Data Layer)
*   **AuthRepository**: Handles FirebaseAuth sign in, sign up, and password reset. Saves user doc to Firestore `users` collection.
*   **AnimalRepository**:
    *   Uploads compressed images to Firebase Storage `animals/{id}/`.
    *   Saves animal data JSON to Firestore `animals` collection.
    *   Implements `getAnimals({DocumentSnapshot? startAfter})` for pagination.
*   **CategoryRepository**: Handles CRUD for categories in Firestore.
*   **Storage Paths Reference**:
    *   Animals: `animals/{id}/image.jpg`
    *   Users: `users/{id}/profile_pic.jpg`
    *   Categories: `categories/{id}/icon.jpg`

## 5. Local Storage
*   Use `shared_preferences` for theme toggling (Light/Dark mode) and storing "first launch" status (for potential onboarding). This should feed into a global `ThemeCubit` for reactive UI updates.
