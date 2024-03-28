import 'package:flutter/material.dart';

class forecastcard extends StatelessWidget {
  final String time;
  final IconData iconn;
  final double temprature;
  const forecastcard({super.key,
  required this.time,
  required this.iconn,
  required this.temprature}
  );

  @override
  Widget build(BuildContext context) {
    return Card(
                        elevation: 4,
                        surfaceTintColor: Colors.blue[200],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        shadowColor: Colors.black87,
                        child:   Container(
                          width: 100,
                          padding: const EdgeInsets.all(18.0),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(14),
               
                          ),
                          child:  Column(children: [
                            Text(time , style: const  TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                            maxLines: 1,),
                            const SizedBox(height: 16,),
                            Icon(iconn,size: 32,),
                            const  SizedBox(height: 16,),
                            Text('$temprature °C',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold))
                            
                          ],),
                        ),
                      );
  }
}