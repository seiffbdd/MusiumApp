import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musium/features/home/presentation/home_constants/images_list.dart';

import 'package:musium/features/home/presentation/widgets/build_circular_container.dart';
import 'package:musium/features/home/presentation/widgets/clickable_list_tile.dart';
import 'package:musium/features/home/presentation/widgets/custom_card.dart';

class PlaylistsTabView extends StatelessWidget {
  const PlaylistsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ClickableListTile(
          titleText: 'Add New Playlist',
          onTap: () {
            // TODO: navigate to add playlist page
          },
          leading: const BuildCircularContainer(icon: Icons.add),
        ),
        const SizedBox(height: 24),
        Text(
          'Recently Added',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: const Color(0XFF39C0D4)),
        ),
        const SizedBox(height: 24),
        ...List.generate(
          20,
          (index) {
            final random = Random();
            return Padding(
              padding: EdgeInsets.only(bottom: 24.h),
              child: CustomCard(
                assetPath: imagesList[random.nextInt(10)],
                title: 'Coffe & Jazz',
                onTap: () {
                  // TODO
                },
              ),
            );
          },
        )
      ],
    );
  }
}
