import 'dart:async';

import 'package:mech_manager/network/api/api.dart';

class JobSheetApi extends Api{

  Future<dynamic> addJobSheet(jsonData) async {
    try {
      final apiResponse =
          await requestPOST(path: '/add_job_sheet', parameters: jsonData);
      return apiResponse;
    } catch (e, _) {
      print(e);
    }
  }
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

  Future<dynamic> dashboardData(jsonData) async
  {
    try{
      final response = await requestGET(path: '/dashboard',parameters: jsonData);
      print("dashboard response=== $response");
      return response;
    }catch (er) {
      print("Error is---------$er");
    }
  }


Future<dynamic> updatedJobSheet(jsonData, String id)async
{
  try{
    final response = await requestPUT(path: '/update_job_sheet/$id', parameters: jsonData);
    print('jobcard update response $response');
    return response;
  }catch (er) {
      print("Error is---------$er");
    }
}

//search vehicle///////

Future<dynamic> searchVehicleDetails(jsonData)async
{
  try{
    final response = await requestGET(path: '/get_vehicles', parameters: jsonData);
    return response['vehicles'];

  }
  catch (er) {
      print("Error is---------$er");
    }
}


//search customer
Future<dynamic> searchCustomerDetails(jsonData)async
{
  try{
    final response = await requestGET(path: '/get_customers', parameters: jsonData);
    print(' customer response $response');
    return response['customers'];
  }catch (er) {
      print("Error is---------$er");
    }
}


 Future<dynamic> updateJobSheetStatus(jsonData, String id) async {
    try {
      final result =
          await requestPUT(path: '/update_status/$id', parameters: jsonData);
      return result;
    } catch (er) {
      print("Error is---------$er");
    }
  }

    //update customer complaints
   Future<dynamic> updateCustomerComplaints(jsonData, String id) async {
    try {
      final result = await requestPUT(
          path: '/update_customer_complaints/$id', parameters: jsonData);
      return result;
    } catch (er) {
      print("Error is------$er");
    }
  }
  

  //estimate list
  Future<dynamic> getEstimate(jsonData)async
  {
    try
    {
      final response = await requestGET(path: '/get-estimates', parameters: jsonData).timeout(const Duration(seconds: 30));
      print('estimate list $response');
      return response['Estimates'];
    }catch (e) {
      print(e);
      return null;
    }
  }

  ///////delete estimate///

  Future<dynamic> deleteEstimate(jsonData) async {
    try {
      final result = await requestDELETE(
          path: '/delete_estimate/${jsonData['id']}', parameters: jsonData);
      return result;
    } catch (er) {
      print("Error is---------$er");
    }
  }


  /////////get Estimate Details by estimate////

  Future<dynamic> getEstimateDetails(jsonData) async {
    try {
      final getEstimateResponse = await requestGET(
          path: 'get_estimate/${jsonData['id']}', parameters: jsonData);
      return getEstimateResponse['Estimate'];
    } catch (er) {
      print("Error is---------$er");
    }
  }


 Future<dynamic> updateCustomer(jsonData, String id) async {
    try {
      final result =
          await requestPUT(path: '/update_customer/$id', parameters: jsonData);
      return result;
    } catch (er) {
      print("Error is------$er");
    }
  }


   Future<dynamic> updateVehicle(jsonData, String id) async {
    try {
      final result =
          await requestPUT(path: '/update_vehicle/$id', parameters: jsonData);
      return result;
    } catch (er) {
      print("Error is------$er");
    }
  }


}