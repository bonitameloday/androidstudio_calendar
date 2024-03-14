import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WifiConnect extends GetxController{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Container(
       margin: EdgeInsets.all(20),
       width: double.infinity,
       height: double.infinity,
       child: StreamBuilder(
         stream: Connectivity().onConnectivityChanged,
         builder: (context, AsyncSnapshot<ConnectivityResult> snapshot){
           print(snapshot.toString());
           if(snapshot.hasData){
             ConnectivityResult? result = snapshot.data;
             if(result == ConnectivityResult.mobile){
               //connected to mobile internet
               return connected('Mobile');
             } else if(result == ConnectivityResult.wifi){
              // connected to wifi internet
               return connected('WIFI');
             } else {
               // no internet
               return noInternet();
             }
           } else{
             // show loading
             return loading();

           }
         },
       ),
     ),
   );
  }


  Widget loading(){
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
      ),
    );
  }


  Widget connected(String type){
   return Center(
     child: Text(
       "$type Connected",
       style: const TextStyle(
         color: Colors.green,
         fontSize: 28
       ),
     ),
   );
  }

  Widget noInternet(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.wifi, color:Colors.white, size: 35,),
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 10),
          child: const Text(
            "No Internet Connection",
            style: TextStyle(fontSize: 22),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: const Text("Check your connection, then refresh the page"),
        ),
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green)
            ),
            onPressed: () async {
              // You can also check the internet connection through this below function as well
              ConnectivityResult result = await Connectivity().checkConnectivity();
              print(result.toString());
            },
            child: const Text('Refresh'))
      ],
    );
  }
}