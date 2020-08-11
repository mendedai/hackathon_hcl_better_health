import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hcl_better_health/constants.dart';

class AppBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NotchedBottomNavBar(
      color: Colors.black45,
      backgroundColor: Colors.white.withOpacity(0.9),
      elevation: 5,
      items: [
        BottomNavBarItem(
          iconData: Icons.home,
        ),
        BottomNavBarItem(
          iconData: Icons.graphic_eq,
        ),
        BottomNavBarItem(
          iconData: Icons.bubble_chart,
        ),
        BottomNavBarItem(
          iconData: Icons.more_vert,
        ),
      ],
      notchedShape: CircularNotchedRectangle(),
    );
  }
}

class BottomNavBarItem {
  BottomNavBarItem({
    this.iconData,
    this.text,
  });
  IconData iconData;
  String text;
}

class NotchedBottomNavBar extends StatefulWidget {
  NotchedBottomNavBar({
    this.items,
    this.centerItemText,
    this.height: 60.0,
    this.iconSize: 26.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    this.notchMargin: 12.0,
    this.onTabSelected,
    this.elevation: 2.0,
  }) {
    assert(this.items.length == 0 ||
        this.items.length == 2 ||
        this.items.length == 4);
  }

  final List<BottomNavBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final double notchMargin;
  final ValueChanged<int> onTabSelected;
  final double elevation;

  @override
  _NotchedBottomNavBarState createState() => _NotchedBottomNavBarState();
}

class _NotchedBottomNavBarState extends State<NotchedBottomNavBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });

    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      elevation: widget.elevation,
      shape: widget.notchedShape,
      notchMargin: widget.notchMargin,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconSize),
            Text(
              widget.centerItemText ?? '',
              style: TextStyle(color: widget.color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    BottomNavBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkResponse(
            onTap: () => onPressed(index),
            highlightShape: BoxShape.circle,
            radius: 25.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  item.iconData,
                  color: color,
                  size: widget.iconSize,
                ),
                item.text != null
                    ? Text(
                        item.text,
                        style: TextStyle(color: color),
                      )
                    : SizedBox(height: 0, width: 0)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
