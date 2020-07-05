import 'package:flutter/material.dart';
import 'package:hcl_better_health/constants.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController _controller = new TextEditingController();

  final String label;
  final IconData prefixIcon;
  final bool obscureText;
  final Function onChanged;
  final TextInputType keyboardType;
  final String text;

  // TODO add reveal obscured text option

  CustomInputField({
    @required this.label,
    @required this.prefixIcon,
    @required this.onChanged,
    this.obscureText,
    this.keyboardType,
    this.text,
  }) {
    _controller.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      obscureText: obscureText,
      onChanged: onChanged,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(kPaddingM),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.12),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.12),
          ),
        ),
        hintText: label,
        hintStyle: TextStyle(
          color: kBlack.withOpacity(0.5),
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: kBlack.withOpacity(0.5),
        ),
      ),
    );
  }
}
