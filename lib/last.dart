import 'package:flutter/material.dart';
import 'package:minions/new.dart';

class PathScreen extends StatefulWidget {
  const PathScreen({required this.source, required this.dest,required this.time});
  @override
  State<PathScreen> createState() => _PathScreenState();
  final String source;
  final String dest;
  final String time;
}

class _PathScreenState extends State<PathScreen> {
  // Sample data for testing
   late List<Map<String, dynamic>> paths;
    @override
  void initState() {
    super.initState();
    // Initialize the paths by calling the mapmaker function
    paths = mapmaker(widget.source, widget.dest, widget.time);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tourist Path Finder',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 112, 151, 190),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color.fromARGB(255, 255, 255, 255), const Color.fromARGB(255, 137, 163, 167)],
          ),
        ),
        child: ListView.builder(
          itemCount: paths.length,
          itemBuilder: (context, index) {
            final path = paths[index]['path'] as List<String>;
            final time = paths[index]['time'];

            return Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [const Color.fromARGB(255, 212, 202, 188), const Color.fromARGB(255, 88, 120, 120)],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Path ${index + 1}",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Stops:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    ...path.map(
                      (place) => Text(
                        "• $place",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Time:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "$time minutes",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
