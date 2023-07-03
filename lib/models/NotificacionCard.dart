import 'package:flutter/material.dart';

class NotificacionScreen extends StatelessWidget {
  final String companyName; 
  final String JobTItle; 
  final String Logo; 
  final Color color; 
  final String hour; 
   
   
  const NotificacionScreen({Key? key, required this.companyName, required this.JobTItle, required this.Logo, required this.hour, required this.color}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.grey[100], 
      border: Border.all(color: Colors.white), 
      borderRadius: BorderRadius.circular(8)
      ),
       child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      Row(children: [
                      ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 50,
              padding:const EdgeInsets.all(12),
              color: Colors.grey[300],
              child: Image.asset(Logo),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(JobTItle,style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), 
              const SizedBox(height: 4),
              Text(companyName, style: TextStyle(
                color: Colors.grey[600]
              ),),
        ],
       ), 
      ]),
       ClipRRect(
         borderRadius: BorderRadius.circular(8),
         child: Container(
          padding: const EdgeInsets.all(5),
          color: Colors.blue,
          child: Text(hour, style: const TextStyle(color: Colors.white),)),
       )
        ],
       ),
    
      ),
    );
  }
}