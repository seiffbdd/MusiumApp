import 'package:flutter/material.dart';
import 'package:musium/features/home/presentation/widgets/build_circular_container.dart';

class ClickableListTile extends StatelessWidget {
  const ClickableListTile({
    super.key,
    this.onTap,
    required this.titleText,
    this.leading,
    this.subTitleText,
    this.trailing,
  });
  final String titleText;
  final String? subTitleText;
  final Function()? onTap;
  final Widget? leading;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: ListTile(
        leading: leading ??
            const BuildCircularContainer(icon: Icons.favorite_outline),
        title: Text(
          titleText,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        subtitle: subTitleText != null
            ? Text(
                subTitleText!,
                style: Theme.of(context).textTheme.titleMedium,
              )
            : null,
        trailing: trailing,
      ),
    );
  }
}
