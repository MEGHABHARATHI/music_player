# ma_so 🎵

A simple Flutter music player app that plays local audio files and displays corresponding cover images.

## Features

- 🎶 Play audio tracks using [`just_audio`](https://pub.dev/packages/just_audio)
- 🖼️ Show local album art (images) for each track
- 🔊 Supports audio session management via [`audio_session`](https://pub.dev/packages/audio_session)
- 💡 Lightweight and easy to customize

## Folder Structure
ma_so/
├── android/
├── ios/
├── lib/
│ └── main.dart
├── images/
│ ├── Kannadi_Poovey.jpg
│ ├── Nee_Kavidhaigala.jpg
│ └── Vena_Machan.jpg
├── pubspec.yaml
└── README.md

## Getting Started

### Prerequisites

- Flutter SDK (>=3.3.2 <4.0.0)
- Android Studio or VS Code with Flutter plugin

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/ma_so.git
   cd ma_so
2. Install dependencies:
flutter pub get
3. Run the app:
flutter run
4. Assets Configuration
Make sure your pubspec.yaml includes the image assets:
yaml
flutter:
  uses-material-design: true
  assets:
    - images/Kannadi_Poovey.jpg
    - images/Nee_Kavidhaigala.jpg
    - images/Vena_Machan.jpg
5. Dependencies
just_audio
audio_session
cupertino_icons

Authors
#Kanika G ( www.linkedin.com/in/kanika-g )
#Megha Bharathi B ( www.linkedin.com/in/meghabharathib )

