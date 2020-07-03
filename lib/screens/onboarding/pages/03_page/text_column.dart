import 'package:flutter/material.dart';
import 'package:hcl_better_health/components/text_column.dart';

class ThirdPageTextColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextColumn(
      title: 'The third thing',
      text: 'Some description about the third thing'
    );
  }
}