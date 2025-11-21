import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/game_provider.dart';
import '../models/player.dart';
import '../widgets/animated_dialog.dart';
import '../services/haptic_service.dart';
import 'home_screen.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        if (gameProvider.gameState == GameState.finished) {
          return _buildGameOverScreen(context, gameProvider);
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Round ${gameProvider.roundNumber}'),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: () => _showGameInfo(context, gameProvider),
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.1),
                  Colors.white,
                ],
              ),
            ),
            child: Column(
              children: [
                // Game Status Bar
                _buildStatusBar(gameProvider),
                
                // Players List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: gameProvider.players.length,
                    itemBuilder: (context, index) {
                      return _buildPlayerCard(
                        context,
                        gameProvider,
                        gameProvider.players[index],
                      )
                          .animate()
                          .fadeIn(delay: (100 * index).ms, duration: 300.ms)
                          .slideX(begin: -0.2, end: 0);
                    },
                  ),
                ),
                
                // Action Buttons
                _buildActionButtons(context, gameProvider),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusBar(GameProvider gameProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatusItem(
            icon: Icons.people,
            label: 'Alive',
            value: '${gameProvider.alivePlayers}/${gameProvider.totalPlayers}',
            color: Colors.blue,
          ),
          _buildStatusItem(
            icon: Icons.groups,
            label: 'Civilians',
            value: '${gameProvider.civilianCount}',
            color: Colors.green,
          ),
          _buildStatusItem(
            icon: Icons.visibility_off,
            label: 'Spies',
            value: '${gameProvider.spyCount}',
            color: Colors.red,
          ),
          if (gameProvider.includeMrWhite)
            _buildStatusItem(
              icon: Icons.help_outline,
              label: 'Mr. White',
              value: gameProvider.hasMrWhite ? '1' : '0',
              color: Colors.orange,
            ),
        ],
      ),
    );
  }

  Widget _buildStatusItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerCard(
    BuildContext context,
    GameProvider gameProvider,
    Player player,
  ) {
    final isEliminated = player.isEliminated;
    
    return Card(
      elevation: isEliminated ? 1 : 4,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isEliminated
            ? BorderSide(color: Colors.red.withOpacity(0.3), width: 2)
            : BorderSide.none,
      ),
      child: Opacity(
        opacity: isEliminated ? 0.5 : 1.0,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: CircleAvatar(
            backgroundColor: isEliminated
                ? Colors.grey
                : _getRoleColor(player.role),
            child: Text(
              'P${player.id}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            player.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              decoration: isEliminated ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: isEliminated
              ? const Text(
                  'Eliminated',
                  style: TextStyle(color: Colors.red),
                )
              : null,
          trailing: isEliminated
              ? const Icon(Icons.close, color: Colors.red)
              : IconButton(
                  icon: const Icon(Icons.how_to_vote, color: Colors.red),
                  onPressed: () {
                    HapticService().light();
                    _confirmElimination(context, gameProvider, player);
                  },
                ),
        ),
      ),
    );
  }

  Color _getRoleColor(PlayerRole role) {
    switch (role) {
      case PlayerRole.civilian:
        return Colors.blue;
      case PlayerRole.spy:
        return Colors.red;
      case PlayerRole.mrWhite:
        return Colors.orange;
    }
  }

  Widget _buildActionButtons(BuildContext context, GameProvider gameProvider) {
    return Container(
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
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _confirmEndGame(context, gameProvider),
              icon: const Icon(Icons.home),
              label: const Text('End Game'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(0, 48),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmElimination(BuildContext context, GameProvider gameProvider, Player player) {
    AnimatedConfirmDialog.show(
      context: context,
      title: 'Eliminate Player',
      content: 'Are you sure you want to eliminate ${player.name}?',
      confirmText: 'Eliminate',
      cancelText: 'Cancel',
      confirmColor: Colors.red,
      icon: Icons.how_to_vote,
      onConfirm: () {
        HapticService().heavy();
        
        // Check if the player being eliminated is Mr. White
        bool isMrWhite = player.role == PlayerRole.mrWhite;
        
        // Eliminate the player
        gameProvider.eliminatePlayer(player.id);
        
        // If Mr. White was eliminated, give them a chance to guess
        if (isMrWhite) {
          Future.delayed(const Duration(milliseconds: 300), () {
            _showMrWhiteGuess(context, gameProvider);
          });
        }
      },
    );
  }

  void _showMrWhiteGuess(BuildContext context, GameProvider gameProvider) {
    final TextEditingController controller = TextEditingController();
    
    showDialog(
      context: context,
      barrierDismissible: false, // Can't dismiss without guessing
      builder: (context) => AlertDialog(
        title: const Text('Mr. White Has Been Eliminated!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Mr. White gets one chance to guess the civilian word. If correct, Mr. White wins!',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Guess the word',
                border: OutlineInputBorder(),
                hintText: 'Enter your guess...',
              ),
              autofocus: true,
              textCapitalization: TextCapitalization.words,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              String guess = controller.text.trim();
              if (guess.isEmpty) {
                // Show error if no guess entered
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter a guess!'),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              }
              Navigator.pop(context);
              gameProvider.mrWhiteGuess(guess);
            },
            child: const Text('Submit Guess'),
          ),
        ],
      ),
    );
  }

  void _showGameInfo(BuildContext context, GameProvider gameProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Information'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Round: ${gameProvider.roundNumber}'),
              const SizedBox(height: 8),
              Text('Total Players: ${gameProvider.totalPlayers}'),
              Text('Alive: ${gameProvider.alivePlayers}'),
              const SizedBox(height: 8),
              Text('Civilians: ${gameProvider.civilianCount}'),
              Text('Spies: ${gameProvider.spyCount}'),
              if (gameProvider.includeMrWhite)
                Text('Mr. White: ${gameProvider.hasMrWhite ? 'Alive' : 'Eliminated'}'),
              const SizedBox(height: 16),
              const Text(
                'Tips:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text('• Tap eye icon to view your word\n'
                  '• Tap vote icon to eliminate a player\n'
                  '• Discuss and deduce who has which role\n'
                  '• Mr. White can only guess when eliminated'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _confirmEndGame(BuildContext context, GameProvider gameProvider) {
    AnimatedConfirmDialog.show(
      context: context,
      title: 'End Game',
      content: 'Are you sure you want to end the current game?',
      confirmText: 'End Game',
      cancelText: 'Cancel',
      confirmColor: Colors.red,
      icon: Icons.exit_to_app,
      onConfirm: () {
        HapticService().heavy();
        gameProvider.resetGame();
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomeScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 300),
          ),
          (route) => false,
        );
      },
    );
  }

  Widget _buildGameOverScreen(BuildContext context, GameProvider gameProvider) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.shade300,
              Colors.deepPurple.shade700,
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
                  const Icon(
                    Icons.emoji_events,
                    size: 100,
                    color: Colors.amber,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'GAME OVER',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Text(
                            gameProvider.winner ?? 'Game ended',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Final Roles:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ...gameProvider.players.map((player) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${player.name}:'),
                                    Row(
                                      children: [
                                        Text(
                                          player.roleDisplay,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: _getRoleColor(player.role),
                                          ),
                                        ),
                                        if (player.word != null) ...[
                                          const SizedBox(width: 8),
                                          Text(
                                            '(${player.word})',
                                            style: const TextStyle(
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      gameProvider.resetGame();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 16,
                      ),
                    ),
                    child: const Text(
                      'Back to Home',
                      style: TextStyle(fontSize: 18),
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
