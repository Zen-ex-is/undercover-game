import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../services/haptic_service.dart';
import 'game_screen.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  final Set<int> _selectedPlayerIds = {};
  bool _allSelected = false;

  @override
  void initState() {
    super.initState();
    // Initialize the game with the configured parameters
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final gameProvider = Provider.of<GameProvider>(context, listen: false);
      gameProvider.setupGame(
        gameProvider.numPlayers,
        gameProvider.numSpies,
        gameProvider.includeMrWhiteSetup,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        final players = gameProvider.players;
        final allPlayersSelected = _selectedPlayerIds.length == players.length;

        // Update allSelected state when all players have picked
        if (allPlayersSelected && !_allSelected) {
          _allSelected = true;
          // Trigger haptic feedback
          Future.delayed(const Duration(milliseconds: 100), () {
            HapticService().success();
          });
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Pick Your Cards'),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                HapticService().light();
                // Show confirmation dialog before going back
                _confirmGoBack(context, gameProvider);
              },
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.deepPurple.shade50,
                  Colors.purple.shade50,
                ],
              ),
            ),
            child: Column(
              children: [
                // Instructions
                _buildInstructions(players.length, _selectedPlayerIds.length),
                
                // Card Grid
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        // Calculate optimal grid based on number of players
                        int crossAxisCount = players.length <= 6 ? 2 : 3;
                        // Use fixed aspect ratio instead of calculation
                        double aspectRatio = players.length <= 6 ? 0.7 : 0.65;
                        
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            childAspectRatio: aspectRatio,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: players.length,
                          itemBuilder: (context, index) {
                            final player = players[index];
                            final isSelected = _selectedPlayerIds.contains(player.id);
                            
                            return _buildCard(
                              context,
                              player,
                              isSelected,
                              index,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                
                // Start Game Button
                _buildStartButton(context, allPlayersSelected),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInstructions(int totalPlayers, int selectedCount) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.deepPurple.shade700,
            Colors.deepPurple.shade500,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            '🎴 Each player picks one card',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Tap a card to reveal your secret role',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: totalPlayers > 0 ? selectedCount / totalPlayers : 0.0,
              backgroundColor: Colors.white30,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 10,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$selectedCount / $totalPlayers players selected',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    dynamic player,
    bool isSelected,
    int index,
  ) {
    return GestureDetector(
      onTap: isSelected
          ? null
          : () {
              setState(() {
                _selectedPlayerIds.add(player.id);
              });
              HapticService().medium();
              _showRoleDialog(context, player);
            },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isSelected
                ? [Colors.green.shade600, Colors.green.shade800]
                : [
                    Colors.deepPurple.shade600,
                    Colors.deepPurple.shade800,
                  ],
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? Colors.green.withOpacity(0.5)
                  : Colors.deepPurple.withOpacity(0.5),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: isSelected
                ? null
                : () {
                    setState(() {
                      _selectedPlayerIds.add(player.id);
                    });
                    HapticService().medium();
                    _showRoleDialog(context, player);
                  },
            child: Stack(
              children: [
                // Card Pattern
                Positioned.fill(
                  child: CustomPaint(
                    painter: _CardPatternPainter(isSelected: isSelected),
                  ),
                ),
                
                // Card Content
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isSelected ? Icons.check_circle : Icons.touch_app,
                        size: 72,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        isSelected ? 'Selected!' : player.name,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isSelected ? '✓ Role Revealed' : 'Tap to reveal',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showRoleDialog(BuildContext context, dynamic player) {
    final isMrWhite = player.role.toString() == 'PlayerRole.mrWhite';
    final word = player.word;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isMrWhite
                  ? [Colors.orange.shade50, Colors.orange.shade100]
                  : [Colors.deepPurple.shade50, Colors.purple.shade100],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              // Background pattern
              Positioned.fill(
                child: CustomPaint(
                  painter: _DialogPatternPainter(isMrWhite: isMrWhite),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isMrWhite ? Icons.help_outline : Icons.visibility,
                      size: 80,
                      color: isMrWhite ? Colors.orange.shade700 : Colors.deepPurple.shade700,
                    ),
                    const SizedBox(height: 24),
                    
                    // Show different content for Mr. White vs others
                    if (isMrWhite) ...[
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.orange.shade700, Colors.orange.shade900],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.orange.shade900, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'You are',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'MR. WHITE',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2,
                                shadows: [
                                  Shadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 2),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                '❌ You have NO word',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.orange.shade300, width: 2),
                        ),
                        child: Text(
                          '🎯 Listen carefully and figure out the word!',
                          style: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            color: Colors.orange.shade900,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ] else ...[
                      // For Civilians and Spies - only show the word
                      Text(
                        'Your Word',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.deepPurple.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.deepPurple.shade700, Colors.deepPurple.shade900],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.deepPurple.shade900, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurple.withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Text(
                          word?.toUpperCase() ?? '',
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 3,
                            shadows: [
                              Shadow(
                                color: Colors.black26,
                                offset: Offset(0, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.deepPurple.shade300, width: 2),
                        ),
                        child: Text(
                          '💡 You don\'t know your role yet!\nListen to others to figure it out.',
                          style: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            color: Colors.deepPurple.shade900,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade700,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.warning_amber_rounded, color: Colors.white, size: 24),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Don\'t show this to anyone!',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        HapticService().light();
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 52),
                        backgroundColor: isMrWhite ? Colors.orange.shade700 : Colors.deepPurple.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 6,
                      ),
                      child: const Text(
                        'Got it!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStartButton(BuildContext context, bool enabled) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: enabled
            ? () {
                HapticService().heavy();
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const GameScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 500),
                  ),
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(0, 56),
          backgroundColor: enabled ? Colors.green : Colors.grey,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (enabled)
              const Icon(Icons.play_arrow, size: 28)
            else
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            const SizedBox(width: 12),
            Text(
              enabled ? 'Start Game!' : 'Waiting for all players...',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmGoBack(BuildContext context, GameProvider gameProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Go Back?'),
        content: const Text(
          'Going back will reset the game. Are you sure you want to change settings?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              HapticService().medium();
              Navigator.pop(context); // Close dialog
              gameProvider.resetGame(); // Reset game state
              Navigator.pop(context); // Go back to setup
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
            ),
            child: const Text('Go Back'),
          ),
        ],
      ),
    );
  }
}

// Custom painter for card pattern
class _CardPatternPainter extends CustomPainter {
  final bool isSelected;

  _CardPatternPainter({required this.isSelected});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(isSelected ? 0.15 : 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    // Draw decorative pattern - concentric circles
    for (int i = 1; i <= 4; i++) {
      final radius = (size.width * 0.15) * i;
      canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        radius,
        paint,
      );
    }
    
    // Draw corner decorations
    final cornerPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;
    
    const cornerRadius = 20.0;
    canvas.drawCircle(const Offset(20, 20), cornerRadius, cornerPaint);
    canvas.drawCircle(Offset(size.width - 20, 20), cornerRadius, cornerPaint);
    canvas.drawCircle(Offset(20, size.height - 20), cornerRadius, cornerPaint);
    canvas.drawCircle(Offset(size.width - 20, size.height - 20), cornerRadius, cornerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter for dialog background pattern
class _DialogPatternPainter extends CustomPainter {
  final bool isMrWhite;

  _DialogPatternPainter({required this.isMrWhite});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isMrWhite 
          ? Colors.orange.withOpacity(0.1) 
          : Colors.deepPurple.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw diagonal lines pattern
    for (int i = 0; i < 20; i++) {
      final offset = i * 30.0;
      canvas.drawLine(
        Offset(offset - size.height, 0),
        Offset(offset, size.height),
        paint,
      );
    }
    
    // Draw corner circles
    final cornerPaint = Paint()
      ..color = isMrWhite 
          ? Colors.orange.withOpacity(0.15) 
          : Colors.deepPurple.withOpacity(0.15)
      ..style = PaintingStyle.fill;
    
    const cornerRadius = 30.0;
    canvas.drawCircle(const Offset(30, 30), cornerRadius, cornerPaint);
    canvas.drawCircle(Offset(size.width - 30, 30), cornerRadius, cornerPaint);
    canvas.drawCircle(Offset(30, size.height - 30), cornerRadius, cornerPaint);
    canvas.drawCircle(Offset(size.width - 30, size.height - 30), cornerRadius, cornerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
