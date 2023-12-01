import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:health_vista_pro/bloc/blocs.dart';
import 'package:health_vista_pro/models/models.dart' as m;
import 'package:health_vista_pro/provider/providers.dart';
import 'package:health_vista_pro/services/services.dart';
import 'package:health_vista_pro/shared/shared.dart';
import 'package:health_vista_pro/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dash_chat/dash_chat.dart';

import 'package:path/path.dart';
import 'package:rating_dialog/rating_dialog.dart';

part 'welcome_page.dart';
part 'login_page.dart';
part 'wrapper.dart';
part 'main_page.dart';
part 'user_registration_page.dart';
part 'doctor_page.dart';
part 'account_confirmation_page.dart';
part 'hospital_page.dart';
part 'user_profile_page.dart';
part 'edit_profile.dart';
part 'doctor_selected_page_list.dart';
part 'chat_list_screen.dart';
part 'chat_list_page.dart';
part 'chat_screen.dart';
part 'registration_page.dart';
part 'doctor_registration_page.dart';
part 'pickup_screen.dart';
part 'call_screen.dart';
part 'pickup_layout.dart';
part 'view_image.dart';
part 'user_profile_page_menu.dart';
part 'see_doctor_page.dart';
part 'history_patient_input_page.dart';
part 'doctor_rating_page.dart';
part 'patient_list_medical_record_page.dart';
