import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/doctor_model.dart';
import 'doctor_card.dart';

class DoctorsList extends StatelessWidget {
  final String specialty;

  const DoctorsList({
    Key? key,
    required this.specialty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('doctors')
          .where('specialty', isEqualTo: specialty)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No doctors found'));
        }

        final doctors = snapshot.data!.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Doctor.fromMap({
            'id': doc.id,
            ...data,
          });
        }).toList();

        return SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              return DoctorCard(doctor: doctors[index]);
            },
          ),
        );
      },
    );
  }
} 