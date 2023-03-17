import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../home/presentation/home.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';

import 'dart:async';


import './../provider/_provider.dart';
import '../../data/model/_model.dart';

part 'login.dart';
part 'first_pass_reset.dart';
part 'comingsoon.dart';
part 'forgetpass/forget_password.dart';
part 'forgetpass/otp_check.dart';
part 'forgetpass/change_password.dart';
part 'forgetpass/methods.dart';