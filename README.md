# 📝 NOTABLE - A Simple Note Taking App

A clean and simple note-taking app built with **Flutter** and **SQLite** — my first app with a local database!

---

## 📸 App Preview

<p align="center">
  <img src="https://github.com/rayhan19122/basic_note_taking_app/blob/7d4bb938f306959cb935bb7ce10e9d3d4916c84a/ReadNote.png" width="300" alt="Ostad UI Screenshot">
  
</p>

---

## 📸 Features

- ✅ Create, Read, Update, and Delete (CRUD) notes
- ✅ Local SQLite database for offline storage
- ✅ Responsive UI using `flutter_screenutil`
- ✅ Clean and minimal Material Design

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| [Flutter](https://flutter.dev/) | UI Framework |
| [Dart](https://dart.dev/) | Programming Language |
| [sqflite](https://pub.dev/packages/sqflite) | SQLite Database |
| [path](https://pub.dev/packages/path) | Database Path Management |
| [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) | Responsive UI |

## 📁 Project Structure

```
basic_note_taking_app/
├── lib/
│   ├── database/
│   │   └── db_helper.dart         # SQLite database helper (CRUD operations)
│   ├── model/
│   │   └── note_model.dart        # Note data model
│   ├── app.dart                   # App configuration & theme
│   ├── home.dart                  # Home page with notes list
│   ├── main.dart                  # App entry point
├── assets/
│   └── images/
│       └── splash.png             # Splash screen image
└── pubspec.yaml
```

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed
- An emulator or physical device

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Rayhan-446/basic_note_taking_app.git
   cd basic_note_taking_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.4.2
  path: ^1.9.1
  flutter_screenutil: ^5.9.0
  cupertino_icons: ^1.0.8
```

> Note: Version numbers may vary. Check [pub.dev](https://pub.dev/) for the latest versions.

## 📖 What I Learned

This is my first Flutter app using a local database. Key takeaways:

- How to set up and use **SQLite** with the `sqflite` package
- Implementing full **CRUD** operations (Create, Read, Update, Delete)
- Structuring a Flutter project with **models** and **database helpers**
- Making responsive layouts with `flutter_screenutil`

## 🎨 App Color Palette

| Color | Hex Code | Usage |
|---|---|---|
| 🟢 Teal | `#44A194` | AppBar, Buttons, FAB |
| 🟡 Cream | `#F4F0E4` | Card Background, Dialogs |
| 🔴 Salmon | `#EC8F8D` | Cancel Button, Note Index |
| 🔵 Steel Blue | `#537D96` | Input Borders |

## 📄 License

This project is open source and available for learning purposes.

---

Made with ❤️ using Flutter
