import 'package:flutter/material.dart';
import 'package:hcl_better_health/components/card_stack.dart';

class OnboardingPageManager extends StatelessWidget {
  final int currentPage;
  final Widget lightCardChild;
  final Widget darkCardChild;
  final Widget textColumn;

  OnboardingPageManager({
    @required this.currentPage,
    @required this.lightCardChild,
    @required this.darkCardChild,
    @required this.textColumn,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // TODO animate the transition
        CardStack(
          pageNumber: currentPage,
          darkCardChild: darkCardChild,
          lightCardChild: lightCardChild,
        ),
        SizedBox(
          height: currentPage % 2 == 1 ? 50.0 : 25.0,
        ),
        textColumn,
      ],
    );
  }
}
