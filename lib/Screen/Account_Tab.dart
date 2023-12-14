import 'dart:convert';

import 'package:eshop_multivendor/Helper/Color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Helper/Session.dart';
import 'package:http/http.dart'as http;

class AccountTab extends StatefulWidget {
  final String? title;

  const AccountTab({Key? key, this.title}) : super(key: key);

  @override
  State<AccountTab> createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {

  @override

  void initState() {
    // TODO: implement initState
    super.initState();
   Future.delayed(Duration(milliseconds: 300),(){
     return  getSetting();
   });
  }

  var webSettingValue;
  
  getSetting() async {
    print("Web setting Apiii");
    var headers = {
      'Cookie': 'ci_session=e38fa98f9a9e0adcbeaf0d4524b7fef982988be9; ekart_security_cookie=44ee249e620c2b968ff272aff5a3d20d'
    };
    var request = http.Request('POST', Uri.parse('https://ashwiniamruttulya.co.in/app/v1/api/get_settings'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalresponse = await response.stream.bytesToString();
      final jsonresponse = json.decode(finalresponse);
      print("Setting final response ${finalresponse}");
      if (jsonresponse['error'] == false) {
     setState(() {
       webSettingValue = jsonresponse['data']["web_settings"][0];
     });
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: getSimpleAppBar(widget.title!, context),
     body:  webSettingValue == "" || webSettingValue == null ?
     Center(child: CircularProgressIndicator(color: colors.primary,)) :
      Column(
        children: [
          SizedBox(height: 30,),
         Image.asset('assets/images/ap-logo.png',height: 150,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 15),
            child: Card(
              elevation: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Find Us On',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                   SizedBox(height: 10),
                   InkWell(
                     onTap: ()async{
                       var url = '${webSettingValue['twitter_link']}';
                       if(await canLaunch(url)){
                       await launch(url);
                       }else {
                       throw 'Could not launch $url';
                       }
                     },
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Image.asset("assets/images/twitter.png", scale: 2,),
                         SizedBox(width: 4,),
                         Text("Twitter ", style: TextStyle(fontWeight: FontWeight.bold),),
                         SizedBox(width: 8,),
                         // Text("${webSettingValue['twitter_link']}")
                       ],
                     ),
                   ),
                    Divider(thickness: 1,color: Colors.black45),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: ()async{
                        var url = '${webSettingValue['facebook_link']}';
                        if(await canLaunch(url)){
                          await launch(url);
                        }else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset("assets/images/facebook.png", scale: 2),
                          SizedBox(width: 4,),
                          Text("Facebook ",style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(width: 8,),
                          // Text("${webSettingValue['facebook_link']}")
                        ],
                      ),
                    ),
                    Divider(thickness: 1,color: Colors.black45,),

                    SizedBox(height: 10,),
                    InkWell(
                      onTap: ()async{
                        var url = '${webSettingValue['instagram_link']}';
                        if(await canLaunch(url)){
                          await launch(url);
                        }else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset("assets/images/instagram.png",scale: 2,),
                          SizedBox(width: 4),
                          Text("Instagram ", style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(width: 8),
                          // Text("${webSettingValue['instagram_link']}")
                        ],
                      ),
                    ),
                    Divider(thickness: 1,color: Colors.black45),

                    SizedBox(height: 10,),
                    InkWell(
                      onTap: ()async{
                        var url = '${webSettingValue['youtube_link']}';
                        if(await canLaunch(url)){
                          await launch(url);
                        }else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset("assets/images/youtube.png", scale: 2,),
                          SizedBox(width: 4),
                          Text("Youtube ", style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(width: 8),
                          // Text("${webSettingValue['youtube_link']}")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
   );
  }
}
