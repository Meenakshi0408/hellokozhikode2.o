import 'package:flutter/material.dart';
import 'package:minions/cont.dart';
import 'package:minions/main.dart';
class TouristPlacesScreen extends StatefulWidget {
  @override
  State<TouristPlacesScreen> createState() => _TouristPlacesScreenState();
}

class _TouristPlacesScreenState extends State<TouristPlacesScreen> {
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Tourist Places in Kozhikode"),
            SizedBox(width: 10,),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context){
                    return Home();
                  })
                );
              },
              child: Icon(Icons.arrow_forward)),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade100, Colors.teal.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: touristPlacesInKozhikode.length,
          itemBuilder: (context, index) {
            return TouristPlaceCard(placeName: touristPlacesInKozhikode[index]);
          },
        ),
      ),
    );
  }
}

class TouristPlaceCard extends StatelessWidget {
  final String placeName;

  const TouristPlaceCard({required this.placeName});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [Colors.teal.shade300, Colors.teal.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.place,
              size: 40,
              color: Colors.white,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                placeName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
