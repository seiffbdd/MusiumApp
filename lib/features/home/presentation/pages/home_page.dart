import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:musium/config/routes/app_router.dart';
import 'package:musium/config/theme/app_colors.dart';
import 'package:musium/core/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:musium/features/home/presentation/widgets/container_with_gredient_background.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerWithGredientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome back !',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: AppColors.textWhite),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  context.read<AuthCubit>().userEntity?.name ?? 'User',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.pushNamed(AppRouter.settingsPageName);
              },
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}
