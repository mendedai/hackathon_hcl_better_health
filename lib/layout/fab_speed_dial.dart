import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:hcl_better_health/constants.dart';

// Built for bottomleft aligned FABs
class FabSpeedDial extends StatefulWidget {
  final Widget body;
  final List<FabSpeedDialItem> items;
  final double blur;
  FabSpeedDial({
    @required this.body,
    @required this.items,
    this.blur: 5.0,
  }) {
    assert(this.items.length > 0);
  }

  @override
  _FabSpeedDialState createState() => _FabSpeedDialState();
}

class _FabSpeedDialState extends State<FabSpeedDial>
    with TickerProviderStateMixin {
  bool _isOpen = false;
  Duration _duration = Duration(milliseconds: 500);
  AnimationController _iconAnimationCtrl;
  Animation<double> _iconAnimationTween;

  // used to position the FAB
  double rightOffset = 20.0;
  double bottomOffset = 20.0;

  @override
  void initState() {
    super.initState();
    _iconAnimationCtrl = AnimationController(
      vsync: this,
      duration: _duration,
    );
    _iconAnimationTween = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_iconAnimationCtrl);
  }

  void _toggleOpen() {
    setState(() {
      _isOpen = !_isOpen;
    });
    if (_isOpen) {
      _iconAnimationCtrl.forward();
    } else {
      _iconAnimationCtrl.reverse();
    }
  }

  Future<bool> _preventPopIfOpen() async {
    if (_isOpen) {
      _toggleOpen();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Stack(
        children: <Widget>[
          widget.body,
          _isOpen ? _buildBlurWidget() : Container(),
          _isOpen ? _buildMenuItemList() : Container(),
          _buildMenuButton(context),
        ],
      ),
      onWillPop: _preventPopIfOpen,
    );
  }

  Widget _buildMenuItemList() {
    return Positioned(
      bottom: bottomOffset + 60,
      right: rightOffset + 5,
      child: ScaleTransition(
        scale: AnimationController(
          vsync: this,
          value: 0.7,
          duration: _duration,
        )..forward(),
        child: SizeTransition(
          axis: Axis.horizontal,
          sizeFactor: AnimationController(
            vsync: this,
            value: 0.5,
            duration: _duration,
          )..forward(),
          child: FadeTransition(
            opacity: AnimationController(
              vsync: this,
              value: 0.0,
              duration: _duration,
            )..forward(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: this
                  .widget
                  .items
                  .map<Widget>((item) => _buildMenuItem(item))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(FabSpeedDialItem item) {
    var onTap = () {
      _toggleOpen();
      item.onPressed();
    };
    return InkWell(
      onTap: onTap,
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 3,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Text(item.label),
          ),
          FloatingActionButton(
            elevation: 0,
            onPressed: onTap,
            mini: true,
            child: item.icon,
          ),
        ],
      ),
    );
  }

  Widget _buildBlurWidget() {
    return InkWell(
      onTap: _toggleOpen,
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(
          sigmaX: this.widget.blur,
          sigmaY: this.widget.blur,
        ),
        child: Container(
          color: Colors.black12,
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context) {
    return Positioned(
      bottom: bottomOffset,
      right: rightOffset,
      child: FloatingActionButton(
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _iconAnimationTween,
        ),
        backgroundColor: kColorMainNavButton,
        onPressed: _toggleOpen,
      ),
    );
  }
}

class FabSpeedDialItem {
  String label;
  Icon icon;
  Function onPressed;
  FabSpeedDialItem({
    @required this.label,
    @required this.onPressed,
    @required this.icon,
  });
}
