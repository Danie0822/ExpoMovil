import 'package:flutter/material.dart';

class CardviewScreen extends StatelessWidget {
  final String companyName; 
  final String JobTItle; 
  final String Logo; 
  final String hour; 
   
  const CardviewScreen({Key? key, required this.companyName, required this.hour, required this.JobTItle, required this.Logo}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
        width: 200,
        color: Colors.grey[200],
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 60,
                  child: Image.asset(Logo),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child:   Container(
                    padding: const EdgeInsets.all(8),
                    child:  Text(companyName, style: TextStyle(color: Colors.white)), color: Colors.grey[500]),
                
                ),
              ],
            ), 
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(JobTItle, style: const TextStyle(
                fontSize: 17, 
                fontWeight: FontWeight.bold
              ),),
            ), 
            Text(hour), 
            
             
           ],
        )),
      ),
    );
  }
}