import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:musium/config/assets/app_images.dart';
import 'package:musium/config/routes/app_router.dart';
import 'package:musium/core/presentation/components.dart';
import 'package:musium/core/presentation/widgets/default_rounded_button.dart';
import 'package:musium/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:musium/features/auth/presentation/widgets/custom_circle_indicator.dart';
import 'package:musium/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:musium/features/auth/presentation/widgets/divider_with_text.dart';
import 'package:musium/features/auth/presentation/widgets/google_circle_button.dart';
import 'package:musium/features/auth/presentation/widgets/text_and_text_button_row.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignupPage> {
  late TextEditingController _emailCont;
  late TextEditingController _passwordCont;
  late TextEditingController _confirmPasswordCont;
  late TextEditingController _nameCont;
  late GlobalKey<FormState> _formKey;
  @override
  void initState() {
    _emailCont = TextEditingController();
    _passwordCont = TextEditingController();
    _confirmPasswordCont = TextEditingController();
    _nameCont = TextEditingController();
    _formKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    _emailCont.dispose();
    _passwordCont.dispose();
    _confirmPasswordCont.dispose();
    _nameCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupFailed) {
          Components.showDefaultSnackBar(
            context: context,
            text: state.errMessage,
          );
        }
        if (state is SignupSuccess) {
          context.goNamed(AppRouter.homePageName);
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
                        child: Image.asset(AppImages.musiumLogoPng),
                      ),
                      const SizedBox(height: 12.0),
                      Text(
                        'Create an account',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 24.0),
                      CustomTextFormField(
                        controller: _nameCont,
                        hintText: 'Your Name',
                        textInputAction: TextInputAction.next,
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
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 24.0),
                      CustomTextFormField(
                        controller: _confirmPasswordCont,
                        hintText: 'Confirm   Password',
                        isPassword: true,
                        prefixIcon: Icons.lock_outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field can\'t be empty';
                          } else if (_passwordCont.text !=
                              _confirmPasswordCont.text) {
                            return 'Password doesn\'t match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32.0),
                      DefaultRoundedButton(
                        text: 'Sign Up',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await context.read<SignupCubit>().signup(
                                name: _nameCont.text,
                                email: _emailCont.text,
                                password: _passwordCont.text);
                          }
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextAndTextButtonRow(
                        text: 'Already have an account? ',
                        textButton: 'Log in',
                        onPressed: () {
                          context.goNamed(AppRouter.loginPageName);
                        },
                      ),
                      const SizedBox(height: 8.0),
                      const DividerWithText(),
                      const SizedBox(height: 16.0),
                      const GoogleCircleButton(),
                      const SizedBox(height: 48.0)
                    ],
                  ),
                ),
              ),
            ),
            BlocBuilder<SignupCubit, SignupState>(
              builder: (context, state) {
                if (state is SignupLoading) {
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
