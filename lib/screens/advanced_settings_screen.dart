import 'package:flutter/material.dart';
import '../models/game_config.dart';

class AdvancedSettingsScreen extends StatefulWidget {
  final GameConfig initialConfig;

  const AdvancedSettingsScreen({
    super.key,
    required this.initialConfig,
  });

  @override
  State<AdvancedSettingsScreen> createState() => _AdvancedSettingsScreenState();
}

class _AdvancedSettingsScreenState extends State<AdvancedSettingsScreen>
    with SingleTickerProviderStateMixin {
  late GameConfig _config;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _config = widget.initialConfig;
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Settings'),
        centerTitle: true,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          padding: EdgeInsets.zero,
          indicatorPadding: EdgeInsets.zero,
          labelPadding: const EdgeInsets.symmetric(horizontal: 12.0),
          tabs: const [
            Tab(icon: Icon(Icons.category), text: 'Categories'),
            Tab(icon: Icon(Icons.people_alt), text: 'Role Variants'),
            Tab(icon: Icon(Icons.auto_awesome), text: 'Modifiers'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCategoriesTab(),
          _buildRoleVariantsTab(),
          _buildModifiersTab(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, _config);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                  child: const Text(
                    'APPLY',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesTab() {
    return Container(
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
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
        children: [
          // Randomize toggle
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: SwitchListTile(
              value: _config.randomizeCategories,
              onChanged: (value) {
                setState(() {
                  _config = _config.copyWith(randomizeCategories: value);
                  if (value) {
                    _config = _config.copyWith(
                      selectedCategories: {WordCategory.all},
                    );
                  }
                });
              },
              title: const Text(
                'Randomize All',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                'Use words from all categories randomly',
              ),
              secondary: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.shuffle, color: Colors.purple),
              ),
            ),
          ),
          const SizedBox(height: 16),

          if (!_config.randomizeCategories) ...[
            const Padding(
              padding: EdgeInsets.only(left: 4.0, top: 8.0, bottom: 8.0),
              child: Text(
                'Select Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            ...WordCategory.values
                .where((cat) => cat != WordCategory.all)
                .map((category) => _buildCategoryTile(category)),
          ],
        ],
      ),
    );
  }

  Widget _buildCategoryTile(WordCategory category) {
    final isSelected = _config.selectedCategories.contains(category);
    return Card(
      elevation: isSelected ? 4 : 1,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected
              ? Theme.of(context).primaryColor
              : Colors.transparent,
          width: 2,
        ),
      ),
      child: CheckboxListTile(
        value: isSelected,
        onChanged: (value) {
          setState(() {
            final newCategories = Set<WordCategory>.from(_config.selectedCategories);
            if (value == true) {
              newCategories.add(category);
            } else {
              newCategories.remove(category);
            }
            // Ensure at least one category is selected
            if (newCategories.isEmpty) {
              newCategories.add(category);
            }
            _config = _config.copyWith(selectedCategories: newCategories);
          });
        },
        title: Text(
          category.displayName,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        secondary: Icon(
          _getCategoryIcon(category),
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
        ),
      ),
    );
  }

  IconData _getCategoryIcon(WordCategory category) {
    // Return appropriate icons for categories
    if (category.displayName.contains('Food') ||
        category.displayName.contains('Beverage') ||
        category.displayName.contains('Sweet')) {
      return Icons.restaurant;
    } else if (category.displayName.contains('Animal') ||
        category.displayName.contains('Pet') ||
        category.displayName.contains('Bird')) {
      return Icons.pets;
    } else if (category.displayName.contains('Transport') ||
        category.displayName.contains('Vehicle')) {
      return Icons.directions_car;
    } else if (category.displayName.contains('Sport') ||
        category.displayName.contains('Entertainment')) {
      return Icons.sports_esports;
    } else if (category.displayName.contains('Nature') ||
        category.displayName.contains('Flower')) {
      return Icons.nature;
    } else if (category.displayName.contains('Tech') ||
        category.displayName.contains('Computer') ||
        category.displayName.contains('Phone')) {
      return Icons.computer;
    }
    return Icons.label;
  }

  Widget _buildRoleVariantsTab() {
    return Container(
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
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
        children: [
          const Card(
            color: Colors.orange,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.white),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Coming Soon! Role variants will be available in v1.3.0',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ...RoleVariant.values.map((variant) {
            final isEnabled = _config.enabledRoleVariants.contains(variant);
            return Opacity(
              opacity: 0.5, // Disabled appearance
              child: Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SwitchListTile(
                  value: isEnabled,
                  onChanged: null, // Disabled for now
                  title: Text(
                    variant.displayName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(variant.description),
                  secondary: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getRoleVariantIcon(variant),
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  IconData _getRoleVariantIcon(RoleVariant variant) {
    switch (variant) {
      case RoleVariant.detective:
        return Icons.search;
      case RoleVariant.jester:
        return Icons.sentiment_very_satisfied;
      case RoleVariant.guardian:
        return Icons.shield;
    }
  }

  Widget _buildModifiersTab() {
    return Container(
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
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
        children: [
          const Card(
            color: Colors.orange,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.white),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Coming Soon! Special modifiers will be available in v1.3.0',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ...SpecialModifier.values.map((modifier) {
            final isEnabled = _config.enabledModifiers.contains(modifier);
            return Opacity(
              opacity: 0.5, // Disabled appearance
              child: Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SwitchListTile(
                  value: isEnabled,
                  onChanged: null, // Disabled for now
                  title: Text(
                    modifier.displayName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(modifier.description),
                  secondary: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getModifierIcon(modifier),
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  IconData _getModifierIcon(SpecialModifier modifier) {
    switch (modifier) {
      case SpecialModifier.oneTimeReveal:
        return Icons.visibility;
      case SpecialModifier.playerSwap:
        return Icons.swap_horiz;
      case SpecialModifier.wordHint:
        return Icons.lightbulb;
      case SpecialModifier.doubleElimination:
        return Icons.close;
      case SpecialModifier.silentRound:
        return Icons.volume_off;
    }
  }
}
