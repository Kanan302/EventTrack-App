import 'package:flutter/material.dart';
import 'package:ascca_app/ui/views/home/create_event/widgets/create_event_formfield.dart';
import 'package:ascca_app/ui/views/home/create_event/service/create_event_date_service.dart';

void showCreateEventDateModal(
  BuildContext context,
  TextEditingController eventStartDateTimeController,
  TextEditingController eventEndDateTimeController,
  CreateEventDateService eventDateService,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.3,
        minChildSize: 0.2,
        maxChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 60,
                    child: CreateEventFormfield(
                      labelText: 'Başlanğıc Tarixi',
                      controller: eventStartDateTimeController,
                      onTap: () => pickDateTime(
                        context,
                        eventStartDateTimeController,
                        true,
                        eventDateService,
                      ),
                      validator: validateDateTimeFormat,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 60,
                    child: CreateEventFormfield(
                      labelText: 'Bitiş Tarixi',
                      controller: eventEndDateTimeController,
                      onTap: () => pickDateTime(
                        context,
                        eventEndDateTimeController,
                        false,
                        eventDateService,
                      ),
                      validator: validateDateTimeFormat,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
