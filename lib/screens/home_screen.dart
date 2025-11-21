import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'setup_screen.dart';
import '../widgets/enhanced_button.dart';
import '../services/haptic_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.shade300,
              Colors.deepPurple.shade700,
              Colors.indigo.shade900,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Game Title
                  const Icon(
                    Icons.psychology,
                    size: 80,
                    color: Colors.white,
                  )
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .scale(delay: 200.ms, duration: 400.ms)
                      .then()
                      .shimmer(delay: 1000.ms, duration: 1500.ms),
                  const SizedBox(height: 24),
                  const Text(
                    'UNDERCOVER',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 4,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 300.ms, duration: 600.ms)
                      .slideY(begin: -0.3, end: 0),
                  const SizedBox(height: 8),
                  const Text(
                    'A Social Deduction Game',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                      letterSpacing: 2,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 500.ms, duration: 600.ms),
                  const SizedBox(height: 48),
                  
                  // Game Description Card
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          const Text(
                            'How to Play',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildRoleDescription(
                            icon: Icons.people,
                            color: Colors.blue,
                            title: 'Civilians',
                            description: 'Get the main word. Try to find the spy!',
                          ),
                          const SizedBox(height: 12),
                          _buildRoleDescription(
                            icon: Icons.visibility_off,
                            color: Colors.red,
                            title: 'Spies',
                            description: 'Get a similar word. Blend in with civilians!',
                          ),
                          const SizedBox(height: 12),
                          _buildRoleDescription(
                            icon: Icons.help_outline,
                            color: Colors.orange,
                            title: 'Mr. White',
                            description: 'Gets NO word. Figure out what everyone is talking about!',
                          ),
                        ],
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 700.ms, duration: 600.ms)
                      .slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 32),
                  
                  // Play Button
                  EnhancedButton(
                    label: 'START GAME',
                    onPressed: () {
                      HapticService().medium();
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              const SetupScreen(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(1.0, 0.0),
                                  end: Offset.zero,
                                ).animate(CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeInOut,
                                )),
                                child: child,
                              ),
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 400),
                        ),
                      );
                    },
                    color: Colors.white,
                    textColor: Colors.deepPurple,
                    minimumSize: const Size(200, 60),
                  ),
                  const SizedBox(height: 16),
                  
                  // Rules Button
                  TextButton(
                    onPressed: () {
                      HapticService().light();
                      _showRulesDialog(context);
                    },
                    child: const Text(
                      'View Complete Rules',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 1100.ms, duration: 600.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleDescription({
    required IconData icon,
    required Color color,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showRulesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Rules'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Setup:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text('• Choose number of players (4-12)\n'
                  '• Select number of spies (1-3)\n'
                  '• Optionally include Mr. White'),
              SizedBox(height: 16),
              Text(
                'Gameplay:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text('1. Each player secretly views their word\n'
                  '2. Players take turns describing their word\n'
                  '3. Players discuss and try to identify roles\n'
                  '4. Vote to eliminate suspected spies/Mr. White\n'
                  '5. If Mr. White survives, they can guess the word'),
              SizedBox(height: 16),
              Text(
                'Win Conditions:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text('• Civilians: Eliminate all spies and Mr. White\n'
                  '• Spies: Eliminate all civilians\n'
                  '• Mr. White: Survive and guess the civilian word correctly'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }
}
