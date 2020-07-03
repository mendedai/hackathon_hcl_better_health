import 'package:flutter/material.dart';
import 'package:hcl_better_health/components/text_column.dart';

class SecondPageTextColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextColumn(
      title: 'The second thing',
      text: 'Some description about the second thing'
    );
  }
}