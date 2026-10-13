<h1 align="center">Scholar Chat</h1>

<p align="center">A real-time group chat app built with Flutter, Firebase Auth, Cloud Firestore and Cubit.</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" alt="Firebase" />
  <img src="https://img.shields.io/badge/Bloc-Cubit-0B7AD1?style=for-the-badge" alt="Bloc / Cubit" />
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-3DDC84?style=for-the-badge" alt="Android | iOS" />
</p>

<p align="center">
  <img src="docs/screens.jpg" alt="Screens" width="100%"/>
  <br/><sub>Login · Register · Chat</sub>
</p>

## 📖 About

Scholar Chat is a real-time chat room built while learning Firebase and state management in Flutter. Users register or log in with email and password, then join a shared room where messages stream live from **Cloud Firestore**. The app started with `setState` and was refactored to **Cubit**: login, registration and chat each have their own Cubit, and a `BlocObserver` logs every state change.

## ✨ Features

- 📝 **Register and login** with Firebase Auth (email/password), with form validation and readable error snack bars.
- ⏳ **Loading overlay** during auth calls (`modal_progress_hud_nsn`).
- ⚡ **Live messages**: a Firestore `snapshots()` stream ordered by `createdAt`.
- 💬 **Chat bubbles** that tell your messages apart from other people's, in a reversed list that scrolls to the newest message.
- 🧩 **Cubit architecture**: `LoginCubit`, `RegisterCubit`, `ChatCubit` and a `SimpleBlocObserver`.

## 🛠 Tech stack

- **Flutter / Dart** (SDK `^3.5.0`)
- **State management:** `bloc`, `flutter_bloc` (Cubit)
- **Backend:** `firebase_core`, `firebase_auth`, `cloud_firestore`
- **UX:** `modal_progress_hud_nsn`

## 🏗 Project structure

```
lib/
├── cubit/          # Chat_cubit, login cubit, register_cubit (+ states)
├── Models/         # Message model
├── pages/          # Login, Register, Chat
├── widgets/        # chat bubbles, button, text field
├── helper/         # snack-bar helper
├── bloc_Observer.dart
├── constant_file.dart
├── firebase_options.dart
└── main.dart
```

## 🚀 Getting started

**Prerequisites:** Flutter SDK and a Firebase project with **Email/Password** auth and **Cloud Firestore** enabled.

```bash
git clone https://github.com/youssef336/Chat_app.git
cd Chat_app
flutter pub get
flutterfire configure   # point lib/firebase_options.dart at your own Firebase project
flutter run
```

Messages are stored in the Firestore collection `messages` with the fields `message`, `createdAt` and `id` (the sender's email).

## 👤 Author

**Youssef Belal Zakaria** · [GitHub @youssef336](https://github.com/youssef336)

⭐ If you like this project, give it a star!
