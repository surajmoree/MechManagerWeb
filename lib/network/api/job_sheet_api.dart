import 'package:mech_manager/network/api/api.dart';

class JobSheetApi extends Api{
  Future<dynamic> getJobSheets(Map<String, String> jsonData) async {
    try {
      final jobSheetList =
          await requestGET(path: '/get-job-sheets', parameters: jsonData)
              .timeout(const Duration(seconds: 30));
      print("jobSheetList=============$jobSheetList");
      return jobSheetList['Jobsheet'];
    } catch (e, _) {
      print(e);
    }
  }


  Future<dynamic> deleteJobSheet(jsonData) async {
    try {
      final result = await requestDELETE(
          path: '/delete_job_sheet/${jsonData['id']}', parameters: jsonData);
      return result;
    } catch (er) {
      print("Error is---------$er");
    }
  }


  Future<dynamic> getJobSheetDetails(jsonData) async {
    try {
      final getJobDetailsResponse = await requestGET(
          path: 'get_job_sheet/${jsonData['id']}', parameters: jsonData);
      return getJobDetailsResponse['Jobsheet'];
    } catch (er) {
      print("Error is---------$er");
    }
  }

  Future<dynamic> getJobSheetImages(jsonData)async
  {
   try {
      final imageslide = await requestGET(
          path: '/get_job_sheet_original_img/${jsonData['id']}',
          parameters: jsonData);
      return imageslide['Jobsheet'];
    } catch (er) {
      print("Error is---------$er");
    }
  }
////customer complaints/////
  Future<dynamic> searchCustomerComplaint(jsonData)async
  {
    try{
      final response = await requestGET(path: '/get_customer_complaints',parameters: jsonData);
      return response['customer_complaints'];

    }catch (er) {
      print("Error is---------$er");
    }
  }

  //search mechanic
  Future<dynamic> searchMechanic(jsonData)async
  {
    try{
      final response = await requestGET(path: '/get_mechanics', parameters: jsonData);
      return response['mechanics'];
    }catch (er, _) {
      print(er);
    }
  }




}