import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musium/config/routes/app_router.dart';
import 'package:musium/config/theme/app_theme.dart';
import 'package:musium/core/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:musium/core/utils/service_locator.dart';
import 'package:musium/features/auth/domain/use_cases/get_user_data_use_case.dart';
import 'package:musium/features/auth/domain/use_cases/listen_to_auth_state_use_case.dart';
import 'package:musium/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setup();
  runApp(const Musium());
}

class Musium extends StatelessWidget {
  const Musium({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        locator.get<ListenToAuthStateUseCase>(),
        locator.get<GetUserDataUseCase>(),
      ),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            AppRouter.router.goNamed(AppRouter.homePageName);
          } else if (state is Unauthenticated || state is UserDataFailed) {
            AppRouter.router.goNamed(AppRouter.loginPageName);
          }
        },
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: buildAppTheme(context),
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
