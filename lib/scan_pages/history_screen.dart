import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'scan_record.dart';

class HistoryScreen extends StatefulWidget {
  static const String routeName = '/history';
  final List<ScanRecord> history;

  HistoryScreen({required this.history});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int _currentIndex = 1;
  final ImagePicker _picker = ImagePicker();

  Map<String, int> _getScansByLocation(List<ScanRecord> history) {
    Map<String, int> scansByLocation = {};
    for (var record in history) {
      scansByLocation.update(record.location, (value) => value + record.count,
          ifAbsent: () => record.count);
    }
    return scansByLocation;
  }

  Future<void> _takePicture() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Picture taken: ${image.path}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No picture taken.')),
      );
    }
  }

  void _openGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image selected from gallery: ${image.path}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected.')),
      );
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/home');
      } else if (index == 1) {
      } else if (index == 3) {
        Navigator.pushReplacementNamed(context, '/calendar');
      } else if (index == 4) {
        Navigator.pushReplacementNamed(context, '/profile');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final scansByLocation = _getScansByLocation(widget.history);
    final locations = <String>[
      'Head',
      'Body',
      'Left Arm',
      'Right Arm',
      'Left Leg',
      'Right Leg'
    ];

    return Scaffold(
      backgroundColor: const Color(0xff1A766E),
      appBar: AppBar(
        backgroundColor: const Color(0xff1A766E),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              weight: 24,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: const Text(
          'History',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
        ),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView.builder(
          padding: const EdgeInsets.only(top: 16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 24.0,
            childAspectRatio: 1.6,
          ),
          itemCount: locations.length,
          itemBuilder: (context, index) {
            final location = locations[index];
            final count = scansByLocation[location] ?? 0;
            return Container(
              decoration: BoxDecoration(
                color: const Color(0xff101623),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      count.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        PopupMenuButton<String>(
                          onSelected: (value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('You selected: $value')),
                            );
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'details',
                              child: Text('View Details'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'clear',
                              child: Text('Clear History for this'),
                            ),
                          ],
                          child: const Icon(
                            Icons.more_vert,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
            selectedItemColor: const Color(0xff1A766E),
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.history,
                    color: _currentIndex == 1
                        ? const Color(0xff1A766E)
                        : Colors.grey),
                label: 'History',
                backgroundColor: Color(0xff1A766E),
              ),
              const BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today), label: 'Calendar'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
          Positioned(
            top: -30,
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.5),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                icon:
                    const Icon(Icons.camera_alt, color: Colors.white, size: 28),
                onPressed: _takePicture,
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
