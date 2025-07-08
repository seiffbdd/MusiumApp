import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:musium/config/assets/app_images.dart';
import 'package:musium/config/routes/app_router.dart';
import 'package:musium/core/presentation/cubits/auth_cubit/auth_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) => previous.runtimeType != UserDataFailed,
      listener: (context, state) {
        if (state is AuthenticatedAndVerified) {
          context.goNamed(AppRouter.homePageName);
        } else if (state is Unauthenticated || state is UserDataFailed) {
          context.goNamed(AppRouter.loginPageName);
        } else if (state is AuthenticatedButUnverified) {
          context.goNamed(AppRouter.emailVerificationPageName);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Image.asset(AppImages.musiumLogoPng),
        ),
      ),
    );
  }
}
