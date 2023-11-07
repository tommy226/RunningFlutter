import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_first/constant/color.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String initialValue;

  // true - 시간 , false - 내용
  final bool isTime;
  final FormFieldSetter<String> onSaved;

  const CustomTextField(
      {super.key,
      required this.label,
      required this.isTime,
      required this.onSaved, required this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w600, color: PRIMARY_COLOR),
        ),
        if (isTime) renderTextField(),
        if (!isTime)
          Expanded(
            child: renderTextField(),
          )
      ],
    );
  }

  Widget renderTextField() {
    return TextFormField(
      onSaved: onSaved,
      validator: (String? val) {
        if (val == null || val.isEmpty) {
          return "값을 입력해주세요";
        }

        if (isTime) {
          int time = int.parse(val);
          if (time < 0) {
            return "0 이상의 숫자를 입력해주세요";
          }
          if (time > 24) {
            return "24 이하의 숫자를 입력해주세요";
          }
        } else {
          if (val.length > 500) {
            return "500자 이하로 입력해주세요";
          }
        }

        return null;
      },
      initialValue: initialValue,
      cursorColor: Colors.grey,
      maxLines: isTime ? 1 : null,
      expands: !isTime,
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
      inputFormatters: isTime ? [FilteringTextInputFormatter.digitsOnly] : [],
      decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[300],
          suffixText: isTime ? "시" : null),
    );
  }
}
