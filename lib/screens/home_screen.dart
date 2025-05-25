import 'package:flutter/material.dart';
import 'package:lputouchclone/screens/noti_screen.dart';
import 'package:lputouchclone/shared/noti_icon.dart';
import 'package:lputouchclone/shared/app_drawer.dart'; // <<< --- NEW IMPORT --- >>>

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // A list to hold the dynamically added tiles
  final List<Widget> _addedTiles = [];

  // Function to add a new tile
  void _addTile() {
    setState(() {
      final int newTileIndex = _addedTiles.length + 1;
      _addedTiles.add(
        _buildDynamicTile(
          title: 'Tile $newTileIndex',
          icon: Icons.dashboard, // Example icon
          value: '${newTileIndex * 10}', // Example value
          onTap: () {
            // This is the onTap callback for each dynamic tile
            print('Tile $newTileIndex tapped!');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('You tapped Tile $newTileIndex'),
                duration: const Duration(milliseconds: 800),
              ),
            );
          },
        ),
      );
    });
  }

  // Helper function to build a single dynamic tile
  Widget _buildDynamicTile({
    required String title,
    required IconData icon,
    String? value,
    VoidCallback? onTap, // Added onTap callback
  }) {
    return GestureDetector( // Use GestureDetector for click functionality
      onTap: onTap, // Assign the onTap callback
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6.0,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 40,
                    color: Colors.orange.shade700,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            if (value != null)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade700,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 4.0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Builder( // Use Builder to get a context that can find the Scaffold
              builder: (BuildContext context) {
                return IconButton(
                  icon: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [Colors.orange, Colors.amber],
                      ).createShader(bounds);
                    },
                    child: const Icon(Icons.menu, size: 30),
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer(); // Open the drawer
                  },
                );
              },
            ),
            title: const Text(
              'Dashboard',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            actions: [
              CartIcon(), // Assuming NotiIcon is now CartIcon
            ],
          ),
        ),
      ),
      drawer: const MyAppDrawer(), // <<< --- USING THE SEPARATE DRAWER WIDGET --- >>>
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Today's Timetable",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.orange.shade700, Colors.amber],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Your Dost',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'No Timetable Available',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add More Tiles',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Click on the plus button to add one more grid',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: _addTile,
                    icon: const Icon(
                      Icons.add_circle_outlined,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.0,
                ),
                itemCount: _addedTiles.length,
                itemBuilder: (context, index) {
                  return _addedTiles[index];
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}