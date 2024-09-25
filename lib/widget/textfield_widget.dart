import 'package:anugrah_lens/style/color_style.dart';
import 'package:anugrah_lens/style/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: '',
    decimalDigits: 0,
  );

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Jika input baru kosong, kembalikan nilai kosong
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Hapus semua karakter yang bukan angka
    final newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Format angka menjadi Rupiah dengan pemisah ribuan
    final newFormattedText = _formatter.format(int.parse(newText));

    // Kembalikan nilai yang diformat dengan posisi kursor yang benar
    return newValue.copyWith(
      text: newFormattedText,
      selection: TextSelection.collapsed(offset: newFormattedText.length),
    );
  }
}

class TextFieldWidget extends StatefulWidget {
  final String hintText;
  final double width;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  TextFieldWidget({
    Key? key,
    this.onChanged,
    this.inputFormatters,
    required this.hintText,
    this.width = double.infinity,
    this.controller,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextField(
        onChanged: widget.onChanged,
        controller: widget.controller,
        keyboardType: TextInputType.text,
        inputFormatters: widget.inputFormatters,
        // [
        //   NumberInputFormatter(),
        // ],
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: FontFamily.caption.copyWith(
            color: ColorStyle.disableColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: ColorStyle.disableColor, // Warna stroke ketika tidak fokus
              width: 1.5, // Lebar stroke
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: ColorStyle.primaryColor, // Warna stroke ketika fokus
              width: 1.5, // Lebar stroke ketika fokus
            ),
          ),
        ),
      ),
    );
  }
}

class SearchDropdownFieldHome extends StatefulWidget {
  final List<String> items;
  final String hintText;
  final TextEditingController? controller;
  final Widget? suffixIcons;
  final Widget? prefixIcons;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onSelected;

  const SearchDropdownFieldHome(
      {super.key,
      required this.items,
      required this.hintText,
      this.controller,
      this.onChange,
      this.onSelected,
      this.prefixIcons,
      this.suffixIcons});

  @override
  _SearchDropdownFieldHomeState createState() =>
      _SearchDropdownFieldHomeState();
}

class _SearchDropdownFieldHomeState extends State<SearchDropdownFieldHome> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    // Dispose of the controller if it was created within this widget
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return widget.items;
        }
        return widget.items.where((String item) {
          return item
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      // add optionviewbuilder
      optionsViewBuilder: (BuildContext context, Function(String) onSelected,
          Iterable<String> options) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Material(
              child: Container(
                color: ColorStyle.whiteColors,
                width: 350,
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String option = options.elementAt(index);
                    return Column(
                      children: [
                        ListTile(
                          title: Text(option),
                          onTap: () {
                            onSelected(
                                option); // Call onSelected when an option is tapped
                          },
                        ),
                        if (index <
                            options.length - 1) // Add Divider between items
                          Divider(
                            color: Colors.grey,
                            height: 1,
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
      onSelected: widget.onSelected,
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        // Update the text editing controller if needed
        _controller = textEditingController;
        return TextField(
          onChanged: widget.onChange,
          controller: textEditingController,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: FontFamily.caption.copyWith(
              color: ColorStyle.disableColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color:
                    ColorStyle.disableColor, // Warna stroke ketika tidak fokus
                width: 1.5, // Lebar stroke
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: ColorStyle.primaryColor, // Warna stroke ketika fokus
                width: 1.5, // Lebar stroke ketika fokus
              ),
            ),
            prefixIcon: widget.prefixIcons,
            suffixIcon: widget.suffixIcons,
          ),
        );
      },
    );
  }
}

class TextFieldCalenderWidget extends StatefulWidget {
  final String hintText;
  final double width;
  final TextEditingController? controller;
  TextFieldCalenderWidget({
    Key? key,
    required this.hintText,
    this.width = double.infinity,
    this.controller,
  }) : super(key: key);

  @override
  State<TextFieldCalenderWidget> createState() =>
      _TextFieldCalenderWidgetState();
}

class _TextFieldCalenderWidgetState extends State<TextFieldCalenderWidget> {
  // TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: TextField(
        readOnly: true, // Membuat TextField tidak bisa diubah
        controller: widget
            .controller, // Mengatur controller TextField dengan controller yang diberikan
        // focusNode: focusNode,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: FontFamily.caption.copyWith(
            color: ColorStyle.disableColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: ColorStyle.disableColor, // Warna stroke ketika tidak fokus
              width: 1.5, // Lebar stroke
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: ColorStyle.primaryColor, // Warna stroke ketika fokus
              width: 1.5, // Lebar stroke ketika fokus
            ),
          ),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.calendar_today,
              color: ColorStyle.primaryColor,
            ), // Ikon kalender
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(), // Tanggal awal
                firstDate: DateTime(2000), // Batasan tanggal terawal
                lastDate: DateTime(2101), // Batasan tanggal terakhir
              );

              if (pickedDate != null) {
                //date formatnya 27 februari 2022
                String formattedDate =
                    DateFormat('dd MMMM yyyy').format(pickedDate);
                setState(() {
                  widget.controller!.text = formattedDate;
                });
              }
            },
          ),
        ),
      ),
    );
  }
}

class TextFieldColumnWiget extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const TextFieldColumnWiget({
    super.key,
    this.inputFormatters,
    required this.onChanged,
    required this.hintText,
    this.controller,
  });

  @override
  State<TextFieldColumnWiget> createState() => _TextFieldColumnWigetState();
}

class _TextFieldColumnWigetState extends State<TextFieldColumnWiget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        inputFormatters: widget.inputFormatters,
        controller: widget.controller,
        onChanged: (value) {
          widget.onChanged!(
              value); // Pastikan onChanged tidak menyebabkan controller direset
        },
        decoration: InputDecoration(hintText: widget.hintText),
      ),
    );
  }
}

class SearchDropdownField extends StatefulWidget {
  final List<String> items;
  final String hintText;
  final TextEditingController? controller;
  final Widget? suffixIcons;
  final Widget? prefixIcons;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onSelected;

  const SearchDropdownField({
    Key? key,
    required this.items,
    required this.hintText,
    this.controller,
    this.onChange,
    this.onSelected,
    this.prefixIcons,
    this.suffixIcons,
  }) : super(key: key);

  @override
  _SearchDropdownFieldState createState() => _SearchDropdownFieldState();
}

class _SearchDropdownFieldState extends State<SearchDropdownField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        return widget.items.where((String item) {
          return item
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        _controller.text = selection; // Update text field with selected option
        if (widget.onSelected != null) {
          widget.onSelected!(selection);
        }
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          onChanged: (value) {
            if (widget.onChange != null) {
              widget.onChange!(value);
            }
          },
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: FontFamily.caption.copyWith(
              color: ColorStyle.disableColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color:
                    ColorStyle.disableColor, // Warna stroke ketika tidak fokus
                width: 1.5, // Lebar stroke
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: ColorStyle.primaryColor, // Warna stroke ketika fokus
                width: 1.5, // Lebar stroke ketika fokus
              ),
            ),
            prefixIcon: widget.prefixIcons,
            suffixIcon: widget.suffixIcons,
          ),
        );
      },
      optionsViewBuilder: (BuildContext context, Function(String) onSelected,
          Iterable<String> options) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Material(
              child: Container(
                color: Color.fromARGB(255, 242, 246, 253),
                width: 350,
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String option = options.elementAt(index);
                    return Column(
                      children: [
                        ListTile(
                          title: Text(option),
                          onTap: () {
                            onSelected(
                                option); // Call onSelected when an option is tapped
                          },
                        ),
                        if (index <
                            options.length - 1) // Add Divider between items
                          Divider(
                            color: Colors.grey,
                            height: 1,
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TextFormFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final bool? readOnly; // Tambahkan parameter readOnly
  final double? width;
  final List<TextInputFormatter>? inputFormatters;
  final Color? color; // Tambahkan parameter warna
   final Color? textColor; // Tambahkan parameter warna teks

  const TextFormFieldWidget({
    super.key,
    this.controller,
    this.inputFormatters,
    this.validator,
    this.width,
    this.color,
    this.onTap,
    this.textColor,
    this.readOnly, // Inisialisasi parameter readOnly
  });

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      child: TextFormField(
        inputFormatters: widget.inputFormatters,
        controller: widget.controller,
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: widget.readOnly == true
              ? ColorStyle.disableColor // Warna teks ketika readOnly
              : widget.textColor ??
                  Colors.black, // Gunakan warna teks parameter atau default
        ),
        decoration: InputDecoration(
          labelText: null,
          hintText: null,
          hintStyle: FontFamily.caption.copyWith(
            color: ColorStyle.disableColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: ColorStyle.disableColor, // Warna border ketika tidak fokus
              width: 1.5, // Lebar border ketika tidak fokus
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: widget.color ??
                  ColorStyle
                      .primaryColor, // Gunakan warna parameter atau default
              width: 1.5, // Lebar border ketika fokus
            ),
          ),
        ),
        validator: widget.validator,
        readOnly: widget.readOnly ?? false,
        onTap: widget.onTap,
      ),
    );
  }
}
