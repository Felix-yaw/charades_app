enum WordCategory { all, animals, movies, actions, food, custom }

extension WordCategoryLabel on WordCategory {
  String get label => switch (this) {
        WordCategory.all => 'All',
        WordCategory.animals => 'Animals',
        WordCategory.movies => 'Movies',
        WordCategory.actions => 'Actions',
        WordCategory.food => 'Food & Drink',
        WordCategory.custom => 'My Words',
      };
}

class WordCard {
  const WordCard(this.text, this.category);

  final String text;
  final WordCategory category;
}
