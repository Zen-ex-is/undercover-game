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
}
