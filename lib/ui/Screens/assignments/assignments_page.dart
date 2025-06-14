import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'assignment_details.dart';
import 'assignment_model.dart';

class AssignmentsListPage extends StatefulWidget {
  const AssignmentsListPage({super.key});

  @override
  State<AssignmentsListPage> createState() => _AssignmentsListPageState();
}

class _AssignmentsListPageState extends State<AssignmentsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Assignments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _addDummyAssignment();
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('assignments').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No assignments found.'));
          }

          final assignments = snapshot.data!.docs.map((doc) {
            return Assignment.fromFirestore(doc);
          }).toList();

          return ListView.builder(
            itemCount: assignments.length,
            itemBuilder: (context, index) {
              final assignment = assignments[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4,
                child: ListTile(
                  title: Text(assignment.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Doctor: ${assignment.doctorName}'),
                      Text('Expires: ${assignment.expireDate.toLocal().toString().split(' ')[0]}'),
                      if (assignment.achieveLink != null && assignment.achieveLink!.isNotEmpty)
                        Text('Achieved: ${assignment.achieveLink}', style: const TextStyle(color: Colors.green)),
                      if (assignment.achieveLink == null || assignment.achieveLink!.isEmpty)
                        const Text('Achieve link not added yet', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AssignmentDetailPage(
                          assignmentId: assignment.id,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _addDummyAssignment() async {
    final newAssignment = Assignment(
      id: '',
      title: 'Math Homework 1',
      description: 'Complete exercises 1-5 from Chapter 3.',
      doctorName: 'Dr. Ahmed',
      expireDate: DateTime.now().add(const Duration(days: 7)),
      achieveLink: null,
    );

    try {
      await FirebaseFirestore.instance.collection('assignments').add(newAssignment.toFirestore());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dummy assignment added!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add dummy assignment: $e')),
      );
    }
  }
}