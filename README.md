# 🌌 Cosmic - Explore the Solar System

A stunning Flutter application that lets you explore planets in our solar system with beautiful animations, immersive UI, and Firebase authentication.

![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)
![Firebase](https://img.shields.io/badge/Firebase-Enabled-orange.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

## ✨ Features

- 🪐 **Explore Planets**: Browse through all planets in our solar system with detailed information
- 🎨 **Beautiful UI**: Premium glassmorphism design with smooth animations
- 🔐 **Firebase Authentication**: Secure email/password authentication
- 📱 **Responsive Design**: Optimized for phones, tablets, and desktop
- 🌟 **Planet of the Day**: Daily featured planet with detailed stats
- ❤️ **Favorites**: Save your favorite planets for quick access
- 👤 **User Profiles**: Personalized user experience with progress tracking
- 🎭 **Immersive Experience**: Edge-to-edge design with dynamic backgrounds

## 📸 Screenshots

_Add your app screenshots here_

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK
- Firebase account
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Aditya41150/Cosmic-App.git
   cd cosmic
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   
   a. Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   
   b. Enable **Email/Password Authentication** in Firebase Console:
      - Go to Authentication → Sign-in method
      - Enable Email/Password provider
   
   c. Configure Firebase for your app:
      ```bash
      # Install FlutterFire CLI
      dart pub global activate flutterfire_cli
      
      # Configure Firebase (this will generate firebase_options.dart)
      flutterfire configure
      ```
   
   d. Alternatively, manually create `lib/firebase_options.dart`:
      - Copy `lib/firebase_options.dart.template` to `lib/firebase_options.dart`
      - Replace placeholder values with your Firebase project credentials

4. **Generate App Icon** (Optional)
   ```bash
   flutter pub run flutter_launcher_icons
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

## 🔧 Configuration

### Firebase Configuration

The `firebase_options.dart` file is **not included** in this repository for security reasons. You must create your own Firebase project and generate this file.

**Quick Setup:**
```bash
flutterfire configure
```

This will:
- Create a new Firebase project (or select existing)
- Register your Flutter app
- Generate `lib/firebase_options.dart` with your credentials

### App Icon

To customize the app icon:
1. Replace `assets/applogo.png` with your icon (1024x1024 recommended)
2. Run: `flutter pub run flutter_launcher_icons`

## 📁 Project Structure

```
lib/
├── core/
│   ├── services/
│   │   └── auth_service.dart       # Firebase authentication logic
│   └── theme/
│       ├── app_colors.dart         # Color palette
│       └── app_theme.dart          # App theme configuration
├── features/
│   ├── auth/
│   │   └── screens/
│   │       ├── login_screen.dart   # Login UI
│   │       └── signup_screen.dart  # Signup UI
│   ├── home/
│   │   └── screens/
│   │       └── home_screen.dart    # Main home screen
│   └── profile/
│       └── screens/
│           ├── favourites.dart     # Favorites screen
│           ├── plant_details.dart  # Planet details
│           └── profile_screen.dart # User profile
├── firebase_options.dart           # Firebase config (gitignored)
└── main.dart                       # App entry point
```

## 🎨 Design Features

- **Glassmorphism**: Modern frosted glass effect throughout the app
- **Smooth Animations**: Flutter Animate for entrance and interaction animations
- **Edge-to-Edge**: Immersive full-screen experience
- **Responsive Layout**: Adapts beautifully to different screen sizes
- **Custom Fonts**: Google Fonts (Inter) for premium typography

## 🛠️ Built With

- [Flutter](https://flutter.dev/) - UI framework
- [Firebase](https://firebase.google.com/) - Backend & Authentication
- [Flutter Animate](https://pub.dev/packages/flutter_animate) - Animations
- [Google Fonts](https://pub.dev/packages/google_fonts) - Typography
- [Flutter Launcher Icons](https://pub.dev/packages/flutter_launcher_icons) - Icon generation

## 📝 Environment Variables

This project uses Firebase for authentication. Sensitive configuration is stored in `firebase_options.dart`, which is **gitignored** for security.

**Files to configure:**
- `lib/firebase_options.dart` - Firebase credentials (use template provided)

<<<<<<< HEAD
## 🤝 Contributing
=======
```bash
flutter build apk      # Android
flutter build ios      # iOS
flutter build web      # Web
```
# Screenshots
<img width="438" height="828" alt="image" src="https://github.com/user-attachments/assets/856f7754-2f57-43ec-b6b8-d795658682eb" />

# UI Inspired From
https://www.figma.com/design/cz2jAOkuZvkWjBytiuBpY2/Cosmic-%E2%80%94-Free-Flutter-App-UI-Template--Community-?node-id=297-3830&t=phj5K3MzC6DKTmJ9-0
>>>>>>> 528e692ca6f046829ad78328d29fe0bb7f73dce6

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Aditya**
- GitHub: [@Aditya41150](https://github.com/Aditya41150)
- LeetCode: [Aditya_57](https://leetcode.com/u/Aditya_57/)

## 🙏 Acknowledgments

- Planet images and data from NASA
- Design inspiration from modern space exploration apps
- Flutter community for amazing packages

## 📞 Support

If you have any questions or run into issues, please open an issue on GitHub.

---

**⭐ Star this repo if you like it!**
