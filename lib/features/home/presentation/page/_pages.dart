import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:presensi_mobileapp/features/home/data/model/presensi_model.dart';
import 'package:presensi_mobileapp/widgets/_widgets.dart';
import 'package:presensi_mobileapp/features/authentication/presentation/pages/_pages.dart';
import 'package:provider/provider.dart';
import '../../../authentication/presentation/provider/_provider.dart';
import '../../../profile/presentation/profile.dart';

part 'home.dart';
