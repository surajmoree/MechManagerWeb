import 'dart:async';

import 'package:mech_manager/config.dart';
import 'package:mech_manager/network/api/api.dart';

class JobSheetApi extends Api {
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

  //get labour details
  Future<dynamic> getLabourDetails(jsonData) async {
    try {
      final response = await requestGET(
          path: 'get_labour/${jsonData['id']}', parameters: jsonData);
      return response['Labour'];
    } catch (er) {
      print("Error is---------$er");
    }
  }

  ///////////update profile///////
  Future<dynamic> getProfileDetail(jsonData) async {
    try {
      final result = await requestGET(
          path: '/get_company/${jsonData['id']}', parameters: jsonData);
      return result['company'];
    } catch (er) {
      print("Error is---------$er");
    }
  }

  Future<dynamic> getJobSheetImages(jsonData) async {
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
  Future<dynamic> searchCustomerComplaint(jsonData) async {
    try {
      final response = await requestGET(
          path: '/get_customer_complaints', parameters: jsonData);
      return response['customer_complaints'];
    } catch (er) {
      print("Error is---------$er");
    }
  }

  //search mechanic
  Future<dynamic> searchMechanic(jsonData) async {
    try {
      final response =
          await requestGET(path: '/get_mechanics', parameters: jsonData);
      return response['mechanics'];
    } catch (er, _) {
      print(er);
    }
  }

  Future<dynamic> dashboardData(jsonData) async {
    try {
      final response =
          await requestGET(path: '/dashboard', parameters: jsonData);
      print("dashboard response=== $response");
      return response;
    } catch (er) {
      print("Error is---------$er");
    }
  }

  Future<dynamic> updatedJobSheet(jsonData, String id) async {
    try {
      final response =
          await requestPUT(path: '/update_job_sheet/$id', parameters: jsonData);
      print('jobcard update response $response');
      return response;
    } catch (er) {
      print("Error is---------$er");
    }
  }

//search vehicle///////

  Future<dynamic> searchVehicleDetails(jsonData) async {
    try {
      final response =
          await requestGET(path: '/get_vehicles', parameters: jsonData);
      return response['vehicles'];
    } catch (er) {
      print("Error is---------$er");
    }
  }

//search customer
  Future<dynamic> searchCustomerDetails(jsonData) async {
    try {
      final response =
          await requestGET(path: '/get_customers', parameters: jsonData);
      print(' customer response $response');
      return response['customers'];
    } catch (er) {
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
  Future<dynamic> getEstimate(jsonData) async {
    try {
      final response =
          await requestGET(path: '/get-estimates', parameters: jsonData)
              .timeout(const Duration(seconds: 30));
      print('estimate list $response');
      return response['Estimates'];
    } catch (e) {
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

  Future<dynamic> updateMechanic(jsonData, String id) async {
    try {
      final result =
          await requestPUT(path: '/update_mechanic/$id', parameters: jsonData);
      print('mechanic update response $result');
      return result;
    } catch (er) {
      print("Error is------$er");
    }
  }

  // Future<dynamic> updateLabour(jsonData, String id) async {
  //   try {
  //     final result =
  //         await requestPUT(path: '/update_labour/$id', parameters: jsonData);
  //         print('labour update response $result');
  //     return result;
  //   } catch (er) {
  //     print("Error is------$er");
  //   }
  // }

  Future<dynamic> updateLabour(jsonData, String id) async {
    try {
      final result =
          await requestPUT(path: '/update_labour/$id', parameters: jsonData);
      print('labour update response $result');
      return result;
    } catch (er) {
      print("Error is------$er");
    }
  }

  Future<dynamic> searchSparePart(jsonData) async {
    try {
      final apiResponse =
          await requestGET(path: '/get_spare_parts', parameters: jsonData);
      return apiResponse['spare_parts'];
    } catch (er, _) {
      print(er);
    }
  }

  Future<dynamic> searchProduct(jsonData) async {
    try {
      final apiResponse =
          await requestGET(path: '/get_products', parameters: jsonData);
      return apiResponse['products'];
    } catch (er, _) {
      print(er);
    }
  }

  Future<dynamic> getInvoice(Map<String, String> jsonData) async {
    try {
      final invoiceList =
          await requestGET(path: '/get-invoices', parameters: jsonData)
              .timeout(const Duration(seconds: 30));
      return invoiceList['Invoice'];
    } catch (e, _) {
      print(e);
      return null;
    }
  }

  //get labour

  Future<dynamic> getLabour(Map<String, String> jsonData) async {
    try {
      final invoiceList =
          await requestGET(path: '/get-labours', parameters: jsonData)
              .timeout(const Duration(seconds: 30));
      return invoiceList['labours'];
    } catch (e, _) {
      print(e);
      return null;
    }
  }

  //spare parts
  Future<dynamic> getSpareParts(jsonData) async {
    try {
      final sparepartList =
          await requestGET(path: '/get-spare-parts', parameters: jsonData)
              .timeout(const Duration(seconds: 30));
      return sparepartList['spare_parts'];
    } catch (e, _) {
      print(e);
      return null;
    }
  }

  // get machenics

  Future<dynamic> getMechanics(jsonData) async {
    try {
      final response =
          await requestGET(path: '/get-mechanics', parameters: jsonData)
              .timeout(const Duration(seconds: 30));
      print('mechanics response $response');
      return response['mechanics'];
    } catch (e, _) {
      print(e);
      return null;
    }
  }

  ///////delete invoice///

  Future<dynamic> deleteInvoice(jsonData) async {
    try {
      final result = await requestDELETE(
          path: '/delete_invoice/${jsonData['id']}', parameters: jsonData);
      return result;
    } catch (er) {
      print("Error is---------$er");
    }
  }

  Future<dynamic> deleteMechanic(jsonData) async {
    try {
      final response = await requestDELETE(
          path: '/delete_mechanic/${jsonData['id']}', parameters: jsonData);
      print('delete mechanci response $response');
      return response;
    } catch (er) {
      print("Error is---------$er");
    }
  }

  Future<dynamic> deleteLabour(jsonData) async {
    try {
      final response = await requestDELETE(
          path: '/delete_labour/${jsonData['id']}', parameters: jsonData);
      print('delete labour response $response');
      return response;
    } catch (er) {
      print("Error is---------$er");
    }
  }

  //  Future<dynamic> getInvoiceByInvoiceId(jsonData)async
  //  {
  //   try{
  //     final response = await requestGET(path:  'get_invoice_by_id/${jsonData['id']}', parameters: jsonData);
  //     print('result if invoice api ===== $response');
  //     return response['Invoice'];
  //   }catch (er) {
  //     print("Error is---------$er");
  //   }
  //  }

  Future<dynamic> getInvoiceByInvoiceId(jsonData) async {
    try {
      final getEstimateResponse = await requestGET(
          path: '/get_invoice_by_id/${jsonData['id']}', parameters: jsonData);
      print('result if invoice api ===== $getEstimateResponse');
      return getEstimateResponse['Invoice'];
    } catch (er) {
      print("Error is---------$er");
    }
  }

  Future<dynamic> getMechanicById(jsonData) async {
    try {
      final response = await requestGET(
          path: '/get_mechanic/${jsonData['id']}', parameters: jsonData);
      print(' get mechanics api  $response');
      return response['Mechanic'];
    } catch (er) {
      print("Error is---------$er");
    }
  }

  Future<dynamic> createAddInvoice(jsonData) async {
    try {
      final response =
          await requestPOST(path: '/create_invoice', parameters: jsonData);
      print('invoice create  api respo $response');
      return response;
    } catch (e, _) {
      print(e);
    }
  }

//create mechanics
  Future<dynamic> createMechanic(jsonData) async {
    try {
      final response =
          await requestPOST(path: '/add_mechanic', parameters: jsonData);
      print('mechanic create  $response');
      return response;
    } catch (e, _) {
      print(e);
    }
  }

  Future<dynamic> createLabour(jsonData) async {
    try {
      final response =
          await requestPOST(path: '/add_labour', parameters: jsonData);
      print('add labour $response');
      return response;
    } catch (e, _) {
      print(e);
    }
  }

  Future<dynamic> addEstimate(jsonData) async {
    try {
      final response =
          await requestPOST(path: '/create_estimate', parameters: jsonData);
      print('estimate created response $response');
      return response;
    } catch (e, _) {
      print(e);
    }
  }





  /////profile information////////////
  Future<dynamic> profileInformation(jsonData) async {
    try {
      final profileInformation =
          await requestGET(path: '/profile_information', parameters: jsonData);

      storage.write(
          key: 'id', value: profileInformation['user']['id'].toString());
      storage.write(
          key: 'firstName',
          value: profileInformation['user']['first_name'].toString());
      return profileInformation['user'];
    } catch (e, _) {
      print(e);
    }
  }
}
