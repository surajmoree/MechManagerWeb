

import 'package:intl/intl.dart';
import 'package:mech_manager/config.dart'as appInstance;

class Utility {
  resetAdditionalImageCount() {
    appInstance.appConfig.additonalImageCount = 0;
  }

  resetToastCount() {
    appInstance.appConfig.toastCount = 0;
  }

  String getCurrentDate() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  String getOldDate({int dayCount = 1}) {
    var now = DateTime.now().subtract(Duration(days: dayCount));
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  String thisMonthFirstDate() {
    var now = DateTime.now();

    var currentYearformatter = DateFormat('yyyy');
    String currnetYearformatted = currentYearformatter.format(now);

    var currentMonthformatter = DateFormat('MM');
    String currnetMonthformatted = currentMonthformatter.format(now);

    dynamic getFirstDate = "$currnetYearformatted-$currnetMonthformatted-1";
    return getFirstDate;
  }

  String lastMonthFirstDate() {
    var now = DateTime.now().subtract(const Duration(days: 30));
    var currentYearformatter = DateFormat('yyyy');
    String currnetYearformatted = currentYearformatter.format(now);

    var currentMonthformatter = DateFormat('MM');
    String currnetMonthformatted = currentMonthformatter.format(now);

    dynamic getFirstDate = "$currnetYearformatted-$currnetMonthformatted-1";
    return getFirstDate;
  }

  String lastMonthLastDate() {
    var now = DateTime.now().subtract(const Duration(days: 30));
    var currentYearformatter = DateFormat('yyyy');
    String currnetYearformatted = currentYearformatter.format(now);

    var currentMonthformatter = DateFormat('MM');
    String currnetMonthformatted = currentMonthformatter.format(now);

    dynamic getFirstDate = "$currnetYearformatted-$currnetMonthformatted-30";
    return getFirstDate;
  }
}

