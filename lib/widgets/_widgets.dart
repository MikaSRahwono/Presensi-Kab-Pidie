import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:provider/provider.dart';
import 'package:presensi_mobileapp/features/authentication/data/model/http_exception_model.dart';


import '../features/authentication/data/model/user_model.dart';
import '../features/authentication/presentation/pages/_pages.dart';
import '../features/authentication/presentation/provider/_provider.dart';
import '../features/history/data/model/_model.dart';
import '../features/presensi/data/model/_model.dart';

part 'HelperBigText.dart';
part 'HelperDialog.dart';
part 'HelperMethod.dart';
