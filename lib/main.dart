import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:goals/pages/goals_page.dart';
import 'package:goals/utils/colors.dart';

void main() { 
  runApp(MaterialApp(
  title: 'Navigation Basics',
  home: TopNavPage(),
));
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => new ThemeData(
        primaryColor: MyColors.primaryColor,
        accentColor: MyColors.accentColor,
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          title: "Goals",
          theme: theme,
          home: GoalsPage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class TopNavPage extends StatefulWidget{
  @override
 _TopNavPageState createState() => _TopNavPageState(); 
}

class _TopNavPageState extends State<TopNavPage> {
  int _selectedTabIndex = 0;
  void _onNavBarTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final _listPage = <Widget>[
      Text('Halaman Makanan'),
      Text('Helaman Minuman'),
    ];

    final _TopNavBarItems = <TopNavigationBarItem>[
      TopNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text('Makanan'),
      ),
      TopNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text('Minuman'),
      ),
    ];

    final _topNavBar = TopNavigationBar(
      items: _topNavBarItems,
      currentIndex: _selectedTabIndex,
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.grey,
      onTap: _onNavBarTapped,
    );

    return Scaffold (
      appBar: AppBar (
        title: Text('Top Navigation Bar')
      ),
      body: Center(
        child: _listPage[_selectedTabIndex]
      ),
      topNavigationBar: _topNavBar,
    );
  }
}