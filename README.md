# Undercover Game 🕵️

A Flutter-based social deduction word guessing game featuring Civilians, Spies, and Mr. White.

## 🎮 Game Overview

Undercover is a party game where players try to identify each other's roles through word associations and descriptions. The game includes three distinct roles:

- **Civilians** 👥: Receive the main word. They must find and eliminate the Spies and Mr. White.
- **Spies** 👁️: Receive a similar but different word. They must blend in with Civilians without being caught.
- **Mr. White** ❓: Receives NO word at all! Must figure out what everyone is talking about and guess the Civilian word.

## ✨ Features

- **Customizable Setup**: Choose 4-12 players, 1-3 spies, and optionally include Mr. White
- **Player Name Management**: Save and reuse player names across games with search/filter functionality
- **40+ Word Pairs**: Diverse categories including food, animals, transportation, entertainment, and more
- **Intuitive UI**: Beautiful Material Design 3 interface with gradient backgrounds
- **Pass-and-Play Role Selection**: Players take turns passing the device to pick a card and reveal their word privately
- **Player Elimination**: Vote system to eliminate suspected players
- **Mr. White Guess**: Special mechanic allowing Mr. White to guess and win
- **Game Statistics**: Live tracking of player counts and roles
- **Haptic Feedback**: Vibration feedback for enhanced gameplay experience
- **Win Conditions**: Multiple victory scenarios for different roles

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Git

### Installation

1. **Install Flutter**
   - Download from: https://docs.flutter.dev/get-started/install
   - Add Flutter to your system PATH
   - Run `flutter doctor` to verify installation

2. **Clone or Navigate to Project**
   ```powershell
   cd C:\Users\coolp\OneDrive\Documents\Code\undercover_game
   ```

3. **Get Dependencies**
   ```powershell
   flutter pub get
   ```

4. **Run the App**
   ```powershell
   flutter run
   ```

## 📱 How to Play

### Setup Phase
1. Launch the app and tap "START GAME"
2. Configure game settings:
   - Number of players (4-12)
   - Number of spies (1-3)
   - Include Mr. White (optional)
3. Enter or select player names:
   - Choose from saved players (with search)
   - Or manually enter new names
   - Names are saved automatically for future games
4. The app will prompt each player to take the device and pick a card to reveal their word privately

### Game Phase
1. Players take turns describing their word (without saying it!)
2. Discuss and deduce who has which role
3. Use the vote icon to eliminate suspected players
4. If Mr. White survives, they can attempt to guess the civilian word

### Win Conditions
- **Civilians win**: Eliminate all Spies and Mr. White
- **Spies win**: Eliminate all Civilians or reduce players to 2
- **Mr. White wins**: Survive elimination and correctly guess the civilian word

## 🎯 Game Rules

### Describing Your Word
- **DO**: Give vague, general descriptions
- **DON'T**: Say your word directly or give obvious hints
- **TIP**: Watch how others describe their words

### Identifying Roles
- **Civilians**: Look for descriptions that don't quite match
- **Spies**: Try to mirror the majority's descriptions
- **Mr. White**: Stay vague and blend in!

### Voting Strategy
- Discuss suspicions openly
- Pay attention to inconsistent descriptions
- Remember: Mr. White has NO word at all

## 🏗️ Project Structure

```
undercover_game/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── models/
│   │   ├── player.dart          # Player model with roles
│   │   └── word_pair.dart       # Word database
│   ├── providers/
│   │   └── game_provider.dart   # Game state management
│   └── screens/
│       ├── home_screen.dart      # Main menu
│       ├── setup_screen.dart     # Game configuration
│       ├── game_screen.dart      # Main gameplay
│       └── word_reveal_screen.dart # Secret word viewing
├── pubspec.yaml                  # Dependencies
└── README.md                     # This file
```

## 🛠️ Technologies Used

- **Flutter**: Cross-platform UI framework
- **Provider**: State management
- **Material Design 3**: Modern UI components

## 🎨 Customization

### Adding New Word Pairs

Edit `lib/models/word_pair.dart` and add new entries to the `wordPairs` list:

```dart
WordPair(
  civilianWord: 'Your Word',
  spyWord: 'Similar Word',
  category: 'Category Name'
),
```

### Modifying Colors

Edit the theme in `lib/main.dart`:

```dart
primarySwatch: Colors.deepPurple, // Change to your preferred color
```

## 📝 Tips for Best Experience

1. **Play in Person**: This game works best when players are together
2. **Use Full Screen**: Ensure privacy when viewing words
3. **Time Limits**: Consider setting discussion time limits for faster gameplay
4. **Multiple Rounds**: Play several rounds with different word pairs

## 🐛 Troubleshooting

### Flutter not recognized
- Ensure Flutter is installed and added to PATH
- Restart your terminal/command prompt
- Run `flutter doctor` to check setup

### Build errors
```powershell
flutter clean
flutter pub get
flutter run
```

### Performance issues
- Enable hardware acceleration on emulator
- Test on physical device for best performance

## 📄 License

This project is created for educational and entertainment purposes.

## 🤝 Contributing

Feel free to fork this project and add your own features:
- More word pairs
- Custom categories
- Enhanced dark mode animations
- Additional game modes
- Sound effects
- Timer features

## 📧 Support

For issues or questions about Flutter setup, visit:
- Flutter Documentation: https://docs.flutter.dev
- Flutter Community: https://flutter.dev/community

## 🎉 Enjoy the Game!

Have fun playing Undercover with your friends! May the best detective (or deceiver) win! 🕵️‍♀️🕵️‍♂️
