import 'dart:io';

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
  late final TextEditingController articleController;
  late final TextEditingController wordController;
  late final TextEditingController readingController;
  late final TextEditingController translationController;

  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  String? _selectedFlag;
  late Color _selectedArticleColor;
  late Color _selectedCardBackgroundColor;

  Color? _tmpSelectedArticleColor;
  Color? _tmpSelectedCardBackgroundColor;

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

  Future<void> _pickImage() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );

    if (picked != null) {
      setState(() {
        _pickedImage = File(picked.path);
      });
    }
  }

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
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Отмена', style: TextStyle(fontFamily: 'wdxl')),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                setState(() {
                  _selectedArticleColor = tempColor;
                });
                Navigator.pop(context);
              },
              child: Text('Сохранить', style: TextStyle(fontFamily: 'wdxl')),
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
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Отмена', style: TextStyle(fontFamily: 'wdxl')),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                setState(() {
                  _selectedCardBackgroundColor = tempColor;
                });
                Navigator.pop(context);
              },
              child: Text('Сохранить', style: TextStyle(fontFamily: 'wdxl')),
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
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Отмена',
                        style: TextStyle(fontFamily: 'wdxl'),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
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
                      child: Text(
                        'Выбрать',
                        style: TextStyle(fontFamily: 'wdxl'),
                      ),
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
    final prefs = context.read<SaveCardColorsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
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
                _buildCustomRow(
                  'Выберите изображение для карточки',
                  _pickImage,
                  Icons.folder_copy,
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
                _buildCustomRow('Убрать картинку у карточки', () {
                  setState(() {
                    _pickedImage = null;
                  });
                }, Icons.remove_circle),
                const SizedBox(height: 20),

                // ? ---------------------------- Цвет карточки ----------------------------
                _buildCustomRow(
                  'Выберите цвет для карточки',
                  _selectCardBackgroundColor,
                  Icons.palette,
                ),
                const SizedBox(height: 20),

                // ? ---------------------------- Цвет артикля ----------------------------
                _buildCustomRow(
                  'Выберите цвет для артикля',
                  _selectArticleColor,
                  Icons.abc,
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
                          label: Text(
                            'Артикль',
                            style: TextStyle(fontFamily: 'wdxl'),
                          ),
                          hint: Text(
                            // '(｡♥‿♥｡)',
                            'Введите артикль',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
                _buildCustomTextField(wordController, 'Слово', 'Введите слово'),
                const SizedBox(height: 10),
                _buildCustomTextField(
                  readingController,
                  'Чтение',
                  'Введите чтение',
                ),
                const SizedBox(height: 10),
                _buildCustomTextField(
                  translationController,
                  'Перевод',
                  'Введите перевод',
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

  Widget _buildCustomTextField(
    TextEditingController controller,
    String label,
    String hint,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text(label, style: TextStyle(fontFamily: 'wdxl')),
        hint: Text(hint, style: TextStyle(fontFamily: 'wdxl')),
      ),
    );
  }

  Widget _buildCustomRow(
    String text,
    void Function()? onPressed,
    IconData icon,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: TextStyle(fontSize: 20, fontFamily: 'wdxl')),

        IconButton(onPressed: onPressed, icon: Icon(icon)),
      ],
    );
  }
}
