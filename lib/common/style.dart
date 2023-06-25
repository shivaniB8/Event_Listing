// ignore_for_file: constant_identifier_names
// ignore_for_file: non_constant_identifier_names
import 'package:all_events_task/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

const text_style_title1 = TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.w700,
  color: primary_text_color,
);

const text_style_title2 = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w600,
  color: primary_text_color,
);

const text_style_title3 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: primary_text_color,
);

const text_style_title4 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w700,
  color: hint_color,
);

const text_style_title5 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w700,
  color: Colors.blue,
);

const text_style_title6 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w700,
  color: Colors.black,
);

const text_style_title7 = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w700,
  color: Colors.black,
);

const text_style_title8 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: Colors.grey,
);

const text_style_title10 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: Colors.blue,
);

const text_style_title11 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: primary_text_color,
);

const text_style_title12 = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  color: primary_text_color,
);

const text_style_title13 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: Colors.black87,
);

const text_style_title14 = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);

const text_style_title15 = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: primary_text_color,
);

const text_style_para1 = TextStyle(
  fontSize: 14,
  color: primary_text_color,
);

const text_style_para2 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: primary_text_color,
);

const text_style_para3 = TextStyle(
  fontSize: 10,
  color: primary_text_color,
);

const text_field_label_style = TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.w700,
  color: hint_color,
);

final text_field_input_decoration = form_field_input_decoration.copyWith(
  isDense: true,
  contentPadding: EdgeInsets.zero,
  hintStyle: text_field_label_style,
);

const form_field_input_decoration = InputDecoration(
  border: InputBorder.none,
  hintStyle: text_style_title4,

  /// to hide default error showing at the bottom of field
  errorStyle: TextStyle(
    height: 0,
    color: Colors.transparent,
  ),
);

final lookup_suggestion_box_decoration = SuggestionsBoxDecoration(
  elevation: 2,
  color: Colors.white,
  borderRadius: BorderRadius.circular(4),
);
