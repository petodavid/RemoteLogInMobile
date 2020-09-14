import 'package:RemoteLogIn/core/colors.dart';
import 'package:RemoteLogIn/pages/user_page.dart';
import 'package:animate_do/animate_do.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'devices_page.dart';
import 'web_site_pages.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomIn(
        child: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              WebSitesPage(),
              DevicesPage(),
              UserPage(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            activeColor: KColors.appStartGradientColor,
            title: Text(
              'Pages',
              textAlign: TextAlign.center,
            ),
            icon: Icon(FontAwesomeIcons.pager),
          ),
          BottomNavyBarItem(
            activeColor: KColors.appStartGradientColor,
            title: Text(
              'Devices',
              textAlign: TextAlign.center,
            ),
            icon: Icon(
              FontAwesomeIcons.desktop,
            ),
          ),
          BottomNavyBarItem(
            activeColor: KColors.appStartGradientColor,
            title: Text(
              'My Profile',
              textAlign: TextAlign.center,
            ),
            icon: Icon(FontAwesomeIcons.solidUser),
          ),
        ],
      ),
    );
  }
}
