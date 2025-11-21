# Development Roadmap 🗺️

## Current Version: 1.0.0

### ✅ Completed Features (v1.0.0)
- [x] Core game mechanics
- [x] 3 distinct roles (Civilian, Spy, Mr. White)
- [x] 40+ word pairs
- [x] Player setup (4-12 players)
- [x] Private word reveal
- [x] Voting/elimination system
- [x] Mr. White guess mechanic
- [x] Win condition detection
- [x] Beautiful Material Design UI
- [x] Game state management
- [x] Complete documentation
- [x] Development environment setup
  - [x] Git integration
  - [x] Flutter SDK configuration
  - [x] Android toolchain setup
  - [x] Android emulator configuration
  - [x] Environment variables configuration
- [x] Bug fixes
  - [x] Fixed slider divisions assertion error
  - [x] Fixed text visibility on dark backgrounds
  - [x] Added launcher icons for all densities

---

## 🎯 Planned Features

### v1.1.0 - UI/UX Enhancements
**Priority: High**
**Timeline: 2-3 weeks**

- [x] Custom app icon (basic Flutter icon added)
- [ ] Splash screen animation
- [x] Sound effects (service implemented, audio files pending)
  - [x] Word reveal sound (service ready)
  - [x] Elimination sound (service ready)
  - [x] Victory sound (service ready)
  - [ ] Background music (service ready, toggle implemented)
- [x] Vibration feedback (fully implemented)
- [x] Smooth page transitions (fade, slide animations)
- [x] Loading indicators (component created)
- [x] Confirmation dialogs with animations (AnimatedConfirmDialog)
- [ ] Player avatars (customizable)
- [x] Advanced game configuration system
  - [x] Game configuration models and enums
  - [x] Advanced settings screen with tabs
  - [x] Word category selection
  - [x] Role variants UI (Detective, Jester, Guardian - coming in v1.3.0)
  - [x] Special modifiers UI (coming in v1.3.0)
  - [x] Integration with game setup flow
  - [x] Category-based word filtering

---

### v1.1.5 - Player Management ✅ COMPLETED
**Priority: High**
**Timeline: 1 day (November 22, 2025)**

- [x] Player name management system
  - [x] Player names screen between setup and role selection
  - [x] Local storage with `shared_preferences`
  - [x] Saved players list with search/filter
  - [x] Two-mode UI: "Saved Players" vs "Enter Manually"
  - [x] Quick-select from saved players with checkboxes
  - [x] Add new players on-the-fly
  - [x] Delete saved players with confirmation
  - [x] Progress indicator showing selection count
- [x] Player names on role selection cards
- [x] Player names throughout game
- [x] Validation and duplicate detection
- [x] Error handling for plugin initialization
- [x] Updated game flow: Setup → Names → Role Selection → Game
- [x] Haptic feedback on all interactions

---

### v1.2.0 - Content Expansion
**Priority: High**
**Timeline: 2-3 weeks**

- [ ] 100+ additional word pairs
- [x] Category selection (implemented in Advanced Settings)
  - [x] Choose specific categories
- [ ] Themed word packs
  - [ ] Movies
  - [ ] Video games
  - [ ] Sports
  - [ ] History

---

### v1.3.0 - Advanced Features
**Priority: Medium**
**Timeline: 4-5 weeks**

- [ ] Role variants (UI ready, logic pending)
  - [ ] Detective (can investigate once)
  - [ ] Jester (wants to be eliminated)
  - [ ] Guardian (protects one player)
- [ ] Special abilities/modifiers (UI ready, logic pending)
  - [ ] One-time reveals
  - [ ] Player swaps
  - [ ] Word hints
  - [ ] Double elimination
  - [ ] Silent round
- [ ] Custom rules
  - [ ] Adjustable settings
  - [ ] Rule variations

---

## 🛠️ Technical Improvements

### Code Quality
- [ ] Increase test coverage to 80%+
- [ ] Add integration tests
- [ ] Add widget tests for all screens
- [ ] Improve error handling
- [ ] Add logging system
- [ ] Code documentation (DartDoc)
- [ ] Performance optimization
- [ ] Memory leak prevention

### Architecture
- [ ] Implement clean architecture
- [ ] Add repository pattern
- [ ] Use dependency injection
- [ ] Separate business logic
- [ ] Add use cases layer
- [ ] Implement event-driven architecture

### Platform Support
- [ ] iOS app (requires macOS)
- [ ] Web optimization
- [ ] Desktop optimization (Windows/Mac/Linux)
- [ ] Tablet UI optimization
- [ ] Responsive design improvements

---

## 🐛 Known Issues to Fix

### High Priority
- [x] Ensure proper state management on app lifecycle
- [x] Slider divisions assertion error (Fixed: Added null check)
- [x] Text visibility on dark backgrounds (Fixed: Changed to white70)
- [ ] Handle network errors gracefully
- [ ] Add input validation
- [ ] Prevent rapid button taps

### Medium Priority
- [ ] Optimize word reveal screen transitions
- [ ] Improve card animations
- [ ] Better error messages
- [ ] Add haptic feedback

### Low Priority
- [ ] Polish UI animations
- [ ] Improve accessibility
- [ ] Add screen reader support
- [ ] Keyboard navigation

---

## 📊 Performance Goals

### v1.x
- [ ] App startup < 2 seconds
- [ ] 60 FPS on all screens
- [ ] < 100MB installed size
- [ ] < 50MB RAM usage

### v2.x
- [ ] < 1 second screen transitions
- [ ] Offline mode support
- [ ] Background sync
- [ ] Efficient data caching

---

## 🎨 Design Improvements

### v1.x
- [ ] Consistent spacing
- [ ] Better color contrast
- [ ] Improved typography
- [ ] Custom illustrations

### v2.x
- [ ] Animated backgrounds
- [ ] Custom game board view
- [ ] 3D card effects
- [ ] Particle effects

---

## 📱 Platform Releases

### Current
- [x] Android support
- [x] Android Emulator tested
- [ ] Android Play Store (pending)

### Future
- [ ] iOS App Store
- [ ] Web hosting
- [ ] Windows Store
- [ ] macOS App Store
- [ ] Linux (Snap/Flatpak)

---

## 🤝 Community Features

### Short Term
- [ ] GitHub repository
- [ ] Issue tracker
- [ ] Contributing guidelines
- [ ] Code of conduct

### Long Term
- [ ] Community word pack submissions
- [ ] Translation contributions
- [ ] Beta testing program
- [ ] Developer API

---

## 📝 Documentation

### Technical Docs
- [ ] API documentation
- [ ] Architecture guide
- [ ] Contributing guide
- [ ] Testing guide

### User Docs
- [ ] Video tutorial
- [ ] Strategy guide
- [ ] FAQ page
- [ ] Community forum

---

## 🎯 Milestones

### Q1 2026
- Release v1.1.0 (UI/UX)
- Release v1.2.0 (Gameplay)
- Reach 1,000 downloads

### Q2 2026
- Release v1.3.0 (Content)
- Release v1.4.0 (Statistics)
- Reach 10,000 downloads

### Q3 2026
- Release v1.5.0 (Advanced)
- Begin v2.0.0 development
- Community feedback integration

### Q4 2026
- Release v2.0.0 (Online Multiplayer)
- Major marketing push
- Reach 100,000 downloads

---

## 💡 Ideas for Consideration

### Gameplay
- Detective mode (find the words)
- Picture cards instead of words
- Team-based gameplay
- Tournament mode
- Daily challenges
- Expert Mode: Mr. White can win by guessing either word (civilian OR spy)
- Difficulty presets (Easy/Normal/Hard/Expert)

### Social
- Clan/Guild system
- Weekly competitions
- Seasonal events
- Special holiday modes

### Monetization
- Cosmetic items
- Battle pass system
- Ad-supported free tier
- Premium subscription

---

## 🔄 Development Cycle

### For Each Version:
1. **Planning** (1 week)
   - Feature specification
   - Design mockups
   - Technical planning

2. **Development** (2-4 weeks)
   - Implementation
   - Unit testing
   - Code review

3. **Testing** (1 week)
   - QA testing
   - Bug fixes
   - Performance testing

4. **Release** (1 week)
   - Beta release
   - Feedback collection
   - Final release

5. **Maintenance** (Ongoing)
   - Bug fixes
   - Small improvements
   - User support

---

## 🎓 Learning Goals

While developing this project, learn:
- [ ] Advanced Flutter widgets
- [ ] State management (Bloc/Riverpod)
- [ ] Firebase integration
- [ ] WebSocket for real-time
- [ ] Payment integration
- [ ] CI/CD pipelines
- [ ] App store deployment
- [ ] Analytics integration

---

---

**Remember:** Keep it simple, focus on fun gameplay, and prioritize the player experience! 🎮

---

## 📋 Recent Updates

### November 18-19, 2025
- ✅ Completed development environment setup
- ✅ Configured Git, Flutter SDK, and Android toolchain
- ✅ Set up environment variables (ANDROID_HOME, PATH)
- ✅ Successfully ran app on Android emulator
- ✅ Fixed slider divisions bug in setup screen
- ✅ Fixed text visibility on home screen (dark background)
- ✅ Added missing launcher icons for all screen densities
- ✅ Accepted Android SDK licenses
- ✅ Updated Gradle build files
- ✅ Removed role display from word reveal screen (players must deduce roles)
- ✅ Fixed Mr. White guess mechanic - now only triggers when eliminated
- ✅ Updated Mr. White to guess civilian word only (Expert Mode planned for v1.5.0)
- ✅ **v1.1.0 UI/UX Enhancements:**
  - ✅ Implemented vibration/haptic feedback service
  - ✅ Created audio service for sound effects
  - ✅ Added smooth page transitions (fade, slide)
  - ✅ Created animated confirmation dialogs
  - ✅ Created loading indicator widget
  - ✅ Created enhanced button with animations
  - ✅ Added animations to home screen (shimmer, fade, slide)
  - ✅ Added animations to word reveal screen
  - ✅ Added animations to player cards in game screen
  - ✅ Integrated haptic feedback on all button presses
  - ✅ Added Android permissions for vibration and audio

### November 22, 2025
- ✅ **Role Selection Phase Implementation:**
  - ✅ Created new `RoleSelectionScreen` with card-based role picking
  - ✅ Implemented animated card grid for player selection
  - ✅ Added visual feedback when players pick their cards
  - ✅ Created role reveal dialog showing only words (not roles)
  - ✅ **Game Flow Change:** Players only see their WORD, not their role
    - Civilians and Spies see their word (e.g., "COFFEE" or "TEA")
    - Mr. White sees "YOU ARE MR. WHITE" with "You have NO word"
    - Players must deduce if they're Civilian or Spy during gameplay
  - ✅ Added progress bar showing selection status
  - ✅ Implemented custom card pattern painter for visual appeal
  - ✅ Implemented dialog background pattern painter
  - ✅ Added haptic feedback for card selection
  - ✅ Created smooth transitions between setup → role selection → game
  - ✅ Updated game flow to include role selection before gameplay
  - ✅ Added "Start Game" button that activates after all players select
  - ✅ Adaptive card grid (2 columns for ≤6 players, 3 columns for 7+ players)
  - ✅ Improved contrast and readability in reveal dialogs
  - ✅ Dark gradient backgrounds for word/role cards with white text
  - ✅ Themed color schemes (Purple for words, Orange for Mr. White)
  - ✅ **Removed eye icon from game screen** (word reveal now done in card selection)
  - ✅ Cleaned up unused word reveal functionality from game screen
  - ✅ Removed `WordRevealScreen` navigation from game flow
  - ✅ **Added back button** to role selection screen with confirmation dialog
  - ✅ Back button allows players to return to setup and modify settings

- ✅ **Player Name Management System (v1.1.5 - FULLY TESTED & WORKING):**
  - ✅ Created `PlayerNamesScreen` between setup and role selection
  - ✅ Implemented local storage with `shared_preferences`
  - ✅ Built saved players list with search/filter functionality
  - ✅ Added manual name entry mode (fallback if no saved players)
  - ✅ Quick-select from saved players with checkboxes
  - ✅ Add new players on-the-fly while selecting
  - ✅ Delete saved players with confirmation
  - ✅ Progress indicator showing selection count (X/Y selected)
  - ✅ Two-mode UI: "Saved Players" vs "Enter Manually"
  - ✅ Validation: Ensures exact player count is entered
  - ✅ Duplicate name detection
  - ✅ Player names display on role selection cards
  - ✅ Player names persist throughout game (setup → names → roles → game)
  - ✅ Updated `GameProvider` with `setPlayerNames()` method
  - ✅ Added `numPlayers`, `numSpies`, `includeMrWhiteSetup` getters
  - ✅ Updated game flow: Setup → Player Names → Role Selection → Game
  - ✅ Haptic feedback on all player selection interactions
  - ✅ Error handling for plugin initialization failures
  - ✅ Non-blocking save operations (graceful degradation)
  - ✅ **TESTED & CONFIRMED WORKING** - Full rebuild completed successfully

- ✅ **Advanced Game Configuration System (v1.1.0 Extension):**
  - ✅ Created comprehensive game configuration models
  - ✅ Implemented `GameConfig` class with all settings
  - ✅ Added enums for WordCategory, RoleVariant, SpecialModifier
  - ✅ Built `AdvancedSettingsScreen` with 3 tabs:
    - ✅ Categories tab: Select specific word categories or randomize all
    - ✅ Role Variants tab: Detective, Jester, Guardian (UI ready, marked as coming soon)
    - ✅ Modifiers tab: Special abilities (UI ready, marked as coming soon)
  - ✅ Integrated advanced settings button in setup screen
  - ✅ Added settings summary display showing active configurations
  - ✅ Updated `GameProvider` to handle `GameConfig`
  - ✅ Implemented category-based word filtering in `WordDatabase`
  - ✅ Added `getRandomWordPairByCategories()` method
  - ✅ Category-to-string mapping for filtering
  - ✅ Smooth navigation flow: Setup → Advanced Settings → Apply → Continue
  - ✅ Cancel/Apply buttons for settings changes
  - ✅ Visual feedback for selected categories
  - ✅ Removed game modes feature (keeping game classic only)

- ✅ **Roadmap Cleanup:**
  - ✅ Removed unnecessary features from v1.2.0 (timer system, description history, vote tracking, hint system, tutorial)
  - ✅ Simplified v1.2.0 to focus on core gameplay improvements
  - ✅ Reduced timeline from 3-4 weeks to 1-2 weeks
  - ✅ Removed difficulty levels (not needed - word difficulty is inherent)
  - ✅ Removed custom word lists (deferred)
  - ✅ Removed multiple languages (deferred)
  - ✅ Updated v1.3.0 to reflect UI completion for role variants and modifiers
  - ✅ Added progress bar showing selection status
  - ✅ Implemented custom card pattern painter for visual appeal
  - ✅ Implemented dialog background pattern painter
  - ✅ Added haptic feedback for card selection
  - ✅ Created smooth transitions between setup → role selection → game
  - ✅ Updated game flow to include role selection before gameplay
  - ✅ Added "Start Game" button that activates after all players select
  - ✅ Adaptive card grid (2 columns for ≤6 players, 3 columns for 7+ players)
  - ✅ Improved contrast and readability in reveal dialogs
  - ✅ Dark gradient backgrounds for word/role cards with white text
  - ✅ Themed color schemes (Purple for words, Orange for Mr. White)
  - ✅ **Removed eye icon from game screen** (word reveal now done in card selection)
  - ✅ Cleaned up unused word reveal functionality from game screen
  - ✅ Removed `WordRevealScreen` navigation from game flow
  - ✅ **Added back button** to role selection screen with confirmation dialog
  - ✅ Back button allows players to return to setup and modify settings

- ✅ **Roadmap Cleanup:**
  - ✅ Removed unnecessary features from v1.2.0 (timer system, description history, vote tracking, hint system, tutorial)
  - ✅ Simplified v1.2.0 to focus on core gameplay improvements
  - ✅ Reduced timeline from 3-4 weeks to 1-2 weeks

**Note:** Since players reveal their words during card selection, the in-game word reveal feature (eye icon) has been removed. If needed in the future, it can be restored from git history.

---

Last Updated: November 22, 2025
