import 'dart:io';

import 'package:card_learn_languages/providers/app_theme.dart';
import 'package:card_learn_languages/models/learning_card.dart';
// import 'package:card_learn_languages/widgets/custom_drop_down_color_menu.dart';
import 'package:card_learn_languages/widgets/custom_drop_down_flag_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateEditCardScreen extends StatefulWidget {
  final LearningCard? card;
  final String? initialFlag;
  final Color? initialColor;
  const CreateEditCardScreen({
    super.key,
    this.card,
    this.initialFlag,
    this.initialColor,
  });

  @override
  State<CreateEditCardScreen> createState() => _CreateEditCardScreenState();
}

class _CreateEditCardScreenState extends State<CreateEditCardScreen> {
  // это текстовые контроллеры для ловки пользовательского ввода
  // но я не понимаю почему они late
  late final TextEditingController articleController;
  late final TextEditingController wordController;
  late final TextEditingController readingController;
  late final TextEditingController translationController;
  // late final String? flag;
  // late final Color? articleColor;
  // late final Color? cardBackgroundColor;

  // ---------------------- Image ----------------------
  //
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  // это переменные для начальных значений для некоторых элементов
  //! но нужно это исправить, потому-что даже при редактировании
  //! у меня все равно показываются начальные значения
  String? _selectedFlag;
  late Color _selectedArticleColor;
  late Color _selectedCardBackgroundColor;

  // ну вот тут как-раз таки инициализация late переменных и мы в них ставим наш артикль, слово или чтение
  // я так понял что это late потому что этот экран работает как create и edit,
  @override
  void initState() {
    super.initState();
    articleController = TextEditingController(text: widget.card?.article ?? '');
    wordController = TextEditingController(text: widget.card?.word ?? '');
    readingController = TextEditingController(text: widget.card?.reading ?? '');
    translationController = TextEditingController(
      text: widget.card?.translation ?? '',
    );
    if (widget.card?.imagePath != null) {
      _pickedImage = File(widget.card!.imagePath!);
    }
    _selectedFlag = widget.card?.flag ?? '';
    _selectedArticleColor = widget.card?.articlecolor ?? Colors.red;
    _selectedCardBackgroundColor =
        widget.card?.cardBackgroundColor ?? Colors.blue;
  }

  // это для выбора картинки для карточки
  //! тут мы создаем какой-то XFile и после у переменной File? _pickedImage
  //! вызываем метод pickImage, но я не понимаю прикол maxWidth, minHeight, imageQuality
  Future<void> _pickImage() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );

    //! тут проверка, я так понял со всеми переменными с ? в async методе
    // нужно делать такую проверку
    // ну и после, мы просто присваиваем путь выбранной картинки к _pickedImage
    if (picked != null) {
      setState(() {
        _pickedImage = File(picked.path);
      });
    }
  }

  //! я не понимаю для чего это нужно
  @override
  void dispose() {
    super.dispose();
    articleController.dispose();
    wordController.dispose();
    readingController.dispose();
    translationController.dispose();
  }

  void _selectArticleColor() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Color tempColor = _selectedArticleColor;
        return AlertDialog(
          title: const Text('Выберите цвет артикля'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: tempColor,
              onColorChanged: (Color color) => setState(() {
                tempColor = color;
              }),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedArticleColor = tempColor;
                });
                Navigator.pop(context);
              },
              child: const Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }

  void _selectCardBackgroundColor() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Color tempColor = _selectedCardBackgroundColor;
        return AlertDialog(
          title: const Text('Выберите цвет карточки'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: tempColor,
              onColorChanged: (Color color) => setState(() {
                tempColor = color;
              }),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedCardBackgroundColor = tempColor;
                });
                Navigator.pop(context);
              },
              child: const Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.watch<AppTheme>();
    //! я не понимаю, это опять начальные значения?
    Color _initialArticleColor = Colors.red;
    Color _initialCardColor = Colors.blue;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          // просто я так понял что при создании же карточка пустая и она
          // по факту равна null и из-за этого тут такая гениальная проверка
          widget.card == null ? 'Новая карточка' : 'Редактирование',
          style: TextStyle(fontFamily: 'wdxl'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // ? ---------------------------- Изображение карточки ----------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Выберите изображение для карточки',
                  style: TextStyle(fontSize: 20, fontFamily: 'wdxl'),
                ),

                IconButton(
                  onPressed: _pickImage,
                  icon: Icon(Icons.folder_copy),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // ? ---------------------------- Показ картинки после выбора ----------------------------
            if (_pickedImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  _pickedImage!,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 10),

            // ? ---------------------------- Цвет карточки ----------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Выберите цвет для карточки',
                  style: TextStyle(fontSize: 20, fontFamily: 'wdxl'),
                ),

                IconButton(
                  onPressed: _selectCardBackgroundColor,
                  icon: Icon(Icons.palette),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // ? ---------------------------- Цвет артикля ----------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Выберите цвет для артикля',
                  style: TextStyle(fontSize: 20, fontFamily: 'wdxl'),
                ),

                IconButton(
                  onPressed: _selectArticleColor,
                  icon: Icon(Icons.abc),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // ? ---------------------------- Ввод артикля ----------------------------
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: articleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      // labelText: 'Артикль',
                      label: Text(
                        'Артикль',
                        style: TextStyle(fontFamily: 'wdxl'),
                      ),
                      // hintText: '(｡♥‿♥｡)',
                      hint: Text(
                        '(｡♥‿♥｡)',
                        style: TextStyle(fontFamily: 'wdxl'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: CustomDropDownFlagMenu(
                    initialFlag: _selectedFlag,
                    onChanged: (flag) => setState(() {
                      _selectedFlag = flag;
                    }),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: wordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Слово', style: TextStyle(fontFamily: 'wdxl')),
                // labelText: 'Слово',
                hint: Text(
                  'Ня~ введите словечко, пожалуйста! (=^-ω-^=)',
                  style: TextStyle(fontFamily: 'wdxl'),
                ),
                // hintText: 'Ня~ введите.. словечко, пожалуйста!',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: readingController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                // labelText: 'Чтение',
                label: Text('Чтение', style: TextStyle(fontFamily: 'wdxl')),
                hint: Text(
                  'Пожалуйста, введите чтенице~ (｡♥‿♥｡)',
                  style: TextStyle(fontFamily: 'wdxl'),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: translationController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                // labelText: 'Перевод',
                label: Text('Перевод', style: TextStyle(fontFamily: 'wdxl')),
                hint: Text(
                  'Переводик, пожалуйста~ (づ｡◕‿‿◕｡)づ',
                  style: TextStyle(fontFamily: 'wdxl'),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: currentTheme.isDark
                      ? Colors.deepPurple
                      : Colors.indigoAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  final newCard = LearningCard(
                    imagePath: _pickedImage?.path,
                    article: articleController.text,
                    flag: _selectedFlag,
                    articlecolor: _selectedArticleColor,
                    cardBackgroundColor: _selectedCardBackgroundColor,
                    word: wordController.text,
                    reading: readingController.text,
                    translation: translationController.text,
                  );
                  Navigator.pop(context, newCard);
                },
                child: Text(
                  widget.card == null ? 'Создать' : 'Сохранить',
                  style: TextStyle(fontFamily: 'wdxl'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
