import 'dart:ui';

const Color bluecolorprimary = Color.fromARGB(255, 3, 117, 204);
const Color primaryColor = Color.fromRGBO(255, 213, 59, 1.0);
const Color blackColor = Color.fromARGB(255, 39, 39, 46);
const Color hintTextColor = Color.fromARGB(255, 161, 161, 161);
//const Color backgroundColor = Color.fromRGBO(247, 247, 247, 1.0);
const Color backgroundColor = Color.fromRGBO(255, 245, 206, 1.0);
const Color lightColor = Color(0xFFFFFFFF);
const Color whiteColor = Color.fromARGB(255, 255, 255, 255);
const Color blackColorLight = Color.fromRGBO(167, 166, 164, 1.0);
const Color lightyellowColor = Color(0xD3EEDFAD);
///////////////////

const Color darkColor = Color(0xff15181B);
const Color greyColor = Color(0xff585858);
const Color darkgreyColor = Color.fromARGB(255, 150, 143, 143);
const Color borderColor = Color.fromARGB(255, 161, 161, 161);
const Color lightGreyColor = Color.fromARGB(255, 238, 239, 240);
const Color primaryDarkColor = Color(0xffFAB921);
const Color primaryYellowColor = Color.fromARGB(255, 230, 189, 95);
const Color blueColor = Color(0xff3B82F6);
const Color blurLightColor = Color.fromARGB(255, 158, 206, 243);
const Color purpleColor = Color.fromARGB(255, 178, 62, 231);
const Color lightBlueColor = Color.fromARGB(255, 164, 212, 248);
const Color cardBackgroundColor = Color(0xffEEF2FF);
const Color redColor = Color.fromARGB(255, 255, 2, 2);
const Color pinkColor = Color.fromARGB(255, 230, 83, 139);
const Color successColor = Color.fromARGB(255, 0, 177, 80);
const Color successLightColor = Color.fromARGB(255, 183, 231, 173);
const Color successDarkColor = Color.fromARGB(255, 2, 139, 64);
const Color blackColorDark = Color.fromARGB(255, 61, 62, 65);

const Color drawerColor = Color.fromARGB(255, 8, 16, 31);
//EBF2EB
const Color  jobcardColor = Color(0xffEBF2EB);
const Color  jobcardIconColor = Color(0xff2E7D32);
const Color  estimatecardColor = Color(0xffFAEAEA);
const Color  estimateIconColor = Color(0xffC62828);
const Color  invoicecardColor = Color(0xffFFF7EA);
const Color  invoiceIconColor = Color(0xffF9A825);
const Color  staffcardColor = Color(0xffF2EBF6);
const Color  staffIconColor = Color(0xff7C33A5);
const Color  customercardColor = Color(0xffFFF3E9);
const Color  customerIconColor = Color(0xffFF801A);
const Color  stockcardColor = Color(0xffF9EBFB);
const Color  stockIconColor = Color(0xffBA34D0);
const Color  mechanicscardColor = Color(0xffD8ECDD);
const Color  mechanicsIconColor = Color(0xff19B929);
const Color  labourscardColor = Color(0xffE8F8F9);
const Color  laboursIconColor = Color(0xff16B4C2);
const Color textColor = Color(0xff27272E);
const Color dashboardTextColor= Color(0xff7D7D82);
const Color textfieldColor= Color(0xffF3F4F6);
const Color taskbuttonColor= Color(0xff22C55E);
const Color complentboxColor= Color(0xffF9FAFB);
const Color complentborderColor= Color(0xff9CA3AF);
const Color tablerowcolor= Color(0xff6B7280);
const Color savebuttoncolor= Color(0xff22C55E);

//0xff22C55E

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}
