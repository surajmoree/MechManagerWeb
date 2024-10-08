import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_state.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_details_bloc.dart/job_sheet_details_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/profile_bloc/profile_section_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/profile_bloc/profile_section_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/search_bloc/search_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/search_mechanic_bloc/search_mechanic_bloc.dart';
import 'package:mech_manager/router/app_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'modules/login/cubit/login_cubit.dart';
import 'network/controller/authentication_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final auth = Authentication();
  final isLogin = await auth.checkLogin();

  runApp(MyApp(
    appRouter: AppRouter(),
    initialRoute: isLogin ? '/dashboard_page' : '/login_screen',
  ));
}

class MyApp extends StatelessWidget {
  final String? initialRoute;
  final AppRouter appRouter;
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  const MyApp({super.key, required this.appRouter, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LogInCubit>(
            create: (context) => LogInCubit(),
          ),

          BlocProvider<JobSheetBloc>(
              create: (context) => JobSheetBloc()
                ..add(const FetchDashboard(status: jobSheetStatus.initial))
                ..add(const FetchJobSheets(status: jobSheetStatus.initial))
                ..add(const FetchEstimateList(status: jobSheetStatus.initial))
                ..add(const FetchInvoiceList(status: jobSheetStatus.initial))
                ..add(const FetchSparePartList(status: jobSheetStatus.initial))
                ..add(const FetchMechanics(status: jobSheetStatus.initial))
                ..add(const FetchLabour(status: jobSheetStatus.initial))
                ..add(const FetchCustomer(status: jobSheetStatus.initial))
                ..add(const GetCustomerInfoJobCard(status: jobSheetStatus.initial))
                ..add(const FetchStock(status: jobSheetStatus.initial))
                
              //  ..add(const FetchDashboard(status: jobSheetStatus.initial))
              // ..add(const FetchServiceList(status: jobSheetStatus.initial)),
              ),
          // FetchStock
          BlocProvider<JobSheetDetailsBloc>(
              create: (context) => JobSheetDetailsBloc()),
          BlocProvider<SearchBloc>(create: (context) => SearchBloc()),
          BlocProvider<SearchMechanicBloc>(
              create: (context) => SearchMechanicBloc()),

              BlocProvider<ProfileSectionBloc>(
            create: (context) =>
                ProfileSectionBloc()..add(const FetchProfileInfo())),
        ],
        child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'meck',
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          title: 'MechManager',
          navigatorKey: MyApp.navigatorKey,
          onGenerateRoute: appRouter.onGenerateRoute,
          builder: (context, widget) => ResponsiveWrapper.builder(
            ClampingScrollWrapper.builder(context, widget!),
            maxWidth: MediaQuery.of(context).size.width,
            minWidth: 470,
            defaultScale: true,
            breakpoints: [
              ResponsiveBreakpoint.resize(500, name: MOBILE),
              ResponsiveBreakpoint.autoScale(850, name: TABLET),
              ResponsiveBreakpoint.autoScale(1250, name: DESKTOP),
            ],
            background: Container(color: Color(0xFFF5F5F5)),
          ),
        ),
      ),
    );
  }
}



/*
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Authentication().checkLogin().then((isLogin) {
    runApp(MyApp(
      appRouter: AppRouter(),
      initialRoute: isLogin ? '/dashboard_page' : '/login_screen',
    ));
  }).catchError((error) {
    // Handle any errors during authentication check.
  });
}

class MyApp extends StatelessWidget {
  final String? initialRoute;
  final AppRouter appRouter;
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  const MyApp({super.key, required this.appRouter, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LogInCubit>(
            create: (context) => LogInCubit(),
          ),
          BlocProvider<JobSheetBloc>(
            create: (context) => JobSheetBloc()
              ..add(const FetchJobSheets(status: jobSheetStatus.initial))
              ..add(const FetchDashboard(status: jobSheetStatus.initial)),
          ),
          BlocProvider<JobSheetDetailsBloc>(create: (context) => JobSheetDetailsBloc()),
          BlocProvider<SearchBloc>(create: (context) => SearchBloc()),
          BlocProvider<SearchMechanicBloc>(create: (context) => SearchMechanicBloc()),
        ],
        child: MaterialApp(
          theme: ThemeData(fontFamily: 'meck'),
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          title: 'MechManager',
          navigatorKey: MyApp.navigatorKey,
          onGenerateRoute: appRouter.onGenerateRoute,
          builder: (context, widget) => ResponsiveWrapper.builder(
            ClampingScrollWrapper.builder(context, widget!),
            maxWidth: MediaQuery.of(context).size.width,
            minWidth: 470,
            defaultScale: true,
            breakpoints: [
              ResponsiveBreakpoint.resize(500, name: MOBILE),
              ResponsiveBreakpoint.autoScale(850, name: TABLET),
              ResponsiveBreakpoint.autoScale(1250, name: DESKTOP),
            ],
            background: Container(color: const Color(0xFFF5F5F5)),
          ),
        ),
      ),
    );
  }
}

*/


