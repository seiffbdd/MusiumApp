import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:musium/config/theme/app_colors.dart';
import 'package:musium/core/presentation/components.dart';
import 'package:musium/features/auth/presentation/widgets/custom_circle_indicator.dart';
import 'package:musium/features/settings/presentation/cubits/sign_out_cubit/sign_out_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignOutCubit, SignOutState>(
      listener: (context, state) {
        if (state is SignOutFailed) {
          Components.showDefaultSnackBar(
            context: context,
            text: state.errMessage,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Stack(
          children: [
            Center(
              child: IconButton(
                onPressed: () async {
                  await context.read<SignOutCubit>().signOut();
                },
                icon: const Icon(
                  Icons.logout,
                  size: 40,
                  color: AppColors.cyan,
                ),
              ),
            ),
            BlocBuilder<SignOutCubit, SignOutState>(builder: (context, state) {
              if (state is SignOutLoading) {
                return CustomCircleIndicator();
              }
              return const SizedBox.shrink();
            })
          ],
        ),
      ),
    );
  }
}
