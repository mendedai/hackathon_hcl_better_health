import 'package:flutter/material.dart';
import 'package:hcl_better_health/components/botton_nav_bar.dart';
import 'package:hcl_better_health/constants.dart';
import 'package:hcl_better_health/layout/body_fab.dart';
import 'package:hcl_better_health/theme/fonts.dart';

class FeedScreen extends StatelessWidget {
  static final String route = 'discover_feed';
  final List mockdata = [
    {
      'title': 'Namaste the Pain Away: 15 Yoga Poses for Back Pain',
      'color': Colors.deepPurple,
      'image': 'https://images.unsplash.com/photo-1549890762-0a3f8933bc76',
    },
    {
      'title':
          '7 Strength-Building Exercises That May Help Relieve Your Lower Back Pain',
      'color': Colors.deepOrange,
      'image': 'https://images.unsplash.com/photo-1534367507873-d2d7e24c797f',
    },
    {
      'title': '4 Natural Remedies For Pain Relief',
      'color': Colors.blue,
      'image': 'https://images.unsplash.com/photo-1518241353330-0f7941c2d9b5',
    },
    {
      'title': 'Waking up without backpain',
      'color': Colors.red,
      'image': 'https://images.unsplash.com/photo-1506126613408-eca07ce68773',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Discover',
      //     style: TextStyles.pageTitle.copyWith(color: kBlack),
      //   ),
      //   backgroundColor: Colors.white,
      // ),
      backgroundColor: kLightGrey,
      bottomNavigationBar: BottomNavBar(currentRoute: FeedScreen.route),
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: BodyFab(
          currentRoute: FeedScreen.route,
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            children: mockdata.map((article) {
              return _buildTextPost(article);
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildTextPost(article) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Container(
        // padding: EdgeInsets.all(20),
        // width: double.infinity,
        child: Card(
          elevation: 0,
          // color: Colors.black,
          color: article['color'].shade700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.7,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          // make the image grayscale
                          colorFilter: ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                          image: NetworkImage(
                            article['image'],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 100.0, bottom: 20.0, left: 20.0, right: 100.0),
                      child: Text(
                        article['title'],
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.title.bold.copyWith(
                          fontSize: 20,
                          // color: article['color'],
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMediaPost() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25.0)),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              children: <Widget>[
                InkWell(
                  onDoubleTap: () => print('Like post'),
                  child: Container(
                    margin: EdgeInsets.all(15.0),
                    width: double.infinity,
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          offset: Offset(0, 5),
                          blurRadius: 8.0,
                        ),
                      ],
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1518241353330-0f7941c2d9b5'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () {},
                            iconSize: 30.0,
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
