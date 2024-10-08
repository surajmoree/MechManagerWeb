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

  Future<dynamic> getLabourDetails(jsonData) {
    return jobSheetApi.getLabourDetails(jsonData);
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

  //get stock

  Future<dynamic> getStock(jsonData)async
  {
    return jobSheetApi.getStock(jsonData);
  }

  // delete estimate
  Future<dynamic> deleteEstimate(jsonData) {
    return jobSheetApi.deleteEstimate(jsonData);
  }

  // get estimate details
  Future<dynamic> getEstimateDetails(jsonData) {
    return jobSheetApi.getEstimateDetails(jsonData);
  }

  // get customer info jobcard

Future<dynamic> getCustomerInfoJobCard(jsonData,String id) {
    return jobSheetApi.getCustomerInfoJobCard(jsonData, id);
  }
  Future<dynamic> updateCustomer(jsonData, String id) {
    return jobSheetApi.updateCustomer(jsonData, id);
  }

  //get profile details
  Future<dynamic> getProfileDetail(jsonData) async {
    return jobSheetApi.getProfileDetail(jsonData);
  }

  // update vehicle
  Future<dynamic> updateVehicle(jsonData, String id) {
    return jobSheetApi.updateVehicle(jsonData, id);
  }

  Future<dynamic> updateMechanic(jsonData, String id) {
    return jobSheetApi.updateMechanic(jsonData, id);
  }

  //updateLabour
  Future<dynamic> updateLabour(jsonData, String id) {
    return jobSheetApi.updateLabour(jsonData, id);
  }

  //updateProfile

  Future<dynamic> updateProfile(jsonData, String id) {
    return jobSheetApi.updateProfile(jsonData, id);
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

  // fetch spare parts
  Future<dynamic> getSpareParts(jsonData) async {
    return jobSheetApi.getSpareParts(jsonData);
  }

  Future<dynamic> getLabour(jsonData) async {
    return jobSheetApi.getLabour(jsonData);
  }

   Future<dynamic> getCustomer(jsonData) async {
    return jobSheetApi.getCustomer(jsonData);
  }



  //search mechanics
  Future<dynamic> getMechanics(jsonData) async {
    return jobSheetApi.getMechanics(jsonData);
  }

  // delete inoice
  Future<dynamic> deleteInvoice(jsonData) {
    return jobSheetApi.deleteInvoice(jsonData);
  }

  Future<dynamic> deleteMechanic(jsonData) {
    return jobSheetApi.deleteMechanic(jsonData);
  }

  Future<dynamic> deleteLabour(jsonData) {
    return jobSheetApi.deleteLabour(jsonData);
  }

  Future<dynamic> getInvoiceByInvoiceId(jsonData) async {
    return jobSheetApi.getInvoiceByInvoiceId(jsonData);
  }

  Future<dynamic> getMechanicById(jsonData) async {
    return jobSheetApi.getMechanicById(jsonData);
  }

  //getCustomerById

  Future<dynamic> getCustomerById(jsonData) async {
    return jobSheetApi.getCustomerById(jsonData);
  }

  Future<dynamic> createAddInvoice(jsonData) async {
    return jobSheetApi.createAddInvoice(jsonData);
  }

  Future<dynamic> createMechanic(jsonData) async {
    return jobSheetApi.createMechanic(jsonData);
  }

  //createLabour

  Future<dynamic> createLabour(jsonData) async {
    return jobSheetApi.createLabour(jsonData);
  }

  //createCustomer
    Future<dynamic> createCustomer(jsonData) async {
    return jobSheetApi.createCustomer(jsonData);
  }




  Future<dynamic> addEstimate(jsonData) async {
    return jobSheetApi.addEstimate(jsonData);
  }

  // fetch profile information
  Future<dynamic> profileInformation(jsonData) async {
    return jobSheetApi.profileInformation(jsonData);
  }

  //update password

  Future<dynamic> changePassword(jsonData, String id) async {
    return jobSheetApi.changePassword(jsonData, id);
  }
}
