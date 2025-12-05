import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highland/about.dart';
import 'package:flutter_highland/careers.dart';
import 'package:flutter_highland/controller/booking_enquiry_controller.dart';
import 'package:flutter_highland/controller/contact_inquiry_controller.dart';
import 'package:flutter_highland/highland_departments.dart';
import 'package:flutter_highland/model/booking_enquiry_model.dart';
import 'package:flutter_highland/model/contact_enquiry.dart';

// <-- FIX #1: ADDED MISSING IMPORT
import 'package:flutter_highland/responsive.dart';
import 'package:flutter_highland/constants/color_constant.dart';
import 'package:flutter_highland/contacts.dart';
import 'package:flutter_highland/patient_registration.dart';
import 'package:flutter_highland/url_launcher_connection.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// --- CoreLogo Class ---
class CoreLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/img/LogowithISO.png',
      //height: 180,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          Icon(Icons.business, size: 30),
    );
  }
}

class Highlandhome extends StatefulWidget {
  @override
  _HighlandhomeState createState() => _HighlandhomeState();
}

class _HighlandhomeState extends State<Highlandhome>
    with TickerProviderStateMixin {
  late AnimationController _marqueeController;
  late Animation<Offset> _scrollAnimation;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> menuItems = [
    'Home',
    'About',
    'Services',
    'Departments',
    'Careers',
    'News',
    'Feedback',
    // 'International - Patient',
    'Contact',
  ];

  // --- FORM KEYS FOR VALIDATION ---
  final _responsiveBookingFormKey = GlobalKey<FormState>();
  final _desktopBookingFormKey =
      GlobalKey<FormState>(); // <-- FIX #2: DEFINED FORM KEY

  // Text Editing Controllers for Responsive Booking Form

  // Text Editing Controllers for Desktop Contact Form
  final TextEditingController _desktopContactNameController =
      TextEditingController();
  final TextEditingController _desktopContactEmailController =
      TextEditingController();
  final TextEditingController _desktopContactMobileController =
      TextEditingController();
  final TextEditingController _desktopContactMessageController =
      TextEditingController();
  final _desktopContactFormKey = GlobalKey<FormState>();

  // Text Editing Controllers for Desktop Booking Form
  final TextEditingController _desktopBookFirstNameController =
      TextEditingController();
  final TextEditingController _desktopBookLastNameController =
      TextEditingController();
  final TextEditingController _desktopBookEmailController =
      TextEditingController();
  final TextEditingController _desktopBookAddressController =
      TextEditingController();
  final TextEditingController _desktopBookPhoneController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _marqueeController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 17),
    )..repeat();

    _scrollAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset(-1.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _marqueeController,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    _marqueeController.dispose();

    _desktopContactNameController.dispose();
    _desktopContactEmailController.dispose();
    _desktopContactMobileController.dispose();
    _desktopContactMessageController.dispose();
    _desktopBookFirstNameController.dispose();
    _desktopBookLastNameController.dispose();
    _desktopBookEmailController.dispose();
    _desktopBookAddressController.dispose();
    _desktopBookPhoneController.dispose();
    super.dispose();
  }

  void onMenuItemTapped(String menuItem) {
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.pop(context);
    }
    switch (menuItem) {
      case 'About':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => About()));
        break;
      case 'Feedback':
        _launchURL('https://feedback.highlandhospitals.in/');
        break;
      case 'Departments':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeDashboard()));
        break;
      case 'Careers':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Careers()));
        break;
      case 'Contact':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Contacts()));
        break;
      case 'International - Patient':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => New_register2(
                      firstName: '',
                      lastName: '',
                      email: '',
                      address: '',
                      phone: '',
                    )));
        break;
      default:
        print("Tapped on: $menuItem");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isDesktop = Responsive.isDesktop(context);
    final bool isTablet = Responsive.isTablet(context);
    final bool isMobile = Responsive.isMobile(context);

    double heading1 = isMobile ? 30 : (isTablet ? 34 : 32);
    double heading2 = isMobile ? 24 : (isTablet ? 26 : 24);
    double heading3 = isMobile ? 22 : (isTablet ? 24 : 22);
    double bodyTextLarge = isMobile ? 22 : (isTablet ? 24 : 22);
    double bodyTextMedium = isMobile ? 20 : (isTablet ? 22 : 19);
    double bodyTextSmall = isMobile ? 30 : (isTablet ? 20 : 16);
    double buttonText = isMobile ? 20 : (isTablet ? 22 : 18);

    return ChangeNotifierProvider(
      create: (context) => BookingEnquiryController(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: isDesktop
            ? _buildDesktopAppBar(context, screenSize.width)
            : _buildMobileTabletAppBar(context, isDesktop, isTablet, isMobile),
        drawer: isDesktop ? null : _buildAppDrawer(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  width: screenSize.width,
                  height: 20,
                  color: Color(0xFF1FBCB1)),
              Container(
                  width: screenSize.width, height: 3, color: Color(0xFFEE9B27)),
              if (isDesktop)
                _buildDesktopLayout(context, screenSize)
              else
                _buildMobileTabletLayout(
                    context,
                    screenSize,
                    isTablet,
                    isMobile,
                    heading1,
                    heading2,
                    heading3,
                    bodyTextLarge,
                    bodyTextMedium,
                    bodyTextSmall,
                    buttonText),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDrawerMenu() {
    return ListView.builder(
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            menuItems[index],
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          onTap: () => onMenuItemTapped(menuItems[index]),
        );
      },
    );
  }

  Widget _buildDesktopLayout(BuildContext context, Size screenSize) {
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;
    double desktopMenuFontSize = 18;
    double desktopBodyLarge = 27;
    double desktopWelcomeHeading1 = 30;
    double desktopWelcomeHeading2 = 20;
    double desktopOutpatientTitle = 40;
    double desktopSpecialityFontSize = 19;
    double desktopFooterFontSize = 18;
    double desktopMarqueeFontSize = 20;

    return Column(
      children: [
        _buildDesktopMenuBar(context, desktopMenuFontSize),
        SizedBox(height: 20),
        _buildHeroSectionDesktop(context, screenHeight, screenWidth),
        SizedBox(height: 20),
        _buildWelcomeSectionDesktop(context, screenWidth,
            desktopWelcomeHeading1, desktopWelcomeHeading2),
        SizedBox(height: 20),
        _buildHospitalDescriptionDesktop(
            context, screenWidth, desktopBodyLarge),
        SizedBox(height: 30),
        _buildKnowMoreButtonDesktop(context, screenWidth),
        SizedBox(height: 10),
        _buildFeatureCarouselDesktop(context, screenHeight, screenWidth),
        SizedBox(height: screenHeight * .12),
        _buildVisionMissionSectionDesktop(context, screenHeight, screenWidth),
        _buildBookingAndInfoSectionDesktopOriginal(
            context, screenHeight, screenWidth),
        _buildOutPatientSectionDesktopOriginal(
            context, screenHeight, screenWidth, desktopOutpatientTitle),
        _buildServicesAndContactSectionDesktopOriginal(
            context, screenHeight, screenWidth),
        _buildSpecialitiesAndFormSectionDesktopOriginal(
            context, screenHeight, screenWidth, desktopSpecialityFontSize),
        SizedBox(height: 20),
        _buildDisclaimerMarqueeDesktopOriginal(context, desktopMarqueeFontSize),
        SizedBox(height: 2),
        _buildFooterDesktopOriginal(context, desktopFooterFontSize),
      ],
    );
  }

  Widget _buildMobileTabletLayout(
      BuildContext context,
      Size screenSize,
      bool isTablet,
      bool isMobile,
      double heading1,
      double heading2,
      double heading3,
      double bodyTextLarge,
      double bodyTextMedium,
      double bodyTextSmall,
      double buttonText) {
    return Column(
      children: [
        _buildHeroSectionResponsive(context, screenSize, false, isTablet,
            isMobile, heading3, buttonText),
        SizedBox(height: isMobile ? 20 : 30),
        _buildWelcomeSectionResponsive(
            context, screenSize, false, isTablet, isMobile, heading1, heading2),
        SizedBox(height: isMobile ? 15 : 20),
        _buildHospitalDescriptionResponsive(
            context, screenSize, false, isTablet, isMobile, bodyTextLarge),
        SizedBox(height: isMobile ? 20 : 30),
        // _buildKnowMoreButtonResponsive(
        //     context, screenSize, false, isTablet, isMobile, buttonText),
        // SizedBox(height: isMobile ? 20 : 30),
        // _buildFeatureCarouselResponsive(
        //     context, screenSize, false, isTablet, isMobile),
        // SizedBox(height: isMobile ? 30 : screenSize.height * .08),
        // _buildVisionMissionSectionResponsive(
        //     context, screenSize, false, isTablet, isMobile, bodyTextMedium),
        _buildKnowMoreButtonResponsive(
            context, screenSize, false, isTablet, isMobile, buttonText),
        SizedBox(height: isMobile ? 20 : 30),

        // **** THIS IS THE CORRECTED LINE ****
        _buildFeatureCarouselResponsive(context), // No extra arguments needed

        SizedBox(height: isMobile ? 30 : screenSize.height * .08),
        _buildVisionMissionSectionResponsive(
            context, screenSize, false, isTablet, isMobile, bodyTextMedium),
        _buildBookingAndInfoSectionResponsive(context, screenSize, false,
            isTablet, isMobile, heading3, bodyTextMedium, buttonText),
        SizedBox(height: isMobile ? 30 : 50),
        _buildOutPatientSectionResponsive(context, screenSize, false, isTablet,
            isMobile, heading1, heading3, bodyTextMedium),
        SizedBox(height: isMobile ? 30 : 50),
        _buildServicesAndContactSectionResponsive(context, screenSize, false,
            isTablet, isMobile, heading2, bodyTextMedium, buttonText),
        SizedBox(height: isMobile ? 30 : 50),
        _buildSpecialitiesAndFormSectionResponsive(context, screenSize, false,
            isTablet, isMobile, heading2, bodyTextMedium, buttonText),
        SizedBox(height: isMobile ? 20 : 30),
        _buildDisclaimerMarqueeResponsive(
            context, false, isTablet, isMobile, heading3),
        _buildFooterResponsive(
            context, false, isTablet, isMobile, bodyTextSmall),
      ],
    );
  }

  PreferredSizeWidget _buildDesktopAppBar(
      BuildContext context, double screenWidth) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.only(left: screenWidth * .012),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // **** CLICKABLE EMAIL SECTION ****
            InkWell(
              onTap: () async {
                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: 'reachus@highlandhospital.in',
                );
                if (await canLaunchUrl(emailLaunchUri)) {
                  await launchUrl(emailLaunchUri);
                }
              },
              // Add mouse cursor to indicate it's clickable
              mouseCursor: SystemMouseCursors.click,
              child: Row(
                children: [
                  Icon(
                    Icons.mail,
                    color: const Color.fromARGB(255, 90, 78, 78),
                    size: 24,
                  ),
                  SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'reachus@highlandhospital.in',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: screenWidth * .012),
              child: HighlandSocialBar(iconSize: 22),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFFFFFFFF),
      automaticallyImplyLeading: false,
      elevation: 1.0,
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _buildDesktopMenuBar(BuildContext context, double menuTextSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(menuItems.length, (index) {
          bool isContact = menuItems[index] == 'CONTACT';
          return Flexible(
            child: InkWell(
              onTap: () {
                if (menuItems[index] == 'CONTACT') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Contacts()));
                } else {
                  onMenuItemTapped(menuItems[index]);
                }
              },
              borderRadius: BorderRadius.circular(4),
              splashColor: Color(0xFFEE9821).withOpacity(0.3),
              hoverColor: Color(0xFFEE9821).withOpacity(0.1),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                decoration: isContact
                    ? BoxDecoration(
                        color: Color(0xFFEE9821),
                        borderRadius: BorderRadius.circular(4.0),
                      )
                    : null,
                child: Text(
                  menuItems[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: menuTextSize,
                    fontWeight: FontWeight.bold,
                    color: isContact
                        ? Colors.white
                        : Color.fromARGB(255, 1, 5, 10),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildHeroSectionDesktop(
      BuildContext context, double screenHeight, double screenWidth) {
    return Stack(children: [
      Image.asset('assets/img/bg.jpeg',
          height: screenHeight * 0.9,
          width: screenWidth,
          fit: BoxFit.cover,
          errorBuilder: (c, e, s) => Container(
              height: screenHeight * 0.9,
              width: screenWidth,
              color: Colors.grey[300])),
      Positioned(
          left: screenWidth * .15,
          top: screenHeight * .2,
          child: Column(children: [
            Image.asset('assets/img/LogowithISO.png',
                height: screenHeight * 0.32,
                width: screenWidth * 0.3,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                    height: screenHeight * 0.32,
                    width: screenWidth * 0.3,
                    color: Colors.grey[200])),
            SizedBox(
              width: screenWidth * .3,
              child: Text(
                '''At Highland Hospital, it's not just healthcare but care for your health''',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.normal,
                  color: const Color.fromARGB(255, 15, 2, 2),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () => onMenuItemTapped('Departments'),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                decoration: BoxDecoration(
                  color: Color(0xFF7CB3AC),
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: Center(
                  child: Text(
                    'Our Specialties',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
              ),
            ),
          ]))
    ]);
  }

  Widget _buildWelcomeSectionDesktop(BuildContext context, double screenWidth,
      double heading1, double heading2) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "Welcome to Highland Hospital",
            style: TextStyle(
                fontSize: heading1,
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 24, 5, 5)),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            "Established in 1995",
            style: TextStyle(
              fontSize: heading2,
              fontWeight: FontWeight.normal,
              color: Color(0xFF6CC1B6),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: screenWidth * .25,
          height: 2,
          decoration: BoxDecoration(color: Color(0xFFF1B056)),
        ),
      ],
    );
  }

  Widget _buildHospitalDescriptionDesktop(
      BuildContext context, double screenWidth, double bodyTextLarge) {
    return SizedBox(
      width: screenWidth * .6,
      child: Text(
        '''Our 250 bedded hospital brings you the best in multispecialty treatment with state-of-the-art technology focusing on various specialties including Critical Care, Cardiology, Cardiac Surgery, Orthopaedic & Joint Replacement, Neurology, Neuro-Surgery, Pulmonology, Gastroenterology, Diabetes and Endocrinology, Paediatrics, Gynaecology, Nephrology,Urology, and many more. The focus of healthcare at Highland Hospital is the health and wellbeing of our patients, utilising the latest infrastructure and qualified medical expertise available while at the same time ensuring affordability.''',
        style: TextStyle(
          fontSize: bodyTextLarge,
          fontWeight: FontWeight.normal,
          color: Color(0xFFADADAD),
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _buildKnowMoreButtonDesktop(BuildContext context, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: InkWell(
        onTap: () => onMenuItemTapped('About'),
        child: Container(
          height: 45.0,
          width: screenWidth * 0.2,
          padding: EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            color: Color(0xFF78CAC6),
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: Center(
            child: Text(
              'Know more',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCarouselDesktop(
      BuildContext context, double screenHeight, double screenWidth) {
    return SizedBox(
      width: screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(width: 20, height: 277, color: Color(0xFF1FBCB1)),
          Expanded(
              child: _originalCarousalContainer(
                  image: 'assets/img/find a doctor.png',
                  label: 'FIND A DOCTOR',
                  backgroundColor: Color(0xFF1FBCB1),
                  height: screenHeight,
                  width: screenWidth,
                  context: context)),
          Expanded(
              child: _originalCarousalContainer(
                  image: 'assets/img/Test result.png',
                  label: 'TEST RESULT',
                  backgroundColor: Color(0xFFEE9821),
                  height: screenHeight,
                  width: screenWidth,
                  context: context)),
          Expanded(
              child: _originalCarousalContainer(
                  image: 'assets/img/online admission.png',
                  label: 'ONLINE ADMISSION',
                  backgroundColor: Color(0xFF1BA08D),
                  height: screenHeight,
                  width: screenWidth,
                  context: context)),
          Expanded(
              child: _originalCarousalContainer(
                  image: 'assets/img/Patient acces.png',
                  label: 'PATIENT ACCESS',
                  backgroundColor: Color(0xFF5592C8),
                  height: screenHeight,
                  width: screenWidth,
                  context: context)),
          Container(width: 20, height: 277, color: Color(0xFF5592C8)),
        ],
      ),
    );
  }

  Widget _buildVisionMissionSectionDesktop(
      BuildContext context, double screenHeight, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth * 0.38,
            height: screenHeight * .5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset('assets/img/vision.jpeg',
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) =>
                      Container(color: Colors.grey[300])),
            ),
          ),
          Container(
            width: screenWidth * 0.38,
            height: screenHeight * .5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset('assets/img/mission.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) =>
                      Container(color: Colors.grey[300])),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingAndInfoSectionDesktopOriginal(
      BuildContext context, double screenHeight, double screenWidth) {
    double stackHeight = screenHeight * 1;
    final bookingController = context.watch<BookingEnquiryController>();

    return SizedBox(
      height: stackHeight,
      width: screenWidth,
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: constraints.maxHeight * .1,
              child: Container(
                width: screenWidth,
                height: constraints.maxHeight * .4,
                color: Color(0xFF1FBCB1),
              ),
            ),
            Positioned(
              top: 0,
              child: SizedBox(
                width: screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: screenWidth * 0.40,
                      height: screenHeight * .3,
                      padding: EdgeInsets.all(10),
                      color: Color(0xFFFFFFFF),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'VISION',
                              style: TextStyle(
                                color: Color.fromARGB(255, 29, 23, 23),
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Text(
                                  '''To be a beacon of healthcare excellence, where “YOUR HEALTH, OUR CARE” is not just a tagline but a promise. We envision Highland Hospital as a leader in innovation and compassionate care, ensuring that every patient—regardless of their background—receives world-class, accessible healthcare. Through dedication to patient well-being, cutting-edge technology, and community welfare, we aim to shape a future where healthcare is a right, not a privilege.''',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 29, 23, 23),
                                    fontSize: 17,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: screenWidth * .4,
                      height: constraints.maxHeight * .3,
                      padding: EdgeInsets.all(10),
                      color: Color(0xFFFFFFFF),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'MISSION',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Text(
                                  '''To provide advanced, patient-centered healthcare through our guiding principle of “YOUR HEALTH, OUR CARE.” We are dedicated to delivering the highest standards of care with empathy, integrity, and innovation. By investing in both our people and technology, we strive to improve the health and well-being of every individual we serve. We aim to create a supportive environment where every patient feels valued, ensuring accessible, high-quality healthcare that elevates lives and strengthens our community.''',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: constraints.maxHeight * .4,
              left: screenWidth * .4,
              child: Container(
                width: screenWidth * .45,
                height: screenHeight * .55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
                child: Column(children: [
                  Container(
                    height: constraints.maxHeight * .1,
                    decoration: BoxDecoration(
                      color: Color(0xFF1BA08F),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Booking Enquiry',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * .45,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFEE9821), width: 2),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: _desktopBookingFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: screenWidth * .42,
                              child: Text(
                                '''Request a callback from our team''',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 5,
                              ),
                            ),

                            // First name + Last name
                            _bookAnAppointmentFieldsOriginal(
                              firstFieldLabel: 'First Name :',
                              firstFieldController:
                                  _desktopBookFirstNameController,
                              secondFieldLabel: 'Last Name :',
                              secondFieldController:
                                  _desktopBookLastNameController,
                            ),

                            // Email + Address
                            _bookAnAppointmentFieldsOriginal(
                              firstFieldLabel: 'Email :',
                              firstFieldController: _desktopBookEmailController,
                              secondFieldLabel: 'Address :',
                              secondFieldController:
                                  _desktopBookAddressController,
                            ),

                            // Phone number
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 40,
                                      color: const Color(0xFFF2F3F5),
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Text(
                                              'Phone Number :',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                              controller:
                                                  _desktopBookPhoneController,
                                              keyboardType:
                                                  TextInputType.number,
                                              maxLength: 10,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                counterText: "",
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 15),
                                                hintStyle: TextStyle(
                                                    color: Colors.black54),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Required';
                                                }
                                                if (!RegExp(r'^\d{10}$')
                                                    .hasMatch(value)) {
                                                  return 'Enter a valid 10-digit number';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Submit button WITH LOADING SUPPORT
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Consumer<BookingEnquiryController>(
                                    builder: (context, bookingController, _) {
                                      return InkWell(
                                        onTap: bookingController.isLoading
                                            ? null
                                            : () async {
                                                if (_desktopBookingFormKey
                                                    .currentState!
                                                    .validate()) {
                                                  final enquiry =
                                                      BookingEnquiry(
                                                    firstName:
                                                        _desktopBookFirstNameController
                                                            .text,
                                                    lastName:
                                                        _desktopBookLastNameController
                                                            .text,
                                                    phone:
                                                        _desktopBookPhoneController
                                                            .text,
                                                    email:
                                                        _desktopBookEmailController
                                                            .text,
                                                    address:
                                                        _desktopBookAddressController
                                                            .text,
                                                  );

                                                  final controller = context.read<
                                                      BookingEnquiryController>();

                                                  await controller
                                                      .submitEnquiry(enquiry)
                                                      .then((success) {
                                                    if (success) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(controller
                                                              .successMessage!),
                                                          backgroundColor:
                                                              Colors.green,
                                                        ),
                                                      );

                                                      _desktopBookFirstNameController
                                                          .clear();
                                                      _desktopBookLastNameController
                                                          .clear();
                                                      _desktopBookPhoneController
                                                          .clear();
                                                      _desktopBookEmailController
                                                          .clear();
                                                      _desktopBookAddressController
                                                          .clear();
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(controller
                                                              .errorMessage!),
                                                          backgroundColor:
                                                              Colors.red,
                                                        ),
                                                      );
                                                    }
                                                  });
                                                }
                                              },
                                        child: Container(
                                          width: 220,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFEE9821),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            border: Border.all(
                                                color: Colors.yellow),
                                          ),
                                          child: Center(
                                            child: bookingController.isLoading
                                                ? CircularProgressIndicator(
                                                    color: Colors.white,
                                                  )
                                                : Text(
                                                    'Request Callback',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            ),
            Positioned(
              bottom: 0,
              left: screenWidth * .15,
              child: Image.asset('assets/img/doct.png',
                  width: screenWidth * .25,
                  height: constraints.maxHeight * .7,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(
                      width: screenWidth * .25,
                      height: constraints.maxHeight * .7,
                      color: Colors.grey[200])),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildOutPatientSectionDesktopOriginal(BuildContext context,
      double screenHeight, double screenWidth, double titleFontSize) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: screenWidth * .05, vertical: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        SizedBox(
          width: screenWidth * .45,
          height: screenHeight * .6,
          child: LayoutBuilder(builder: (context, outpatientconstraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Out-Patient Services',
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF494949),
                      ),
                    ),
                    Container(
                        width: outpatientconstraints.maxWidth * .2,
                        height: 5,
                        color: Colors.black,
                        margin: EdgeInsets.only(top: 5, bottom: 10)),
                    Container(
                      width: outpatientconstraints.maxWidth * .8,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Color(0xFF1BA08F),
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'We provide the following features',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    _originalOutPatientServices(
                      outpatientconstraints: outpatientconstraints,
                      image: 'assets/img/health.png',
                      title: 'Health',
                      content: '''"The First Wealth is Health"''',
                    ),
                    _originalOutPatientServices(
                      outpatientconstraints: outpatientconstraints,
                      image: 'assets/img/Surgeryicon.png',
                      title: 'Surgery',
                      content: '''"Truth Like Surgery May Hurt But It Cures"''',
                    ),
                  ],
                ),
                Row(
                  children: [
                    _originalOutPatientServices(
                      outpatientconstraints: outpatientconstraints,
                      image: 'assets/img/careers.png',
                      title: 'Careers',
                      content: '''"Be So good They Can't ignore you"''',
                    ),
                    _originalOutPatientServices(
                      outpatientconstraints: outpatientconstraints,
                      image: 'assets/img/calender.png',
                      title: 'Planning',
                      content: '''"If You Can Dream It, You Can Do It."''',
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
        Flexible(
          fit: FlexFit.loose,
          child: Container(
            width: screenWidth * .4,
            height: 400,
            child: Image.asset('assets/img/out_patient.jpg',
                fit: BoxFit.contain,
                errorBuilder: (c, e, s) => Container(color: Colors.grey[200])),
          ),
        ),
      ]),
    );
  }

  Widget _buildServicesAndContactSectionDesktopOriginal(
      BuildContext context, double screenHeight, double screenWidth) {
    // Helper function for URLs
    Future<void> _launchURL(String url) async {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    }

    Widget _originalContactColumn({
      required IconData icon,
      required String title,
      required String description,
      required VoidCallback onTap,
    }) {
      return InkWell(
        onTap: onTap,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: const Color(0xFF0EA69F), size: 30),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: screenWidth,
      color: const Color(0xFF1FBCB1),
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // FIX: Wrapped in Expanded to prevent Overflow
                Expanded(
                  child: _buildDesktopHealthTipBox(
                    title: "Health Tips",
                    image: 'assets/img/healthi.png',
                    content:
                        '''Add more fruits and vegetables to your daily meals — your heart will thank you!''',
                    backgroundColor: const Color.fromARGB(255, 231, 162, 14),
                    width: double.infinity, // Let Expanded handle width
                    height: 275,
                  ),
                ),
                const SizedBox(width: 20), // Add spacing
                Expanded(
                  child: _buildDesktopHealthTipBox(
                    title: "Latest News",
                    image: 'assets/img/Latest.png',
                    content:
                        '''Our hospital continues to provide 24/7 emergency care with the latest medical technology and dedicated specialists.''',
                    backgroundColor: const Color(0xFF3FAE9E),
                    width: double.infinity, // Let Expanded handle width
                    height: 275,
                  ),
                ),
                const SizedBox(width: 20), // Add spacing
                Expanded(
                  child: _buildDesktopPatientCountBox(
                      width: double.infinity, // Let Expanded handle width
                      height: 275 // Matched height with others
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 70),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              children: [
                Container(height: 2),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Services",
                    style: TextStyle(
                      fontSize: 33,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDesktopServiceImage(
                    'assets/img/highlandservice.jpg', '', 0),
                _buildDesktopServiceImage('assets/img/pi2.jpg', '', 0),
                _buildDesktopServiceImage('assets/img/pi3.jpg', '', 0),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _originalContactColumn(
                    icon: Icons.location_on,
                    title: 'Location',
                    description:
                        'Mother Theresa Road,\nKankanady, Highland Hospitals,\nMangaluru, Karnataka 575002,\nIndia.',
                    onTap: () => _launchURL(
                        'https://www.google.com/maps/place/Highland+Hospital/@12.8664995,74.8546887,17z/data=!3m1!4b1!4m6!3m5!1s0x3ba35a34c13203f9:0xfb2782cbf31a7784!8m2!3d12.8664995!4d74.8546887!16s%2Fg%2F1thcl645?entry=ttu&g_ep=EgoyMDI1MTEwMi4wIKXMDSoASAFQAw%3D%3D'),
                  ),
                ),
                Expanded(
                  child: _originalContactColumn(
                    icon: Icons.phone,
                    title: 'Emergency 24x7',
                    description: '0824-4235555',
                    onTap: () => makePhoneCall('08244235555', context),
                  ),
                ),
                Expanded(
                  child: _originalContactColumn(
                    icon: Icons.email,
                    title: 'Email',
                    description: 'reachus@highlandhospital.in',
                    onTap: () => _launchURL(
                      'mailto:reachus@highlandhospital.in?subject=Hospital%20Inquiry',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Future<void> makePhoneCall(String phoneNumber, BuildContext context) async {
  //   final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);

  //   // 🔹 On web: launch tel: link directly (browser will handle or show error)
  //   if (kIsWeb) {
  //     try {
  //       await launchUrl(callUri);
  //     } catch (e) {
  //       _showError(context, 'Web call not supported on this device.');
  //     }
  //     return;
  //   }

  //   // 🔹 On mobile or desktop
  //   if (await canLaunchUrl(callUri)) {
  //     await launchUrl(callUri);
  //   } else {
  //     _showError(context, 'This device cannot make phone calls.');
  //   }
  // }

// Helper to show error as SnackBar

  Widget _originalCarousalContainer({
    required BuildContext context,
    required String image,
    required String label,
    required Color backgroundColor,
    required double width,
    required double height,
  }) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        height: 277,
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 1.0),
        color: backgroundColor,
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(image,
                width: 80,
                height: 80,
                fit: BoxFit.contain,
                errorBuilder: (c, e, s) =>
                    Icon(Icons.error_outline, size: 50, color: Colors.white54)),
            SizedBox(height: 15),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialitiesAndFormSectionDesktopOriginal(BuildContext context,
      double screenHeight, double screenWidth, double specialityFontSize) {
    double contactFormTitleSize = 20;
    double contactFormButtonSize = 24;
    // **** THE ONLY FIX NEEDED IS THIS LINE ****
    final contactController = context.watch<ContactInquiryController>();

    return Container(
      width: screenWidth,
      color: Color(0xFFEAEBED),
      padding:
          EdgeInsets.symmetric(vertical: screenHeight * 0.04, horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Specialties',
                    style: TextStyle(
                      color: Color.fromARGB(255, 24, 14, 14),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('General Medicine',
                      style: TextStyle(fontSize: specialityFontSize)),
                  SizedBox(height: 10),
                  Text('General Surgery',
                      style: TextStyle(fontSize: specialityFontSize)),
                  SizedBox(height: 10),
                  Text('Orthopaedic & Trauma Care',
                      style: TextStyle(fontSize: specialityFontSize)),
                  SizedBox(height: 10),
                  Text('Total Knee & Hip Replacement',
                      style: TextStyle(fontSize: specialityFontSize)),
                  SizedBox(height: 10),
                  Text('Arthroscopy & Sports Medicine',
                      style: TextStyle(fontSize: specialityFontSize)),
                  SizedBox(height: 10),
                  Text('Pediatric & Pediatric Surgery',
                      style: TextStyle(fontSize: specialityFontSize)),
                  SizedBox(height: 10),
                  Text('Nephrology',
                      style: TextStyle(fontSize: specialityFontSize)),
                  SizedBox(height: 10),
                  Text('Gastroenterology',
                      style: TextStyle(fontSize: specialityFontSize)),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10.0, top: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text('Ophthalmology',
                      style: TextStyle(fontSize: specialityFontSize)),
                  SizedBox(height: 10),
                  Text('E.N.T Micro Surgery',
                      style: TextStyle(fontSize: specialityFontSize)),
                  SizedBox(height: 10),
                  Text('Neurology and Neuro Surgery',
                      style: TextStyle(fontSize: specialityFontSize)),
                  SizedBox(height: 10),
                  Text('Plastic & Reconstructive Surgery',
                      style: TextStyle(fontSize: specialityFontSize)),
                  SizedBox(height: 10),
                  Text('Maxillofacial Surgery',
                      style: TextStyle(fontSize: specialityFontSize)),
                  SizedBox(height: 10),
                  Text('Microvascular Surgery',
                      style: TextStyle(fontSize: specialityFontSize)),
                  SizedBox(height: 10),
                  Text('Endocrinology',
                      style: TextStyle(fontSize: specialityFontSize)),
                  SizedBox(height: 10),
                  Text('Urology & Andrology',
                      style: TextStyle(fontSize: specialityFontSize)),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Form(
                key: _desktopContactFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Contact us',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 15, 12, 12),
                        fontSize: contactFormTitleSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        controller: _desktopContactNameController,
                        decoration: InputDecoration(
                            labelText: 'Name:',
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5)),
                        style: TextStyle(color: Colors.black),
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Name is required' : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        controller: _desktopContactEmailController,
                        decoration: InputDecoration(
                            labelText: 'Email:',
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5)),
                        style: TextStyle(color: Colors.black),
                        validator: (v) {
                          if (v == null || v.isEmpty)
                            return 'Email is required';
                          if (!RegExp(r'^.+@.+\..+$').hasMatch(v))
                            return 'Enter a valid email';
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        controller: _desktopContactMobileController,
                        keyboardType: TextInputType.number, // 🔢 Numeric keypad
                        maxLength: 10, // ✅ Limit to 10 digits
                        inputFormatters: [
                          FilteringTextInputFormatter
                              .digitsOnly, // ✅ Allow only digits
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Mobile Number:',
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          counterText: "", // ✅ Hide maxLength counter text
                        ),
                        style: const TextStyle(color: Colors.black),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'Mobile number is required';
                          }
                          if (!RegExp(r'^\d{10}$').hasMatch(v)) {
                            return 'Enter a valid 10-digit mobile number';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        controller: _desktopContactMessageController,
                        maxLines: 4,
                        decoration: InputDecoration(
                            labelText: 'Message:',
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10)),
                        style: TextStyle(color: Colors.black),
                        validator: (v) => v == null || v.isEmpty
                            ? 'Message is required'
                            : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: 240,
                        child: ElevatedButton(
                          onPressed: contactController.isLoading
                              ? null
                              : () async {
                                  if (_desktopContactFormKey.currentState!
                                      .validate()) {
                                    final inquiry = ContactInquiry(
                                      name: _desktopContactNameController.text,
                                      email:
                                          _desktopContactEmailController.text,
                                      phone:
                                          _desktopContactMobileController.text,
                                      message:
                                          _desktopContactMessageController.text,
                                    );
                                    final controller = context
                                        .read<ContactInquiryController>();
                                    await controller
                                        .submitContactInquiry(inquiry)
                                        .then((success) {
                                      if (success) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    controller.successMessage!),
                                                backgroundColor: Colors.green));
                                        _desktopContactNameController.clear();
                                        _desktopContactEmailController.clear();
                                        _desktopContactMobileController.clear();
                                        _desktopContactMessageController
                                            .clear();
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    controller.errorMessage!),
                                                backgroundColor: Colors.red));
                                      }
                                    });
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFE7A20E),
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: contactController.isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: contactFormButtonSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDisclaimerMarqueeDesktopOriginal(
      BuildContext context, double marqueeFontSize) {
    return ClipRect(
      child: SlideTransition(
        position: _scrollAnimation,
        child: Row(
          children: [
            SizedBox(width: 30),
            Text(
              'Disclaimer: ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'We do not charge for hiring!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterDesktopOriginal(
      BuildContext context, double footerFontSize) {
    return Container(
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
                fontSize: footerFontSize,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Text(
              'Developed by Avanzo Cyber Security Solutions Pvt.Ltd.',
              style: TextStyle(
                color: Colors.white,
                fontSize: footerFontSize,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookAnAppointmentFieldsOriginal({
    required String firstFieldLabel,
    required TextEditingController firstFieldController,
    required String secondFieldLabel,
    required TextEditingController secondFieldController,
  }) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      height: 40,
      color: Color(0xFFF2F3F5),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 8.0),
                  child: Text(
                    firstFieldLabel,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: firstFieldController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 5,
                      ),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 8.0),
                  child: Text(
                    secondFieldLabel,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: secondFieldController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 5,
                      ),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _originalOutPatientServices({
    required BoxConstraints outpatientconstraints,
    required String image,
    required String title,
    required String content,
  }) {
    return Expanded(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              color: Color(0xFF3FAE9E),
              padding: const EdgeInsets.all(10),
              child: ClipOval(
                child: Image.asset(image,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Icon(Icons.error, size: 30)),
              ),
            ),
          ),
          SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5),
              SizedBox(
                width: outpatientconstraints.maxWidth * .3,
                child: Text(
                  content,
                  softWrap: true,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopHealthTipBox(
      {required String title,
      required String image,
      required String content,
      required Color backgroundColor,
      required double width,
      required double height}) {
    return Container(
      height: height,
      width: width,
      color: backgroundColor,
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Image.asset(image,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) =>
                        Icon(Icons.info, color: Colors.white, size: 30)),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                height: 1.5,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDesktopPatientCountBox(
      {required double width, required double height}) {
    return Container(
      height: height, // Use the passed height (275)
      width: width, // This will be infinity via Expanded, which is fine
      color: Color(0xFF1BA08F),
      padding: EdgeInsets.all(15),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 90,
                height: 90,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Color(0xFFE7A20E),
                    BlendMode.srcATop,
                  ),
                  child: Image.asset('assets/img/patient icon.webp',
                      errorBuilder: (c, e, s) => Icon(Icons.people_alt_outlined,
                          size: 40, color: Color(0xFFE7A20E))),
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                // Added Flexible here to prevent text overflow inside the box
                child: Text(
                  "PATIENT COUNT",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Text(
            '1,30,000+',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopServiceImage(
      String imagePath, String text, double screenWidth) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 400,
          height: 350,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) =>
                      Container(color: Colors.grey[300])),
              Positioned.fill(
                  child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.6)
              ], begin: Alignment.center, end: Alignment.bottomCenter)))),
              Positioned(
                left: 0,
                right: 0,
                bottom: 10,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopContactColumn({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: ContactColumn(
          icon: icon,
          title: title,
          description: description,
        ),
      ),
    );
  }

  Widget _buildOriginalSpecialtiesList(
      {required List<String> specialties, required double fontSize}) {
    return Text(
      specialties.join('\n'),
      textAlign: TextAlign.left,
      style: TextStyle(
          color: const Color.fromARGB(255, 24, 21, 21),
          fontSize: fontSize,
          height: 1.5),
    );
  }

  // PreferredSizeWidget _buildMobileTabletAppBar(
  //     BuildContext context, bool isDesktop, bool isTablet, bool isMobile) {
  //   double iconSize = isMobile ? 20 : 24;
  //   double emailFontSize = isMobile ? 12 : (isTablet ? 14 : 16);
  //   return AppBar(
  //     leading: IconButton(
  //       icon: Icon(Icons.menu, color: Colors.black),
  //       onPressed: () => _scaffoldKey.currentState?.openDrawer(),
  //     ),
  //     title: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         if (isTablet)
  //           Flexible(
  //             child: Row(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Icon(Icons.mail,
  //                     color: const Color.fromARGB(255, 90, 78, 78),
  //                     size: iconSize),
  //                 SizedBox(width: 10),
  //                 Flexible(
  //                   child: Text(
  //                     'reachus@highlandhospital.in',
  //                     style: TextStyle(
  //                         color: Colors.black, fontSize: emailFontSize),
  //                     overflow: TextOverflow.ellipsis,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         if (isMobile) CoreLogo(),
  //         if (isTablet) HighlandSocialBar(iconSize: iconSize),
  //       ],
  //     ),
  //     backgroundColor: Color(0xFFFFFFFF),
  //     elevation: 1.0,
  //   );
  // }
  PreferredSizeWidget _buildMobileTabletAppBar(
      BuildContext context, bool isDesktop, bool isTablet, bool isMobile) {
    double iconSize = isMobile ? 18 : 22;
    // Adjusted font size back to readable dimensions, or keep your 30 if preferred
    double emailFontSize = isMobile ? 14 : 16;

    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.menu, color: Colors.black),
        onPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // **** CLICKABLE EMAIL SECTION ****
          Flexible(
            child: InkWell(
              // onTap triggers the mailto action
              onTap: () async {
                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: 'reachus@highlandhospital.in',
                  query: 'subject=Enquiry', // Optional: adds a subject line
                );
                if (await canLaunchUrl(emailLaunchUri)) {
                  await launchUrl(emailLaunchUri);
                } else {
                  // Fallback if specific email app launch fails
                  await launchUrl(
                      Uri.parse('mailto:reachus@highlandhospital.in'));
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0), // increased hit area
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.mail,
                      color: const Color.fromARGB(255, 90, 78, 78),
                      size: iconSize,
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'reachus@highlandhospital.in',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20, // Adjusted for mobile visibility
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Social Icons (Tablet only)
          if (isTablet) HighlandSocialBar(iconSize: iconSize),
        ],
      ),
      backgroundColor: Color(0xFFFFFFFF),
      elevation: 1.0,
    );
  }

  // Widget _buildAppDrawer(BuildContext context) {
  //   return Drawer(
  //     child: ListView(
  //       padding: EdgeInsets.zero,
  //       children: [
  //         DrawerHeader(
  //           decoration: BoxDecoration(color: Color(0xFF1FBCB1)),
  //           child: Center(child: CoreLogo()),
  //         ),
  //         ...menuItems
  //             .map((item) => ListTile(
  //                   title: Text(item),
  //                   onTap: () => onMenuItemTapped(item),
  //                 ))
  //             .toList(),
  //       ],
  //     ),
  //   );
  // }
  Widget _buildAppDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        // 1. Wrap with a Column
        children: [
          Expanded(
            // 3. Allow ListView to take available space
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: Color(0xFF1FBCB1)),
                  child: Center(child: CoreLogo()),
                ),
                ...menuItems
                    .map((item) => ListTile(
                          title: Text(item, style: TextStyle(fontSize: 25)),
                          onTap: () => onMenuItemTapped(item),
                        ))
                    .toList(),
              ],
            ),
          ),
          // 2. Add the social media icons at the bottom
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child:
                HighlandSocialBar(iconSize: 30), // Adjust icon size as needed
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSectionResponsive(
      BuildContext context,
      Size screenSize,
      bool isDesktop,
      bool isTablet,
      bool isMobile,
      double textSize,
      double buttonTextSize) {
    double imageWidth =
        isMobile ? screenSize.width * 0.6 : screenSize.width * 0.4;
    double imageHeight =
        isMobile ? screenSize.height * 0.25 : screenSize.height * 0.3;
    double verticalSpacing = isMobile ? 10 : 20;
    double horizontalPadding = isMobile ? 20 : 50;
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset('assets/img/bg.jpeg',
            height:
                isMobile ? screenSize.height * 0.5 : screenSize.height * 0.7,
            width: screenSize.width,
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) => Container(
                height: isMobile
                    ? screenSize.height * 0.5
                    : screenSize.height * 0.7,
                width: screenSize.width,
                color: Colors.grey[300])),
        Positioned.fill(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/img/LogowithISO.png',
                    height: imageHeight,
                    width: imageWidth,
                    fit: BoxFit.contain,
                    errorBuilder: (c, e, s) => Container(
                        height: imageHeight,
                        width: imageWidth,
                        color: Colors.grey[200])),
                SizedBox(height: verticalSpacing),
                SizedBox(
                  width: imageWidth * 1.5,
                  child: Text(
                    '''At Highland Hospital, it's not just healthcare but care for your health''',
                    maxLines: isMobile ? 3 : 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: textSize,
                      fontWeight: FontWeight.normal,
                      color: const Color.fromARGB(255, 15, 2, 2),
                    ),
                  ),
                ),
                SizedBox(height: verticalSpacing),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeDashboard()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF7CB3AC),
                    padding: EdgeInsets.symmetric(
                        vertical: isMobile ? 10 : 12,
                        horizontal: isMobile ? 20 : 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(isMobile ? 4.0 : 2.0),
                    ),
                    elevation: 3,
                  ),
                  child: Text(
                    'Our Specialties',
                    style: TextStyle(
                      fontSize: buttonTextSize,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeSectionResponsive(
      BuildContext context,
      Size screenSize,
      bool isDesktop,
      bool isTablet,
      bool isMobile,
      double heading1,
      double heading2) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 15 : 30),
      child: Column(
        children: [
          Text(
            "Welcome to Highland Hospital",
            style: TextStyle(
                fontSize: heading1,
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 24, 5, 5)),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 5 : 10),
          Text(
            "Established in 1995",
            style: TextStyle(
              fontSize: heading2,
              fontWeight: FontWeight.normal,
              color: Color(0xFF6CC1B6),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 8 : 10),
          Container(
            width: isMobile ? screenSize.width * 0.4 : screenSize.width * .25,
            height: 2,
            decoration: BoxDecoration(color: Color(0xFFF1B056)),
          ),
        ],
      ),
    );
  }

  Widget _buildHospitalDescriptionResponsive(
      BuildContext context,
      Size screenSize,
      bool isDesktop,
      bool isTablet,
      bool isMobile,
      double bodyTextLarge) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : screenSize.width * 0.15),
      child: Text(
        '''Our 250 bedded hospital brings you the best in multispecialty treatment with state-of-the-art technology focusing on various specialties including Critical Care, Cardiology, Cardiac Surgery, Orthopaedic & Joint Replacement, Neurology, Neuro-Surgery, Pulmonology, Gastroenterology, Diabetes and Endocrinology, Paediatrics, Gynaecology, Nephrology,Urology, and many more. The focus of healthcare at Highland Hospital is the health and wellbeing of our patients, utilising the latest infrastructure and qualified medical expertise available while at the same time ensuring affordability.''',
        style: TextStyle(
          fontSize: bodyTextLarge,
          fontWeight: FontWeight.normal,
          color: Color(0xFF555555),
          height: 1.4,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _buildKnowMoreButtonResponsive(BuildContext context, Size screenSize,
      bool isDesktop, bool isTablet, bool isMobile, double buttonTextSize) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => About()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF78CAC6),
        padding: EdgeInsets.symmetric(
            vertical: isMobile ? 12 : 15, horizontal: isMobile ? 30 : 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isMobile ? 4.0 : 2.0),
        ),
        elevation: 3,
      ),
      child: Text(
        'Know more',
        style: TextStyle(
            fontSize: buttonTextSize,
            fontWeight: FontWeight.bold,
            color: Colors.black),
      ),
    );
  }

  // Widget _buildFeatureCarouselResponsive(BuildContext context, Size screenSize,
  //     bool isDesktop, bool isTablet, bool isMobile) {
  //   List<Widget> carouselItems = [
  //     _buildCarouselItem(context, screenSize, isMobile,
  //         image: 'assets/img/find a doctor.png',
  //         label: 'FIND A DOCTOR',
  //         backgroundColor: Color(0xFF1FBCB1)),
  //     _buildCarouselItem(context, screenSize, isMobile,
  //         image: 'assets/img/Test result.png',
  //         label: 'TEST RESULT',
  //         backgroundColor: Color(0xFFEE9821)),
  //     _buildCarouselItem(context, screenSize, isMobile,
  //         image: 'assets/img/online admission.png',
  //         label: 'ONLINE ADMISSION',
  //         backgroundColor: Color(0xFF1BA08D)),
  //     _buildCarouselItem(context, screenSize, isMobile,
  //         image: 'assets/img/Patient acces.png',
  //         label: 'PATIENT ACCESS',
  //         backgroundColor: Color(0xFF5592C8)),
  //   ];

  //   if (isMobile) {
  //     return Center(
  //       child: SingleChildScrollView(
  //         scrollDirection: Axis.horizontal,
  //         child: Row(
  //           children: carouselItems
  //               .map((item) => Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 6.0),
  //                     child: item,
  //                   ))
  //               .toList(),
  //         ),
  //       ),
  //     );
  //   } else {
  //     return Center(
  //       child: Container(
  //         constraints: BoxConstraints(maxWidth: 1200),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: carouselItems
  //               .map((item) => Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                     child: item,
  //                   ))
  //               .toList(),
  //         ),
  //       ),
  //     );
  //   }
  // }

  // Widget _buildCarouselItem(
  //     BuildContext context, Size screenSize, bool isMobile,
  //     {required String image,
  //     required String label,
  //     required Color backgroundColor}) {
  //   double itemHeight = isMobile ? 200 : 290;
  //   double imageSize = isMobile ? 50 : 70;
  //   double labelSize = isMobile ? 16 : 20;

  //   return Container(
  //     width: MediaQuery.of(context).size.width * (83 / 375),
  //     height: itemHeight,
  //     color: backgroundColor,
  //     margin: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 4),
  //     padding: EdgeInsets.all(isMobile ? 8 : 12),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Image.asset(image,
  //             width: imageSize,
  //             height: imageSize,
  //             fit: BoxFit.contain,
  //             errorBuilder: (c, e, s) => Icon(Icons.image_not_supported,
  //                 size: imageSize, color: Colors.white54)),
  //         SizedBox(height: 8),
  //         Text(
  //           label,
  //           textAlign: TextAlign.center,
  //           style: TextStyle(
  //             fontSize: labelSize,
  //             fontWeight: FontWeight.bold,
  //             color: Colors.white,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget _buildFeatureCarouselResponsive(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    List<Widget> carouselItems = [
      _buildCarouselItem(
          'assets/img/find a doctor.png', 'FIND A DOCTOR', Color(0xFF1FBCB1)),
      _buildCarouselItem(
          'assets/img/Test result.png', 'TEST RESULT', Color(0xFFEE9821)),
      _buildCarouselItem('assets/img/online admission.png', 'ONLINE ADMISSION',
          Color(0xFF1BA08D)),
      _buildCarouselItem(
          'assets/img/Patient acces.png', 'PATIENT ACCESS', Color(0xFF5592C8)),
    ];

    if (isMobile) {
      // **** THIS IS THE CORRECTED SECTION FOR MOBILE ****
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          // Use a Column to stack items vertically
          children: carouselItems
              .map((item) => Padding(
                    padding: const EdgeInsets.only(
                        bottom: 15.0), // Add space between items
                    child: item,
                  ))
              .toList(),
        ),
      );
    } else {
      // Desktop layout remains the same
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 20, height: 277, color: Color(0xFF1FBCB1)),
            ...carouselItems.map((item) => Expanded(child: item)),
            Container(width: 20, height: 277, color: Color(0xFF5592C8)),
          ],
        ),
      );
    }
  }

  Widget _buildCarouselItem(String image, String label, Color backgroundColor) {
    final bool isMobile = Responsive.isMobile(context);
    // Adjust sizes for better appearance
    double itemHeight = isMobile ? 180 : 277;
    double imageSize = isMobile ? 60 : 80;
    double labelSize = isMobile ? 18 : 18;

    return Container(
      // **** THIS IS THE OTHER KEY CHANGE ****
      width: isMobile ? double.infinity : null, // Fill width on mobile
      height: itemHeight,
      color: backgroundColor,
      margin: isMobile ? EdgeInsets.zero : EdgeInsets.symmetric(horizontal: 1),
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image,
              width: imageSize,
              height: imageSize,
              fit: BoxFit.contain,
              color: Colors.white),
          SizedBox(height: 15),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: labelSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildVisionMissionSectionResponsive(
    BuildContext context,
    Size screenSize,
    bool isDesktop,
    bool isTablet,
    bool isMobile,
    double bodyTextMedium,
  ) {
    double imageWidth =
        isMobile ? screenSize.width * 0.9 : screenSize.width * 0.4;
    double imageHeight = isMobile ? 180 : 250;
    double borderRadius = isMobile ? 16 : 40;

    Widget visionImage = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        'assets/img/vision.jpeg',
        width: imageWidth,
        height: imageHeight,
        fit: BoxFit.cover,
        errorBuilder: (c, e, s) => Container(
          width: imageWidth,
          height: imageHeight,
          color: Colors.grey[300],
        ),
      ),
    );

    Widget missionImage = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        'assets/img/mission.jpg',
        width: imageWidth,
        height: imageHeight,
        fit: BoxFit.cover,
        errorBuilder: (c, e, s) => Container(
          width: imageWidth,
          height: imageHeight,
          color: Colors.grey[300],
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 30),
      child: isMobile
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                visionImage,
                SizedBox(height: 20),
                missionImage,
                SizedBox(height: 20),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                visionImage,
                SizedBox(width: 20),
                missionImage,
              ],
            ),
    );
  }

  Widget _buildBookingAndInfoSectionResponsive(
      BuildContext context,
      Size screenSize,
      bool isDesktop,
      bool isTablet,
      bool isMobile,
      double headingSize,
      double bodySize,
      double buttonSize) {
    Widget visionMissionTextBoxes = _buildVisionMissionTextBoxesResponsive(
        context,
        screenSize,
        isDesktop,
        isTablet,
        isMobile,
        headingSize,
        bodySize);
    Widget bookingForm = _buildBookingAppointmentFormResponsive(
        context,
        screenSize,
        isDesktop,
        isTablet,
        isMobile,
        headingSize,
        bodySize,
        buttonSize);
    if (isMobile) {
      return Column(
        children: [
          SizedBox(height: 30),
          visionMissionTextBoxes,
          SizedBox(height: 30),
          bookingForm,
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            visionMissionTextBoxes,
            SizedBox(height: 30),
            bookingForm,
          ],
        ),
      );
    }
  }

  Widget _buildVisionMissionTextBoxesResponsive(
      BuildContext context,
      Size screenSize,
      bool isDesktop,
      bool isTablet,
      bool isMobile,
      double headingSize,
      double bodySize) {
    double boxWidth =
        isMobile ? screenSize.width * 0.85 : screenSize.width * 0.42;
    double boxHeight = isMobile ? 180 : 200;
    Widget visionBox = Container(
      width: boxWidth,
      height: boxHeight,
      padding: EdgeInsets.all(isMobile ? 10 : 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(isMobile ? 8 : 10),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('VISION',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: headingSize,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                '''To be a beacon of healthcare excellence, where “YOUR HEALTH, OUR CARE” is not just a tagline but a promise. We envision Highland Hospital as a leader in innovation and compassionate care, ensuring that every patient—regardless of their background—receives world-class, accessible healthcare. Through dedication to patient well-being, cutting-edge technology, and community welfare, we aim to shape a future where healthcare is a right, not a privilege.''',
                style: TextStyle(
                    color: Color.fromARGB(255, 50, 50, 50),
                    fontSize: bodySize,
                    height: 1.3),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    );
    Widget missionBox = Container(
      width: boxWidth,
      height: boxHeight,
      padding: EdgeInsets.all(isMobile ? 10 : 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(isMobile ? 8 : 10),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('MISSION',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: headingSize,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                '''To provide advanced, patient-centered healthcare through our guiding principle of “YOUR HEALTH, OUR CARE.” We are dedicated to delivering the highest standards of care with empathy, integrity, and innovation. By investing in both our people and technology, we strive to improve the health and well-being of every individual we serve. We aim to create a supportive environment where every patient feels valued, ensuring accessible, high-quality healthcare that elevates lives and strengthens our community.''',
                style: TextStyle(
                    color: Color.fromARGB(255, 50, 50, 50),
                    fontSize: bodySize,
                    height: 1.3),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    );
    if (isMobile) {
      return Column(
        children: [visionBox, SizedBox(height: 20), missionBox],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [visionBox, SizedBox(width: 15), missionBox],
      );
    }
  }

  Widget _buildBookingAppointmentFormResponsive(
    BuildContext context,
    Size screenSize,
    bool isDesktop,
    bool isTablet,
    bool isMobile,
    double headingSize,
    double bodySize,
    double buttonSize,
  ) {
    final formKey = GlobalKey<FormState>();

    double formWidth = isMobile
        ? screenSize.width * 0.95
        : (isTablet ? screenSize.width * 0.65 : screenSize.width * 0.5);

    double fieldHeight = isMobile ? 55 : (isTablet ? 60 : 50);
    double inputFontSize = isMobile ? 16 : (isTablet ? 18 : 15);
    double borderRadius = isMobile ? 16 : (isTablet ? 20 : 18);
    double formBorderRadius = isMobile ? 18 : (isTablet ? 24 : 20);

    final bookingController = context.watch<BookingEnquiryController>();

    return SingleChildScrollView(
      child: Container(
        width: formWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(formBorderRadius),
          border: Border.all(color: const Color(0xFFEE9821), width: 2),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🟢 Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: isMobile ? 12 : 15),
              decoration: BoxDecoration(
                color: const Color(0xFF1BA08F),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  topRight: Radius.circular(borderRadius),
                ),
              ),
              child: Text(
                'Booking Enquiry',
                style: TextStyle(
                  fontSize: headingSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // 🟣 Form
            Padding(
              padding: EdgeInsets.all(isMobile ? 15 : 20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Request a callback from our team',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: isMobile ? 15 : 20),

                    // 🔹 Fields
                    if (isMobile) ...[
                      _buildAppointmentTextFieldResponsive(
                          label: 'First Name :',
                          controller: _desktopBookFirstNameController,
                          isMobile: isMobile,
                          height: fieldHeight,
                          inputFontSize: inputFontSize),
                      const SizedBox(height: 10),
                      _buildAppointmentTextFieldResponsive(
                          label: 'Last Name :',
                          controller: _desktopBookLastNameController,
                          isMobile: isMobile,
                          height: fieldHeight,
                          inputFontSize: inputFontSize),
                      const SizedBox(height: 10),
                      _buildAppointmentTextFieldResponsive(
                          label: 'Email :',
                          controller: _desktopBookEmailController,
                          isMobile: isMobile,
                          keyboardType: TextInputType.emailAddress,
                          height: fieldHeight,
                          inputFontSize: inputFontSize),
                      const SizedBox(height: 10),
                      _buildAppointmentTextFieldResponsive(
                          label: 'Address :',
                          controller: _desktopBookAddressController,
                          isMobile: isMobile,
                          height: fieldHeight,
                          inputFontSize: inputFontSize),
                      const SizedBox(height: 10),
                      _buildAppointmentTextFieldResponsive(
                        label: 'Phone Number :',
                        controller: _desktopBookPhoneController,
                        isMobile: isMobile,
                        keyboardType: TextInputType.number,
                        height: fieldHeight,
                        inputFontSize: inputFontSize,

                        // 👇 ADD THESE LINES
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter
                              .digitsOnly, // Allows only 0-9
                          LengthLimitingTextInputFormatter(
                              10), // Hard limit to 10 chars
                        ],
                      ),
                    ] else ...[
                      Row(
                        children: [
                          Expanded(
                            child: _buildAppointmentTextFieldResponsive(
                              label: 'First Name :',
                              controller: _desktopBookFirstNameController,
                              isMobile: isMobile,
                              height: fieldHeight,
                              inputFontSize: inputFontSize,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildAppointmentTextFieldResponsive(
                              label: 'Last Name :',
                              controller: _desktopBookLastNameController,
                              isMobile: isMobile,
                              height: fieldHeight,
                              inputFontSize: inputFontSize,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _buildAppointmentTextFieldResponsive(
                              label: 'Email :',
                              controller: _desktopBookEmailController,
                              isMobile: isMobile,
                              keyboardType: TextInputType.emailAddress,
                              height: fieldHeight,
                              inputFontSize: inputFontSize,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildAppointmentTextFieldResponsive(
                              label: 'Address :',
                              controller: _desktopBookAddressController,
                              isMobile: isMobile,
                              height: fieldHeight,
                              inputFontSize: inputFontSize,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _buildAppointmentTextFieldResponsive(
                        label: 'Phone Number :',
                        controller: _desktopBookPhoneController,
                        isMobile: isMobile,
                        // Change keyboardType to number
                        keyboardType: TextInputType.number,
                        height: fieldHeight,
                        inputFontSize: inputFontSize,

                        // 👇 ADD THESE LINES TO FIX DESKTOP/TABLET VIEW 👇
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                      ),
                    ],

                    SizedBox(height: isMobile ? 20 : 25),

                    // 🟡 Button
                    Center(
                      child: ElevatedButton(
                        onPressed: bookingController.isLoading
                            ? null
                            : () async {
                                if (formKey.currentState!.validate()) {
                                  final enquiry = BookingEnquiry(
                                    firstName:
                                        _desktopBookFirstNameController.text,
                                    lastName:
                                        _desktopBookLastNameController.text,
                                    phone: _desktopBookPhoneController.text,
                                    email: _desktopBookEmailController.text,
                                    address: _desktopBookAddressController.text,
                                  );

                                  final controller =
                                      context.read<BookingEnquiryController>();

                                  await controller.submitEnquiry(enquiry).then(
                                    (success) {
                                      if (success) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              controller.successMessage ?? ''),
                                          backgroundColor: Colors.green,
                                        ));
                                        _desktopBookFirstNameController.clear();
                                        _desktopBookLastNameController.clear();
                                        _desktopBookPhoneController.clear();
                                        _desktopBookEmailController.clear();
                                        _desktopBookAddressController.clear();
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              controller.errorMessage ?? ''),
                                          backgroundColor: Colors.red,
                                        ));
                                      }
                                    },
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEE9821),
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(
                            vertical: isMobile ? 12 : 14,
                            horizontal: isMobile ? 30 : 50,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(isMobile ? 6 : 8),
                          ),
                          elevation: 3,
                        ),
                        child: bookingController.isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : Text(
                                'Request Callback',
                                style: TextStyle(
                                  fontSize: buttonSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildAppointmentTextFieldResponsive(
  //     {required String label,
  //     required TextEditingController controller,
  //     required bool isMobile,
  //     TextInputType keyboardType = TextInputType.text,
  //     required double height,
  //     required double inputFontSize}) {
  //   return SizedBox(
  //     height: height,
  //     child: TextFormField(
  //       controller: controller,
  //       keyboardType: keyboardType,
  //       style: TextStyle(fontSize: inputFontSize),
  //       decoration: InputDecoration(
  //         labelText: label,
  //         labelStyle:
  //             TextStyle(fontSize: inputFontSize, color: Colors.grey[600]),
  //         filled: true,
  //         fillColor: Color(0xFFF2F3F5),
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
  //           borderSide: BorderSide.none,
  //         ),
  //         contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
  //         isDense: true,
  //       ),
  //       validator: (value) {
  //         if (value == null || value.isEmpty) {
  //           return 'Please enter $label';
  //         }
  //         if (label == 'Email' &&
  //             !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
  //           return 'Please enter a valid email';
  //         }
  //         if (label == 'Phone Number' && !RegExp(r'^\d{10}$').hasMatch(value)) {
  //           return 'Enter a valid 10-digit number';
  //         }
  //         return null;
  //       },
  //     ),
  //   );
  // }
  Widget _buildAppointmentTextFieldResponsive({
    required String label,
    required TextEditingController controller,
    required bool isMobile,
    double? height,
    double? inputFontSize,
    TextInputType? keyboardType,
    // Add these optional parameters
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return SizedBox(
      height: height ?? 55,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        // Apply the new constraints
        maxLength: maxLength,
        inputFormatters: inputFormatters,

        decoration: InputDecoration(
          labelText: label,
          // Hide the character counter (e.g., 5/10)
          counterText: "",
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          filled: true,
          fillColor: Colors.white,
        ),
        style: TextStyle(
          fontSize: inputFontSize ?? 19,
          color: Colors.black,
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter $label';
          }
          // specific validation for Phone Number
          if (label == 'Phone Number') {
            if (value.length != 10) {
              return 'Enter exactly 10 digits';
            }
          }
          return null;
        },
      ),
    );
  }

  Widget _buildOutPatientSectionResponsive(
    BuildContext context,
    Size screenSize,
    bool isDesktop,
    bool isTablet,
    bool isMobile,
    double heading1,
    double heading3,
    double bodyTextMedium,
  ) {
    // Determine image height based on device
    double imageHeight = isMobile ? 250 : (isTablet ? 300 : 400);

    // 1. Define the Text Content
    // We remove the fixed 'width' here or let Expanded override it later.
    Widget textContent = Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Out-Patient Services',
          style: TextStyle(
            fontSize: heading1,
            fontWeight: FontWeight.bold,
            color: Color(0xFF494949),
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        SizedBox(height: 5),
        Container(
          width: isMobile ? 100 : 120,
          height: 3,
          color: Colors.black,
          margin: isMobile
              ? EdgeInsets.only(bottom: 15)
              : EdgeInsets.only(bottom: 15, left: 0),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8),
          margin: EdgeInsets.only(bottom: isMobile ? 20 : 30),
          decoration: BoxDecoration(
            color: Color(0xFF1BA08F),
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          child: Text(
            'We provide the following features',
            style: TextStyle(
                fontSize: heading3,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          ),
        ),
        // Layout the items (Health, Surgery, etc.)
        if (isMobile || isTablet)
          Wrap(
            spacing: 15,
            runSpacing: 20,
            children: [
              _buildOutPatientServiceItemResponsive(
                  context, true, // treat tablet like mobile for inner items
                  image: 'assets/img/health.png',
                  title: 'Health',
                  content: '''"The First Wealth is Health"''',
                  bodyTextMedium: bodyTextMedium),
              _buildOutPatientServiceItemResponsive(context, true,
                  image: 'assets/img/Surgeryicon.png',
                  title: 'Surgery',
                  content: '''"Truth Like Surgery May Hurt But It Cures"''',
                  bodyTextMedium: bodyTextMedium),
              _buildOutPatientServiceItemResponsive(context, true,
                  image: 'assets/img/careers.png',
                  title: 'Careers',
                  content: '''"Be So good They Can't ignore you"''',
                  bodyTextMedium: bodyTextMedium),
              _buildOutPatientServiceItemResponsive(context, true,
                  image: 'assets/img/calender.png',
                  title: 'Planning',
                  content: '''"If You Can Dream It, You Can Do It."''',
                  bodyTextMedium: bodyTextMedium),
            ],
          )
        else
          // Desktop Layout for items
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOutPatientServiceItemResponsive(context, false,
                        image: 'assets/img/health.png',
                        title: 'Health',
                        content: '''"The First Wealth is Health"''',
                        bodyTextMedium: bodyTextMedium),
                    SizedBox(height: 20),
                    _buildOutPatientServiceItemResponsive(context, false,
                        image: 'assets/img/careers.png',
                        title: 'Careers',
                        content: '''"Be So good They Can't ignore you"''',
                        bodyTextMedium: bodyTextMedium),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOutPatientServiceItemResponsive(context, false,
                        image: 'assets/img/Surgeryicon.png',
                        title: 'Surgery',
                        content:
                            '''"Truth Like Surgery May Hurt But It Cures"''',
                        bodyTextMedium: bodyTextMedium),
                    SizedBox(height: 20),
                    _buildOutPatientServiceItemResponsive(context, false,
                        image: 'assets/img/calender.png',
                        title: 'Planning',
                        content: '''"If You Can Dream It, You Can Do It."''',
                        bodyTextMedium: bodyTextMedium),
                  ],
                ),
              ),
            ],
          ),
      ],
    );

    // 2. Define the Image Content
    Widget imageContent = SizedBox(
      height: imageHeight,
      child: Image.asset(
        'assets/img/out_patient.jpg',
        fit: BoxFit.contain,
        errorBuilder: (c, e, s) => Container(
          height: imageHeight,
          color: Colors.grey[300],
          child: Icon(Icons.image),
        ),
      ),
    );

    // 3. Final Layout Return
    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            textContent,
            SizedBox(height: 20),
            imageContent,
          ],
        ),
      );
    } else {
      // DESKTOP / TABLET FIX:
      // Use Expanded to force children to fit within the screen width.
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Expanded forces text content to take up available space (flex 5)
            Expanded(
              flex: 5,
              child: textContent,
            ),
            SizedBox(width: 20),
            // Expanded forces image to take up remaining space (flex 4)
            Expanded(
              flex: 4,
              child: imageContent,
            ),
          ],
        ),
      );
    }
  }

  Widget _buildOutPatientServiceItemResponsive(
      BuildContext context, bool isMobile,
      {required String image,
      required String title,
      required String content,
      required double bodyTextMedium}) {
    double iconSize = isMobile ? 40 : 50;
    double titleSize = isMobile ? 14 : 16;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(isMobile ? 8 : 10),
          decoration: BoxDecoration(
            color: Color(0xFF3FAE9E),
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            image,
            width: iconSize,
            height: iconSize,
            fit: BoxFit.contain,
            errorBuilder: (c, e, s) =>
                Icon(Icons.error, size: iconSize, color: Colors.white),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 3),
              Text(
                content,
                style: TextStyle(
                    fontSize: bodyTextMedium,
                    fontWeight: FontWeight.normal,
                    color: Colors.black54,
                    height: 1.3),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServicesAndContactSectionResponsive(
      BuildContext context,
      Size screenSize,
      bool isDesktop,
      bool isTablet,
      bool isMobile,
      double headingSize,
      double bodyTextMedium,
      double buttonTextSize) {
    double tipsHeight = isMobile ? 160 : 180;
    double tipsWidth =
        isMobile ? screenSize.width * 0.9 : screenSize.width * 0.3;
    double serviceImageHeight = isMobile ? 200 : 280;
    double contactIconSize = isMobile ? 24 : 32;
    double contactTitleSize = isMobile ? 14 : 16;
    double contactDescSize = isMobile ? 12 : 14;
    List<Widget> tipsWidgets = [
      _buildHealthTipBoxResponsive(context, isMobile, tipsHeight, tipsWidth,
          backgroundColor: Color.fromARGB(255, 231, 162, 14),
          title: "HEALTH TIPS",
          image: 'assets/img/healthi.png',
          content:
              '''Add more fruits and vegetables to your daily meals — your heart will thank you!''',
          bodyTextSize: bodyTextMedium * 0.9),
      _buildHealthTipBoxResponsive(context, isMobile, tipsHeight, tipsWidth,
          backgroundColor: Color(0xFF3FAE9E),
          title: "LATEST NEWS",
          image: 'assets/img/Latest.png',
          content:
              '''Our hospital continues to provide 24/7 emergency care with the latest medical technology and dedicated specialists.''',
          bodyTextSize: bodyTextMedium * 0.9),
      _buildPatientCountBoxResponsive(context, isMobile, tipsHeight, tipsWidth,
          bodyTextSize: headingSize * 0.9),
    ];
    List<Widget> serviceImages = [
      _buildServiceImageResponsive(context, isMobile, serviceImageHeight,
          'assets/img/highlandservice.jpg', '', bodyTextMedium),
      _buildServiceImageResponsive(context, isMobile, serviceImageHeight,
          'assets/img/pi2.jpg', '', bodyTextMedium),
      _buildServiceImageResponsive(context, isMobile, serviceImageHeight,
          'assets/img/pi3.jpg', '', bodyTextMedium),
    ];
    // List<Widget> contactInfo = [
    //   _buildContactColumnResponsive(
    //       isMobile: isMobile,
    //       icon: Icons.location_on,
    //       title: 'Location',
    //       description: 'Mother Theresa Road...',
    //       iconSize: contactIconSize,
    //       titleSize: contactTitleSize,
    //       descriptionSize: contactDescSize),
    //   _buildContactColumnResponsive(
    //       isMobile: isMobile,
    //       icon: Icons.phone,
    //       title: 'Emergency 24x7',
    //       description: '0824-4235555',
    //       iconSize: contactIconSize,
    //       titleSize: contactTitleSize,
    //       descriptionSize: contactDescSize),
    //   _buildContactColumnResponsive(
    //       isMobile: isMobile,
    //       icon: Icons.email,
    //       title: 'Email',
    //       description: 'reachus@highlandhospital.in',
    //       iconSize: contactIconSize,
    //       titleSize: contactTitleSize,
    //       descriptionSize: contactDescSize),
    // ];
    List<Widget> contactInfo = [
      _buildContactColumnResponsive(
        isMobile: isMobile,
        icon: Icons.location_on,
        title: 'Location',
        description:
            'Mother Theresa Road,\nKankanady, Highland Hospitals,\nMangaluru, Karnataka 575002,\nIndia.',
        iconSize: contactIconSize,
        titleSize: contactTitleSize,
        descriptionSize: contactDescSize,
        iconColor: const Color(0xFFEE9821), // Purple accent color
        textColor: Colors.black87,
        onTap: () => _launchURL(
          'https://www.google.com/maps/place/Highland+Hospital/@12.8664995,74.8546887,17z/data=!3m1!4b1!4m6!3m5!1s0x3ba35a34c13203f9:0xfb2782cbf31a7784!8m2!3d12.8664995!4d74.8546887!16s%2Fg%2F1thcl645?entry=ttu',
        ),
      ),
      _buildContactColumnResponsive(
        isMobile: isMobile,
        icon: Icons.phone,
        title: 'Emergency 24x7',
        description: '0824-4235555',
        iconSize: contactIconSize,
        titleSize: contactTitleSize,
        descriptionSize: contactDescSize,
        iconColor: const Color(0xFFEE9821),
        textColor: Colors.black87,
        onTap: () => makePhoneCall('08244235555', context),
      ),
      _buildContactColumnResponsive(
        isMobile: isMobile,
        icon: Icons.email,
        title: 'Email',
        description: 'reachus@highlandhospital.in',
        iconSize: contactIconSize,
        titleSize: contactTitleSize,
        descriptionSize: contactDescSize,
        iconColor: const Color(0xFFEE9821),
        textColor: Colors.black87,
        onTap: () => _launchURL(
          'mailto:reachus@highlandhospital.in?subject=Hospital%20Inquiry',
        ),
      ),
    ];

    return Container(
      width: screenSize.width,
      color: Color(0xFF1FBCB1),
      padding: EdgeInsets.symmetric(vertical: isMobile ? 20 : 40),
      child: Column(
        children: [
          if (isMobile)
            Column(
                children: tipsWidgets
                    .map((w) =>
                        Padding(padding: EdgeInsets.only(bottom: 15), child: w))
                    .toList())
          else
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isTablet ? 20 : 50),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: tipsWidgets
                      .map((w) => Expanded(
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: w)))
                      .toList()),
            ),
          SizedBox(height: isMobile ? 25 : 40),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 50),
            child: Row(
              children: [
                Expanded(
                  child: Container(height: 2, color: Color(0xFFF1B056)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text("Services",
                      style: TextStyle(
                          fontSize: headingSize,
                          color: ColorConstant.mainBlack,
                          fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child: Container(height: 2, color: Color(0xFFF1B056)),
                ),
              ],
            ),
          ),
          SizedBox(height: isMobile ? 20 : 30),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 15 : (isTablet ? 30 : 50)),
            child: isMobile
                ? Column(
                    children: serviceImages
                        .map((w) => Padding(
                            padding: EdgeInsets.only(bottom: 15), child: w))
                        .toList())
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: serviceImages
                        .map((w) => Expanded(
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: w)))
                        .toList()),
          ),
          SizedBox(height: isMobile ? 30 : 50),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : (isTablet ? 40 : 80)),
            child: isMobile
                ? Column(
                    children: contactInfo
                        .map((w) => Padding(
                            padding: EdgeInsets.only(bottom: 20), child: w))
                        .toList())
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        contactInfo.map((w) => Flexible(child: w)).toList()),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthTipBoxResponsive(
      BuildContext context, bool isMobile, double height, double width,
      {required Color backgroundColor,
      required String title,
      required String image,
      required String content,
      required double bodyTextSize}) {
    double titleSize = isMobile ? 16 : 18;
    double iconSize = isMobile ? 30 : 40;
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(isMobile ? 10 : 15),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(isMobile ? 8 : 10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(title,
                    style: TextStyle(
                        fontSize: titleSize,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
              Image.asset(
                image,
                height: iconSize,
                width: iconSize,
                fit: BoxFit.contain,
                errorBuilder: (c, e, s) => Icon(Icons.info_outline,
                    size: iconSize, color: Colors.white54),
              )
            ],
          ),
          SizedBox(height: 8),
          Expanded(
            child: Text(
              content,
              style: TextStyle(
                  fontSize: bodyTextSize,
                  color: Colors.white.withOpacity(0.9),
                  height: 1.3),
              maxLines: isMobile ? 4 : 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientCountBoxResponsive(
      BuildContext context, bool isMobile, double height, double width,
      {required double bodyTextSize}) {
    double titleSize = isMobile ? 16 : 18;
    double numberSize = isMobile ? 24 : 28;
    double iconSize = isMobile ? 35 : 50;
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(isMobile ? 10 : 15),
      decoration: BoxDecoration(
        color: Color(0xFF1BA08F),
        borderRadius: BorderRadius.circular(isMobile ? 8 : 10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/patient icon.webp',
                width: iconSize,
                height: iconSize,
                fit: BoxFit.contain,
                color: Color(0xFFE7A20E),
                colorBlendMode: BlendMode.srcATop,
                errorBuilder: (c, e, s) => Icon(Icons.people_alt_outlined,
                    size: iconSize, color: Color(0xFFE7A20E)),
              ),
              SizedBox(width: 10),
              Flexible(
                  child: Text("PATIENT COUNT",
                      style: TextStyle(
                          fontSize: titleSize,
                          color: ColorConstant.mainWhite,
                          fontWeight: FontWeight.w500))),
            ],
          ),
          SizedBox(height: 8),
          Text(
            '1,30,000+',
            style: TextStyle(
                fontSize: numberSize,
                fontWeight: FontWeight.bold,
                color: ColorConstant.mainWhite),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceImageResponsive(BuildContext context, bool isMobile,
      double height, String imagePath, String text, double textSize) {
    return Container(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => Container(
                  color: Colors.grey[300],
                  child: Center(child: Text('Service Img Error'))),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.6)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            bottom: 10,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: textSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactColumnResponsive({
    required bool isMobile,
    required IconData icon,
    required String title,
    required String description,
    required double iconSize,
    required double titleSize,
    required double descriptionSize,
    required VoidCallback onTap,
    required Color iconColor,
    required Color textColor,
  }) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: iconSize),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: titleSize,
              color: textColor,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: descriptionSize,
              color: textColor.withOpacity(0.8),
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialitiesAndFormSectionResponsive(
      BuildContext context,
      Size screenSize,
      bool isDesktop,
      bool isTablet,
      bool isMobile,
      double headingSize,
      double bodyTextMedium,
      double buttonTextSize) {
    double sectionPadding = isMobile ? 20 : 40;
    double columnSpacing = isMobile ? 20 : 30;

    Widget specialities1 = _buildSpecialitiesListResponsive(
      context,
      isMobile: isMobile,
      title: 'Specialities',
      specialties: [
        'General Medicine',
        'General Surgery',
        'Orthopaedic & Trauma Care',
        'Total Knee & Hip Replacement',
        'Arthroscopy & Sports Medicine',
        'Pediatric & Pediatric Surgery',
        'Nephrology',
        'Gastroenterology',
      ],
      headingSize: headingSize,
      bodyTextMedium: bodyTextMedium,
    );

    Widget specialities2 = _buildSpecialitiesListResponsive(
      context,
      isMobile: isMobile,
      title: ' ',
      specialties: [
        'Ophthalmology',
        'E.N.T Micro Surgery',
        'Neurology and Neuro Surgery',
        'Plastic & Reconstructive Surgery',
        'Maxillofacial Surgery',
        'Microvascular Surgery',
        'Endocrinology',
        'Urology & Andrology',
      ],
      headingSize: headingSize,
      bodyTextMedium: bodyTextMedium,
    );

    Widget contactForm = _buildContactUsFormResponsive(
        context, isMobile, headingSize, bodyTextMedium, buttonTextSize);

    return Container(
      color: Color(0xFFEAEBED),
      padding: EdgeInsets.symmetric(
          vertical: sectionPadding, horizontal: sectionPadding),
      child: isMobile
          // --- MOBILE LAYOUT: Everything stacked vertically ---
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                specialities1,
                SizedBox(height: columnSpacing),
                specialities2,
                SizedBox(height: columnSpacing + 10),
                contactForm,
              ],
            )
          // --- DESKTOP LAYOUT (FIXED) ---
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // FIX: Used Expanded here.
                // The internal text lists use Flexible, so they MUST be inside
                // a parent with a defined width (like Expanded within a Row).
                Expanded(flex: 1, child: specialities1),
                SizedBox(width: columnSpacing),
                Expanded(flex: 1, child: specialities2),
                SizedBox(width: columnSpacing),
                Expanded(flex: 1, child: contactForm),
              ],
            ),
    );
  }

  Widget _buildSpecialitiesListResponsive(BuildContext context,
      {required bool isMobile,
      required String title,
      required List<String> specialties,
      required double headingSize,
      required double bodyTextMedium}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Text(
            title,
            style: TextStyle(
                color: Color.fromARGB(255, 24, 14, 14),
                fontSize: headingSize,
                fontWeight: FontWeight.bold),
          ),
        if (title.isNotEmpty) SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: specialties
              .map((spec) => Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, top: 5),
                          child: Icon(Icons.circle,
                              size: 8, color: Color(0xFF1BA08F)),
                        ),
                        Flexible(
                          child: Text(
                            spec,
                            style: TextStyle(
                                color: Color.fromARGB(255, 50, 50, 50),
                                fontSize: bodyTextMedium,
                                height: 1.3),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildContactUsFormResponsive(BuildContext context, bool isMobile,
      double headingSize, double bodyTextMedium, double buttonTextSize) {
    final contactController = context.watch<ContactInquiryController>();

    return Form(
      key: _responsiveBookingFormKey, // Use the specific key for this form
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Contact us',
          style: TextStyle(
              color: const Color.fromARGB(255, 15, 12, 12),
              fontSize: headingSize,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15),
        // **** FIX: USING CORRECT CONTROLLERS FOR THIS FORM ****
        _buildContactTextFieldResponsive(
            controller: _desktopContactNameController, // Correct controller
            label: 'Name:',
            isMobile: isMobile,
            inputFontSize: bodyTextMedium),
        SizedBox(height: 10),
        _buildContactTextFieldResponsive(
            controller: _desktopContactEmailController, // Correct controller
            label: 'Email:',
            isMobile: isMobile,
            keyboardType: TextInputType.emailAddress,
            inputFontSize: bodyTextMedium,
            validator: (v) {
              if (v == null || v.isEmpty) return 'Required';
              if (!RegExp(r'^.+@.+\..+$').hasMatch(v)) return 'Invalid email';
              return null;
            }),
        SizedBox(height: 10),
        _buildContactTextFieldResponsive(
            controller: _desktopContactMobileController,
            label: 'Mobile Number:',
            isMobile: isMobile,
            keyboardType: TextInputType.phone,
            inputFontSize: bodyTextMedium,
            maxLength: 10, // 🔹 Limit to 10 digits
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly, // 🔹 Allow digits only
            ],
            validator: (v) {
              if (v == null || v.isEmpty) return 'Required';
              if (!RegExp(r'^\d{10}$').hasMatch(v))
                return 'Invalid mobile number';
              return null;
            }),
        SizedBox(height: 10),
        _buildContactTextFieldResponsive(
            controller: _desktopContactMessageController, // Correct controller
            label: 'Message:',
            isMobile: isMobile,
            maxLines: isMobile ? 3 : 4,
            inputFontSize: bodyTextMedium,
            validator: (v) {
              if (v == null || v.isEmpty) return 'Required';
              return null;
            }),
        SizedBox(height: 20),
        Center(
          child: SizedBox(
            width: 170,
            child: ElevatedButton(
              onPressed: contactController.isLoading
                  ? null
                  : () async {
                      if (_responsiveBookingFormKey.currentState!.validate()) {
                        final inquiry = ContactInquiry(
                          name: _desktopContactNameController.text,
                          email: _desktopContactEmailController.text,
                          phone: _desktopContactMobileController.text,
                          message: _desktopContactMessageController.text,
                        );
                        final controller =
                            context.read<ContactInquiryController>();
                        await controller
                            .submitContactInquiry(inquiry)
                            .then((success) {
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(controller.successMessage!),
                                backgroundColor: Colors.green));
                            _desktopContactNameController.clear();
                            _desktopContactEmailController.clear();
                            _desktopContactMobileController.clear();
                            _desktopContactMessageController.clear();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(controller.errorMessage!),
                                backgroundColor: Colors.red));
                          }
                        });
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE7A20E),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(30), // More rounded corners
                ),
                textStyle: TextStyle(
                    fontSize: buttonTextSize, fontWeight: FontWeight.bold),
              ),
              child: contactController.isLoading
                  ? SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ))
                  : Text('Submit'),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildContactTextFieldResponsive({
    required TextEditingController controller,
    required String label,
    required bool isMobile,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    required double inputFontSize,
    String? Function(String?)? validator,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      style: TextStyle(fontSize: inputFontSize, color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        counterText: "",
        labelStyle: TextStyle(fontSize: inputFontSize, color: Colors.grey[700]),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
          borderSide: BorderSide(color: Color(0xFF1BA08F), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(
            horizontal: 15, vertical: maxLines > 1 ? 15 : 10),
      ),
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
    );
  }

  Widget _buildDisclaimerMarqueeResponsive(BuildContext context, bool isDesktop,
      bool isTablet, bool isMobile, double textSize) {
    return Container(
      child: ClipRect(
        child: SlideTransition(
          position: _scrollAnimation,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Disclaimer: ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: textSize,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Text(
                  'We do not charge for hiring!',
                  style:
                      TextStyle(color: Colors.black, fontSize: textSize * 0.95),
                ),
                SizedBox(width: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooterResponsive(BuildContext context, bool isDesktop,
      bool isTablet, bool isMobile, double footerTextSize) {
    return Container(
      width: double.infinity,
      color: Color(0xFF1BA08D),
      padding: EdgeInsets.symmetric(
          vertical: isMobile ? 10 : 15, horizontal: isMobile ? 15 : 30),
      child: isMobile
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '© Highland Hospitals. All Rights Reserved',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: footerTextSize,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  'Developed by Avanzo Cyber Security Solutions Pvt.Ltd.',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: footerTextSize * 0.9),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    '© Highland Hospitals. All Rights Reserved',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: footerTextSize,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 20),
                Flexible(
                  child: Text(
                    'Developed by Avanzo Cyber Security Solutions Pvt.Ltd.',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: footerTextSize),
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> makePhoneCall(String phoneNumber, BuildContext context) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);

    try {
      if (kIsWeb) {
        // ✅ Open in a new tab to avoid replacing the Flutter web app
        if (!await launchUrl(
          callUri,
          webOnlyWindowName: '_blank', // this keeps your app open
        )) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('⚠️ Web call not supported on this device.')),
          );
        }
      } else {
        // ✅ On Android/iOS
        if (!await launchUrl(callUri, mode: LaunchMode.externalApplication)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('⚠️ Could not launch $phoneNumber')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Error: $e')),
      );
    }
  }
}

class ContactColumn extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  ContactColumn({
    required this.icon,
    required this.title,
    required this.description,
  });

  String _getIconAssetPath(IconData icon) {
    if (icon == Icons.location_on) return 'assets/img/Location.png';
    if (icon == Icons.phone) return 'assets/img/Call.png';
    if (icon == Icons.email) return 'assets/img/E-mail.png';
    return 'assets/img/default_icon.png';
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              _getIconAssetPath(icon),
              width: 60,
              height: 60,
              errorBuilder: (c, e, s) =>
                  Icon(icon, size: 40, color: Colors.black54),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
