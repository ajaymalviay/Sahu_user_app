import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:omega_employee_management/Helper/Color.dart';
import 'package:omega_employee_management/Helper/Constant.dart';
import 'package:omega_employee_management/Helper/String.dart';
import 'package:omega_employee_management/model_all_response/check_in_model.dart';
import 'package:omega_employee_management/Screen/Auth_view/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dashboard/Dashboard.dart';
import 'package:http/http.dart'as http;

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({Key? key}) : super(key: key);

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  var latitude;
  var longitude;

  var pinController = TextEditingController();
  var currentAddress = TextEditingController();


 bool? errormsg;
  Future<void>CheckInNow() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uids = prefs.getString('new_user_id');
    var headers = {
      'Cookie': 'ci_session=3515d88c5cab45d32a201da39275454c5d051af2'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}checkinNow'));
    request.fields.addAll({
      'checkin_latitude': '${latitude}',
      'checkin_longitude': '${longitude}',
      'address': '${currentAddress}',
      'user_id': '${uids}'
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var Response = await response.stream.bytesToString();
      final finalResponse = CheckInModel.fromJson(json.decode(Response));
      errormsg = finalResponse.data.error;
      Fluttertoast.showToast(msg:'${finalResponse.data.msg}');
      print('kkkkkkkkkkkkkkkkkk${finalResponse.data.msg}');

    }
    else {
      print(response.reasonPhrase);
    }

  }





  Future<void> getCurrentLoc() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      print("checking permission here ${permission}");
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
   // var loc = Provider.of<LocationProvider>(context, listen: false);

    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
    List<Placemark> placemark = await placemarkFromCoordinates(
        double.parse(latitude!), double.parse(longitude!),
        localeIdentifier: "en");

    pinController.text = placemark[0].postalCode!;
    if (mounted) {
      setState(() {
        pinController.text = placemark[0].postalCode!;
        currentAddress.text =
            "${placemark[0].street}, ${placemark[0].subLocality}, ${placemark[0].locality}";
        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
       // loc.lng = position.longitude.toString();
        //loc.lat = position.latitude.toString();


        print('=============${latitude}');
        print('Longitude*************${longitude}');
        print('Current Addresssssss${currentAddress.text}');
        getLatLong();
        CheckInNow();

      });

      if (currentAddress.text == "" || currentAddress.text == null) {
      } else {
        setState(() {
          navigateToPage();
        });
      }
    }
  }


  Future<void> getLatLong() async {
    SharedPreferences preferences= await SharedPreferences.getInstance();
    preferences.setString('lattt',latitude ?? '0.0');
    preferences.setString('longg',longitude ?? '0.0');
    preferences.setString('address1',currentAddress.text);
   // var latt = preferences.getString('longitude');

     // print('my pickedLat-------------${latt}');
      print('my pickedLong-------------${longitude}');


  }

  navigateToPage() async {
    Future.delayed(Duration(milliseconds:1200), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) =>Dashboard()),
          (route) => false);
    });
  }

  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colors.whiteTemp,
        title: Text('Check In ',style: TextStyle(color:colors.primary),),
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Container(
            height:MediaQuery.of(context).size.height/4 ,
            width:MediaQuery.of(context).size.width/1,
            child: Image.asset(
              "assets/images/check_in_image2.jpg.png",
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "DELIVERING TO",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40,
          ),
          currentAddress.text == "" || currentAddress.text == null
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Locating...",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                )
              : Text(
                  "${currentAddress.text}",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,),
                ),
           SizedBox(height: 50,),
          Container(
              height: 45,
              width:MediaQuery.of(context).size.width/1.3,
              decoration:BoxDecoration(
                  color:colors.primary,
                  borderRadius: BorderRadius.circular(30)),
              child: ElevatedButton(onPressed: (){
                getCurrentLoc();
              },style: ElevatedButton.styleFrom(backgroundColor:colors.primary), child:Text('Check In Now ')))

        ],
      ),
    );
  }
}
