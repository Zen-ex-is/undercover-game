# Audio Assets

This directory should contain the following sound effect files:

## Required Audio Files

1. **click.mp3** - Button click sound
2. **reveal.mp3** - Word reveal sound effect
3. **eliminate.mp3** - Player elimination sound
4. **victory.mp3** - Victory/win sound
5. **background.mp3** - Background music (optional)

## Format Requirements

- **Format**: MP3 or OGG
- **Sample Rate**: 44.1 kHz recommended
- **Bit Rate**: 128-192 kbps
- **Duration**: 
  - Click: < 0.5 seconds
  - Effects: 1-3 seconds
  - Background: 30-120 seconds (loopable)

## Where to Get Sounds

### Free Resources:
- [freesound.org](https://freesound.org/)
- [zapsplat.com](https://www.zapsplat.com/)
- [mixkit.co](https://mixkit.co/free-sound-effects/)
- [pixabay.com/sound-effects](https://pixabay.com/sound-effects/)

### Tips:
- Use royalty-free or Creative Commons licensed sounds
- Keep file sizes small (< 100KB for effects)
- Test sounds on device for appropriate volume
- Ensure sounds are not jarring or annoying

## Current Status

⚠️ **Audio files not included yet**

The audio service is fully implemented and ready to use. Just add the sound files to this directory and update `pubspec.yaml` to include them.

## How to Add to Project

1. Place sound files in this directory
2. Update `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/sounds/
```

3. Sound effects will work automatically!

## Testing Without Audio Files

The app will work fine without audio files. Audio playback errors are caught and ignored gracefully, so the game is fully functional even without sound effects.
