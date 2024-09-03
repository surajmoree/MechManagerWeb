import 'package:mech_manager/network/api/job_sheet_api.dart';
import 'package:mech_manager/network/repositories/repository.dart';

class JobSheetRepository extends Repository
{
   final jobSheetApi = JobSheetApi();

   Future<dynamic> getJobSheets(jsonData)async
   {
    return jobSheetApi.getJobSheets(jsonData);
   }

    Future<dynamic> deleteJobSheet(jsonData) {
    return jobSheetApi.deleteJobSheet(jsonData);
  }

  Future<dynamic> getJobSheetDetails(jsonData)
  {
    return jobSheetApi.getJobSheetDetails(jsonData);
  }

  Future<dynamic> getJobSheetImages(jsonData)
  {
    return jobSheetApi.getJobSheetImages(jsonData);
  }

  Future<dynamic> searchCustomerComplaint(jsonData)async
  {
     return jobSheetApi.searchCustomerComplaint(jsonData);
  }

  Future<dynamic> searchMechanic(jsonData)async
  {
    return jobSheetApi.searchMechanic(jsonData);
  }
}