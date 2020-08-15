import 'package:flutter/material.dart';
import 'package:hcl_better_health/constants.dart';

class CustomInputField extends StatefulWidget {
  final String label;
  final IconData prefixIcon;
  final bool obscureText;
  final Function onChanged;
  final TextInputType keyboardType;
  final String text;

  final TextEditingController _controller = new TextEditingController();

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
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget._controller,
      obscureText: widget.obscureText,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: kPaddingM),
        labelText: widget.label,
        hintText: widget.label,
        hintStyle: TextStyle(
          color: kBlack.withOpacity(0.25),
          fontWeight: FontWeight.w500,
        ),
        suffixIcon: Icon(
          widget.prefixIcon,
          color: kBlack.withOpacity(0.25),
        ),
      ),
    );
  }
}
