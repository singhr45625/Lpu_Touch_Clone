import 'package:flutter/material.dart';
import 'package:lputouchclone/screens/noti_screen.dart';
import 'package:lputouchclone/shared/noti_icon.dart';
import 'package:lputouchclone/shared/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // State variable to keep track of the selected tab index
  int _selectedIndex = 0;

  // List of widgets to display for each tab in the bottom navigation bar
  // You can replace these with actual screens or content for each section
  static final List<Widget> _widgetOptions = <Widget>[
    // The current HomeScreen content will be the first tab (Dashboard)
    _DashboardContent(), // Encapsulate the existing HomeScreen body into a separate widget
    const Center(child: Text('Happenings Page', style: TextStyle(fontSize: 24))),
    const Center(child: Text('RMS Page', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Quick Quiz Page', style: TextStyle(fontSize: 24))),
  ];

  // Method to handle item taps on the bottom navigation bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Map<String, dynamic>> _addedTilesData = [];

  final List<Map<String, dynamic>> _availableTiles = [
    {'title': 'Academics', 'icon': Icons.school},
    {'title': 'Attendance', 'icon': Icons.calendar_today},
    {'title': 'Results', 'icon': Icons.grading},
    {'title': 'Fee Statement', 'icon': Icons.currency_rupee},
    {'title': 'Library', 'icon': Icons.local_library},
    {'title': 'Hostel', 'icon': Icons.bed},
    {'title': 'Announcements', 'icon': Icons.campaign},
    {'title': 'Events', 'icon': Icons.event},
    {'title': 'Transport', 'icon': Icons.directions_bus},
    {'title': 'Placements', 'icon': Icons.work},
    {'title': 'Mentoring', 'icon': Icons.people_alt},
    {'title': 'Assignment', 'icon': Icons.assignment},
    {'title': 'Exams', 'icon': Icons.edit_note},
    {'title': 'RMS Status', 'icon': Icons.calendar_month},
    {'title': '10 to Thrive', 'icon': Icons.rocket_launch},
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

  void _addTileFromDrawer(String title, IconData icon) {
    if (!_addedTilesData.any((tile) => tile['title'] == title)) {
      setState(() {
        _addedTilesData.add({
          'title': title,
          'icon': icon,
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

  Widget _buildDynamicTile({
    required String title,
    required IconData icon,
    String? value,
    VoidCallback? onTap,
    required VoidCallback onRemove,
  }) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onRemove,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
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
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [Colors.orange.shade300, Colors.deepOrange.shade700],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  child: Icon(
                    icon,
                    size: 45,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            if (value != null)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  constraints: const BoxConstraints(minWidth: 35, minHeight: 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.shade400,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(8),
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

  void _showAddTileOptions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        final List<Map<String, dynamic>> filteredAvailableTiles = _availableTiles
            .where((availableTile) => !_addedTilesData
            .any((addedTile) => addedTile['title'] == availableTile['title']))
            .toList();

        if (filteredAvailableTiles.isEmpty) {
          return Container(
            height: 150,
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

        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
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
                    child: const Icon(Icons.notes, size: 30),
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
            title: Text(
              _selectedIndex == 0 ? 'Dashboard' : ['Happenings', 'RMS', 'Quick Quiz'][_selectedIndex - 1],
              style: const TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            actions: [
              NotiIcon(),
            ],
          ),
        ),
      ),
      drawer: MyAppDrawer(onItemSelect: _addTileFromDrawer),
      body: _widgetOptions.elementAt(_selectedIndex), // Display the selected page content
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: _selectedIndex == 0 ? [Colors.orange, Colors.deepOrange] : [Colors.grey, Colors.grey],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: const Icon(Icons.dashboard),
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: _selectedIndex == 1 ? [Colors.orange, Colors.deepOrange] : [Colors.grey, Colors.grey],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: const Icon(Icons.article), // Icon for Happenings
            ),
            label: 'Happenings',
          ),
          BottomNavigationBarItem(
            icon: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: _selectedIndex == 2 ? [Colors.orange, Colors.deepOrange] : [Colors.grey, Colors.grey],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: const Icon(Icons.receipt), // Icon for RMS
            ),
            label: 'RMS',
          ),
          BottomNavigationBarItem(
            icon: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: _selectedIndex == 3 ? [Colors.orange, Colors.deepOrange] : [Colors.grey, Colors.grey],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: const Icon(Icons.quiz), // Icon for Quick Quiz
            ),
            label: 'Quick Quiz',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrange, // Color for the selected item's label
        unselectedItemColor: Colors.grey, // Color for unselected item's label
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Ensures all items are visible
      ),
    );
  }
}

// A separate widget to hold the original Dashboard content
class _DashboardContent extends StatefulWidget {
  const _DashboardContent({Key? key}) : super(key: key);

  @override
  State<_DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<_DashboardContent> {
  final List<Map<String, dynamic>> _addedTilesData = [];

  final List<Map<String, dynamic>> _availableTiles = [
    {'title': 'Academics', 'icon': Icons.school},
    {'title': 'Attendance', 'icon': Icons.calendar_today},
    {'title': 'Results', 'icon': Icons.grading},
    {'title': 'Fee Statement', 'icon': Icons.currency_rupee},
    {'title': 'Library', 'icon': Icons.local_library},
    {'title': 'Hostel', 'icon': Icons.bed},
    {'title': 'Announcements', 'icon': Icons.campaign},
    {'title': 'Events', 'icon': Icons.event},
    {'title': 'Transport', 'icon': Icons.directions_bus},
    {'title': 'Placements', 'icon': Icons.work},
    {'title': 'Mentoring', 'icon': Icons.people_alt},
    {'title': 'Assignment', 'icon': Icons.assignment},
    {'title': 'Exams', 'icon': Icons.edit_note},
    {'title': 'RMS Status', 'icon': Icons.calendar_month},
    {'title': '10 to Thrive', 'icon': Icons.rocket_launch},
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

  void _addTileFromDrawer(String title, IconData icon) {
    if (!_addedTilesData.any((tile) => tile['title'] == title)) {
      setState(() {
        _addedTilesData.add({
          'title': title,
          'icon': icon,
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
    Navigator.of(context).pop();
  }

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

  Widget _buildDynamicTile({
    required String title,
    required IconData icon,
    String? value,
    VoidCallback? onTap,
    required VoidCallback onRemove,
  }) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onRemove,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
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
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [Colors.orange.shade300, Colors.deepOrange.shade700],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  child: Icon(
                    icon,
                    size: 45,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            if (value != null)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  constraints: const BoxConstraints(minWidth: 35, minHeight: 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.shade400,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(8),
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

  void _showAddTileOptions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        final List<Map<String, dynamic>> filteredAvailableTiles = _availableTiles
            .where((availableTile) => !_addedTilesData
            .any((addedTile) => addedTile['title'] == availableTile['title']))
            .toList();

        if (filteredAvailableTiles.isEmpty) {
          return Container(
            height: 150,
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

        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
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
    return SingleChildScrollView(
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
                      'Tap the plus icon to add.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Long press a tile to remove.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                IconButton(
                  onPressed: _showAddTileOptions,
                  icon: const Icon(
                    Icons.add_circle_outlined,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
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
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.0,
              ),
              itemCount: _addedTilesData.length,
              itemBuilder: (context, index) {
                final tileData = _addedTilesData[index];
                String badgeValue = '0';
                if (tileData['title'] == 'Attendance') {
                  badgeValue = '70%';
                } else if (tileData['title'] == 'Assignment') {
                  badgeValue = '20';
                } else if (tileData['title'] == 'Results') {
                  badgeValue = '8.26';
                } else if (tileData['title'] == 'Exams') {
                  badgeValue = '3';
                } else {
                  badgeValue = '0';
                }

                return _buildDynamicTile(
                  title: tileData['title'],
                  icon: tileData['icon'],
                  value: badgeValue,
                  onTap: () {
                    print('${tileData['title']} tile tapped!');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('You tapped "${tileData['title']}"'),
                        duration: const Duration(milliseconds: 800),
                      ),
                    );
                  },
                  onRemove: () {
                    _removeTile(tileData['title']);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
