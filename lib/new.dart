import 'dart:math';

import 'package:minions/cont.dart';



int generateRandomWeight(int data) {
  List<int> validWeights = [20, 30, 40, 50, 60];
  return validWeights[data];
}

List<Map<String, dynamic>> mapmaker(String source,String dest,String time) {
  int s=0;
  int d=9;
  for(int i=0;i<touristPlacesInKozhikode.length;i++){
    if(source==touristPlacesInKozhikode[i]){
      s=i;
    }else if(dest==touristPlacesInKozhikode[i]){
      d=i;
    }else{
      print("Place not found");
    }
  }
  
  int numNodes = touristPlacesInKozhikode.length;
  List<List<int>> adjMatrixspeed = List.generate(numNodes, (_) => List.filled(numNodes, 0));
  List<List<int>> adjMatrixdistance = List.generate(numNodes, (_) => List.filled(numNodes, 0));

  Random random = Random();
  int distance;
  for (int i = 0; i < numNodes; i++) {
    for (int j = i + 1; j < numNodes; j++) {
      if (random.nextBool()) {
        distance=random.nextInt(100);
        adjMatrixdistance[i][j] = distance;
        adjMatrixdistance[j][i] = distance;

        int weight = generateRandomWeight((i+j)%5);
        adjMatrixspeed[i][j] = weight;
        adjMatrixspeed[j][i] = weight;
      }
    }
  }

  print("Speed Matrix:");
  printAdjacencyMatrix(adjMatrixspeed);
  
  print("\nDistance Matrix:");
  printAdjacencyMatrix(adjMatrixdistance);

  print("\nTime Matrix:");
  List<List<int>> timeMatrix = time_find(adjMatrixdistance, adjMatrixspeed, numNodes);
  printAdjacencyMatrix(timeMatrix);

  print("\nDFS Paths:");
  List<List<int>> adjList = convertToAdjList(timeMatrix);
  Graph graph = Graph(numNodes, adjList, int.parse(time), timeMatrix);  

  List<List<int>> paths = graph.getAllPaths(s, d);
  int j = paths.length;
  print(j);
  print("All paths from $s to $d:");
    print(paths.length);
 int largestSize = 0;
  List<List<int>> largestLists = [];
  for (var path in paths) {
    if (path.length > largestSize) {
      largestSize = path.length;
      largestLists = [path];
    } else if (path.length == largestSize) {
      largestLists.add(path);
    }
  }

  // Convert largest paths to place names and calculate total time
  List<Map<String, dynamic>> results = [];
  for (var path in largestLists) {
    List<String> placeNames = path.map((node) => touristPlacesInKozhikode[node]).toList();
    int ttime = 0;
    for (int i = 0; i < path.length - 1; i++) {
      int a = path[i];
      int b = path[i + 1];
      ttime += timeMatrix[a][b];
    }
    results.add({
      'path': placeNames,
      'time': ttime,
    });
  }

  return results;
}

void printAdjacencyMatrix(List<List<int>> adjMatrix) {
  for (var row in adjMatrix) {
    print(row.map((e) => e.toString()).join(' '));
  }
}

List<List<int>> time_find(List<List<int>> dist, List<List<int>> spe, int numNodes) {
  List<List<int>> adjtime = List.generate(numNodes, (_) => List.filled(numNodes, 0));

  for (int i = 0; i < numNodes; i++) {
    for (int j = 0; j < numNodes; j++) {
      if (spe[i][j] != 0) {
        double value = (dist[i][j] * 60) / spe[i][j];
        adjtime[i][j] = value.floor();
      } else {
        adjtime[i][j] = 0; // No speed, set time as 0
      }
    }
  }
  return adjtime;
}

List<List<int>> convertToAdjList(List<List<int>> adjMatrix) {
  int numNodes = adjMatrix.length;
  List<List<int>> adjList = List.generate(numNodes, (_) => []);

  for (int i = 0; i < numNodes; i++) {
    for (int j = 0; j < numNodes; j++) {
      if (adjMatrix[i][j] > 0) {
        adjList[i].add(j);
      }
    }
  }

  return adjList;
}

class Graph {
  final int vertices;
  List<List<int>> adjList;
  final int time;
  List<List<int>> timeMatrix; // Add the timeMatrix
  Graph(this.vertices, this.adjList, this.time, this.timeMatrix);

  /// Returns all paths from `start` to `end` as a list of lists.
  List<List<int>> getAllPaths(int start, int end) {
    List<bool> visited = List.filled(vertices, false);
    List<int> path = [];
    List<List<int>> allPaths = [];
    _getAllPathsUtil(start, end, visited, path, allPaths, 0);
    return allPaths;
  }

  /// Helper function to recursively find all paths.
  void _getAllPathsUtil(int start, int end, List<bool> visited, List<int> path, List<List<int>> allPaths, int currentTime) {
    visited[start] = true;
    path.add(start);

    // If we exceed the allowed time, terminate this path search
    if (currentTime > time) {
      path.removeLast();
      visited[start] = false;
      return;
    }

    if (start == end) {
      allPaths.add(List.from(path)); // Add a copy of the current path
    } else {
      for (int neighbor in adjList[start]) {
        if (!visited[neighbor]) {
          // Calculate the time to the neighbor using timeMatrix
          int travelTime = timeMatrix[start][neighbor];
          _getAllPathsUtil(neighbor, end, visited, path, allPaths, currentTime + travelTime);
        }
      }
    }

    path.removeLast();
    visited[start] = false;
  }
}
