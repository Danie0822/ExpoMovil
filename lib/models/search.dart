import 'package:flutter/material.dart';
// diseño de text field de Buscador
class SearchScreen extends StatelessWidget {
   
  const SearchScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(
            children: [
              // diseño pro de buscador 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Container(
                      height: 30,
                      child: Image.asset(
                        'assets/icons/lupa.png',
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                  child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search for job'))),
                          const SizedBox(width: 10),
                          
              
            ],
          );
  }
}

