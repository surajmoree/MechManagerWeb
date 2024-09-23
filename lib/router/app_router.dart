import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mech_manager/config/colors.dart';
import 'package:mech_manager/modules/customer/customer_page.dart';
import 'package:mech_manager/modules/estimate/estimate_listening.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_state.dart';
import 'package:mech_manager/modules/job_sheet/edit_jobsheet/edit_job_sheet.dart';
import 'package:mech_manager/modules/job_sheet/pages/job_sheet_details.dart';
import 'package:mech_manager/modules/spare_Parts/spare_parts.dart';
import 'package:mech_manager/modules/staff/staff_page.dart';
import 'package:mech_manager/modules/stocks/stocks_page.dart';

import '../modules/dashboard/dashboard_page.dart';
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
            child: DashboardPage(),
          ),
        );

      case "/job_sheet_listing":
        return MaterialPageRoute(
          builder: (_) => BlocProvider<JobSheetBloc>(
            create: (context) => JobSheetBloc()
              ..add(const FetchJobSheets(status: jobSheetStatus.initial)),
            child: JobSheetListing(),
          ),
        );

      case '/job_sheet_details':
        return MaterialPageRoute(
          builder: (_) => JobSheetDetails(),
        );

      case "/estimate_listing":
        return MaterialPageRoute(
            builder: (_) => BlocProvider<JobSheetBloc>(
                  create: (context) => JobSheetBloc()
                    ..add(const FetchEstimateList(
                      status: jobSheetStatus.initial,
                    )),
                  child: EstimateListing(),
                ));

      case "/invoice":
        return MaterialPageRoute(builder: (_) => InvoicePage());

      case "/editjobcard":
        return MaterialPageRoute(builder: (_) => EditJobSheet());

      case "/staff_page":
        return MaterialPageRoute(builder: (_) => StaffPage());

      case "/customer_page":
        return MaterialPageRoute(builder: (_) => CustomerPage());
      
      case "/spare_parts_page":
       return MaterialPageRoute(builder: (_)=>SparePartsPage());
      
      case "/stock_page":
       return MaterialPageRoute(builder: (_)=>StockPage());

      default:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
    }
  }
}
