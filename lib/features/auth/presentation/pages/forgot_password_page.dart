import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:musium/core/presentation/components.dart';
import 'package:musium/core/presentation/widgets/default_rounded_button.dart';
import 'package:musium/features/auth/presentation/cubits/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:musium/features/auth/presentation/widgets/custom_text_form_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late final TextEditingController _emailCont;
  late final GlobalKey<FormState> _formKey;
  @override
  void initState() {
    _emailCont = TextEditingController();
    _formKey = GlobalKey();
    super.initState();
  }

  @override
  void dispose() {
    _emailCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is SendingPasswordResetEmailSuccess) {
          Components.showDefaultSnackBar(
            context: context,
            text: 'Please check your inbox to reset password.',
          );
          Future.delayed(
            Duration(
              seconds: 3,
            ),
            () {
              if (context.mounted) {
                context.pop();
              }
            },
          );
        }
        if (state is SendingPasswordResetEmailFailed) {
          Components.showDefaultSnackBar(
            context: context,
            text: state.errMessage,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Reset Password',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'Enter your email to reset password',
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
                    CustomTextFormField(
                      controller: _emailCont,
                      prefixIcon: Icons.email_outlined,
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                        height: Components.h(
                      componentHeight: 32.0,
                      currentScreenHeight: screenHeight,
                    )),
                    BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                      builder: (context, state) {
                        if (state is SendingPasswordResetEmailLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return DefaultRoundedButton(
                            icon: const Icon(
                              Icons.email,
                            ),
                            text: 'Reset Password',
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await context
                                    .read<ForgotPasswordCubit>()
                                    .sendPasswordResetEmail(
                                      email: _emailCont.text,
                                    );
                              }
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
                        context.pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
