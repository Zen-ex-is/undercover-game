import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../models/game_config.dart';
import 'player_names_screen.dart';
import 'advanced_settings_screen.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  int _numPlayers = 6;
  int _numSpies = 1;
  bool _includeMrWhite = true;
  GameConfig _gameConfig = GameConfig();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Setup'),
        centerTitle: true,
        elevation: 0,
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
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Number of Players
                _buildSettingCard(
                  title: 'Number of Players',
                  icon: Icons.people,
                  color: Colors.blue,
                  child: Column(
                    children: [
                      Slider(
                        value: _numPlayers.toDouble(),
                        min: 4,
                        max: 12,
                        divisions: 8,
                        label: _numPlayers.toString(),
                        onChanged: (value) {
                          setState(() {
                            _numPlayers = value.toInt();
                            // Adjust spies if needed
                            int maxSpies = (_numPlayers / 3).floor();
                            if (_numSpies > maxSpies) {
                              _numSpies = maxSpies;
                            }
                          });
                        },
                      ),
                      Text(
                        '$_numPlayers Players',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Number of Spies
                _buildSettingCard(
                  title: 'Number of Spies',
                  icon: Icons.visibility_off,
                  color: Colors.red,
                  child: Column(
                    children: [
                      Slider(
                        value: _numSpies.toDouble(),
                        min: 1,
                        max: (_numPlayers / 3).floor().toDouble(),
                        divisions: (_numPlayers / 3).floor() > 1 ? (_numPlayers / 3).floor() - 1 : null,
                        label: _numSpies.toString(),
                        onChanged: (value) {
                          setState(() {
                            _numSpies = value.toInt();
                          });
                        },
                      ),
                      Text(
                        '$_numSpies ${_numSpies == 1 ? 'Spy' : 'Spies'}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Include Mr. White
                _buildSettingCard(
                  title: 'Include Mr. White',
                  icon: Icons.help_outline,
                  color: Colors.orange,
                  child: SwitchListTile(
                    value: _includeMrWhite,
                    onChanged: (value) {
                      setState(() {
                        _includeMrWhite = value;
                      });
                    },
                    title: Text(
                      _includeMrWhite ? 'Yes' : 'No',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      _includeMrWhite
                          ? 'One player will be Mr. White (no word)'
                          : 'Game will only have Civilians and Spies',
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Role Distribution Summary
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Role Distribution',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildRoleCount(
                          'Civilians',
                          _numPlayers - _numSpies - (_includeMrWhite ? 1 : 0),
                          Colors.blue,
                        ),
                        _buildRoleCount('Spies', _numSpies, Colors.red),
                        if (_includeMrWhite)
                          _buildRoleCount('Mr. White', 1, Colors.orange),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Advanced Settings Button
                ElevatedButton.icon(
                  onPressed: _openAdvancedSettings,
                  icon: const Icon(Icons.settings),
                  label: const Text(
                    'ADVANCED SETTINGS',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    backgroundColor: Colors.white,
                    foregroundColor: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 12),

                // Settings Summary
                if (!_gameConfig.randomizeCategories)
                  Card(
                    elevation: 2,
                    color: Colors.blue.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.info_outline, size: 16),
                              SizedBox(width: 8),
                              Text(
                                'Active Settings',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '• ${_gameConfig.selectedCategories.length} categor${_gameConfig.selectedCategories.length == 1 ? 'y' : 'ies'} selected',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 16),

                // Start Game Button
                ElevatedButton(
                  onPressed: _startGame,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                  child: const Text(
                    'START GAME',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingCard({
    required String title,
    required IconData icon,
    required Color color,
    required Widget child,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCount(String role, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                role,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          Text(
            '$count',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openAdvancedSettings() async {
    // Update config with current basic settings
    final currentConfig = _gameConfig.copyWith(
      numPlayers: _numPlayers,
      numSpies: _numSpies,
      includeMrWhite: _includeMrWhite,
    );

    final result = await Navigator.push<GameConfig>(
      context,
      MaterialPageRoute(
        builder: (context) => AdvancedSettingsScreen(
          initialConfig: currentConfig,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _gameConfig = result;
        // Update basic settings from config
        _numPlayers = result.numPlayers;
        _numSpies = result.numSpies;
        _includeMrWhite = result.includeMrWhite;
      });
    }
  }

  void _startGame() {
    final gameProvider = Provider.of<GameProvider>(context, listen: false);
    
    // Update config with final values
    _gameConfig = _gameConfig.copyWith(
      numPlayers: _numPlayers,
      numSpies: _numSpies,
      includeMrWhite: _includeMrWhite,
    );
    
    // Save game configuration to provider
    gameProvider.setGameConfiguration(_gameConfig);
    
    // Navigate to player names screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const PlayerNamesScreen(),
      ),
    );
  }
}
