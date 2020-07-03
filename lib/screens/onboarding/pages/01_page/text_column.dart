import 'package:flutter/material.dart';
import 'package:hcl_better_health/components/text_column.dart';

class FirstPageTextColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextColumn(
      title: 'The first thing',
      text: 'Some description about the first thing'
    );
  }
}