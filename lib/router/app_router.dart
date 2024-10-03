import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mech_manager/modules/Settings/settings_page.dart';
import 'package:mech_manager/modules/customer/customer_listening.dart';
import 'package:mech_manager/modules/estimate/estimate_listening.dart';
import 'package:mech_manager/modules/invoice/invoice_listening.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_event.dart';
import 'package:mech_manager/modules/job_sheet/bloc/job_sheet_bloc.dart/job_sheet_state.dart';
import 'package:mech_manager/modules/job_sheet/bloc/profile_bloc/profile_section_bloc.dart';
import 'package:mech_manager/modules/job_sheet/bloc/profile_bloc/profile_section_event.dart';
import 'package:mech_manager/modules/job_sheet/edit_jobsheet/edit_job_sheet.dart';
import 'package:mech_manager/modules/job_sheet/pages/job_sheet_details.dart';
import 'package:mech_manager/modules/labours/labours_listening.dart';
import 'package:mech_manager/modules/mechanics/mechanics_listening.dart';
import 'package:mech_manager/modules/spare_Parts/spare_parts_listening.dart';
import 'package:mech_manager/modules/staff/staff_page.dart';
import 'package:mech_manager/modules/stocks/stocks_page.dart';

import '../modules/dashboard/dashboard_page.dart';
import '../modules/job_sheet/job_sheet_listening.dart';
import '../modules/login/login_screen.dart';

class AppRouter {
  final id = 125;
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

      case "/invoice_listing":
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => JobSheetBloc()
                    ..add(
                        const FetchInvoiceList(status: jobSheetStatus.initial)),
                  child: const InvoiceListening(),
                ));

      case "/editjobcard":
        return MaterialPageRoute(builder: (_) => EditJobSheet());

      case "/staff_page":
        return MaterialPageRoute(builder: (_) => StaffPage());

      case "/customer_listing":
         return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => JobSheetBloc()
                    ..add(
                        const FetchCustomer(status: jobSheetStatus.initial)),
                  child: const CustomerPage(),
                ));

      case "/spare_parts_page":
        return MaterialPageRoute(builder: (_) => SparePartsPage());

      case "/stock_page":
        return MaterialPageRoute(builder: (_) => StockPage());

      case "/mechanics_listing":
      //  return MaterialPageRoute(builder: (_) => MechanicsPage());
      return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => JobSheetBloc()
                    ..add(
                        const FetchMechanics(status: jobSheetStatus.initial)),
                  child: const MechanicsPage(),
                ));

      case "/labours_listing":
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => JobSheetBloc()
                    ..add(
                        const FetchLabour(status: jobSheetStatus.initial)),
                  child: const LaboursPage(),
                ));
      case "/setting_page":
       return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) =>
                      ProfileSectionBloc()..add(const FetchProfileInfo()),
                  child: const SettingsPage(),
                ));

      default:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
    }
  }
}
