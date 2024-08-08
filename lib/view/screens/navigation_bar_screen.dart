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
//       body: screens[currentIndex],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../providers/connectivity_provider.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';

class NavigationBarScreen extends ConsumerStatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  ConsumerState<NavigationBarScreen> createState() =>
      _NavigationBarScreenState();
}

class _NavigationBarScreenState extends ConsumerState<NavigationBarScreen> {
  List<Widget> screens = [const HomeScreen(), const FavoriteScreen()];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isConnected = ref.watch(connectivityNotifierProvider);

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
        ],
      ),
      body: isConnected
          ? screens[currentIndex]
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Check your internet connection,\n then try again!',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  Lottie.asset('assets/json/internet.json', width: 200),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(connectivityNotifierProvider.notifier)
                          .checkInternetConnection();
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            ),
    );
  }
}
