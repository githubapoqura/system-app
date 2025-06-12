import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/news_model.dart';
import 'package:untitled4/provider/project_provider.dart';
import 'package:untitled4/ui/Screens/books/choose_year_page.dart';
import 'package:untitled4/ui/Screens/icon_page/assignments_page.dart';
import 'package:untitled4/ui/Screens/books/books_page.dart';
import 'package:untitled4/ui/Screens/icon_page/gpa_page.dart';
import 'package:untitled4/ui/Screens/icon_page/payment_page.dart';
import 'package:untitled4/ui/Screens/icon_page/projects_page.dart';
import 'package:untitled4/ui/Screens/icon_page/registration_page.dart';
import 'package:untitled4/ui/Screens/icon_page/summer_course_page.dart';
import 'package:untitled4/ui/Screens/schedule/choose_schedule_year.dart';
import '../../summary/choose_summary_year.dart';
import '../news/news.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Map<String, String>> iconItems = [
    {"title": "Books", "image": "assets/icons/books.png"},
    {"title": "schedule", "image": "assets/icons/schedule.png"},
    {"title": "Assignments", "image": "assets/icons/assignments.png"},
    {"title": "Payment", "image": "assets/icons/payment.png"},
    {"title": "GPA", "image": "assets/icons/gpa.png"},
    {"title": "Projects", "image": "assets/icons/project.png"},
    {"title": "Summer Course", "image": "assets/icons/summerCourse.png"},
    {"title": "Registration", "image": "assets/icons/Course registration.png"},
    {"title": "Summary", "image": "assets/icons/summary.png"},
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProjectProvider>(context);
    List<NewsModel> sortedNews = provider.newsItems;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),

          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _homeContent(sortedNews),

          const Center(child: Text('تحت التطوير')),
          _profileContent(),
        ],
      ),
    );
  }

  Widget _homeContent(List<NewsModel> sortedNews) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hallo,",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text("Mostafa Ali",
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ],
              ),
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              hintText: "Search",
              prefixIcon: const Icon(Icons.search, color: Colors.blue),
              suffixIcon:
                  const Icon(Icons.notifications, color: Colors.blueAccent),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.grey, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
            ),
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: iconItems.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => _navigateToIconPage(index),
              child: buildIconCard(index),
            ),
          ),
          const SizedBox(height: 16),
          const Text("Latest News",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          if (sortedNews.isNotEmpty)
            SizedBox(height: 280, child: buildNewsCard(sortedNews[0])),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sortedNews.length > 1 ? sortedNews.length - 1 : 0,
            itemBuilder: (context, i) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: buildNewsCard(sortedNews[i + 1]),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToIconPage(int index) {
    Widget page;
    switch (index) {
      case 0:
        page = const ChooseYearPage();
        break;
      case 1:
        page = const ChooseScheduleYear();
        break;
      case 2:
        page = const AssignmentsPage();
        break;
      case 3:
        page = const PaymentPage();
        break;
      case 4:
        page = const GpaPage();
        break;
      case 5:
        page = const ProjectsPage();
        break;
      case 6:
        page = const SummerCoursePage();
        break;
      case 7:
        page = const RegistrationPage();
        break;
      case 8:
        page = const ChooseSummaryYear();
        break;
      default:
        return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  Widget buildIconCard(int index) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(iconItems[index]["image"]!, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          iconItems[index]["title"]!,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget buildNewsCard(NewsModel item) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => NewsPage(
            title: item.title,
            description: item.description,
            imageUrl: item.image,
          ),
        ),
      ),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(item.image,
                  width: double.infinity, height: 180, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item.title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(item.description,
                  style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _profileContent() {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text('Account',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue)),
          const SizedBox(height: 16),
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.blue),
                ),
                padding: const EdgeInsets.all(4),
                child: const Icon(Icons.edit, size: 20, color: Colors.blue),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text.rich(
            TextSpan(
              text: 'Hi, ',
              style: TextStyle(fontSize: 16),
              children: [
                TextSpan(
                  text: 'Mostafa Ali',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                _buildProfileItem(Icons.person, 'Profile'),
                _buildProfileItem(Icons.shield, 'Account'),
                _buildProfileItem(Icons.settings, 'Setting'),
                _buildProfileItem(Icons.info, 'About'),
                const ExpansionTile(
                  leading: Icon(Icons.chat, color: Colors.blue),
                  title: Text('Contact us'),
                  children: [
                    ListTile(
                        title: Text('Email: mostafaapoqura1732003@mail.com')),
                    ListTile(title: Text('Phone: 01115792456')),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      onTap: () {
        // يمكنك هنا استبداله لاحقًا بصفحة فعلية
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Page "$title" not implemented yet')),
        );
      },
    );
  }
}
