import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Event {
  final String eventName;
  final String eventType;
  final String eventDate;
  final String eventDescription;
  final Map<String, bool>? services;
  Event(
      {required this.eventName,
      required this.eventDate,
      required this.eventDescription,
      required this.eventType,
      this.services});
}

class EventProvider with ChangeNotifier {
  List<Event> _eventsList = [];
  var _date = DateTime.now();
  var _eventName = "Party";
  bool _optForServices = true;
  Map<String, bool> _services = {
    'Decor and Styling': false,
    'Venue Sourcing': false,
    'Food and Catering': false,
    'Sound': false,
  };
  Map<String, dynamic> _venueSourcing = {
    'opted': false,
    'price': 1000,
  };

  Map<String, dynamic> get venueService {
    return {..._venueSourcing};
  }

  setVenueServices(bool opted) {
    _venueSourcing['opted'] = opted;
    notifyListeners();
  }

  Map<String, dynamic> _entertainment = {
    'opted': false,
    'price': 7500,
  };

  Map<String, dynamic> get entertainment {
    return {..._entertainment};
  }

  setentertainment(bool opted) {
    _entertainment['opted'] = opted;
    notifyListeners();
  }

  Map<String, dynamic> _food = {
    'opted': false,
    'price': 4000,
  };

  Map<String, dynamic> get food {
    return {..._food};
  }

  setfood(bool opted) {
    _food['opted'] = opted;
    notifyListeners();
  }

  Map<String, dynamic> _decor = {
    'opted': false,
    'price': 3000,
  };

  Map<String, dynamic> get decor {
    return {..._decor};
  }

  setdecor(bool opted) {
    _decor['opted'] = opted;
    notifyListeners();
  }

  String get eventName {
    return _eventName;
  }

  DateTime get dateOfEvent {
    return _date;
  }

  List<Event> get eventsList {
    return [..._eventsList];
  }

  Map<String, bool> get services {
    return _services;
  }

  setServices(Map<String, bool> services) {
    _services = services;
    log(services.toString());
    notifyListeners();
  }

  goForBusinessServices(optServices) {
    _optForServices = optServices;
    notifyListeners();
  }

  setDate(DateTime date) {
    _date = date;
    notifyListeners();
  }

  setEventTypeUsingEventNumber(int eventNumber) {
    switch (eventNumber) {
      case 1:
        _eventName = 'Party';
        break;
      case 2:
        _eventName = 'Wedding';
        break;
      case 3:
        _eventName = 'Business';
        break;
      case 4:
        _eventName = 'Festive';
        break;
    }
  }

  getTotalCost() {
    num totalCost = 10000;
    _food['opted']
        ? totalCost += _food['price'].toInt()
        : totalCost = totalCost;
    _decor['opted']
        ? totalCost += _decor['price'].toInt()
        : totalCost = totalCost;
    _entertainment['opted']
        ? totalCost += _entertainment['price'].toInt()
        : totalCost = totalCost;
    _venueSourcing['opted']
        ? totalCost += _venueSourcing['price'].toInt()
        : totalCost = totalCost;
    return totalCost;
  }

  getTax() {
    final totalCost = getTotalCost();
    final tax = (totalCost * 18) / 100;
    return tax;
  }

  void addEvent(String name, String description) async {
    try {
      await FirebaseFirestore.instance.collection('events').doc().set({
        'name': name,
        'type': _eventName,
        'date': _date,
        'description': description,
        'totalCost': getTotalCost() + getTax(),
      }).then((value) {
        log('Data inserted successfully');
      });
    } on FirebaseException catch (e) {
      log(e.message.toString());
    }
    // _eventsList.add(Event(
    //     eventName: name,
    //     eventDate: date,
    //     eventDescription: description,
    //     eventType: type));
    // notifyListeners();
  }
}
