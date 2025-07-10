import 'dart:io';

import 'package:card_learn_languages/providers/app_theme.dart';
import 'package:card_learn_languages/models/learning_card.dart';
import 'package:card_learn_languages/providers/save_card_colors_provider.dart';
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

  //! это для сохранения выбранных цветов
  // late Color _tmpArticleColor;
  // late Color _tmpCardBackgroundColor;

  //! для подсветки выбранных цветов
  Color? _tmpSelectedArticleColor;
  Color? _tmpSelectedCardBackgroundColor;

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
    _tmpSelectedArticleColor = _selectedArticleColor;
    _tmpSelectedCardBackgroundColor = _selectedCardBackgroundColor;
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
          title: const Text(
            'Выберите цвет артикля',
            style: TextStyle(fontFamily: 'wdxl'),
          ),
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
          title: const Text(
            'Выберите цвет карточки',
            style: TextStyle(fontFamily: 'wdxl'),
          ),
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

  void _showSelectedColors() {
    final prefs = context.read<SaveCardColorsProvider>();
    _tmpSelectedArticleColor = _selectedArticleColor;
    _tmpSelectedCardBackgroundColor = _selectedCardBackgroundColor;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (
                BuildContext context,
                void Function(void Function()) setModalState,
              ) {
                return AlertDialog(
                  title: const Text(
                    'Ваши сохраненные ранее цвета',
                    style: TextStyle(fontFamily: 'wdxl'),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Нажмите на цвет, чтобы выбрать фон карточки:',
                        style: TextStyle(fontFamily: 'wdxl', fontSize: 19),
                      ),
                      const SizedBox(height: 8),

                      Wrap(
                        spacing: 8,
                        children: prefs.cardBackgroundColors.map((c) {
                          final isSelected =
                              _tmpSelectedCardBackgroundColor == c;
                          return InkWell(
                            // onTap: () => setState(() {
                            //   _tmpSelectedCardBackgroundColor = c;
                            // }),
                            onTap: () => setModalState(() {
                              _tmpSelectedCardBackgroundColor = c;
                            }),
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: c,
                                shape: BoxShape.circle,
                                // border: Border.all(
                                //   color: _tmpCardBackgroundColor == c
                                //       ? Colors.black
                                //       : Colors.grey,
                                //   width: _tmpCardBackgroundColor == c ? 2 : 1,
                                // ),
                                // border: isSelected
                                //     ? Border.all(
                                //         color:
                                //             Theme.of(context).brightness ==
                                //                 Brightness.dark
                                //             ? Colors.white
                                //             : Colors.black,
                                //         width: 3,
                                //       )
                                //     : null,
                                border: isSelected
                                    ? Border.all(
                                        color: _getBorderColor(c, context),
                                        width: 3,
                                      )
                                    : null,
                              ),
                              // child: isSelected
                              //     ? Icon(
                              //         Icons.check,
                              //         color: Colors.white,
                              //         size: 10,
                              //       )
                              //     : null,
                              child: isSelected
                                  ? Icon(
                                      Icons.check,
                                      color: _getBorderColor(c, context),
                                      size: 10,
                                    )
                                  : null,
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        'Нажмите на цвет, чтобы выбрать цвет артикля: ',
                        style: TextStyle(fontFamily: 'wdxl', fontSize: 19),
                      ),
                      const SizedBox(height: 8),

                      Wrap(
                        spacing: 8,
                        children: prefs.articleColors.map((c) {
                          final bool isSelected = _tmpSelectedArticleColor == c;
                          return InkWell(
                            onTap: () => setModalState(() {
                              _tmpSelectedArticleColor = c;
                            }),
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: c,
                                shape: BoxShape.circle,
                                // border: isSelected
                                //     ? Border.all(
                                //         color:
                                //             Theme.of(context).brightness ==
                                //                 Brightness.dark
                                //             ? Colors.white
                                //             : Colors.black,
                                //         width: 3,
                                //       )
                                //     : null,
                                border: isSelected
                                    ? Border.all(
                                        color: _getBorderColor(c, context),
                                        width: 3,
                                      )
                                    : null,
                              ),
                              child: isSelected
                                  ? Icon(
                                      Icons.check,
                                      color: _getBorderColor(c, context),
                                      size: 10,
                                    )
                                  : null,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
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
                          _selectedArticleColor =
                              _tmpSelectedArticleColor ?? _selectedArticleColor;
                          _selectedCardBackgroundColor =
                              _tmpSelectedCardBackgroundColor ??
                              _selectedCardBackgroundColor;
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('Выбрать'),
                    ),
                  ],
                );
              },
        );
      },
    );
  }

  Color _getBorderColor(Color bgColor, BuildContext context) {
    if (bgColor.computeLuminance() > 0.85) {
      return Colors.black;
    }

    if (bgColor.computeLuminance() < 0.15) {
      return Colors.white;
    }

    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? Colors.white : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    // для сохранения цветов в Hive
    final prefs = context.read<SaveCardColorsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          // просто я так понял что при создании же карточка пустая и она
          // по факту равна null и из-за этого тут такая гениальная проверка
          widget.card == null ? 'Новая карточка' : 'Редактирование',
          style: TextStyle(fontFamily: 'wdxl'),
        ),
      ),
      body: ListView(
        children: [
          Padding(
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
                const SizedBox(height: 20),
                // ? ---------------------------- Показ картинки после выбора ----------------------------
                if (_pickedImage != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      _pickedImage!,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                // ? ---------------------------- Убрать картинку карточки ----------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Убрать картинку у карточки',
                      style: TextStyle(fontSize: 20, fontFamily: 'wdxl'),
                    ),

                    IconButton(
                      onPressed: () => setState(() {
                        _pickedImage = null;
                      }),
                      icon: Icon(Icons.remove_circle),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

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

                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                          ? Colors.teal
                          : Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: _showSelectedColors,
                    child: Text(
                      'Показать выбранные цвета',
                      style: TextStyle(fontFamily: 'wdxl'),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                          ? Colors.teal
                          : Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      if (_tmpSelectedArticleColor != null) {
                        prefs.addArtileColor(_tmpSelectedArticleColor!);
                      }
                      if (_tmpSelectedCardBackgroundColor != null) {
                        prefs.addCardBackgroundColor(
                          _tmpSelectedCardBackgroundColor!,
                        );
                      }
                    },
                    child: Text(
                      'Сохранить выбранные цвета',
                      style: TextStyle(fontFamily: 'wdxl'),
                    ),
                  ),
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
                    label: Text(
                      'Перевод',
                      style: TextStyle(fontFamily: 'wdxl'),
                    ),
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
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                          ? Colors.deepPurple
                          : Colors.indigoAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      final newCard = LearningCard(
                        id:
                            widget.card?.id ??
                            DateTime.now().millisecondsSinceEpoch.toString(),
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
        ],
      ),
    );
  }
}
