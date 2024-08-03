import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/favorite_list_widget.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});
  @override
  ConsumerState<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    print('build favorite');
    return const Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Flexible(
          child: FavoriteListWidget(),
        ),
      ],
    );
  }
}
