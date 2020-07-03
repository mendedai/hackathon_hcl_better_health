import 'package:flutter/material.dart';
import 'package:hcl_better_health/constants.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String text;
  final Widget image; // TODO make this an icon
  final VoidCallback onPressed;

  CustomButton({
    @required this.color,
    @required this.textColor,
    @required this.text,
    @required this.onPressed,
    this.image,
  });

  Widget _getFlatButton(context) {
    return FlatButton(
      color: color,
      padding: const EdgeInsets.all(kPaddingM),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .subtitle1
            .copyWith(color: textColor, fontWeight: FontWeight.bold),
      ),
      onPressed: onPressed,
    );
  }

  Widget _getOutlineButton(context) {
    return OutlineButton(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: kPaddingL),
            child: image,
          ),
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(color: textColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: double.infinity,
      ),
      child:
          image != null ? _getOutlineButton(context) : _getFlatButton(context),
    );
  }
}
