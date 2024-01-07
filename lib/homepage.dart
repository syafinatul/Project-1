import 'package:flutter/material.dart';
import 'upcoming_task.dart';

void main() => runApp(UniversityHomePage());

class UniversityHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'To-Do-List',
            style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold // Set text weight to bold
                ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 193, 126, 133),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/homepage.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          fit: StackFit
              .expand, // Make the stack children expand to fill the container
          children: <Widget>[
            // Positioned widget to display the message at the top
            Positioned(
              top: 25.0,
              left: 16.0,
              right: 16.0,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'IT TAKES GOOD EFFORT TO BEGIN AND A GREAT EFFORT TO COMPLETE A TASK',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 4.0,
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Positioned widget to place the button at the bottom
            Positioned(
              bottom: 105.0,
              left: 16.0,
              right: 16.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpcomingTaskScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'My Task',
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 4.0,
                  primary: const Color.fromARGB(255, 211, 131, 106),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
