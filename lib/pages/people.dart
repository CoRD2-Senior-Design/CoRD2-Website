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
        image: 'Naiyara.jpg',
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

  final List<Person> seniorDesign = [
    Person(
        name: 'Colby Wang',
        image: 'colby.jpg',
        school: 'Undergrad Student, University of Central Florida'),
    Person(
        name: 'Leonardo Marquez',
        image: 'leo.jpg',
        school: 'Undergrad Student, University of Central Florida'),
    Person(
        name: 'Dick Dela Cruz',
        image: 'dc.jpg',
        school: 'Undergrad Student, University of Central Florida'),
    Person(
        name: 'Tarina Sadek',
        image: 'tarina.jpg',
        school: 'Undergrad Student, University of Central Florida'),
    Person(
        name: 'Menachem Jaimovich',
        image: 'mendy.jpg',
        school: 'Undergrad Student, University of Central Florida'),
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
                _buildPeopleGrid(context, "Project Investigators", projectInvestigators),
                _buildPeopleGrid(context, "Research Assistants", researchAssistants),
                _buildPeopleGrid(context, "Former Members", formerMembers),
                _buildPeopleGrid(context, "Senior Design", seniorDesign)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPeopleGrid(
      BuildContext context, String title, List<Person> people) {
    int crossAxisCount = 3; // Default number of columns
    double width = MediaQuery.of(context).size.width;

    if (width < 450) {
      crossAxisCount = 1;
    } else if (width < 700) {
      crossAxisCount = 2;
    } // Add more breakpoints as needed

    double maxGridBlockSize = 200.0; // Maximum size for each grid block

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
          ),
          itemCount: people.length,
          itemBuilder: (context, index) {
            final person = people[index];
            return SizedBox(
              width: maxGridBlockSize, // Set the width to limit the size
              height: maxGridBlockSize, // Set the height to limit the size
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center the content vertically
                  children: [
                    Image.asset(
                      person.image,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Center(
                        // Center the text horizontally
                        child: Text(
                          person.name,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Center(
                        // Center the text horizontally
                        child: Text(
                          person.school,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
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

