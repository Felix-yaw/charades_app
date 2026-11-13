import 'dart:math';

import '../models/word_card.dart';

const List<WordCard> allWords = [
  WordCard('Elephant', WordCategory.animals),
  WordCard('Giraffe', WordCategory.animals),
  WordCard('Kangaroo', WordCategory.animals),
  WordCard('Penguin', WordCategory.animals),
  WordCard('Octopus', WordCategory.animals),
  WordCard('Flamingo', WordCategory.animals),
  WordCard('Crocodile', WordCategory.animals),
  WordCard('Monkey', WordCategory.animals),
  WordCard('Snake', WordCategory.animals),
  WordCard('Butterfly', WordCategory.animals),
  WordCard('Tiger', WordCategory.animals),
  WordCard('Dolphin', WordCategory.animals),
  WordCard('Chicken', WordCategory.animals),
  WordCard('Bear', WordCategory.animals),
  WordCard('Rabbit', WordCategory.animals),
  WordCard('Spider', WordCategory.animals),
  WordCard('Horse', WordCategory.animals),
  WordCard('Seal', WordCategory.animals),
  WordCard('Titanic', WordCategory.movies),
  WordCard('The Lion King', WordCategory.movies),
  WordCard('Harry Potter', WordCategory.movies),
  WordCard('Jurassic Park', WordCategory.movies),
  WordCard('Toy Story', WordCategory.movies),
  WordCard('Spider-Man', WordCategory.movies),
  WordCard('Frozen', WordCategory.movies),
  WordCard('The Matrix', WordCategory.movies),
  WordCard('Finding Nemo', WordCategory.movies),
  WordCard('Star Wars', WordCategory.movies),
  WordCard('Jaws', WordCategory.movies),
  WordCard('Shrek', WordCategory.movies),
  WordCard('Avatar', WordCategory.movies),
  WordCard('Rocky', WordCategory.movies),
  WordCard('E.T.', WordCategory.movies),
  WordCard('The Godfather', WordCategory.movies),
  WordCard('Ghostbusters', WordCategory.movies),
  WordCard('The Wizard of Oz', WordCategory.movies),
  WordCard('Brushing teeth', WordCategory.actions),
  WordCard('Riding a bike', WordCategory.actions),
  WordCard('Swimming', WordCategory.actions),
  WordCard('Dancing', WordCategory.actions),
  WordCard('Cooking', WordCategory.actions),
  WordCard('Flying a kite', WordCategory.actions),
  WordCard('Taking a selfie', WordCategory.actions),
  WordCard('Playing guitar', WordCategory.actions),
  WordCard('Washing dishes', WordCategory.actions),
  WordCard('Shooting a basketball', WordCategory.actions),
  WordCard('Reading a book', WordCategory.actions),
  WordCard('Fishing', WordCategory.actions),
  WordCard('Driving a car', WordCategory.actions),
  WordCard('Rock climbing', WordCategory.actions),
  WordCard('Ice skating', WordCategory.actions),
  WordCard('Mowing the lawn', WordCategory.actions),
  WordCard('Blowing bubbles', WordCategory.actions),
  WordCard('Jumping rope', WordCategory.actions),
  WordCard('Pizza', WordCategory.food),
  WordCard('Hamburger', WordCategory.food),
  WordCard('Ice cream', WordCategory.food),
  WordCard('Banana', WordCategory.food),
  WordCard('Watermelon', WordCategory.food),
  WordCard('Spaghetti', WordCategory.food),
  WordCard('Popcorn', WordCategory.food),
  WordCard('Coffee', WordCategory.food),
  WordCard('Donut', WordCategory.food),
  WordCard('Apple', WordCategory.food),
  WordCard('Sushi', WordCategory.food),
  WordCard('Pancakes', WordCategory.food),
  WordCard('French fries', WordCategory.food),
  WordCard('Birthday cake', WordCategory.food),
  WordCard('Orange juice', WordCategory.food),
  WordCard('Tacos', WordCategory.food),
  WordCard('Chocolate', WordCategory.food),
  WordCard('Hot dog', WordCategory.food),
];

class WordRepository {
  WordRepository({List<WordCard>? words}) : words = words ?? allWords;

  final List<WordCard> words;

  List<WordCard> dailyDeck(DateTime date, {int count = 5}) {
    final int seed = date.year * 10000 + date.month * 100 + date.day;
    final List<WordCard> source = [...words]..shuffle(Random(seed));
    return source.take(count).toList(growable: false);
  }

  List<WordCard> shuffledDeck(
    WordCategory category, {
    List<WordCard> customWords = const [],
  }) {
    final List<WordCard> source;
    switch (category) {
      case WordCategory.all:
        source = [...words, ...customWords];
      case WordCategory.custom:
        source = [...customWords];
      default:
        source = words
            .where((wordCard) => wordCard.category == category)
            .toList(growable: false);
    }
    return [...source]..shuffle();
  }
}
