import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:presensi_mobileapp/widgets/_widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'dart:async';

import '../../../home/presentation/page/_pages.dart';
import './../provider/_provider.dart';

part 'login.dart';
part 'first_pass_reset.dart';
part 'forgotpass/forget_password.dart';
part 'forgotpass/otp_check.dart';
part 'forgotpass/change_password.dart';
part 'forgotpass/methods.dart';
