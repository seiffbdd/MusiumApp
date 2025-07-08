import 'package:flutter/material.dart';
import 'package:musium/features/home/presentation/widgets/clickable_list_tile.dart';

class SongsTabView extends StatelessWidget {
  const SongsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ClickableListTile(
          titleText: 'Your Liked Songs',
          onTap: () {
            // TODO: navigae to songs list
          },
        ),
        const SizedBox(height: 24),
        Text(
          'Recently Played',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: const Color(0XFF39C0D4)),
        ),
        const SizedBox(height: 24),
        ...List.generate(
          20,
          (index) {
            return const ClickableListTile(
              leading: Icon(Icons.audiotrack),
              titleText: 'Conan Grey',
              subTitleText: '<Unknown>',
            );
          },
        )
      ],
    );
  }
}
