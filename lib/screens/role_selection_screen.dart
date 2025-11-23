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
  final Set<int> _selectedCardIndices = {};
  int _currentPlayerIndex = 0;
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
      
      // Show the first player's turn dialog
      if (gameProvider.players.isNotEmpty) {
        _showTurnDialog(context, gameProvider.players[0].name);
      }
    });
  }

  void _showTurnDialog(BuildContext context, String playerName) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Next Player', textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.person_pin, size: 64, color: Colors.deepPurple),
            const SizedBox(height: 16),
            const Text(
              'Pass the device to:',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              playerName,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'It\'s your turn to pick a card!',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                HapticService().light();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Text('I am $playerName'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        final players = gameProvider.players;
        
        // Safety check
        if (players.isEmpty) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final currentPlayerName = _currentPlayerIndex < players.length 
            ? players[_currentPlayerIndex].name 
            : 'All Done';

        return Scaffold(
          appBar: AppBar(
            title: const Text('Pick Your Cards'),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                HapticService().light();
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
                // Instructions / Status
                _buildStatusHeader(players.length, _currentPlayerIndex, currentPlayerName),
                
                // Card Grid
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        int crossAxisCount = players.length <= 6 ? 2 : 3;
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
                            final isSelected = _selectedCardIndices.contains(index);
                            
                            return _buildCard(
                              context,
                              isSelected,
                              index,
                              gameProvider,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                
                // Start Game Button
                _buildStartButton(context, _allSelected),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusHeader(int totalPlayers, int currentIndex, String currentPlayerName) {
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
          if (!_allSelected) ...[
            const Text(
              'Current Turn',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              currentPlayerName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pick a random card!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            ),
          ] else ...[
            const Icon(Icons.check_circle, color: Colors.greenAccent, size: 40),
            const SizedBox(height: 8),
            const Text(
              'All players ready!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: totalPlayers > 0 ? currentIndex / totalPlayers : 0.0,
              backgroundColor: Colors.white30,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$currentIndex / $totalPlayers selected',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    bool isSelected,
    int cardIndex,
    GameProvider gameProvider,
  ) {
    return GestureDetector(
      onTap: isSelected || _allSelected
          ? null
          : () => _handleCardTap(cardIndex, gameProvider),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isSelected
                ? [Colors.grey.shade700, Colors.grey.shade900]
                : [
                    Colors.deepPurple.shade600,
                    Colors.deepPurple.shade800,
                  ],
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? Colors.black.withOpacity(0.2)
                  : Colors.deepPurple.withOpacity(0.5),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
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
              child: isSelected
                  ? const Icon(Icons.check, size: 48, color: Colors.white54)
                  : const Text(
                      '?',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleCardTap(int cardIndex, GameProvider gameProvider) async {
    if (_currentPlayerIndex >= gameProvider.players.length) return;

    setState(() {
      _selectedCardIndices.add(cardIndex);
    });
    HapticService().medium();

    final currentPlayer = gameProvider.players[_currentPlayerIndex];

    // Show the role dialog and wait for it to close
    await _showRoleDialog(context, currentPlayer);

    // Move to next player
    setState(() {
      _currentPlayerIndex++;
    });

    if (_currentPlayerIndex < gameProvider.players.length) {
      if (mounted) {
        _showTurnDialog(context, gameProvider.players[_currentPlayerIndex].name);
      }
    } else {
      setState(() {
        _allSelected = true;
      });
      HapticService().success();
    }
  }

  Future<void> _showRoleDialog(BuildContext context, dynamic player) async {
    final isMrWhite = player.role.toString() == 'PlayerRole.mrWhite';
    final word = player.word;
    
    await showDialog(
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
              Positioned.fill(
                child: CustomPaint(
                  painter: _DialogPatternPainter(isMrWhite: isMrWhite),
                ),
              ),
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
                      return FadeTransition(opacity: animation, child: child);
                    },
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
