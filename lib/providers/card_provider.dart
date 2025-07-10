import 'package:card_learn_languages/models/learning_card.dart';
import 'package:card_learn_languages/models/save_cards.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class CardProvider extends ChangeNotifier {
  final Box<SaveCards> _box = Hive.box<SaveCards>(
    'save_cards',
  ); // создаем саму коробку из модели Hive и даем ей имя

  List<LearningCard> _cards = []; // сам наш список карточек
  List<LearningCard> get cards => List.unmodifiable(
    _cards,
  ); // геттер, который возвращает неизменямую копиб списка _cards

  final List<SaveCards> _trashed =
      []; // это список для удаленных карточек (это для возможности восстановления)

  // я не понимаю что это
  // а, все, я понял, это конструктор для того
  // чтобы подгрузить карточки сразу при создании экземпляра
  CardProvider() {
    _loadCards();
  }

  // это сам метод для загрузки карт из Hive на экран
  void _loadCards() {
    // здесь мы просто мапим все карточки
    // из Hive и заносим все значения в LearningCard
    // (Ну как я понял это так SaveCards -> LearningCard),
    // а это все заносим в наш список из LearningCard _cards
    // (ааа, ну теперь все сходится)
    // но потом почему-то делаем .toList(), я просто не понимаю что это
    // ну и notifyListeners(), это для того, чтобы уведомить Provider о новом состоянии
    _cards = _box.values
        .map(
          (s) => LearningCard(
            id: s.id,
            word: s.word,
            reading: s.reading,
            translation: s.translation,
            imagePath: s.imagePath,
            article: s.article,
            flag: s.flag,
            //? это две проверки на null, потому что в Hive указано
            //? final int? ... Ну и короче, тут если мы указали цвет при создании карточки,
            //? то мы ставим цвет, который указали, а если нет, то null
            articlecolor: s.articleColor != null
                ? Color(s.articleColor!)
                : null,
            cardBackgroundColor: s.cardBackgroundColor != null
                ? Color(s.cardBackgroundColor!)
                : null,
          ),
        )
        .toList(); // короче, я прочитал что это такое
    // это метод, который превращает ленивый Iterable<LearningCard>
    // список в обычный List<LearningCard>, чтобы с ним можно было работать как с обычным
    // потому что .map() возвращает ленивый
    notifyListeners();
  }

  // это метод для добавления именно в Hive из экрана
  void addCard(LearningCard card) {
    _cards.add(card); // тут добаляется наша карточка в наш список
    _box.add(
      // а тут все сохраняется именно в Hive

      // тут есть ?, походу потому что в Hive
      // у карточки может не быть цвета, потому что это не required поле
      SaveCards(
        id: card.id,
        word: card.word,
        reading: card.reading,
        translation: card.translation,
        imagePath: card.imagePath,
        article: card.article,
        flag: card.flag,
        articleColor: card.articlecolor?.toARGB32(),
        cardBackgroundColor: card.cardBackgroundColor?.toARGB32(),
      ),
    );
    notifyListeners();
  }

  // это метод для я как понял когда я именно изменяю карточку
  // (у меня есть для этого экран)
  // короче, этот метод обновляет элемент по индексу в коробке putAt
  void updatedCard(int index, LearningCard card) {
    _cards[index] = card;
    _box.putAt(
      index,
      SaveCards(
        id: card.id,
        word: card.word,
        reading: card.reading,
        translation: card.translation,
        imagePath: card.imagePath,
        article: card.article,
        flag: card.flag,
        // тут есть ?, походу потому что в Hive
        // у карточки может не быть цвета, потому что это не required поле
        articleColor: card.articlecolor?.toARGB32(),
        cardBackgroundColor: card.cardBackgroundColor?.toARGB32(),
      ),
    );
    notifyListeners();
  }

  // ну это для удаления (удаляется по индексу)
  void deleteCard(int index) {
    _cards.removeAt(index);
    _box.deleteAt(index);
    notifyListeners();
  }

  // это для удаления именно всех карточек
  void deleteAll() {
    _trashed.clear();
    _trashed.addAll(_box.values);
    _cards.clear();
    _box.clear();
    notifyListeners();
  }

  // это для восстановления всех карточек
  // я просто сначала не понял почему мы добавляем все в LearningCard,
  // но сразу понял, это потому-что нужно именно отобразить карточки,
  // то есть LearningCard для карточек на экране, а SaveCards для карточек в Hive
  void restoreAll() {
    for (var s in _trashed) {
      _box.add(s);
      _cards.add(
        LearningCard(
          id: s.id,
          word: s.word,
          reading: s.reading,
          translation: s.translation,
          imagePath: s.imagePath,
          article: s.article,
          flag: s.flag,
          //? это две проверки на null, потому что в Hive указано
          //? final int? ... Ну и короче, тут если мы указали цвет при создании карточки,
          //? то мы ставим цвет, который указали, а если нет, то null
          articlecolor: s.articleColor != null ? Color(s.articleColor!) : null,
          cardBackgroundColor: s.cardBackgroundColor != null
              ? Color(s.cardBackgroundColor!)
              : null,
        ),
      );
    }
    _trashed.clear();
    notifyListeners();
  }

  LearningCard? getCardById(String id) {
    try {
      return _cards.firstWhere((card) => card.id == id);
    } catch (e) {
      return null;
    }
  }
}
