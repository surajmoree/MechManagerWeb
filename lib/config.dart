import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mech_manager/config/app_config.dart';
import 'package:mech_manager/config/utility.dart';
import 'package:mech_manager/network/repositories/job_sheet_repository.dart';

final Utility utility = Utility();
final AppConfig appConfig = AppConfig();
final JobSheetRepository jobSheetRepository = JobSheetRepository();
final FlutterSecureStorage storage = FlutterSecureStorage();
ValueNotifier<String> selectedRouteNotifier =
    ValueNotifier<String>("/dashboard_page");

