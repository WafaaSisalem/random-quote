// import 'package:flutter/material.dart';
// import 'package:test_quote_api/view/screens/favorite_screen.dart';

// import 'home_screen.dart';

// class NavigationBarScreen extends StatefulWidget {
//   const NavigationBarScreen({
//     super.key,
//   });

//   @override
//   State<NavigationBarScreen> createState() => _NavigationBarScreenState();
// }

// class _NavigationBarScreenState extends State<NavigationBarScreen> {
//   List<Widget> screens = [const HomeScreen(), const FavoriteScreen()];
//   int currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
//         title: Text(
//           'Your Quote Today',
//           style: TextStyle(
//               color: Theme.of(context).colorScheme.onSecondaryContainer),
//         ),
//       ),
//       bottomNavigationBar: NavigationBar(
//           selectedIndex: currentIndex,
//           onDestinationSelected: (value) {
//             setState(() {
//               currentIndex = value;
//             });
//           },
//           destinations: const [
//             NavigationDestination(
//               icon: Icon(Icons.home_outlined),
//               label: 'Home',
//               selectedIcon: Icon(Icons.home),
//             ),
//             NavigationDestination(
//               icon: Icon(Icons.favorite_outline),
//               label: 'Favorite',
//               selectedIcon: Icon(Icons.favorite),
//             ),
//           ]),
//       body: IndexedStack(
//         index: currentIndex,
//         children: screens,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:test_quote_api/view/screens/favorite_screen.dart';

import 'home_screen.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({
    super.key,
  });

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  List<Widget> screens = [const HomeScreen(), const FavoriteScreen()];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        title: Text(
          'Your Quote Today',
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer),
        ),
      ),
      bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
              selectedIcon: Icon(Icons.home),
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_outline),
              label: 'Favorite',
              selectedIcon: Icon(Icons.favorite),
            ),
          ]),
      body: screens[currentIndex],
    );
  }
}
