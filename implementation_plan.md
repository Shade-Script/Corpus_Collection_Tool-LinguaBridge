# Implementation Plan: Corpus Collection Tool

This application is designed to crowdsource data for low-resource language models. It enables users to contribute text translations, audio recordings, and image tags. It will also serve as a dictionary with descriptions and images of objects, animals, and other items for the low resource language.

## Goals
- **User-Friendly**: Simple interface for non-technical contributors.
- **Scalable backend**: Firebase for real-time data, Cloudinary for media storage.
- **Data Export**: Easy extraction of structured data for AI training.

## Tech Stack
- **Frontend**: Flutter (Mobile/Web)
- **Auth & Database**: Firebase Auth, Cloud Firestore
- **Media Storage**: Cloudinary (Free tier, easy API)
- **State Management**: Riverpod

---

## Proposed Modules

### 1. Authentication & Onboarding
- **Feature**: Sign up/Login via Email or Google.
- **Data**: Store user profile (native language, dialect region) in Firestore `users` collection.
- **UI**: Simple, clean login screen. Language selection dropdown during onboarding.

### 2. Dashboard
- **Feature**: Central hub showing contribution categories (Audio, Image, Translation).
- **UI**: Card-based layout with progress indicators (e.g., "10 words contributed").
- **Gamification**: Badges or simple stats to encourage more contributions.

### 3. Audio Collection (Speech-to-Text)
- **Feature**: Display a prompt (sentence/word in target language). User holds button to record reading it.
- **Logic**:
  - Record audio using `flutter_sound` or `record`.
  - Upload to **Cloudinary** (Resource type: `video` or `raw` for audio).
  - Save metadata to Firestore:
    ```json
    {
      "text_prompt": "Hello world",
      "audio_url": "https://res.cloudinary.com/...",
      "user_id": "xyz",
      "language": "yo-NG",
      "duration_ms": 2500
    }
    ```
- **UI**: Large microphone button, waveform visualization (optional).

### 4. Image Tagging (Object Recognition)
- **Feature**: User uploads an image or takes a photo.
- **Logic**:
  - Upload image to Cloudinary.
  - User draws bounding boxes (advanced) or simply lists objects visible in the image (basic).
  - Save tags to Firestore:
    ```json
    {
      "image_url": "https://res.cloudinary.com/...",
      "tags": ["dog", "house", "tree"],
      "user_id": "xyz"
    }
    ```
- **UI**: Image preview, tag input field (`Chip` widgets for added tags).

### 5. Translation Exercises
- **Feature**: Show a sentence in Source Language (e.g., English). User types translation in Target Language.
- **Data**:
    ```json
    {
      "source_text": "The sky is blue.",
      "translated_text": "Oju  orun je bulu.",
      "source_lang": "en",
      "target_lang": "yo"
    }
    ```

### 6. Admin/Export
- **Feature**: Admin panel to view recent contributions.
- **Export**: Generates a JSON or CSV dump of the Firestore collections for ML training.

---

## Step-by-Step Implementation

### Phase 1: Setup
1. Initialize Flutter Project.
2. Configure Firebase (FlutterFire CLI).
3. Configure Cloudinary (store API keys in `.env` or build config).
4. Create basic UI scaffold (Routes, Themes).

### Phase 2: Core Features
1. Implement Auth flow.
2. Build Dashboard.
3. Build **Translation** module (simplest data flow).

### Phase 3: Media Features
1. Implement **Image Tagging** (Camera/Gallery + Cloudinary Upload).
2. Implement **Audio Recording** (Microphone permission + Cloudinary Upload).

### Phase 4: Polish & Export
1. Add gamification/stats.
2. Fix UI/UX issues.
3. Create Export script/function.

## User Review Required
> [!IMPORTANT]
> **Cloudinary Setup**: You will need a Cloudinary account (Free tier) and provide the `Cloud Name`, `API Key`, and `Upload Preset`.
> **Firebase Setup**: Standard Firebase project setup required.

