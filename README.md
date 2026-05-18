# LinguaBridge 🌍

A cross-platform Flutter application for crowdsourcing language data to build comprehensive datasets for low-resource language models. Contributors can submit translations, record audio, and tag images in their native languages.

## Overview

LinguaBridge is designed to democratize AI language model development by enabling speakers of underrepresented languages to contribute valuable linguistic data. The platform is built with a focus on **user accessibility**, **scalability**, and **data quality**.

## ✨ Features

### Core Modules

- **🔐 Authentication & Onboarding**
  - Email and Google Sign-In integration
  - User profile management with native language and dialect selection
  - Firebase-powered authentication

- **📊 Dashboard**
  - Central hub for all contribution activities
  - Real-time progress tracking and contribution statistics
  - Gamification elements (badges, achievements)
  - Easy navigation to all modules

- **🎙️ Audio Recording (Speech Collection)**
  - Record native speakers reading prompts in their language
  - High-quality audio capture with waveform visualization
  - Automatic upload to cloud storage
  - Metadata tracking (speaker, language, duration, prompt)

- **🏷️ Image Tagging (Object Recognition)**
  - Upload photos or capture images directly
  - Tag objects and scenes in images
  - Support for multiple language labels
  - Bounding box annotation (optional advanced feature)

- **📝 Translation Exercises**
  - Contribute translations from English to target languages
  - Validate translation quality through community review
  - Track translation history and contributions

- **📤 Data Export**
  - Admin panel for contribution management
  - Export structured datasets (JSON/CSV) for ML training
  - Filter exports by language, date, and contribution type

## 🛠️ Tech Stack

| Component | Technology |
|-----------|------------|
| **Frontend** | Flutter (Mobile & Web) |
| **State Management** | Riverpod 2.x |
| **Authentication** | Firebase Auth |
| **Database** | Cloud Firestore |
| **Media Storage** | Cloudinary |
| **Routing** | GoRouter |
| **Code Generation** | Freezed, JSON Serializable, Riverpod Generator |
| **Typography** | Google Fonts |

## 📋 Project Structure

```
lib/
├── src/
│   ├── features/
│   │   ├── authentication/          # Auth & user management
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   ├── corpus_recording/        # Audio collection module
│   │   ├── image_tagging/           # Image tagging module
│   │   ├── translation/             # Translation exercises
│   │   ├── dashboard/               # Main dashboard
│   │   └── admin/                   # Export & analytics
│   ├── common_widgets/              # Reusable UI components
│   ├── constants/                   # Colors, strings, styles
│   ├── utils/                       # Helpers & formatters
│   └── routing/                     # Navigation configuration
├── main.dart
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.10.1+
- Dart 3.10.1+
- Firebase project
- Cloudinary account (free tier available)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Shade-Script/Corpus_Collection_Tool-LinguaBridge.git
   cd Corpus_Collection_Tool-LinguaBridge
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   ```bash
   flutterfire configure
   ```
   - Select your Firebase project
   - Configure for Android, iOS, Web, Linux, macOS, and Windows as needed

4. **Configure Cloudinary**
   - Create a Cloudinary account at https://cloudinary.com
   - Store your API credentials in environment variables or config file:
     ```
     CLOUDINARY_CLOUD_NAME=your_cloud_name
     CLOUDINARY_API_KEY=your_api_key
     CLOUDINARY_UPLOAD_PRESET=your_preset
     ```

5. **Run code generation**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

6. **Launch the app**
   ```bash
   flutter run
   ```

## 📱 Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ macOS
- ✅ Linux
- ✅ Windows

## 🏗️ Architecture

This project follows a **Feature-First Architecture** with clean separation of concerns:

- **Presentation Layer**: UI components using Material 3 design
- **Domain Layer**: Business logic and entities
- **Data Layer**: Repository pattern with Firestore and API calls

**State Management**: Riverpod provides dependency injection and reactive state management without the BuildContext.

## 📚 Database Schema

### Users Collection
```json
{
  "uid": "user_id",
  "email": "user@example.com",
  "nativeLanguage": "Yoruba",
  "dialect_region": "Nigeria",
  "contributionsCount": 42,
  "joinDate": "2026-05-18",
  "badges": ["early_contributor", "translator_10"]
}
```

### Audio Contributions
```json
{
  "textPrompt": "Hello world",
  "audioUrl": "https://res.cloudinary.com/...",
  "userId": "user_id",
  "language": "yo-NG",
  "durationMs": 2500,
  "timestamp": "2026-05-18T10:30:00Z"
}
```

### Image Tags
```json
{
  "imageUrl": "https://res.cloudinary.com/...",
  "tags": ["dog", "house", "tree"],
  "userId": "user_id",
  "language": "yo-NG",
  "timestamp": "2026-05-18T10:30:00Z"
}
```

### Translations
```json
{
  "sourceText": "The sky is blue",
  "translatedText": "Oju orun je bulu",
  "sourceLanguage": "en",
  "targetLanguage": "yo",
  "userId": "user_id",
  "quality": "verified",
  "timestamp": "2026-05-18T10:30:00Z"
}
```

## 🎯 Development Roadmap

### Phase 1: Foundation ✅
- [x] Project setup with Flutter and Firebase
- [x] Authentication system
- [x] Basic UI scaffold and routing

### Phase 2: Core Features 🔄
- [ ] Dashboard implementation
- [ ] Translation module
- [ ] Basic state management setup

### Phase 3: Media Features
- [ ] Audio recording and upload
- [ ] Image tagging and annotation
- [ ] Cloudinary integration

### Phase 4: Polish & Launch
- [ ] Data export functionality
- [ ] Gamification system
- [ ] Performance optimization
- [ ] Accessibility improvements
- [ ] Beta testing

## 🤝 Contributing

We welcome contributions! Here's how you can help:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

### Code Standards

- Follow Material 3 design guidelines
- Use `freezed` for immutable models
- Implement proper error handling with `AsyncValue`
- Write unit tests for business logic
- Keep widgets lean and composable
- Use `const` constructors where possible

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙋 Support

For questions, issues, or feature requests:
- Open an [issue](https://github.com/Shade-Script/Corpus_Collection_Tool-LinguaBridge/issues)
- Contact the maintainers

## 🌟 Acknowledgments

Built with ❤️ to support underrepresented languages and their communities.

---

**Made with Flutter & Riverpod**
