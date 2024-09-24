import 'package:mech_manager/network/api/job_sheet_api.dart';
import 'package:mech_manager/network/repositories/repository.dart';

class JobSheetRepository extends Repository {
  final jobSheetApi = JobSheetApi();

  // create new job sheet
  Future<dynamic> addJobSheet(jsonData) async {
    return jobSheetApi.addJobSheet(jsonData);
  }

  Future<dynamic> getJobSheets(jsonData) async {
    return jobSheetApi.getJobSheets(jsonData);
  }

  Future<dynamic> deleteJobSheet(jsonData) {
    return jobSheetApi.deleteJobSheet(jsonData);
  }

  Future<dynamic> getJobSheetDetails(jsonData) {
    return jobSheetApi.getJobSheetDetails(jsonData);
  }

  Future<dynamic> getJobSheetImages(jsonData) {
    return jobSheetApi.getJobSheetImages(jsonData);
  }

  Future<dynamic> searchCustomerComplaint(jsonData) async {
    return jobSheetApi.searchCustomerComplaint(jsonData);
  }

  Future<dynamic> searchMechanic(jsonData) async {
    return jobSheetApi.searchMechanic(jsonData);
  }

  Future<dynamic> dashboardData(jsonData) {
    return jobSheetApi.dashboardData(jsonData);
  }

  Future<dynamic> updateJobSheet(jsonData, String id) {
    return jobSheetApi.updatedJobSheet(jsonData, id);
  }

  Future<dynamic> searchVehicleDetails(jsonData) async {
    return jobSheetApi.searchVehicleDetails(jsonData);
  }

  Future<dynamic> searchCustomerDetails(jsonData) async {
    return jobSheetApi.searchCustomerDetails(jsonData);
  }

  Future<dynamic> updateJobSheetStatus(jsonData, String id) {
    return jobSheetApi.updateJobSheetStatus(jsonData, id);
  }

  //update customer complaints
  Future<dynamic> updateCustomerComplaints(jsonData, String id) {
    return jobSheetApi.updateCustomerComplaints(jsonData, id);
  }

  Future<dynamic> getEstimate(jsonData) async {
    return jobSheetApi.getEstimate(jsonData);
  }

  // delete estimate
  Future<dynamic> deleteEstimate(jsonData) {
    return jobSheetApi.deleteEstimate(jsonData);
  }

  // get estimate details
  Future<dynamic> getEstimateDetails(jsonData) {
    return jobSheetApi.getEstimateDetails(jsonData);
  }

  Future<dynamic> updateCustomer(jsonData, String id) {
    return jobSheetApi.updateCustomer(jsonData, id);
  }

  // update vehicle
  Future<dynamic> updateVehicle(jsonData, String id) {
    return jobSheetApi.updateVehicle(jsonData, id);
  }

  // search spare part
  Future<dynamic> searchSparePart(jsonData) async {
    return jobSheetApi.searchSparePart(jsonData);
  }

  // search product
  Future<dynamic> searchProduct(jsonData) async {
    return jobSheetApi.searchProduct(jsonData);
  }

  ////fetch invoice list/////
  Future<dynamic> getInvoice(jsonData) async {
    return jobSheetApi.getInvoice(jsonData);
  }

  // delete inoice
  Future<dynamic> deleteInvoice(jsonData) {
    return jobSheetApi.deleteInvoice(jsonData);
  }

  Future<dynamic> getInvoiceByInvoiceId(jsonData) async {
    return jobSheetApi.getInvoiceByInvoiceId(jsonData);
  }
}
