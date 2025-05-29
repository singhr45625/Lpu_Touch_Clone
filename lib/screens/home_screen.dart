import 'package:flutter/material.dart';
import 'package:lputouchclone/screens/noti_screen.dart'; // Assuming NotiScreen is still used
import 'package:lputouchclone/shared/noti_icon.dart'; // Assuming NotiIcon is still used
import 'package:lputouchclone/shared/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // A list to hold the dynamically added tiles data.
  // Each element is a Map containing the title and icon data for a tile.
  final List<Map<String, dynamic>> _addedTilesData = [];

  // Define a list of available tiles that can be added to the dashboard.
  final List<Map<String, dynamic>> _availableTiles = [
    {'title': 'Academics', 'icon': Icons.school},
    {'title': 'Attendance', 'icon': Icons.calendar_today},
    {'title': 'Results', 'icon': Icons.grading},
    {'title': 'Fee Statement', 'icon': Icons.currency_rupee}, // Changed to match image
    {'title': 'Library', 'icon': Icons.local_library},
    {'title': 'Hostel', 'icon': Icons.bed},
    {'title': 'Announcements', 'icon': Icons.campaign}, // Matches "Announce" in image
    {'title': 'Events', 'icon': Icons.event},
    {'title': 'Transport', 'icon': Icons.directions_bus},
    {'title': 'Placements', 'icon': Icons.work},
    {'title': 'Mentoring', 'icon': Icons.people_alt},
    {'title': 'Assignment', 'icon': Icons.assignment}, // Added from image
    {'title': 'Exams', 'icon': Icons.edit_note}, // Added from image
    {'title': 'RMS Status', 'icon': Icons.calendar_month}, // Added from image
    {'title': '10 to Thrive', 'icon': Icons.rocket_launch}, // Added from image
    {'title': 'Student Support', 'icon': Icons.support_agent},
    {'title': 'Feedback', 'icon': Icons.feedback},
    {'title': 'Health & Wellness', 'icon': Icons.health_and_safety},
    {'title': 'Campus Jobs', 'icon': Icons.work_outline},
    {'title': 'Student ID', 'icon': Icons.badge},
    {'title': 'Course Enrollment', 'icon': Icons.assignment_turned_in},
    {'title': 'Certificates', 'icon': Icons.card_membership},
    {'title': 'Complaint Box', 'icon': Icons.bug_report},
    {'title': 'Lost & Found', 'icon': Icons.find_in_page},
  ];

  // This is the callback function used for both the drawer and the plus icon.
  // It's responsible for adding a new tile to the dashboard.
  void _addTileFromDrawer(String title, IconData icon) {
    if (!_addedTilesData.any((tile) => tile['title'] == title)) {
      setState(() {
        _addedTilesData.add({
          'title': title,
          'icon': icon,
          // You can also add a default value for the badge if needed, e.g., '0'
          'badgeValue': '0',
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('"$title" tile added! Long press to remove.'),
          duration: const Duration(seconds: 1),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('"$title" tile already exists on your dashboard!'),
          duration: const Duration(milliseconds: 800),
        ),
      );
    }
    Navigator.of(context).pop(); // Close current modal (drawer or bottom sheet)
  }

  // Function to remove a tile from the dashboard.
  void _removeTile(String titleToRemove) {
    setState(() {
      _addedTilesData.removeWhere((tile) => tile['title'] == titleToRemove);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"$titleToRemove" tile removed!'),
        duration: const Duration(milliseconds: 800),
      ),
    );
  }

  // Helper function to build a single dynamic tile widget, now matching the image's style.
  Widget _buildDynamicTile({
    required String title,
    required IconData icon,
    String? value, // This will be the badge content, e.g., '0', '70%', '20'
    VoidCallback? onTap,
    required VoidCallback onRemove, // Triggered by long press
  }) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onRemove, // Long press to trigger removal
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9), // Light cream background from image
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
          alignment: Alignment.center, // Center content by default
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShaderMask( // Apply gradient to the icon
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) {
                    // This gradient visually approximates the icon style in the image
                    return LinearGradient(
                      colors: [Colors.orange.shade300, Colors.deepOrange.shade700],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  child: Icon(
                    icon,
                    size: 45, // Larger icon as seen in the image
                  ),
                ),
                const SizedBox(height: 10), // Spacing between icon and text background
                Container( // Background for the text label
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade200, // Peach/light orange background for text
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 2, // Allow text to wrap to two lines
                    overflow: TextOverflow.ellipsis, // Show ellipsis if overflows
                    style: const TextStyle(
                      fontSize: 14, // Font size for the main title
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            // Top-right status/value badge, replicating the image
            if (value != null)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  // Ensure minimum size for the badge
                  constraints: const BoxConstraints(minWidth: 35, minHeight: 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.shade400, // Solid dark orange for badge
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12), // Matches tile's top-right corner
                      bottomLeft: Radius.circular(8), // Rounded bottom-left corner as in image
                    ),
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

  // Method to show a modal bottom sheet with options to add tiles.
  void _showAddTileOptions() { // <-- This method is defined here
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows content to control its height
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        // Filter out tiles that are already added to avoid showing duplicates
        final List<Map<String, dynamic>> filteredAvailableTiles = _availableTiles
            .where((availableTile) => !_addedTilesData
            .any((addedTile) => addedTile['title'] == availableTile['title']))
            .toList();

        // If no more tiles can be added, display a message.
        if (filteredAvailableTiles.isEmpty) {
          return Container(
            height: 150, // Fixed height if no options
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.info_outline, size: 40, color: Colors.grey),
                  const SizedBox(height: 10),
                  Text(
                    'All available tiles are already on your dashboard!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          );
        }

        // Otherwise, display the list of addable tiles.
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Make column only as tall as its children
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Add New Dashboard Tiles',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade700,
                    ),
                  ),
                ),
              ),
              Flexible( // Use Flexible to constrain ListView height in a Column
                child: ListView.builder(
                  shrinkWrap: true, // Important for ListView inside Column/Flexible
                  itemCount: filteredAvailableTiles.length,
                  itemBuilder: (context, index) {
                    final tileOption = filteredAvailableTiles[index];
                    return ListTile(
                      leading: Icon(tileOption['icon'], color: Colors.black54),
                      title: Text(
                        tileOption['title'],
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      onTap: () {
                        _addTileFromDrawer(tileOption['title'], tileOption['icon']);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
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
            leading: Builder(
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
                    Scaffold.of(context).openDrawer(); // Opens the custom app drawer
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
              NotiIcon(), // Your custom notification/cart icon widget
            ],
          ),
        ),
      ),
      drawer: MyAppDrawer(onItemSelect: _addTileFromDrawer),
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
                      onPressed: () {}, // Action for 'Your Dost' button
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
              // Timetable Container
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
              // Section to guide user to add/remove tiles
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Manage Dashboard Tiles', // Updated descriptive text
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Tap the plus icon to add.', // Updated hint
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Long press a tile to remove.', // Updated hint
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  // Plus icon button to open the modal bottom sheet for adding tiles.
                  IconButton(
                    onPressed: _showAddTileOptions, // Calls the new method
                    icon: const Icon(
                      Icons.add_circle_outlined,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Display dynamic tiles using GridView.
              // Shows a message if no tiles are added yet.
              _addedTilesData.isEmpty
                  ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Your dashboard is empty! Tap the plus icon above to add your first tile.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ),
              )
                  : GridView.builder(
                shrinkWrap: true, // Takes only the space it needs
                physics: const NeverScrollableScrollPhysics(), // Prevents GridView from scrolling independently
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 tiles per row
                  crossAxisSpacing: 10, // Horizontal space between tiles
                  mainAxisSpacing: 10, // Vertical space between tiles
                  childAspectRatio: 1.0, // Makes tiles square
                ),
                itemCount: _addedTilesData.length, // Number of tiles to display
                itemBuilder: (context, index) {
                  final tileData = _addedTilesData[index]; // Get data for the current tile
                  // Example dynamic value for the badge based on title, similar to the image
                  String badgeValue = '0'; // Default value
                  if (tileData['title'] == 'Attendance') {
                    badgeValue = '70%';
                  } else if (tileData['title'] == 'Assignment') {
                    badgeValue = '20';
                  } else if (tileData['title'] == 'Results') {
                    badgeValue = '8.26';
                  } else if (tileData['title'] == 'Exams') {
                    badgeValue = '3';
                  } else {
                    badgeValue = '0'; // Default for other tiles
                  }

                  return _buildDynamicTile(
                    title: tileData['title'],
                    icon: tileData['icon'],
                    value: badgeValue, // Pass the dynamic badge value
                    onTap: () {
                      print('${tileData['title']} tile tapped!');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('You tapped "${tileData['title']}"'),
                          duration: const Duration(milliseconds: 800),
                        ),
                      );
                      // You can add navigation or other actions here
                    },
                    onRemove: () {
                      // Action when the long press is detected on the tile
                      _removeTile(tileData['title']);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}