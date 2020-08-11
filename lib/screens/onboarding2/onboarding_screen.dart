import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hcl_better_health/constants.dart';
import 'package:hcl_better_health/screens/onboarding2/gradient_button.dart';
import 'package:hcl_better_health/theme/fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'login_registration.dart';

class OnboardingScreen extends StatefulWidget {
  static final String route = 'onboarding';
  final double screenHeight;

  OnboardingScreen({this.screenHeight});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PanelController _controller = PanelController();

  void _onPageChanged(int page, bool done) {
    print('pageChanged $page ... $done');
    if (done) {
      Timer(Duration(seconds: 1), () {
        _controller.animatePanelToPosition(1.0);
      });
    }
  }

  Widget getPanelBar() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          width: 30,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double panelBorderRadius = 40;

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SlidingUpPanel(
          backdropEnabled: true,
          parallaxEnabled: true,
          minHeight: 180,
          maxHeight: 600,
          controller: _controller,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(panelBorderRadius),
            topRight: Radius.circular(panelBorderRadius),
          ),
          collapsed: Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(panelBorderRadius),
                topRight: Radius.circular(panelBorderRadius),
              ),
            ),
            child: Center(
              child: GradientButton(
                text: 'Get started',
                onPressed: () {
                  _controller.open();
                },
              ),
            ),
          ),
          panel: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: LoginRegistration(),
                  ),
                ]),
          ),
          body: OnboardingContent(
            onPageChanged: _onPageChanged,
          ),
        ),
      ),
    );
  }
}

class OnboardingContent extends StatefulWidget {
  final Function onPageChanged;

  OnboardingContent({this.onPageChanged});

  @override
  _OnboardingContentState createState() => _OnboardingContentState();
}

class _OnboardingContentState extends State<OnboardingContent> {
  final int _numOfPages = 4;
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  final List<Widget> _pages = [
    OnboardingContentPage(
      imageUrl: 'assets/images/onboarding0.png',
      title: 'Experience custom\ntreatment plans',
      description:
          'Everyone\'s pain is different. That\'s why at Mended, your treatment will be custom made for you and no one else.',
    ),
    OnboardingContentPage(
      imageUrl: 'assets/images/onboarding1.png',
      title: 'Discover more about\nyour condition',
      description:
          'Healing isn\'t just about what you do -- it\'s also about what you know. With Mended we make learning about injury easy.',
    ),
    OnboardingContentPage(
      imageUrl: 'assets/images/onboarding2.png',
      title: 'Gain insights on your\npath to recovery',
      description:
          'The path to recovery is long and can sometimes feel like its going nowhere. Mended shows you how far you\'ve come and where you\'ll be.',
    ),
    Padding(
      padding: const EdgeInsets.all(80.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1.0,
                  child: Opacity(
                    opacity: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              kPurple3.withOpacity(0),
                              kPurple5.withOpacity(0),
                              kPurple3,
                              kPurple5,
                              kPurple3.withOpacity(0),
                              kPurple5.withOpacity(0),
                            ],
                            stops: [
                              0,
                              0.2,
                              0.2,
                              0.80,
                              0.80,
                              1
                            ]),
                      ),
                      child: Center(
                        child: Text(
                          'M',
                          textAlign: TextAlign.center,
                          style: TextStyles.title.bold.copyWith(
                            color: Colors.white70,
                            fontSize: 130,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text('MENDED',
              style: TextStyles.title.bold.copyWith(
                color: Colors.white,
                fontSize: 30,
              )),
        ],
      ),
    )
  ];

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_currentPage < _numOfPages - 1) {
        _currentPage++;

        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      } else {
        timer.cancel();
      }
    });
  }

  void _onPageChanged(BuildContext context, int page) {
    setState(() {
      _currentPage = page;
    });
    if (widget.onPageChanged != null) {
      bool done = page == _numOfPages - 1;
      widget.onPageChanged(page, done);
    }
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (var i = 0; i < _numOfPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white70,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: [0.1, 0.4, 0.7, 0.9],
          colors: [
            kPurple1,
            kPurple2,
            kPurple3,
            kPurple4,
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 550,
              child: PageView(
                physics: ClampingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (page) {
                  _onPageChanged(context, page);
                },
                children: _pages,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingContentPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const OnboardingContentPage({
    @required this.title,
    @required this.description,
    @required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image(
              image: AssetImage(
                imageUrl,
              ),
              height: 300,
              width: 300,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            title,
            style: TextStyles.sectionTitle.bold.copyWith(
              color: Colors.white,
            ),
          ),
          SizedBox(height: 15),
          Text(
            description,
            style: TextStyles.bodyLg.copyWith(color: Colors.white),
          )
        ],
      ),
    );
  }
}
