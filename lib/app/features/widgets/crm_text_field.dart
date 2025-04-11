import 'package:crm_flutter/app/config/themes/resources/color_resources.dart';
import 'package:crm_flutter/app/features/widgets/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? title;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final Widget? suffixIcon;

  const CrmTextField({
    super.key,
    this.controller,
    required this.title,
    this.validator,
    this.hintText,
    this.obscureText = false, // Default value set
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {

    control ss = Get.put(control());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: TextStyle(
            fontSize: 16,
            color: COLORRes.TEXT_SECONDARY,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          obscureText: obscureText,
          controller: controller,
          onChanged: ss._filterSuggestions,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15),
            focusedBorder: tile(Get.theme.colorScheme.primary),
            enabledBorder: tile(Get.theme.colorScheme.outline),
            focusedErrorBorder: tile(Get.theme.colorScheme.error),
            errorBorder: tile(Get.theme.colorScheme.error),
            suffixIcon: suffixIcon,
          ),
        ),
        if (ss._filteredSuggestions.isNotEmpty)
          CrmCard(
            margin: EdgeInsets.only(top: 4),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            child: Column(
              children: ss._filteredSuggestions.map((suggestion) {
                return ListTile(
                  title: Text(suggestion),
                  onTap: () => ss._selectSuggestion(suggestion),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}

InputBorder? tile(Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(14),
    borderSide: BorderSide(color: color, width: 1),
  );
}

class control extends GetxController{


  TextEditingController _controller = TextEditingController();
  List<String> _allSuggestions = ['Apple', 'Banana', 'Mango', 'Orange', 'Grapes'];
  List<String> _filteredSuggestions = [];

  void _filterSuggestions(String input) {
      _filteredSuggestions = _allSuggestions
          .where((item) => item.toLowerCase().contains(input.toLowerCase()))
          .toList();
  }

  void _selectSuggestion(String suggestion) {
  _controller.text = suggestion;
  _filteredSuggestions.clear();
  }

}