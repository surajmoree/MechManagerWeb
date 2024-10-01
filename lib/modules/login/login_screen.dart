import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_state.dart';
import 'package:mech_manager/modules/job_sheet/bloc/profile_bloc/profile_section_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/profile_bloc/profile_section_event.dart';

import '../../components/skeletone/center_loader.dart';
import '../../config/colors.dart';
import '../../models/login_model.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_state.dart';
/*
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogInCubit, LogInState>(listener: (context, state) {
      if (state.status.isSubmissionSuccess) {
        CenterLoader.hide();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login Successfully',
                style: TextStyle(color: Colors.white)),
            backgroundColor: successColor,
            duration: Duration(seconds: 2),
          ),
        );
        // context
        //     .read<JobSheetBloc>()
        //     .add(const FetchJobSheets(status: jobSheetStatus.initial));
        // context.read<ProfileSectionBloc>().add(const FetchProfileInfo());
        Navigator.pushNamed(context, '/dashboard_page');
        if (state.status.isSubmissionInProgress) {
          CenterLoader.show(context);
        }
        if (state.status.isSubmissionFailure) {
          CenterLoader.hide();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('Login Failed', style: TextStyle(color: Colors.white)),
              backgroundColor: redColor,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: backgroundColor,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;

            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.37, // 10% of screen width
                  //  vertical: screenHeight * 0.33, // 10% of screen height
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02, // 5% of screen height
                        horizontal: screenWidth * 0.02, // 5% of screen width
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Container(
                              color: whiteColor,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icons/mech-mang.png', // Replace with your logo asset
                                      height: 110,
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 7),
                          // const Padding(
                          //   padding: EdgeInsets.only(left: 15),
                          //   child:
                          Center(
                            child: Text(
                              'Sign in to Continue...',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          //   ),
                          const SizedBox(height: 30),
                          EmailInputBox(emailController: emailController),
                          const SizedBox(height: 15),
                          PasswordInputBox(
                              passwordController: passwordController),
                          const SizedBox(height: 30),
                          LoginButton(
                            emailController: emailController,
                            passwordController: passwordController,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

class EmailInputBox extends StatelessWidget {
  final TextEditingController? emailController;
  const EmailInputBox({super.key, this.emailController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInCubit, LogInState>(builder: (context, state) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: TextField(
          controller: emailController,
          onChanged: (value) {
            context.read<LogInCubit>().emailChanged(value);
          },
          textAlign: TextAlign.start,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(color: blackColor),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(width: 0, style: BorderStyle.none),
            ),
            filled: true,
            fillColor: lightGreyColor,
            hintText: "Username",
            errorText: state.email.invalid &&
                    state.email.error == EmailValidationError.empty
                ? 'Please enter email address or username'
                : null,
            hintStyle: const TextStyle(
              color: hintTextColor,
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
      );
    });
  }
}

class PasswordInputBox extends StatelessWidget {
  final TextEditingController? passwordController;
  const PasswordInputBox({super.key, this.passwordController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInCubit, LogInState>(builder: (context, state) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          controller: passwordController,
          onChanged: (value) {
            context.read<LogInCubit>().passwordChanged(value);
          },
          textAlign: TextAlign.start,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.visiblePassword,
          style: const TextStyle(color: blackColor),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(width: 0, style: BorderStyle.none),
            ),
            errorText: state.password.invalid ? 'Please enter password' : null,
            filled: true,
            fillColor: lightGreyColor,
            hintText: "Password",
            hintStyle: const TextStyle(
              color: hintTextColor,
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          obscureText: true,
        ),
      );
    });
  }
}

class LoginButton extends StatelessWidget {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  const LoginButton({super.key, this.emailController, this.passwordController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInCubit, LogInState>(builder: (context, state) {
      return Center(
        child: Container(
          //padding: const EdgeInsets.symmetric(horizontal: 13),
          // width: double.infinity, // Makes the button full width
          width: 120,
          height: 40,
          child: ElevatedButton(
            onPressed: () async {
              if (state.status.isValid) {
                await context.read<LogInCubit>().submitLoginForm(context);
              } else {
                context.read<LogInCubit>().emailChanged(emailController!.text);
                context
                    .read<LogInCubit>()
                    .passwordChanged(passwordController!.text);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              'Sign In',
              style: TextStyle(
                fontFamily: 'Mulish',
                fontSize: 14,
                color: blackColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      );
    });
  }
}

*/

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}
class LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogInCubit, LogInState>(listener: (context, state) {
      if (state.status.isSubmissionSuccess) {
        CenterLoader.hide();
      //  Fluttertoast.cancel();
          Fluttertoast.showToast(
              msg: "Login Successfully",
              backgroundColor: successColor,
              toastLength: Toast.LENGTH_SHORT);
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Login Successfully',
        //         style: TextStyle(color: Colors.white)),
        //     backgroundColor: successColor,
        //     duration: Duration(seconds: 2),
        //   ),
        // );]
        context
              .read<JobSheetBloc>()
              .add(const FetchDashboard(status: jobSheetStatus.initial));
        context
              .read<JobSheetBloc>()
              .add(const FetchJobSheets(status: jobSheetStatus.initial));
              
              context
              .read<JobSheetBloc>()
              .add(const FetchJobSheets(status: jobSheetStatus.initial));
              context.read<ProfileSectionBloc>().add(const FetchProfileInfo());
         Navigator.pushNamed(context, '/dashboard_page');
      } else if (state.status.isSubmissionInProgress) {
        CenterLoader.show(context);
      } else if (state.status.isSubmissionFailure) {
        CenterLoader.hide();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login Failed', style: TextStyle(color: Colors.white)),
            backgroundColor: redColor,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: backgroundColor,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;
            final isMobile = screenWidth < 600;

            return Center(
              child: SingleChildScrollView(
                child: Container(
                  width: isMobile ? screenWidth * 0.9 : screenWidth * 0.4, 
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.05, 
                    horizontal: screenWidth * 0.05, 
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/mech-mang.png', 
                              height: screenHeight * 0.15, 
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                      const SizedBox(height: 7),
                      Center(
                        child: Text(
                          'Sign in to Continue...',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      EmailInputBox(emailController: emailController),
                      const SizedBox(height: 15),
                      PasswordInputBox(
                          passwordController: passwordController),
                      const SizedBox(height: 30),
                      LoginButton(
                        emailController: emailController,
                        passwordController: passwordController,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

class EmailInputBox extends StatelessWidget {
  final TextEditingController? emailController;
  const EmailInputBox({super.key, this.emailController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInCubit, LogInState>(builder: (context, state) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: TextField(
          controller: emailController,
          onChanged: (value) {
            context.read<LogInCubit>().emailChanged(value);
          },
          textAlign: TextAlign.start,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(color: blackColor),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(width: 0, style: BorderStyle.none),
            ),
            filled: true,
            fillColor: lightGreyColor,
            hintText: "Username",
            errorText: state.email.invalid &&
                    state.email.error == EmailValidationError.empty
                ? 'Please enter email address or username'
                : null,
            hintStyle: const TextStyle(
              color: hintTextColor,
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
      );
    });
  }
}

class PasswordInputBox extends StatelessWidget {
  final TextEditingController? passwordController;
  const PasswordInputBox({super.key, this.passwordController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInCubit, LogInState>(builder: (context, state) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          controller: passwordController,
          onChanged: (value) {
            context.read<LogInCubit>().passwordChanged(value);
          },
          textAlign: TextAlign.start,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.visiblePassword,
          style: const TextStyle(color: blackColor),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(width: 0, style: BorderStyle.none),
            ),
            errorText: state.password.invalid ? 'Please enter password' : null,
            filled: true,
            fillColor: lightGreyColor,
            hintText: "Password",
            hintStyle: const TextStyle(
              color: hintTextColor,
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          obscureText: true,
        ),
      );
    });
  }
}

class LoginButton extends StatelessWidget {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  const LoginButton({super.key, this.emailController, this.passwordController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInCubit, LogInState>(builder: (context, state) {
      return Center(
        child: Container(
          //padding: const EdgeInsets.symmetric(horizontal: 13),
          // width: double.infinity, // Makes the button full width
          width: 120,
          height: 40,
          child: ElevatedButton(
            onPressed: () async {
              if (state.status.isValid) {
                await context.read<LogInCubit>().submitLoginForm(context);
              } else {
                context.read<LogInCubit>().emailChanged(emailController!.text);
                context
                    .read<LogInCubit>()
                    .passwordChanged(passwordController!.text);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              'Sign In',
              style: TextStyle(
                fontFamily: 'Mulish',
                fontSize: 14,
                color: blackColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      );
    });
  }
}