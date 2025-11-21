/// Game Configuration Models
/// Defines all possible game settings, variants, and modifiers

enum WordCategory {
  all,
  beverages,
  fastFood,
  fruits,
  carbs,
  sweets,
  pets,
  bigCats,
  birds,
  seaAnimals,
  insects,
  vehicles,
  publicTransport,
  aircraft,
  twoWheelers,
  entertainment,
  reading,
  instruments,
  sports,
  performance,
  celestial,
  landforms,
  waterBodies,
  flowers,
  seasons,
  computers,
  phones,
  communication,
  socialMedia,
  swimming,
  dining,
  books,
  healthcare,
  writing,
  utensils,
  furniture,
  clothing,
  time,
  movement,
  expressions,
  rest,
  kitchen,
}

enum RoleVariant {
  detective,      // Can investigate one player per round
  jester,         // Wants to be eliminated (wins if eliminated)
  guardian,       // Can protect one player from elimination
}

enum SpecialModifier {
  oneTimeReveal,  // One player can see another's word
  playerSwap,     // Swap roles mid-game
  wordHint,       // Get a hint about the words
  doubleElimination, // Eliminate two players per round
  silentRound,    // One round where no one can speak
}

class GameConfig {
  // Basic settings
  final int numPlayers;
  final int numSpies;
  final bool includeMrWhite;
  
  // Word settings
  final Set<WordCategory> selectedCategories;
  final bool randomizeCategories;
  
  // Role variants (future feature)
  final Set<RoleVariant> enabledRoleVariants;
  
  // Special modifiers (future feature)
  final Set<SpecialModifier> enabledModifiers;
  
  GameConfig({
    this.numPlayers = 6,
    this.numSpies = 1,
    this.includeMrWhite = true,
    Set<WordCategory>? selectedCategories,
    this.randomizeCategories = true,
    Set<RoleVariant>? enabledRoleVariants,
    Set<SpecialModifier>? enabledModifiers,
  })  : selectedCategories = selectedCategories ?? {WordCategory.all},
        enabledRoleVariants = enabledRoleVariants ?? {},
        enabledModifiers = enabledModifiers ?? {};

  GameConfig copyWith({
    int? numPlayers,
    int? numSpies,
    bool? includeMrWhite,
    Set<WordCategory>? selectedCategories,
    bool? randomizeCategories,
    Set<RoleVariant>? enabledRoleVariants,
    Set<SpecialModifier>? enabledModifiers,
  }) {
    return GameConfig(
      numPlayers: numPlayers ?? this.numPlayers,
      numSpies: numSpies ?? this.numSpies,
      includeMrWhite: includeMrWhite ?? this.includeMrWhite,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      randomizeCategories: randomizeCategories ?? this.randomizeCategories,
      enabledRoleVariants: enabledRoleVariants ?? this.enabledRoleVariants,
      enabledModifiers: enabledModifiers ?? this.enabledModifiers,
    );
  }
}

// Helper extensions for display names
extension WordCategoryExtension on WordCategory {
  String get displayName {
    switch (this) {
      case WordCategory.all:
        return 'All Categories';
      case WordCategory.beverages:
        return 'Beverages';
      case WordCategory.fastFood:
        return 'Fast Food';
      case WordCategory.fruits:
        return 'Fruits';
      case WordCategory.carbs:
        return 'Carbs';
      case WordCategory.sweets:
        return 'Sweets';
      case WordCategory.pets:
        return 'Pets';
      case WordCategory.bigCats:
        return 'Big Cats';
      case WordCategory.birds:
        return 'Birds';
      case WordCategory.seaAnimals:
        return 'Sea Animals';
      case WordCategory.insects:
        return 'Insects';
      case WordCategory.vehicles:
        return 'Vehicles';
      case WordCategory.publicTransport:
        return 'Public Transport';
      case WordCategory.aircraft:
        return 'Aircraft';
      case WordCategory.twoWheelers:
        return 'Two-wheelers';
      case WordCategory.entertainment:
        return 'Entertainment';
      case WordCategory.reading:
        return 'Reading';
      case WordCategory.instruments:
        return 'Instruments';
      case WordCategory.sports:
        return 'Sports';
      case WordCategory.performance:
        return 'Performance';
      case WordCategory.celestial:
        return 'Celestial';
      case WordCategory.landforms:
        return 'Landforms';
      case WordCategory.waterBodies:
        return 'Water Bodies';
      case WordCategory.flowers:
        return 'Flowers';
      case WordCategory.seasons:
        return 'Seasons';
      case WordCategory.computers:
        return 'Computers';
      case WordCategory.phones:
        return 'Phones';
      case WordCategory.communication:
        return 'Communication';
      case WordCategory.socialMedia:
        return 'Social Media';
      case WordCategory.swimming:
        return 'Swimming';
      case WordCategory.dining:
        return 'Dining';
      case WordCategory.books:
        return 'Books';
      case WordCategory.healthcare:
        return 'Healthcare';
      case WordCategory.writing:
        return 'Writing';
      case WordCategory.utensils:
        return 'Utensils';
      case WordCategory.furniture:
        return 'Furniture';
      case WordCategory.clothing:
        return 'Clothing';
      case WordCategory.time:
        return 'Time';
      case WordCategory.movement:
        return 'Movement';
      case WordCategory.expressions:
        return 'Expressions';
      case WordCategory.rest:
        return 'Rest';
      case WordCategory.kitchen:
        return 'Kitchen';
    }
  }
}

extension RoleVariantExtension on RoleVariant {
  String get displayName {
    switch (this) {
      case RoleVariant.detective:
        return 'Detective';
      case RoleVariant.jester:
        return 'Jester';
      case RoleVariant.guardian:
        return 'Guardian';
    }
  }

  String get description {
    switch (this) {
      case RoleVariant.detective:
        return 'Can investigate one player per round';
      case RoleVariant.jester:
        return 'Wins if eliminated';
      case RoleVariant.guardian:
        return 'Can protect one player from elimination';
    }
  }
}

extension SpecialModifierExtension on SpecialModifier {
  String get displayName {
    switch (this) {
      case SpecialModifier.oneTimeReveal:
        return 'One-Time Reveal';
      case SpecialModifier.playerSwap:
        return 'Player Swap';
      case SpecialModifier.wordHint:
        return 'Word Hint';
      case SpecialModifier.doubleElimination:
        return 'Double Elimination';
      case SpecialModifier.silentRound:
        return 'Silent Round';
    }
  }

  String get description {
    switch (this) {
      case SpecialModifier.oneTimeReveal:
        return 'One player can see another\'s word';
      case SpecialModifier.playerSwap:
        return 'Swap roles mid-game';
      case SpecialModifier.wordHint:
        return 'Get a hint about the words';
      case SpecialModifier.doubleElimination:
        return 'Eliminate two players per round';
      case SpecialModifier.silentRound:
        return 'One round where no one can speak';
    }
  }
}
