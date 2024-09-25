// import 'package:flutter/material.dart';

// class CalenderWidget extends StatefulWidget {
//   CalenderWidget({Key? key}) : super(key: key);

//   @override
//   State<CalenderWidget> createState() => _CalenderWidgetState();
// }

// class _CalenderWidgetState extends State<CalenderWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return class SearchDropdownField extends StatefulWidget {
//   final List<String> items;
//   final String hintText;

//   const SearchDropdownField({Key? key, required this.items, required this.hintText}) : super(key: key);

//   @override
//   _SearchDropdownFieldState createState() => _SearchDropdownFieldState();
// }

// class _SearchDropdownFieldState extends State<SearchDropdownField> {
//   TextEditingController _controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Autocomplete<String>(
//       optionsBuilder: (TextEditingValue textEditingValue) {
//         if (textEditingValue.text == '') {
//           return widget.items;
//         }
//         return widget.items.where((String item) {
//           return item
//               .toLowerCase()
//               .contains(textEditingValue.text.toLowerCase());
//         });
//       },
//       onSelected: (String selection) {
//         _controller.text = selection;
//       },
//       fieldViewBuilder: (BuildContext context,
//           TextEditingController textEditingController,
//           FocusNode focusNode,
//           VoidCallback onFieldSubmitted) {
//         _controller = textEditingController;
//         return TextField(
//           controller: textEditingController,
//           focusNode: focusNode,
//           decoration: InputDecoration(
//             hintText: widget.hintText,
//             hintStyle: FontFamily.caption.copyWith(
//               color: ColorStyle.disableColor,
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(
//                 color:
//                     ColorStyle.disableColor, // Warna stroke ketika tidak fokus
//                 width: 1.5, // Lebar stroke
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide(
//                 color: ColorStyle.primaryColor, // Warna stroke ketika fokus
//                 width: 1.5, // Lebar stroke ketika fokus
//               ),
//             ),
//             suffixIcon: IconButton(
//               // ignore: prefer_const_constructors
//               icon: Icon(Icons.arrow_drop_down, color: ColorStyle.primaryColor),
//               onPressed: () {
//                 focusNode.requestFocus();
//                 if (_controller.text.isEmpty) {
//                   _controller.text = ''; // This triggers the optionsBuilder
//                 }
//               },
//             ),
           
//           ),
//         );
//       },
//     );
//   }
// }
//   }
// }