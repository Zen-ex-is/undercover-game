import 'game_config.dart';

class WordPair {
  final String civilianWord;
  final String spyWord;
  final String category;

  WordPair({
    required this.civilianWord,
    required this.spyWord,
    required this.category,
  });
}

class WordDatabase {
  static final List<WordPair> wordPairs = [
    // Food & Drinks
    WordPair(civilianWord: 'Coffee', spyWord: 'Tea', category: 'Beverages'),
    WordPair(civilianWord: 'Pizza', spyWord: 'Burger', category: 'Fast Food'),
    WordPair(civilianWord: 'Apple', spyWord: 'Orange', category: 'Fruits'),
    WordPair(civilianWord: 'Rice', spyWord: 'Noodles', category: 'Carbs'),
    WordPair(civilianWord: 'Chocolate', spyWord: 'Candy', category: 'Sweets'),
    
    // Animals
    WordPair(civilianWord: 'Cat', spyWord: 'Dog', category: 'Pets'),
    WordPair(civilianWord: 'Lion', spyWord: 'Tiger', category: 'Big Cats'),
    WordPair(civilianWord: 'Eagle', spyWord: 'Hawk', category: 'Birds'),
    WordPair(civilianWord: 'Dolphin', spyWord: 'Shark', category: 'Sea Animals'),
    WordPair(civilianWord: 'Butterfly', spyWord: 'Moth', category: 'Insects'),
    
    // Transportation
    WordPair(civilianWord: 'Car', spyWord: 'Motorcycle', category: 'Vehicles'),
    WordPair(civilianWord: 'Train', spyWord: 'Bus', category: 'Public Transport'),
    WordPair(civilianWord: 'Airplane', spyWord: 'Helicopter', category: 'Aircraft'),
    WordPair(civilianWord: 'Bicycle', spyWord: 'Scooter', category: 'Two-wheelers'),
    
    // Entertainment
    WordPair(civilianWord: 'Movie', spyWord: 'TV Show', category: 'Entertainment'),
    WordPair(civilianWord: 'Book', spyWord: 'Magazine', category: 'Reading'),
    WordPair(civilianWord: 'Guitar', spyWord: 'Piano', category: 'Instruments'),
    WordPair(civilianWord: 'Soccer', spyWord: 'Basketball', category: 'Sports'),
    WordPair(civilianWord: 'Dance', spyWord: 'Sing', category: 'Performance'),
    
    // Nature
    WordPair(civilianWord: 'Sun', spyWord: 'Moon', category: 'Celestial'),
    WordPair(civilianWord: 'Mountain', spyWord: 'Hill', category: 'Landforms'),
    WordPair(civilianWord: 'Ocean', spyWord: 'Lake', category: 'Water Bodies'),
    WordPair(civilianWord: 'Rose', spyWord: 'Tulip', category: 'Flowers'),
    WordPair(civilianWord: 'Summer', spyWord: 'Winter', category: 'Seasons'),
    
    // Technology
    WordPair(civilianWord: 'Laptop', spyWord: 'Desktop', category: 'Computers'),
    WordPair(civilianWord: 'iPhone', spyWord: 'Android', category: 'Phones'),
    WordPair(civilianWord: 'Email', spyWord: 'Text Message', category: 'Communication'),
    WordPair(civilianWord: 'Facebook', spyWord: 'Twitter', category: 'Social Media'),
    
    // Places
    WordPair(civilianWord: 'Beach', spyWord: 'Pool', category: 'Swimming'),
    WordPair(civilianWord: 'Restaurant', spyWord: 'Café', category: 'Dining'),
    WordPair(civilianWord: 'Library', spyWord: 'Bookstore', category: 'Books'),
    WordPair(civilianWord: 'Hospital', spyWord: 'Clinic', category: 'Healthcare'),
    
    // Objects
    WordPair(civilianWord: 'Pen', spyWord: 'Pencil', category: 'Writing'),
    WordPair(civilianWord: 'Spoon', spyWord: 'Fork', category: 'Utensils'),
    WordPair(civilianWord: 'Chair', spyWord: 'Sofa', category: 'Furniture'),
    WordPair(civilianWord: 'Shirt', spyWord: 'T-shirt', category: 'Clothing'),
    WordPair(civilianWord: 'Watch', spyWord: 'Clock', category: 'Time'),
    
    // Actions
    WordPair(civilianWord: 'Run', spyWord: 'Walk', category: 'Movement'),
    WordPair(civilianWord: 'Laugh', spyWord: 'Smile', category: 'Expressions'),
    WordPair(civilianWord: 'Sleep', spyWord: 'Nap', category: 'Rest'),
    WordPair(civilianWord: 'Cook', spyWord: 'Bake', category: 'Kitchen'),
  ];

  static WordPair getRandomWordPair() {
    wordPairs.shuffle();
    return wordPairs.first;
  }

  static WordPair getRandomWordPairByCategories(Set<WordCategory> categories) {
    if (categories.isEmpty || categories.contains(WordCategory.all)) {
      return getRandomWordPair();
    }

    // Map WordCategory enum to category strings
    final categoryStrings = categories.map((cat) => _mapCategoryToString(cat)).toSet();
    
    // Filter word pairs by selected categories
    final filtered = wordPairs.where((pair) {
      return categoryStrings.contains(pair.category);
    }).toList();

    if (filtered.isEmpty) {
      // Fallback to all pairs if no matches
      return getRandomWordPair();
    }

    filtered.shuffle();
    return filtered.first;
  }

  static String _mapCategoryToString(WordCategory category) {
    switch (category) {
      case WordCategory.all:
        return '';
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
