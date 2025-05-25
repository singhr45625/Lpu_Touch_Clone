import 'package:flutter/material.dart';

class MyAppDrawer extends StatelessWidget {
  const MyAppDrawer({super.key});

  // Helper method to build consistent Drawer ListTiles
  Widget _buildDrawerItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54), // Adjust icon color as per screenshot
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black87, // Adjust text color as per screenshot
          fontSize: 16,
          fontWeight: FontWeight.w500, // Adjust font weight as per screenshot
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // The background color of the drawer itself
      backgroundColor: Colors.white,
      child: Column( // Use a Column to place the header/search, list, and logout button
        children: <Widget>[
          // Custom Drawer Header (matches the orange/peach background with rounded corners)
          Container(
            // Adjusted padding to match visual spacing in screenshot
            padding: const EdgeInsets.only(top: 40.0, bottom: 20.0, left: 100.0, right: 90.0),
            decoration: BoxDecoration(
              // Added LinearGradient as requested
              gradient: LinearGradient(
                colors: [Colors.orange.shade700, Colors.deepOrange.shade400], // Colors matching screenshot
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10), // Rounded bottom corners for the header
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Picture (CircleAvatar with placeholder image)
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2), // White border
                    image: const DecorationImage(
                      // IMPORTANT: Replace this NetworkImage with your actual user image source (AssetImage or NetworkImage)
                      image: NetworkImage('https://static.vecteezy.com/system/resources/thumbnails/033/837/660/small/happy-school-pupil-asian-boy-in-glasses-on-isolated-on-studio-background-with-copy-space-back-to-school-ai-generative-photo.jpeg'), // Placeholder image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 12), // Spacing below picture
                // User Name
                const Text(
                  'Rohan Singh', // Replace with dynamic user name
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4), // Spacing between name and ID
                // User ID and details
                const Text(
                  '12320/54', // Replace with dynamic user ID
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const Text(
                  'P124:BCA(2023)', // Replace with dynamic user details
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0), // Padding around the search bar
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200], // Light grey background as in screenshot
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search, color: Colors.grey), // Search icon
                  border: InputBorder.none, // Remove default underline for clean look
                  contentPadding: EdgeInsets.symmetric(vertical: 12), // Vertical alignment of text
                ),
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          // List of Menu Items (Expanded to take available space and allow scrolling)
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero, // Removes default top/bottom padding from ListView
              children: <Widget>[
                // Use the helper method for each menu item
                _buildDrawerItem(context, Icons.bar_chart, '10 to Thrive', () {
                  Navigator.pop(context); // Closes the drawer
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('10 to Thrive tapped!')));
                  // Add your navigation or function call here
                }),
                _buildDrawerItem(context, Icons.people_alt, 'Alumni Mentor Selection', () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Alumni Mentor Selection tapped!')));
                }),
                _buildDrawerItem(context, Icons.assignment, 'Assignment (CA)', () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Assignment (CA) tapped!')));
                }),
                _buildDrawerItem(context, Icons.lightbulb_outline, 'Back to Basics', () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Back to Basics tapped!')));
                }),
                _buildDrawerItem(context, Icons.book_online, 'Book Appointment', () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Book Appointment tapped!')));
                }),
                _buildDrawerItem(context, Icons.tour, 'Campus Tour', () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Campus Tour tapped!')));
                }),
                _buildDrawerItem(context, Icons.assignment_turned_in, 'Continue Exit Undertaking', () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Continue Exit Undertaking tapped!')));
                }),
                _buildDrawerItem(context, Icons.medical_services, 'Doctor Appointment', () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Doctor Appointment tapped!')));
                }),
                _buildDrawerItem(context, Icons.upload_file, 'Document Upload', () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Document Upload tapped!')));
                }),
                _buildDrawerItem(context, Icons.how_to_vote, 'Electives Registration', () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Electives Registration tapped!')));
                }),
                // Add any other menu items from your app here
              ],
            ),
          ),
          // Logout Button at the bottom with gradient background
          Padding(
            padding: const EdgeInsets.all(16.0), // Padding around the button
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // Close the drawer before logging out
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logout button tapped!')));
                // IMPORTANT: Implement your actual logout logic here (e.g., clear user session, navigate to login screen)
              },
              child: Container(
                height: 50, // Fixed height for the button
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange.shade700, Colors.amber], // Gradient colors matching screenshot
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Center the text and icon
                  children: [
                    Text(
                      'LOGOUT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5, // Spacing between letters as seen in screenshot
                      ),
                    ),
                    SizedBox(width: 8), // Spacing between text and icon
                    Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18), // Arrow icon
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10), // Small padding below the logout button for visual spacing
        ],
      ),
    );
  }
}
