import 'package:flutter/material.dart';

class MyAppDrawer extends StatelessWidget {
  // Define the callback function type
  final Function(String title, IconData icon) onItemSelect;

  // Constructor to receive the callback
  const MyAppDrawer({super.key, required this.onItemSelect});

  // Helper method to build consistent Drawer ListTiles
  Widget _buildDrawerItem(BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        // Call the onItemSelect callback when a drawer item is tapped
        // Pass the title and icon of the selected item
        onItemSelect(title, icon);
        // We don't need to pop the drawer here, as HomeScreen will do it
        // after processing the selection.
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 40.0, bottom: 20.0, left: 100.0, right: 90.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange.shade700, Colors.deepOrange.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    image: const DecorationImage(
                      image: NetworkImage('https://static.vecteezy.com/system/resources/thumbnails/033/837/660/small/happy-school-pupil-asian-boy-in-glasses-on-isolated-on-studio-background-with-copy-space-back-to-school-ai-generative-photo.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Rohan Singh',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '12320/54',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const Text(
                  'P124:BCA(2023)',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                // Now, when building the drawer item, we don't pass the local onTap,
                // but rely on the _buildDrawerItem's internal logic to call onItemSelect.
                _buildDrawerItem(context, Icons.bar_chart, '10 to Thrive'),
                _buildDrawerItem(context, Icons.people_alt, 'Alumni Mentor Selection'),
                _buildDrawerItem(context, Icons.assignment, 'Assignment (CA)'),
                _buildDrawerItem(context, Icons.lightbulb_outline, 'Back to Basics'),
                _buildDrawerItem(context, Icons.book_online, 'Book Appointment'),
                _buildDrawerItem(context, Icons.tour, 'Campus Tour'),
                _buildDrawerItem(context, Icons.assignment_turned_in, 'Continue Exit Undertaking'),
                _buildDrawerItem(context, Icons.medical_services, 'Doctor Appointment'),
                _buildDrawerItem(context, Icons.upload_file, 'Document Upload'),
                _buildDrawerItem(context, Icons.how_to_vote, 'Electives Registration'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                // Keep the logout logic here
                Navigator.pop(context); // Close the drawer
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logout button tapped!')));
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange.shade700, Colors.amber],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'LOGOUT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}