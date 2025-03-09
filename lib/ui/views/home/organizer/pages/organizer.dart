import 'package:ascca_app/ui/views/home/organizer/widgets/organizer_event_title.dart';
import 'package:ascca_app/ui/views/home/organizer/widgets/organizer_name.dart';
import 'package:ascca_app/ui/views/home/organizer/widgets/organizer_photo.dart';
import 'package:flutter/material.dart';

class OrganizerPage extends StatelessWidget {
  final int organizerId;
  const OrganizerPage({super.key, required this.organizerId});

  // https://ascca.onrender.com/eventTrack/profiles/organizer/1

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              spacing: height * 0.01,
              children: [
                OrganizerPhoto(),
                OrganizerName(name: 'username'),
                SizedBox(height: height * 0.03),
                OrganizerEventTitle(),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
                Text('data'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
