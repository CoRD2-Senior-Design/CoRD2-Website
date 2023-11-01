import 'package:flutter/material.dart';

class PeoplePage extends StatelessWidget {
  PeoplePage({super.key});
  final List<Person> projectInvestigators = [
    Person(
        name: 'Yue (Gurt) Ge, PI',
        image: 'yuege.jpg',
        school:
        'School of Public Administration, University of Central Florida'),
    Person(
        name: 'Naim Kapucu',
        image: 'naimkapucu.jpg',
        school:
        'School of Public Administration, University of Central Florida'),
    Person(
        name: 'Jeremy Hall',
        image: 'jeremyhall.jpg',
        school:
        'School of Public Administration, University of Central Florida'),
    Person(
        name: 'Samiul Hasan',
        image: 'samiulhasan.jpg',
        school: 'Dept. of Civil Engineering, University of Central Florida'),
    Person(
        name: 'Liqiang Wang',
        image: 'liqiangwang.jpg',
        school: 'Dept. of Computer Science, University of Central Florida'),
    Person(
        name: 'Haizhong Wang',
        image: 'haizhongwang.jpg',
        school: 'Civil & Contruction Engineering, Oregon State University'),
    Person(
        name: 'Christopher Zobel',
        image: 'zobel.jpg',
        school: 'Dept. of Business Information Technology, Virginia Tech'),
    Person(
        name: 'Michelle Cechowski',
        image: 'michellecechowski.jpg',
        school: 'East Central Florida Regional Planning Council(ECFRPC)'),
    // Add project investigators here
  ];

  final List<Person> researchAssistants = [
    Person(
        name: 'Sara Iman',
        image: 'saraiman.png',
        school: 'PhD Student, University of Central Florida'),
    Person(
        name: 'Ratna Okhai',
        image: 'ratna.jpg',
        school: 'PhD Student, University of Central Florida'),
    Person(
        name: 'Naiyara Noor',
        image: 'naiyara.jpg',
        school: 'Graduate Fellow, University of Central Florida'),
    Person(
        name: 'Yang Gao',
        image: 'gy.png',
        school: 'PhD Student, University of Central Florida'),
    Person(
        name: 'Yifan Ding',
        image: 'YifanDing.jpg',
        school: 'PhD Student, University of Central Florida'),
    Person(
        name: 'Rayeedul Siam',
        image: 'rayeedul.jpg',
        school: 'PhD Student, Oregon State University'),
    Person(
        name: 'Brian Staes',
        image: 'bstaes.jpg',
        school: 'PhD Student, Oregon State University'),
    Person(
        name: 'Duygu Pamukcu',
        image: 'duygu.jpg',
        school: 'PhD Student, Virginia Tech'),
    Person(
        name: 'David Kaff',
        image: 'davidKaff.jpg',
        school: 'Undergraduate Student, Oregon State University'),
    Person(
        name: 'Charles Abbatantuono',
        image: 'empty.jpg',
        school: 'Planner I, East Central Florida Regional Planning Council'),
    // Add research assistants here
  ];

  final List<Person> formerMembers = [
    Person(
        name: 'Yago Martin',
        image: 'yago-martin.jpg',
        school: 'Researcher, University of Zaragoza'),
    Person(
        name: 'Maroa Mumtarin',
        image: 'empty.jpg',
        school: 'PhD Student, University of Central Florida'),
    // Add former members here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints:
            const BoxConstraints(maxWidth: 700.0), // Set maximum width here
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPeopleGrid("Project Investigators", projectInvestigators),
                _buildPeopleGrid("Research Assistants", researchAssistants),
                _buildPeopleGrid("Former Members", formerMembers),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPeopleGrid(String title, List<Person> people) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Center(
            // Wrap the title Text with Center widget
            child: Text(
              title,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Number of columns in the grid
          ),
          itemCount: people.length,
          itemBuilder: (context, index) {
            final person = people[index];
            return Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero, // Set border radius to zero
              ),
              color: Colors.white,
              child: Column(
                children: [
                  Image.asset(
                    person.image,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(
                      person.name,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(
                      person.school, // Display the school information
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class Person {
  final String name;
  final String image;
  final String school;
  Person({required this.name, required this.image, required this.school});
}

