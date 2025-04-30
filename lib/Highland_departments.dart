import 'package:flutter/material.dart';
import 'package:flutter_highland/responsive.dart'; // Assuming responsive.dart exists
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_highland/constants/color_constant.dart'; // Or define ColorConstant locally

// --- Define ColorConstant if not imported ---
/* Remove this if you have the import
class ColorConstant {
  static const Color mainBlue = Color(0xFF1FBCB1);
  static const Color mainWhite = Colors.white;
}
*/

// --- ServiceItem Class ---
class ServiceItem {
  final String imagePath;
  final String title;
  final VoidCallback onTap;

  ServiceItem(
      {required this.imagePath, required this.title, required this.onTap});
}

// --- HomeDashboard Widget ---
class HomeDashboard extends StatefulWidget {
  const HomeDashboard({Key? key}) : super(key: key);

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _scrollAnimation;
  Widget? selectedPage;

  // --- Service Data List ---
  final List<ServiceItem> _serviceItems = [
    ServiceItem(
        imagePath: 'assets/img/emergency.svg',
        title: 'Emergency',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/general surgeon.svg',
        title: 'General Surgeon',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/cardiology-64.svg',
        title: 'Cardiology',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/pregnant.svg', title: 'Maternity', onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/Nephrologist.svg',
        title: 'Nephrologist',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/oncologist.svg',
        title: 'Oncologist',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/paediatrics.svg',
        title: 'Paediatrics',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/urologist.svg', title: 'Urology', onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/psychiatry.svg',
        title: 'Psychiatry',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/Laparoscopic surgeon.svg',
        title: 'Laparoscopic surgeon',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/maxilliofacial.svg',
        title: 'Maxilliofacial',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/Microbiologist.svg',
        title: 'Microbiologist',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/ophthalmologist.svg',
        title: 'Ophthalmologist',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/orthopaedic.svg',
        title: 'Orthopaedic',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/Anaesthesiologist32.svg',
        title: 'Anaesthesiologist',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/Andrologist.svg',
        title: 'Andrologist',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/audiology.svg',
        title: 'Audiology',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/Dermetology.svg',
        title: 'Dermatology',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/ent-specialist.svg',
        title: 'ENT Specialist',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/Endocrinology.svg',
        title: 'Endocrinology',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/gastroenterology.svg',
        title: 'Gastroenterology',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/orthopaedic.svg',
        title: 'Orthopaedic',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/internal medicine.svg',
        title: 'Internal Medicine',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/neurosurgeon.svg',
        title: 'Neurosurgeon',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/vascular surgery.svg',
        title: 'Vascular Surgery',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/physiotherapists.svg',
        title: 'Physiotherapists',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/foregnsic.svg', title: 'Forensic', onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/gynacologist.svg',
        title: 'Gynacologist',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/wellness.svg', title: 'Wellness', onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/eye-thin.svg', title: 'Eye care', onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/pulmonology.svg',
        title: 'Pulmonology',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/radiology.svg',
        title: 'Radiology',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/rheumatologist.svg',
        title: 'Rheumatologist',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/skin_face.svg',
        title: 'Skin_face',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/speech and hearing.svg',
        title: 'Speech & hear',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/surgical oncologist.svg',
        title: 'Surgical oncologist',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/Neurology.svg',
        title: 'Neurology',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/general physician.svg',
        title: 'General physician',
        onTap: () {}),
    ServiceItem(
        imagePath: 'assets/img/hematology.svg',
        title: 'Hematology',
        onTap: () {}),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();
    _scrollAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      // Adjust end offset based on the actual width of your marquee text + spacing
      // If text is long, you might need a more negative value like -2.0 or -2.5
      end: const Offset(-1.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // --- Helper: Dynamic Rows for Mobile/Tablet (No Change) ---
  List<Widget> _buildServiceRows(BuildContext context, int itemsPerRow) {
    // ... (code remains the same) ...
    List<Widget> rows = [];
    int numRows = (_serviceItems.length / itemsPerRow).ceil();

    for (int i = 0; i < numRows; i++) {
      int startIndex = i * itemsPerRow;
      int endIndex = (startIndex + itemsPerRow > _serviceItems.length)
          ? _serviceItems.length
          : startIndex + itemsPerRow;
      List<ServiceItem> rowData = _serviceItems.sublist(startIndex, endIndex);

      List<Widget> rowChildren = rowData.map((item) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ServiceCard(
              imagePath: item.imagePath,
              title: item.title,
              onTap: item.onTap,
              iconBorder: true,
            ),
          ),
        );
      }).toList();

      int remainingSlots = itemsPerRow - rowData.length;
      for (int k = 0; k < remainingSlots; k++) {
        rowChildren.add(Expanded(child: Container()));
      }

      rows.add(
        Padding(
          padding: EdgeInsets.only(bottom: (i == numRows - 1) ? 0 : 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rowChildren,
          ),
        ),
      );
    }
    return rows;
  }

  // --- Helper: Hardcoded Desktop Layout (No Change) ---
  Widget _buildHardcodedDesktopLayout() {
    // ... (code remains the same) ...
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/emergency.svg',
                      title: 'Emergency',
                      onTap: () {},
                      iconBorder: true))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/general surgeon.svg',
                      title: 'General Surgeon',
                      onTap: () {},
                      iconBorder: true))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/cardiology-64.svg',
                      title: 'Cardiology',
                      onTap: () {},
                      iconBorder: true))),
        ]),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/pregnant.svg',
                      title: 'Maternity',
                      onTap: () {},
                      iconBorder: true))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/Nephrologist.svg',
                      title: 'Nephrologist',
                      onTap: () {},
                      iconBorder: true))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/oncologist.svg',
                      title: 'Oncologist',
                      onTap: () {},
                      iconBorder: true))),
        ]),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/paediatrics.svg',
                      title: 'Paediatrics',
                      onTap: () {},
                      iconBorder: true))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/urologist.svg',
                      title: 'Urology',
                      onTap: () {},
                      iconBorder: true))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/psychiatry.svg',
                      title: 'Psychiatry',
                      onTap: () {},
                      iconBorder: true))),
        ]),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/Laparoscopic surgeon.svg',
                      title: 'Laparoscopic surgeon',
                      onTap: () {},
                      iconBorder: true))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/maxilliofacial.svg',
                      title: 'Maxilliofacial',
                      onTap: () {},
                      iconBorder: true))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/Microbiologist.svg',
                      title: 'Microbiologist',
                      onTap: () {},
                      iconBorder: true))),
        ]),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/ophthalmologist.svg',
                      title: 'Ophthalmologist',
                      onTap: () {},
                      iconBorder: true))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/orthopaedic.svg',
                      title: 'Orthopaedic',
                      onTap: () {},
                      iconBorder: true))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/Anaesthesiologist32.svg',
                      title: 'Anaesthesiologist',
                      onTap: () {},
                      iconBorder: true))),
        ]),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/Andrologist.svg',
                      title: 'Andrologist',
                      onTap: () {},
                      iconBorder: true))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/audiology.svg',
                      title: 'Audiology',
                      onTap: () {},
                      iconBorder: true))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/Dermetology.svg',
                      title: 'Dermatology',
                      onTap: () {},
                      iconBorder: true))),
        ]),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/ent-specialist.svg',
                      title: 'ENT Specialist',
                      onTap: () {},
                      iconBorder: true))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/Endocrinology.svg',
                      title: 'Endocrinology',
                      onTap: () {},
                      iconBorder: true))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/gastroenterology.svg',
                      title: 'Gastroenterology',
                      onTap: () {},
                      iconBorder: true))),
        ]),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/orthopaedic.svg',
                      title: 'Orthopaedic',
                      onTap: () {},
                      iconBorder: true))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/internal medicine.svg',
                      title: 'Internal Medicine',
                      onTap: () {},
                      iconBorder: true))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/neurosurgeon.svg',
                      title: 'Neurosurgeon',
                      onTap: () {},
                      iconBorder: true))),
        ]),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/vascular surgery.svg',
                      title: 'Vascular Surgery',
                      onTap: () {},
                      iconBorder: true))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/physiotherapists.svg',
                      title: 'Physiotherapists',
                      onTap: () {},
                      iconBorder: true))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/foregnsic.svg',
                      title: 'Forensic',
                      onTap: () {},
                      iconBorder: true))),
        ]),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/gynacologist.svg',
                      title: 'Gynacologist',
                      onTap: () {},
                      iconBorder: true))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/wellness.svg',
                      title: 'Wellness',
                      onTap: () {},
                      iconBorder: true))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/eye-thin.svg',
                      title: 'Eye care',
                      onTap: () {},
                      iconBorder: true))),
        ]),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/pulmonology.svg',
                      title: 'Pulmonology',
                      onTap: () {},
                      iconBorder: true))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/radiology.svg',
                      title: 'Radiology',
                      onTap: () {},
                      iconBorder: true))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/rheumatologist.svg',
                      title: 'Rheumatologist',
                      onTap: () {},
                      iconBorder: true))),
        ]),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/skin_face.svg',
                      title: 'Skin_face',
                      onTap: () {},
                      iconBorder: true))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/speech and hearing.svg',
                      title: 'Speech & hear',
                      onTap: () {},
                      iconBorder: true))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/surgical oncologist.svg',
                      title: 'Surgical oncologist',
                      onTap: () {},
                      iconBorder: true))),
        ]),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/Neurology.svg',
                      title: 'Neurology',
                      onTap: () {},
                      iconBorder: true))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/general physician.svg',
                      title: 'General physician',
                      onTap: () {},
                      iconBorder: true))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServiceCard(
                      imagePath: 'assets/img/hematology.svg',
                      title: 'Hematology',
                      onTap: () {},
                      iconBorder: true))),
        ]),
      ],
    );
  }

  // --- Helper: Scrolling Marquee for Desktop (No Change) ---
  Widget _buildDisclaimerMarquee() {
    const double titleSize = 18.0; // Adjusted size
    const double bodySize = 16.0; // Adjusted size

    return SizedBox(
      height: 40,
      child: ClipRect(
        child: SlideTransition(
          position: _scrollAnimation,
          child: Row(
            // Ensures the Row is wide enough to scroll off-screen before repeating
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(width: 30), // Initial padding before first text
              Text('Disclaimer: ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold)),
              Text('We do not charge for hiring!',
                  style: TextStyle(color: Colors.black, fontSize: bodySize)),
              SizedBox(width: 50), // Spacing between repetitions
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper: Static Disclaimer for Mobile/Tablet (No Change) ---
  Widget _buildStaticDisclaimer() {
    const double titleSize = 14.0;
    const double bodySize = 13.0;

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        color: Colors.grey[100], // Optional background
        child: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(
                color: Colors.black54, fontSize: bodySize, height: 1.4),
            children: <TextSpan>[
              TextSpan(
                  text: 'Disclaimer: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: titleSize)),
              TextSpan(text: 'We do not charge for hiring!'),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Departments'),
        backgroundColor: const Color(0xFF1BA08D),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // --- Main Service Card Section ---
                  Container(
                    margin: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            'Our Services',
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1FBCB1)),
                          ),
                        ),
                        const SizedBox(height: 25),
                        // --- Responsive Layout for Service Cards ---
                        Responsive(
                          mobile:
                              Column(children: _buildServiceRows(context, 3)),
                          tablet:
                              Column(children: _buildServiceRows(context, 4)),
                          desktop: _buildHardcodedDesktopLayout(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- CORRECTED: Responsive Disclaimer Section ---
                  Responsive(
                    mobile: _buildStaticDisclaimer(), // Static view for mobile
                    tablet: _buildStaticDisclaimer(), // Static view for tablet
                    desktop:
                        _buildDisclaimerMarquee(), // Scrolling marquee for desktop
                  ),
                  // --- End Responsive Disclaimer Section ---

                  const SizedBox(height: 20), // Bottom spacing
                ],
              ),
            ),
          ),

          // --- Overlay Code (Remains the same) ---
          if (selectedPage != null)
            Positioned.fill(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    AppBar(
                      backgroundColor: ColorConstant.mainWhite,
                      foregroundColor: Colors.black,
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          setState(() {
                            selectedPage = null;
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
    );
  }
} // End of _HomeDashboardState

// --- ServiceCard Widget Definition (Keep As Is) ---
class ServiceCard extends StatelessWidget {
  final IconData? icon;
  final String? imagePath;
  final String title;
  final VoidCallback onTap;
  final bool iconBorder;

  const ServiceCard({
    Key? key,
    this.icon,
    this.imagePath,
    required this.title,
    required this.onTap,
    this.iconBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool hasImage = imagePath != null && imagePath!.isNotEmpty;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorConstant.mainBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: iconBorder
                  ? Border.all(
                      color: ColorConstant.mainBlue.withOpacity(0.5), width: 1)
                  : null,
            ),
            padding: const EdgeInsets.all(15),
            child: hasImage
                ? SvgPicture.asset(
                    imagePath!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                    placeholderBuilder: (context) => const SizedBox(
                        width: 50,
                        height: 50,
                        child: Center(
                            child: CircularProgressIndicator(strokeWidth: 2))),
                  )
                : (icon != null
                    ? Icon(icon!, size: 50, color: const Color(0xFF1FBCB1))
                    : const SizedBox(width: 50, height: 50)),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
