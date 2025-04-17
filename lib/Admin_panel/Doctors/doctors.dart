import 'package:flutter/material.dart';
import 'package:petmate/background.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petmate/Services/firestore_services.dart';

class Doctors extends StatefulWidget {
  const Doctors({super.key});

  @override
  State<Doctors> createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  final List<String> specialties = [
    'Nutritionist',
    'Pathologist',
    'Dermatologist',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctors"),
        centerTitle: true,
      ),
      body: backGround(
        child: Container(
          child: ListView.builder(
            itemCount: specialties.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        specialties[index],
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirestoreServices.getDoctors(specialties[index]),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text('No doctors available in this specialty'),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, docIndex) {
                            var doctor = snapshot.data!.docs[docIndex];
                            Map<String, dynamic> doctorData = doctor.data() as Map<String, dynamic>;

                            return Card(
                              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: doctorData.containsKey('profileImageUrl') &&
                                                 doctorData['profileImageUrl'] != null &&
                                                 doctorData['profileImageUrl'].toString().isNotEmpty
                                      ? NetworkImage(doctorData['profileImageUrl'].toString())
                                      : null,
                                  child: !doctorData.containsKey('profileImageUrl') ||
                                        doctorData['profileImageUrl'] == null ||
                                        doctorData['profileImageUrl'].toString().isEmpty
                                      ? const Icon(Icons.person)
                                      : null,
                                ),
                                title: Text(doctorData['name']?.toString() ?? 'Unknown Doctor', style: Theme.of(context).textTheme.titleMedium,),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Experience: ${doctorData['experience']?.toString() ?? 'N/A'} years', style: Theme.of(context).textTheme.bodySmall,),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
