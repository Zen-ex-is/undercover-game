# Project Summary - Undercover Game

## 🎉 Project Successfully Created!

Your Flutter Undercover game has been set up at:
**C:\Users\coolp\OneDrive\Documents\Code\undercover_game**

## 📁 Project Structure

### Core Application Files
```
undercover_game/
├── lib/
│   ├── main.dart                          # App entry point with Material theme
│   ├── models/
│   │   ├── player.dart                   # Player model (Civilian, Spy, Mr. White)
│   │   └── word_pair.dart                # 40+ word pairs database
│   ├── providers/
│   │   └── game_provider.dart            # Game state management with Provider
│   └── screens/
│       ├── home_screen.dart              # Welcome screen with game intro
│       ├── setup_screen.dart             # Game configuration (players, spies, etc.)
│       ├── game_screen.dart              # Main gameplay with voting system
│       └── word_reveal_screen.dart       # Private word viewing screen
```

### Configuration Files
```
├── pubspec.yaml                          # Dependencies (provider package)
├── analysis_options.yaml                 # Dart linting rules
├── .gitignore                            # Git ignore rules
├── README.md                             # Complete documentation
├── QUICKSTART.md                         # Quick setup guide
└── SETUP_INSTRUCTIONS.md                 # Flutter installation guide
```

### Android Files (for Android deployment)
```
└── android/
    ├── app/
    │   ├── build.gradle                  # Android build configuration
    │   ├── proguard-rules.pro           # ProGuard rules
    │   └── src/main/
    │       ├── AndroidManifest.xml       # App manifest
    │       ├── kotlin/.../MainActivity.kt # Main Android activity
    │       └── res/                      # Android resources
    ├── build.gradle                      # Project-level Gradle
    ├── settings.gradle                   # Gradle settings
    └── gradle.properties                 # Gradle properties
```

## ✨ Key Features Implemented

### 🎮 Game Mechanics
- ✅ 3 distinct roles: Civilians, Spies, and Mr. White
- ✅ 40+ word pairs across multiple categories
- ✅ Customizable player count (4-12)
- ✅ Adjustable spy count (1-3)
- ✅ Optional Mr. White inclusion
- ✅ Private word reveal system
- ✅ Player elimination/voting system
- ✅ Mr. White guess mechanic
- ✅ Multiple win conditions

### 🎨 User Interface
- ✅ Beautiful gradient backgrounds
- ✅ Material Design 3 components
- ✅ Smooth navigation between screens
- ✅ Interactive setup with sliders
- ✅ Color-coded roles (Blue, Red, Orange)
- ✅ Game statistics display
- ✅ Responsive card layouts
- ✅ Intuitive icons and visual feedback

### 🔧 Technical Features
- ✅ State management with Provider
- ✅ Clean architecture (Models, Providers, Screens)
- ✅ Proper role randomization
- ✅ Game state tracking
- ✅ Win condition detection
- ✅ Player elimination logic
- ✅ Round management

## 🚀 Next Steps

### 1. Install Flutter (if not already installed)
See `SETUP_INSTRUCTIONS.md` for detailed Flutter installation guide.

### 2. Get Dependencies
```powershell
cd C:\Users\coolp\OneDrive\Documents\Code\undercover_game
flutter pub get
```

### 3. Run the App
```powershell
flutter run
```

Or see `QUICKSTART.md` for platform-specific instructions.

## 📖 How to Play

1. **Start Game**: Launch app and configure settings
2. **View Words**: Each player privately views their word
3. **Describe**: Players take turns describing their words
4. **Deduce**: Try to identify who has which role
5. **Vote**: Eliminate suspected players
6. **Win**: Achieve your role's victory condition

## 🎯 Game Roles Explained

### Civilians (Blue) 👥
- Get the main word (e.g., "Coffee")
- Majority of players
- Must find and eliminate all Spies and Mr. White
- Can describe their word relatively freely

### Spies (Red) 👁️
- Get a similar word (e.g., "Tea")
- Must blend in without being caught
- Win by eliminating all Civilians
- Must be careful with descriptions

### Mr. White (Orange) ❓
- Gets NO word at all!
- Must listen and deduce what word is being discussed
- Can win by surviving and correctly guessing the Civilian word
- Most challenging role

## 🔥 40+ Word Pairs Included

Categories include:
- 🍔 Food & Drinks (Coffee/Tea, Pizza/Burger, etc.)
- 🐱 Animals (Cat/Dog, Lion/Tiger, etc.)
- 🚗 Transportation (Car/Motorcycle, Train/Bus, etc.)
- 🎬 Entertainment (Movie/TV Show, Guitar/Piano, etc.)
- 🌄 Nature (Sun/Moon, Ocean/Lake, etc.)
- 💻 Technology (Laptop/Desktop, iPhone/Android, etc.)
- 🏖️ Places (Beach/Pool, Restaurant/Café, etc.)
- ✏️ Objects (Pen/Pencil, Spoon/Fork, etc.)

## 🛠️ Customization Options

### Add More Word Pairs
Edit `lib/models/word_pair.dart`:
```dart
WordPair(
  civilianWord: 'Your Word',
  spyWord: 'Similar Word',
  category: 'Category'
),
```

### Change Theme Colors
Edit `lib/main.dart`:
```dart
primarySwatch: Colors.deepPurple, // Change color
```

### Adjust Player Limits
Edit `lib/screens/setup_screen.dart`:
```dart
min: 4,  // Minimum players
max: 12, // Maximum players
```

## 📱 Supported Platforms

- ✅ Android (phones & tablets)
- ✅ iOS (requires macOS to build)
- ✅ Web (Chrome, Firefox, Safari)
- ✅ Windows Desktop
- ✅ macOS Desktop
- ✅ Linux Desktop

## 🎨 Color Scheme

- **Primary**: Deep Purple (#673AB7)
- **Civilians**: Blue (#2196F3)
- **Spies**: Red (#F44336)
- **Mr. White**: Orange (#FF9800)

## 📦 Dependencies Used

```yaml
dependencies:
  flutter: sdk
  cupertino_icons: ^1.0.2
  provider: ^6.0.5        # State management

dev_dependencies:
  flutter_test: sdk
  flutter_lints: ^2.0.0   # Code quality
```

## 🐛 Known Limitations

- Requires Flutter to be installed
- Local multiplayer only (pass-and-play)
- No online multiplayer (future enhancement)
- No sound effects (future enhancement)
- No persistent game history (future enhancement)

## 🚀 Future Enhancement Ideas

- [ ] Online multiplayer
- [ ] Custom word lists
- [ ] Sound effects and music
- [ ] Animations
- [ ] Game history/statistics
- [ ] Multiple languages
- [ ] Timed rounds
- [ ] Chat feature
- [ ] Achievements
- [ ] Dark mode toggle

## 📚 Resources

- **Flutter Documentation**: https://docs.flutter.dev
- **Provider Package**: https://pub.dev/packages/provider
- **Material Design**: https://m3.material.io

## ✅ Testing Checklist

Before running:
- [ ] Flutter installed and in PATH
- [ ] Run `flutter doctor` successfully
- [ ] Android Studio installed (for Android)
- [ ] Device/emulator connected
- [ ] Dependencies fetched (`flutter pub get`)

## 🎉 You're All Set!

Your Undercover game is ready to play! Follow the instructions in `QUICKSTART.md` to run the app.

Enjoy your game! 🎮🕵️
