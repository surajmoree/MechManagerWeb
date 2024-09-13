import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_state.dart';
import 'package:mech_manager/modules/job_sheet/edit_jobsheet/edit_job_sheet.dart';

import '../modules/dashboard/dashboard_page.dart';
import '../modules/estimate/estimate_page.dart';
import '../modules/invoice/invoice.dart';
import '../modules/job_sheet/job_sheet_listening.dart';
import '../modules/login/login_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/login_screen":
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case "/dashboard_page":
        return MaterialPageRoute(
          builder: (_) => BlocProvider<JobSheetBloc>(
            create: (context) => JobSheetBloc()
              ..add(const FetchDashboard(status: jobSheetStatus.initial)),
            child:  DashboardPage(),
          ),
        );

      case "/job_sheet_listing":
        return  MaterialPageRoute(
          builder: (_) => BlocProvider<JobSheetBloc>(
            create: (context) => JobSheetBloc()
              ..add(const FetchJobSheets(status: jobSheetStatus.initial)),
            child:  JobSheetListing(),
          ),
        );

        case "/estimate":
        return MaterialPageRoute(builder: (_) =>  EstimatePage());

      case "/invoice":
        return MaterialPageRoute(builder: (_) => InvoicePage());

      case "/editjobcard":
        return MaterialPageRoute(builder: (_) => EditJobSheet());

      default:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
    }
  }
}
