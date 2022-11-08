// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

class Activity {
    Activity({
        required this.id,
        required this.title,
        required this.description,
        required this.startDate,
        required this.endDate
    });
    int id;
    String title;
    String description;
    DateTime startDate;
    DateTime endDate;

}
