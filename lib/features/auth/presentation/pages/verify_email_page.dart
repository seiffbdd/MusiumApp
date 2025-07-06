import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:musium/config/routes/app_router.dart';
import 'package:musium/config/theme/app_colors.dart';
import 'package:musium/core/presentation/components.dart';
import 'package:musium/core/presentation/widgets/default_rounded_button.dart';
import 'package:musium/core/utils/service_locator.dart';
import 'package:musium/features/auth/domain/use_cases/no_params.dart';
import 'package:musium/features/auth/presentation/cubits/email_verification_cubit/email_verification_cubit.dart';
import 'package:musium/features/auth/presentation/cubits/timer_cubit/timer_cubit.dart';
import 'package:musium/features/settings/domain/use_cases/sign_out_use_case.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  @override
  void initState() {
    _sendEmailVerification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return BlocListener<EmailVerificationCubit, EmailVerificationState>(
      listener: (context, state) {
        if (state is SendingEmailFailure) {
          Components.showDefaultSnackBar(
            context: context,
            text: state.errMessage,
          );
        }
        if (state is EmailVerified) {
          Components.showDefaultSnackBar(
            context: context,
            text: 'Email verified successfully!',
          );
          context.goNamed(AppRouter.homePageName);
        }
        if (state is SendingEmailSuccess) {
          context.read<TimerCubit>().startTimer();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Verify Email',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'A verification email has been sent to you. Please check your inbox and click on the link to verify your account.',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  SizedBox(
                      height: Components.h(
                    componentHeight: 32.0,
                    currentScreenHeight: screenHeight,
                  )),
                  BlocBuilder<TimerCubit, TimerState>(
                    builder: (context, state) {
                      if (state is TimerInProgress) {
                        return Text(
                          'Resend email in ${state.duration} seconds',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: AppColors.buttonBackgroundColor),
                        );
                      } else {
                        return DefaultRoundedButton(
                          icon: const Icon(
                            Icons.email,
                          ),
                          text: 'Resend Email',
                          onPressed: () async {
                            _sendEmailVerification();
                          },
                        );
                      }
                    },
                  ),
                  SizedBox(
                      height: Components.h(
                    componentHeight: 32.0,
                    currentScreenHeight: screenHeight,
                  )),
                  TextButton(
                    child: Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    onPressed: () {
                      locator.get<SignOutUseCase>().call(NoParams.instance);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _sendEmailVerification() async {
    await context.read<EmailVerificationCubit>().sendEmailVerification();
  }
}
