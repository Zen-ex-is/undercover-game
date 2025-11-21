import 'package:shared_preferences/shared_preferences.dart';

class PlayerNamesService {
  static const String _savedPlayersKey = 'saved_player_names';

  /// Save a list of player names to local storage
  Future<void> savePlayerNames(List<String> names) async {
    final prefs = await SharedPreferences.getInstance();
    final existingNames = await getSavedPlayerNames();
    
    // Merge new names with existing ones (no duplicates)
    final allNames = {...existingNames, ...names}.toList();
    await prefs.setStringList(_savedPlayersKey, allNames);
  }

  /// Get all saved player names
  Future<List<String>> getSavedPlayerNames() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_savedPlayersKey) ?? [];
  }

  /// Remove a player name from saved list
  Future<void> removePlayerName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    final names = await getSavedPlayerNames();
    names.remove(name);
    await prefs.setStringList(_savedPlayersKey, names);
  }

  /// Clear all saved player names
  Future<void> clearAllPlayerNames() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_savedPlayersKey);
  }

  /// Search/filter player names
  List<String> filterPlayerNames(List<String> names, String query) {
    if (query.isEmpty) return names;
    final lowerQuery = query.toLowerCase();
    return names
        .where((name) => name.toLowerCase().contains(lowerQuery))
        .toList();
  }
}
