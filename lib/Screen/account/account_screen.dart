import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../../Helper/Color.dart';
import '../../Helper/Constant.dart';
import '../../Helper/String.dart';
import '../../model_all_response/get_leads_model.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String? distance;
  GetLeadModel?getLeadData;
  Future<void> GetLeadsData() async {
    var headers = {
      'Cookie': 'ci_session=f7f450979da7c100cfbf415c279cc332bfca8211'
    };
    var request = http.MultipartRequest('GET', Uri.parse('${baseUrl}get_leads'));
    request.fields.addAll({
      'user_id': '${CUR_USERID}'
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var Result = await response.stream.bytesToString();
      final finalResult = GetLeadModel.fromJson(json.decode(Result));
      setState(() {
        getLeadData = finalResult;
      });
    }
    else {
      print(response.reasonPhrase);
    }

  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetLeadsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
         children: [
           getLeadData!= null?
           Container(
             height: MediaQuery.of(context).size.height/0.2,
             child: ListView.builder(
               physics: NeverScrollableScrollPhysics(),
               shrinkWrap: true,
               scrollDirection: Axis.vertical,
               itemCount:getLeadData?.data?.length,
               itemBuilder: (context, index) {
               return Column(
                 children: [
                   SizedBox(height:10,),
                   Stack(
                     children: [
                       InkWell(
                         onTap: () {
                           showDetails(index);
                         },
                         child: Padding(
                           padding: const EdgeInsets.only(left: 10.0,right: 10,top: 10),
                           child: Card(
                             elevation: 5,
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                             child: Padding(
                               padding: const EdgeInsets.only(left: 8.0,right: 10,top: 10),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   SizedBox(height:50,),
                                   Padding(
                                     padding: const EdgeInsets.only(left:15.0,right: 15),
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text("Name :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.fontColor),),
                                         Text("${getLeadData?.data?[index].name}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),

                                       ],
                                     ),
                                   ),
                                   SizedBox(height: 10,),
                                   Padding(
                                     padding: const EdgeInsets.only(left:15.0,right: 15),
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text("Mobile :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.fontColor),),
                                         Text("${getLeadData?.data?[index].mobile}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),

                                       ],
                                     ),
                                   ),
                                   SizedBox(height: 10,),
                                   Padding(
                                     padding: const EdgeInsets.only(left:15.0,right: 15),
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text("Total :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.fontColor),),
                                         Text("${getLeadData?.data?[index].amount}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),

                                       ],
                                     ),
                                   ),
                                   SizedBox(height: 10,),
                                   Padding(
                                     padding: const EdgeInsets.only(left:15.0,right: 15),
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text("Received :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.fontColor),),
                                         Text("10000", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),

                                       ],
                                     ),
                                   ),
                                   SizedBox(height: 10,),
                                   Padding(
                                     padding: const EdgeInsets.only(left:15.0,right: 15),
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text("Pending :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.fontColor),),
                                         Text("500", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
                                       ],
                                     ),
                                   ),
                                   SizedBox(height: 20,),
                                 ],
                               ),
                             ),
                           ),
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(left:15.0,top:15),
                         child: Container(
                           height: 35,
                           width: MediaQuery.of(context).size.width/1.085,
                           decoration: BoxDecoration(
                             color: colors.primary,
                             border: Border.all(color: colors.secondary),
                             borderRadius: BorderRadius.circular(3),
                           ),
                           child:Padding(
                             padding: const EdgeInsets.only(top:7.0),
                             child: Text('Payment Details',textAlign:TextAlign.center,style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color: colors.whiteTemp),),
                           ),
                         ),
                       )
                     ],
                   )

                 ],
               );
             },),
           ):Center(child: CircularProgressIndicator())
         ],
        ),
      ),
    );
  }

  showDetails(int index){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Lead Details',style: TextStyle(color: colors.primary),),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('User Id :',style: TextStyle(color: colors.blackTemp,fontSize: 15,fontWeight: FontWeight.w700),),
                      SizedBox(width: 20,),
                      Text('${getLeadData?.data?[index].id}'),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Name :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.fontColor),),
                      Text("${getLeadData?.data?[index].name}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),

                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Email id :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.fontColor),),
                      Text("${getLeadData?.data?[index].email}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),

                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Mobile :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.fontColor),),
                      Text("${getLeadData?.data?[index].mobile}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),

                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Address :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.fontColor),),
                      Text("${getLeadData?.data?[index].address}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),

                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.fontColor),),
                      Text("${getLeadData?.data?[index].amount}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),

                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Received :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.fontColor),),
                      Text("10000", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),

                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Pending :", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.fontColor),),
                      Text("500", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color:colors.blackTemp),),
                    ],
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ],
        );
      },
    );

  }




}
