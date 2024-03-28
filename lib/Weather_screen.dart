import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherap/Additional_iforecast_item.dart';
import 'package:weatherap/weather_forecast_item.dart';
import 'package:http/http.dart' as http;


class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // double temprature = 0.0 ;

  Future <Map<String,dynamic>> getCurrentweather() async{
    try{
      final res = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=india,In&APPID=6af0655ae255b387f4a8466bd2a4bcc3'),
    );
    final data = jsonDecode(res.body);
    if(data['cod']!= '200')
    {
      throw 'An Unhandled Error Occured';

    }
    return data ;
   
      //temprature = data['list'][0]['main']['temp'];

    }
    
    catch(e){
      throw e.toString();

    }
    
     
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: const Text("Weather App",
      style: TextStyle(fontWeight: FontWeight.bold),),
      centerTitle: true,
      actions: [
        
        IconButton(onPressed:()  {
          setState(() {
            
          });
        
        }, icon: const Icon (Icons.refresh))
      ],
      
      ),
      body:  FutureBuilder( future: getCurrentweather(),
      builder: (context,snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child:CircularProgressIndicator.adaptive());
        }
        final data1 = snapshot.data!;
        double   ctemp = data1['list'][0]['main']['temp']-273.15;
        String temp =  ctemp.toStringAsFixed(2);
        ctemp = double.parse(temp);
        //print(ctemp);
        final csky = data1['list'][0]['weather'][0]['main'];  
        final chum =data1['list'][0]['main']['humidity'];
        final cpress =data1['list'][0]['main']['pressure'];
        final cwindspeed = data1['list'][0]['wind']['speed'];
        //print(cwindspeed);
        return Center(
          child:    Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container
                (
                  
                  width: double.infinity,
                  child:   Card( 
                    surfaceTintColor: Colors.blue[200],
                    shadowColor: Colors.black87,
                    elevation: 20,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                     child :ClipRRect
                     (
                      borderRadius:BorderRadius.circular(10),
                       child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10,
                        ),
                         child:  Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Column(
                            children: [
                              Text("$ctemp°C",style: const TextStyle(fontSize: 40,
                              fontWeight: FontWeight.bold),),
                               const SizedBox(height:16),
                               
                               Icon(
                                csky == 'Clouds' || csky =='Rain'?

                                Icons.cloud:Icons.sunny,
                                size: 64,),
                              const SizedBox(height:16),
                         
                               Text(csky,style: const TextStyle(fontSize: 20 ),)
                            
                            ],
                            
                                           ),
                         ),
                       ),
                     ),
                      
                  ),
                ),
                const SizedBox(height: 16,),
                Container(
                
                  alignment: Alignment.centerLeft ,
                  child: const Text('Weather Forecast',
                  style: TextStyle(fontSize: 25,
                  fontWeight: FontWeight.bold,
                  ),),
                ),
               // const SizedBox(height:16),
                 // SingleChildScrollView(
                 // scrollDirection: Axis.horizontal,
                  // child: Row(
                  //  children: [  
                     // for(int i=0;i<5;i++) 
                       //  forecastcard(time:data1['list'][i+1]['dt'].toString(), iconn:Icons.cloud,temprature:301.7),

                   // ],
                            //   ),
                // ),
                 SizedBox(
                  height: 154,
                   child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder:(context,index){
                        final hourlyTime = DateTime.parse(data1['list'][index+1]['dt_txt']);
                        final hourlySky = data1['list'][index+1]['weather'][0]['main'];
                        double hourlytemp = data1['list'][index+1]['main']['temp']-273.15;
                        String temp = hourlytemp.toStringAsFixed(2);
                        hourlytemp = double.parse(temp);
                        return forecastcard(time: DateFormat.j().format(hourlyTime), iconn: hourlySky == 'Clouds' || hourlySky =='Rain'? Icons.cloud : Icons.sunny ,
                         temprature: hourlytemp);
                      }),
                 ),
                
                 const SizedBox(height: 16,),
                 Container(
                
                  alignment: Alignment.centerLeft ,
                  child: const Text('Additional Information',
                  style: TextStyle(fontSize: 25,
                  fontWeight: FontWeight.bold,
                  ),),
                ),
                const SizedBox(height: 16,),
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    Additionalitemfile(icon: Icons.water_drop_rounded,label: 'Humidity', data :chum, ),
                    Additionalitemfile(icon: Icons.air_sharp,label: 'Speed', data: cwindspeed, ),
                    Additionalitemfile(icon: Icons.beach_access_sharp,label: 'Pressure', data: cpress, ),
        
                ],
              ),
               
               
              ],
            ),
          ),
        );
      },
      ),
    
    );
  }
}
