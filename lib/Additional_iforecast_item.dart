import 'package:flutter/material.dart';
class Additionalitemfile extends StatelessWidget {
  final IconData icon;
  final String label ;

  final num  data ;

  const Additionalitemfile({super.key,
  required this.icon,
  required this.label,
  required this.data 


  });

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 4,
                        surfaceTintColor: Colors.blue[200],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        shadowColor: Colors.black87,
      
      
      child:  Container(
        width: 100,
                          padding: const EdgeInsets.all(18.0),
                          
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(14),),
        
        child: Column(
          
          children: [
            Icon(icon,
            size: 32,),
            const SizedBox(height:12),
            Text(label),
        
           const  SizedBox(height: 12,),
            Text('$data ',
            style: const TextStyle(fontSize:18,fontWeight: 
            FontWeight.bold),)
        
        
          ],
        
        ),
      )
    );
  }
}