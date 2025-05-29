import 'package:flutter/material.dart';

// A simple data model for a notification
class Notification {
  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  bool isRead;

  Notification({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    this.isRead = false,
  });
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Mock data for notifications about universities
  // In a real application, this data would come from a backend service
  final List<Notification> _notifications = [
    Notification(
      id: '1',
      title: 'Admission Application Open',
      body: 'Applications for Fall 2025 admissions are now open at XYZ University. Apply soon! Don\'t miss out on this opportunity to join a vibrant academic community and kickstart your career.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      isRead: false,
    ),
    Notification(
      id: '2',
      title: 'Scholarship Deadline Approaching',
      body: 'Reminder: The deadline for the Academic Excellence Scholarship at ABC College is June 15th. Ensure all your documents are submitted by the due date to be considered for this prestigious award.',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
    ),
    Notification(
      id: '3',
      title: 'Campus Tour Scheduled',
      body: 'Your virtual campus tour for State University is scheduled for tomorrow at 10:00 AM IST. Please log in 5 minutes early to ensure a smooth connection and enjoy the immersive experience.',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
    ),
    Notification(
      id: '4',
      title: 'Course Registration Begins',
      body: 'Undergraduate course registration for the next semester at Global Tech Institute starts on July 1st. Be sure to check the course catalog and plan your schedule in advance to secure your preferred classes.',
      timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 5)),
      isRead: true,
    ),
    Notification(
      id: '5',
      title: 'New Research Opportunity',
      body: 'A new research assistant position is available in the Computer Science department at Elite University. This is a fantastic chance to work on cutting-edge projects and contribute to significant advancements in the field.',
      timestamp: DateTime.now().subtract(const Duration(days: 3, minutes: 30)),
      isRead: false,
    ),
    Notification(
      id: '6',
      title: 'Alumni Event Invitation',
      body: 'You\'re invited to the annual alumni networking event hosted by City College on August 10th. Connect with fellow graduates, expand your professional network, and reminisce about your university days.',
      timestamp: DateTime.now().subtract(const Duration(days: 4)),
      isRead: false,
    ),
    Notification(
      id: '7',
      title: 'Faculty Lecture Series',
      body: 'Join Professor Anya Sharma for her lecture on "Future of AI" at National University Auditorium next Friday. This insightful session will cover the latest trends and ethical considerations in artificial intelligence.',
      timestamp: DateTime.now().subtract(const Duration(days: 5, hours: 12)),
      isRead: true,
    ),
  ];

  // State variable to keep track of the ID of the currently expanded notification
  String? _expandedNotificationId;

  // Function to mark a notification as read
  void _markAsRead(String id) {
    setState(() {
      final index = _notifications.indexWhere((notification) => notification.id == id);
      if (index != -1) {
        _notifications[index].isRead = true;
      }
    });
  }

  // Function to delete a notification
  void _deleteNotification(String id) {
    setState(() {
      _notifications.removeWhere((notification) => notification.id == id);
    });
  }

  // Function to toggle the expanded state of a notification
  void _toggleExpansion(String id) {
    setState(() {
      if (_expandedNotificationId == id) {
        _expandedNotificationId = null; // Collapse if already expanded
      } else {
        _expandedNotificationId = id; // Expand the tapped notification
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        // Use flexibleSpace to apply a gradient background to the AppBar
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.shade300, Colors.deepOrange.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        foregroundColor: Colors.white, // Text color for the title
      ),
      body: _notifications.isEmpty
          ? const Center(
        child: Text(
          'No new notifications.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          final isExpanded = _expandedNotificationId == notification.id;

          return Dismissible(
            key: Key(notification.id), // Unique key for Dismissible
            direction: DismissDirection.endToStart, // Swipe from right to left
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              _deleteNotification(notification.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Notification "${notification.title}" dismissed'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              elevation: notification.isRead ? 0.5 : 2.0, // Less elevation for read notifications
              color: notification.isRead ? Colors.grey[100] : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                  color: notification.isRead ? Colors.grey[300]! : Colors.deepOrange.withOpacity(0.5), // Adjusted border color
                  width: 1.0,
                ),
              ),
              child: ListTile(
                leading: Icon(
                  notification.isRead ? Icons.notifications_none : Icons.notifications_active,
                  color: notification.isRead ? Colors.grey : Colors.deepOrange, // Adjusted icon color
                ),
                title: Text(
                  notification.title,
                  style: TextStyle(
                    fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                    color: notification.isRead ? Colors.grey[700] : Colors.black87,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      notification.body,
                      maxLines: isExpanded ? null : 2, // Expand or collapse based on state
                      overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                      style: TextStyle(
                        color: notification.isRead ? Colors.grey[600] : Colors.black54,
                      ),
                    ),
                    if (!isExpanded && notification.body.length > 100) // Show "Read more" if truncated
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          'Tap to read more...',
                          style: TextStyle(
                            color: Colors.orange.shade700, // Changed color to orange.shade700
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    const SizedBox(height: 4),
                    Text(
                      '${notification.timestamp.day}/${notification.timestamp.month} ${notification.timestamp.hour}:${notification.timestamp.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        fontSize: 12,
                        color: notification.isRead ? Colors.grey[500] : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                trailing: notification.isRead
                    ? null // No trailing icon if read
                    : IconButton(
                  icon: const Icon(Icons.check_circle_outline, color: Colors.green),
                  onPressed: () {
                    _markAsRead(notification.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Marked "${notification.title}" as read'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
                onTap: () {
                  // Handle tapping on a notification to toggle expansion
                  if (!notification.isRead) {
                    _markAsRead(notification.id);
                  }
                  _toggleExpansion(notification.id);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
