import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:health_vista_pro/extensions/extensions.dart';
import 'package:health_vista_pro/models/models.dart' as m;
import 'package:health_vista_pro/pages/pages.dart';
import 'package:health_vista_pro/shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone_updated_gradle/flutter_native_timezone.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


part 'auth_services.dart';
part 'user_services.dart';
part 'message_services.dart';
part 'call_services.dart';
part 'history _patient_services.dart';
part 'shared_prefs.dart';
part 'notification_service.dart';
