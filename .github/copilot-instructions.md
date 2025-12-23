# Copilot Instructions for AI Agents

## Project Overview
This is a Flutter project for cross-platform mobile and web development. The codebase is organized by feature and platform, with clear separation between UI, business logic, and data models.

## Key Architecture & Patterns
- **Main Entry Point:** `lib/main.dart` initializes the app and sets up navigation.
- **App Logic:** `lib/jura_app.dart` contains the main app widget and routing logic.
- **State Management:** Uses the `provider` package. Providers are located in `lib/controllers/provider/`.
- **Persistence & Services:** Business logic and data access are in `lib/controllers/persistense/` and `lib/controllers/services/`.
- **Models:** Data models are in `lib/models/` (e.g., `admin.dart`, `competition.dart`).
- **Views:** UI screens are in `lib/views/` (e.g., `login_page.dart`, `signup_page.dart`).
- **Assets:** Images and other static files are in `assets/images/`.

## Developer Workflows
- **Build:**
  - Run `flutter build <platform>` (e.g., `flutter build apk`, `flutter build web`).
- **Run:**
  - Use `flutter run` for local development.
- **Test:**
  - Widget tests are in `test/widget_test.dart`. Run tests with `flutter test`.
- **Add Dependencies:**
  - Use `flutter pub add <package>` (recently added: `provider`).

## Project-Specific Conventions
- **Provider Pattern:** All state management uses `provider`. Register providers in the main app widget.
- **File Organization:**
  - UI in `views/`, logic in `controllers/`, data in `models/`.
- **Naming:**
  - Files and classes are named by feature (e.g., `competition.dart`, `login_page.dart`).
- **Platform Code:**
  - Android, iOS, Linux, macOS, Windows, and web folders contain platform-specific code and build scripts.

## Integration Points
- **Firebase:**
  - Configured via `lib/firebase_options.dart` and `firebase.json`.
- **Assets:**
  - Referenced in `pubspec.yaml` under the `assets` section.
- **Platform Launch Screens:**
  - iOS launch images in `ios/Runner/Assets.xcassets/LaunchImage.imageset/`.

## Examples
- To add a new screen, create a Dart file in `lib/views/`, update navigation in `lib/jura_app.dart`, and connect state via a provider from `lib/controllers/provider/`.
- To add a new model, create a Dart file in `lib/models/` and update relevant services/providers.

## References
- Main app setup: `lib/main.dart`, `lib/jura_app.dart`
- State management: `lib/controllers/provider/`
- Firebase config: `lib/firebase_options.dart`, `firebase.json`
- Tests: `test/widget_test.dart`

---
_If any section is unclear or missing important project-specific details, please provide feedback to improve these instructions._
