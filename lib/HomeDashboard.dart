import 'package:flutter/material.dart';
import 'package:flutter_highland/constants/color_constant.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({Key? key}) : super(key: key);

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  Widget? selectedPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content (Home Dashboard)
          Center(
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Our Services',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1FBCB1),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ServiceCard(
                              icon: Icons.local_hospital,
                              title: 'Emergency',
                              onTap: () {
                                setState(() {
                                  // selectedPage = EmergencyHome();
                                });
                              },
                            ),
                            ServiceCard(
                              icon: Icons.healing,
                              title: 'Surgery',
                              onTap: () {
                                setState(() {
                                  // selectedPage = SurgeryHome();
                                });
                              },
                            ),
                            ServiceCard(
                              icon: Icons.favorite,
                              title: 'Cardiology',
                              onTap: () {
                                setState(() {
                                  // selectedPage = CardiologyHome();
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ServiceCard(
                              icon: Icons.pregnant_woman,
                              title: 'Maternity',
                              onTap: () {
                                setState(() {
                                  // selectedPage = MaternityHome();
                                });
                              },
                            ),
                            ServiceCard(
                              icon: Icons.local_hospital,
                              title: 'Nephrology',
                              onTap: () {
                                setState(() {
                                  // selectedPage = NephrologyHome();
                                });
                              },
                            ),
                            ServiceCard(
                              icon: Icons.local_hospital,
                              title: 'Oncology',
                              onTap: () {
                                setState(() {
                                  // selectedPage = OncologyHome();
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ServiceCard(
                              icon: Icons.local_hospital,
                              title: 'Paediatrics',
                              onTap: () {
                                setState(() {
                                  // selectedPage = PaediatricsHome();
                                });
                              },
                            ),
                            ServiceCard(
                              icon: Icons.local_hospital,
                              title: 'Urology',
                              onTap: () {
                                setState(() {
                                  // selectedPage = UrologyHome();
                                });
                              },
                            ),
                            ServiceCard(
                              icon: Icons.local_hospital,
                              title: 'Psychiatry',
                              onTap: () {
                                setState(() {
                                  // selectedPage = PsychiatryHome();
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ServiceCard(
                              icon: Icons.local_hospital,
                              title: 'Gynecology',
                              onTap: () {
                                setState(() {
                                  // selectedPage = GynecologyHome();
                                });
                              },
                            ),
                            ServiceCard(
                              icon: Icons.spa,
                              title: 'Wellness',
                              onTap: () {
                                setState(() {
                                  // selectedPage = WellnessHome();
                                });
                              },
                            ),
                            ServiceCard(
                              icon: Icons.visibility,
                              title: 'Eye Care',
                              onTap: () {
                                setState(() {
                                  // selectedPage = EyecareHome();
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Overlay for selected page
          if (selectedPage != null)
            Positioned.fill(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    AppBar(
                      backgroundColor: ColorConstant.mainWhite,
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          setState(() {
                            selectedPage = null; // Reset the selected page
                          });
                        },
                      ),
                    ),
                    Expanded(child: selectedPage!),
                  ],
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Container(
          width: double.infinity,
          height: 50,
          color: Color(0xFF1BA08D),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(
                  '© Highland Hospitals. All Rights Reserved',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Text(
                  'Developed by Avanzo Cyber Security Solutions Pvt.Ltd.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  ServiceCard({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorConstant.mainBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(15),
            child: Icon(icon, size: 50, color: Color(0xFF1FBCB1)),
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
