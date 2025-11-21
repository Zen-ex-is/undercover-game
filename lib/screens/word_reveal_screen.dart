import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/player.dart';
import '../services/haptic_service.dart';
import '../services/audio_service.dart';

class WordRevealScreen extends StatefulWidget {
  final Player player;

  const WordRevealScreen({super.key, required this.player});

  @override
  State<WordRevealScreen> createState() => _WordRevealScreenState();
}

class _WordRevealScreenState extends State<WordRevealScreen> {
  bool _isRevealed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.player.name}\'s Word'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.withOpacity(0.2),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Warning Icon
                  const Icon(
                    Icons.remove_red_eye,
                    size: 80,
                    color: Colors.deepPurple,
                  )
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .scale(delay: 100.ms, duration: 400.ms)
                      .then()
                      .shimmer(delay: 200.ms, duration: 1000.ms),
                  const SizedBox(height: 24),
                  
                  // Player Name
                  Text(
                    widget.player.name,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 300.ms, duration: 400.ms)
                      .slideY(begin: -0.2, end: 0),
                  const SizedBox(height: 48),
                  
                  // Word Card
                  if (!_isRevealed) ...[
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(32),
                        width: double.infinity,
                        child: Column(
                          children: [
                            Icon(
                              Icons.touch_app,
                              size: 48,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Make sure no one else can see your screen!',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () {
                                HapticService().medium();
                                AudioService().playWordReveal().catchError((_) {
                                  // Ignore audio errors for now (no audio files yet)
                                });
                                setState(() {
                                  _isRevealed = true;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 48,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'REVEAL MY WORD',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(delay: 500.ms, duration: 400.ms)
                        .scale(delay: 500.ms, duration: 400.ms),
                  ] else ...[
                    Card(
                      elevation: 8,
                      color: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(48),
                        width: double.infinity,
                        child: Column(
                          children: [
                            const Text(
                              'Your Word:',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 24),
                            if (widget.player.word != null)
                              Text(
                                widget.player.word!,
                                style: const TextStyle(
                                  fontSize: 56,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              )
                            else
                              const Column(
                                children: [
                                  Text(
                                    'NO WORD',
                                    style: TextStyle(
                                      fontSize: 56,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Listen carefully to what others say!',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 600.ms)
                        .scale(duration: 600.ms)
                        .then()
                        .shimmer(delay: 300.ms, duration: 1000.ms),
                  ],
                  
                  const SizedBox(height: 32),
                  
                  if (_isRevealed)
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                      ),
                      child: const Text(
                        'Got it! Back to Game',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
