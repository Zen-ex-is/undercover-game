import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../services/player_names_service.dart';
import '../services/haptic_service.dart';
import 'role_selection_screen.dart';

class PlayerNamesScreen extends StatefulWidget {
  const PlayerNamesScreen({super.key});

  @override
  State<PlayerNamesScreen> createState() => _PlayerNamesScreenState();
}

class _PlayerNamesScreenState extends State<PlayerNamesScreen> {
  final PlayerNamesService _namesService = PlayerNamesService();
  final HapticService _hapticService = HapticService();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _newNameController = TextEditingController();

  List<String> _savedNames = [];
  List<String> _filteredNames = [];
  Set<String> _selectedNames = {};
  List<TextEditingController> _manualControllers = [];
  bool _isLoading = true;
  bool _showSavedPlayers = false;

  @override
  void initState() {
    super.initState();
    _loadSavedNames();
    _initializeManualControllers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _newNameController.dispose();
    for (var controller in _manualControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _initializeManualControllers() {
    final gameProvider = Provider.of<GameProvider>(context, listen: false);
    _manualControllers = List.generate(
      gameProvider.numPlayers,
      (index) => TextEditingController(),
    );
  }

  Future<void> _loadSavedNames() async {
    try {
      final names = await _namesService.getSavedPlayerNames();
      if (mounted) {
        setState(() {
          _savedNames = names;
          _filteredNames = names;
          _isLoading = false;
          _showSavedPlayers = names.isNotEmpty;
        });
      }
    } catch (e) {
      // If shared_preferences fails, just start with empty list
      debugPrint('Error loading saved names: $e');
      if (mounted) {
        setState(() {
          _savedNames = [];
          _filteredNames = [];
          _isLoading = false;
          _showSavedPlayers = false;
        });
      }
    }
  }

  void _filterNames(String query) {
    setState(() {
      _filteredNames = _namesService.filterPlayerNames(_savedNames, query);
    });
  }

  void _toggleNameSelection(String name) {
    _hapticService.light();
    final gameProvider = Provider.of<GameProvider>(context, listen: false);
    
    setState(() {
      if (_selectedNames.contains(name)) {
        _selectedNames.remove(name);
      } else {
        if (_selectedNames.length < gameProvider.numPlayers) {
          _selectedNames.add(name);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Maximum ${gameProvider.numPlayers} players can be selected'),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    });
  }

  void _addNewPlayer() {
    final name = _newNameController.text.trim();
    if (name.isEmpty) return;

    _hapticService.light();
    final gameProvider = Provider.of<GameProvider>(context, listen: false);

    if (_selectedNames.length >= gameProvider.numPlayers) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Maximum ${gameProvider.numPlayers} players already selected'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      if (!_savedNames.contains(name)) {
        _savedNames.add(name);
        _filteredNames = _savedNames;
      }
      _selectedNames.add(name);
      _newNameController.clear();
    });
  }

  void _proceedWithSelectedNames() {
    final gameProvider = Provider.of<GameProvider>(context, listen: false);
    
    if (_selectedNames.length != gameProvider.numPlayers) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please select exactly ${gameProvider.numPlayers} players '
            '(${_selectedNames.length} selected)',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    _hapticService.medium();
    
    // Save names to local storage (don't block on this)
    _namesService.savePlayerNames(_selectedNames.toList()).catchError((e) {
      debugPrint('Error saving player names: $e');
    });
    
    // Update game provider with player names
    gameProvider.setPlayerNames(_selectedNames.toList());
    
    // Navigate to role selection
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const RoleSelectionScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  void _proceedWithManualNames() {
    final gameProvider = Provider.of<GameProvider>(context, listen: false);
    final names = _manualControllers
        .map((controller) => controller.text.trim())
        .where((name) => name.isNotEmpty)
        .toList();

    if (names.length != gameProvider.numPlayers) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter exactly ${gameProvider.numPlayers} player names',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    // Check for duplicates
    if (names.toSet().length != names.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Player names must be unique'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    _hapticService.medium();
    
    // Save names to local storage (don't block on this)
    _namesService.savePlayerNames(names).catchError((e) {
      debugPrint('Error saving player names: $e');
    });
    
    // Update game provider with player names
    gameProvider.setPlayerNames(names);
    
    // Navigate to role selection
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const RoleSelectionScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A237E), Color(0xFF4A148C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            _hapticService.light();
                            Navigator.of(context).pop();
                          },
                        ),
                        const Expanded(
                          child: Text(
                            'Add Players',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(width: 48), // Balance back button
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Select ${gameProvider.numPlayers} players',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Progress indicator
                    LinearProgressIndicator(
                      value: _selectedNames.length / gameProvider.numPlayers,
                      backgroundColor: Colors.white24,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${_selectedNames.length} / ${gameProvider.numPlayers} selected',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              // Mode toggle
              if (_savedNames.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _hapticService.light();
                            setState(() => _showSavedPlayers = true);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _showSavedPlayers
                                ? Colors.deepPurple
                                : Colors.white24,
                          ),
                          child: const Text('Saved Players'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _hapticService.light();
                            setState(() => _showSavedPlayers = false);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: !_showSavedPlayers
                                ? Colors.deepPurple
                                : Colors.white24,
                          ),
                          child: const Text('Enter Manually'),
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 20),

              // Content area
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _showSavedPlayers
                        ? _buildSavedPlayersView(gameProvider)
                        : _buildManualEntryView(gameProvider),
              ),

              // Bottom button
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: _showSavedPlayers
                      ? (_selectedNames.length == gameProvider.numPlayers
                          ? _proceedWithSelectedNames
                          : null)
                      : _proceedWithManualNames,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Continue to Role Selection'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSavedPlayersView(GameProvider gameProvider) {
    return Column(
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: _searchController,
            onChanged: _filterNames,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search players...',
              hintStyle: const TextStyle(color: Colors.white54),
              prefixIcon: const Icon(Icons.search, color: Colors.white54),
              filled: true,
              fillColor: Colors.white12,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // Add new player
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _newNameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Add new player...',
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSubmitted: (_) => _addNewPlayer(),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.add_circle, color: Colors.greenAccent),
                iconSize: 40,
                onPressed: _addNewPlayer,
              ),
            ],
          ),
        ),

        // Player list
        Expanded(
          child: _filteredNames.isEmpty
              ? const Center(
                  child: Text(
                    'No saved players.\nAdd new players above.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white54, fontSize: 16),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _filteredNames.length,
                  itemBuilder: (context, index) {
                    final name = _filteredNames[index];
                    final isSelected = _selectedNames.contains(name);
                    
                    return Card(
                      color: isSelected ? Colors.deepPurple : Colors.white12,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: Icon(
                          isSelected ? Icons.check_circle : Icons.circle_outlined,
                          color: isSelected ? Colors.greenAccent : Colors.white54,
                        ),
                        title: Text(
                          name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () async {
                            _hapticService.light();
                            await _namesService.removePlayerName(name);
                            setState(() {
                              _savedNames.remove(name);
                              _filteredNames.remove(name);
                              _selectedNames.remove(name);
                            });
                          },
                        ),
                        onTap: () => _toggleNameSelection(name),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildManualEntryView(GameProvider gameProvider) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: gameProvider.numPlayers,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: TextField(
            controller: _manualControllers[index],
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Player ${index + 1}',
              labelStyle: const TextStyle(color: Colors.white70),
              hintText: 'Enter name...',
              hintStyle: const TextStyle(color: Colors.white54),
              filled: true,
              fillColor: Colors.white12,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(Icons.person, color: Colors.white54),
            ),
          ),
        );
      },
    );
  }
}
