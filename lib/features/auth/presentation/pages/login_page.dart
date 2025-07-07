import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:musium/config/assets/app_images.dart';
import 'package:musium/config/routes/app_router.dart';
import 'package:musium/core/presentation/components.dart';
import 'package:musium/core/presentation/widgets/default_rounded_button.dart';
import 'package:musium/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:musium/features/auth/presentation/widgets/custom_circle_indicator.dart';
import 'package:musium/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:musium/features/auth/presentation/widgets/divider_with_text.dart';
import 'package:musium/features/auth/presentation/widgets/google_circle_button.dart';
import 'package:musium/features/auth/presentation/widgets/text_and_text_button_row.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailCont;
  late TextEditingController _passwordCont;
  late GlobalKey<FormState> _formKey;
  @override
  void initState() {
    _emailCont = TextEditingController();
    _passwordCont = TextEditingController();
    _formKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    _emailCont.dispose();
    _passwordCont.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailed) {
          Components.showDefaultSnackBar(
            context: context,
            text: state.errMessage,
          );
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Image.asset(
                          AppImages.musiumLogoPng,
                          height: Components.h(
                            componentHeight: 254,
                            currentScreenHeight:
                                MediaQuery.sizeOf(context).height,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Text(
                        'Login to your account',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 24.0),
                      CustomTextFormField(
                        controller: _emailCont,
                        hintText: 'Email',
                        prefixIcon: Icons.email_outlined,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 24.0),
                      CustomTextFormField(
                        controller: _passwordCont,
                        hintText: 'Password',
                        isPassword: true,
                        prefixIcon: Icons.lock_outline,
                      ),
                      const SizedBox(height: 32.0),
                      DefaultRoundedButton(
                        text: 'Log in',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await context.read<LoginCubit>().login(
                                  email: _emailCont.text,
                                  password: _passwordCont.text,
                                );
                          }
                        },
                      ),
                      const SizedBox(height: 8.0),
                      TextButton(
                        onPressed: () {
                          context.pushNamed(AppRouter.forgotPasswordPageName);
                        },
                        style: TextButton.styleFrom(
                            textStyle: TextStyle(color: Color(0XFF39C0D4))),
                        child: Text(
                          'Forgot your password?',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: const Color(0XFF39C0D4)),
                        ),
                      ),
                      TextAndTextButtonRow(
                        text: 'Don\'t have an account? ',
                        textButton: 'Sign Up',
                        onPressed: () {
                          context.goNamed(AppRouter.signupPageName);
                        },
                      ),
                      const DividerWithText(),
                      const SizedBox(height: 16.0),
                      const GoogleCircleButton()
                    ],
                  ),
                ),
              ),
            ),
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                if (state is LoginLoading) {
                  return const CustomCircleIndicator();
                }
                return const SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }
}
