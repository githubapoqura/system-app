import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'assignment_model.dart';

class AssignmentDetailPage extends StatefulWidget {
  final String assignmentId;

  const AssignmentDetailPage({super.key, required this.assignmentId});

  @override
  State<AssignmentDetailPage> createState() => _AssignmentDetailPageState();
}

class _AssignmentDetailPageState extends State<AssignmentDetailPage> {
  final TextEditingController _achieveLinkController = TextEditingController();
  late Future<Assignment> _assignmentFuture;
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
    if (_currentUser == null) {
      print("Error: User not logged in on detail page.");
    } else {
      _assignmentFuture = _fetchAssignmentDetails();
    }
  }

  Future<Assignment> _fetchAssignmentDetails() async {
    if (_currentUser == null) {
      throw Exception("User not logged in to fetch assignment details.");
    }
    final docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUser!.uid)
        .collection('assignments')
        .doc(widget.assignmentId)
        .get();

    if (!docSnapshot.exists) {
      throw Exception('Assignment not found!');
    }

    final assignment = Assignment.fromFirestore(docSnapshot);
    _achieveLinkController.text = assignment.achieveLink ?? '';
    return assignment;
  }

  Future<void> _updateAchieveLink() async {
    if (_currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please sign in to update achievement link.')),
      );
      return;
    }
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser!.uid)
          .collection('assignments')
          .doc(widget.assignmentId)
          .update({
        'achieveLink': _achieveLinkController.text.trim(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Achieve link updated successfully!')),
      );
      setState(() {
        _assignmentFuture = _fetchAssignmentDetails();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update link: $e')),
      );
    }
  }

  @override
  void dispose() {
    _achieveLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser == null) {
      return  Scaffold(
        appBar: AppBar(title: Text('Assignment Details')),
        body: Center(child: Text('User not logged in.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignment Details'),
      ),
      body: FutureBuilder<Assignment>(
        future: _assignmentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final assignment = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  assignment.title,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Doctor: ${assignment.doctorName}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  'Expires on: ${assignment.expireDate.toLocal().toString().split(' ')[0]}',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Description:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  assignment.description,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Achieve Link:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _achieveLinkController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your achievement link here',
                    border: OutlineInputBorder(),
                    hintText: 'e.g., https://drive.google.com/your-assignment',
                  ),
                  keyboardType: TextInputType.url,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _updateAchieveLink,
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Save Achievement Link'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                if (assignment.achieveLink != null && assignment.achieveLink!.isNotEmpty && _achieveLinkController.text != assignment.achieveLink)
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Current Saved Link: ${assignment.achieveLink}',
                      style: const TextStyle(color: Colors.blueGrey),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}