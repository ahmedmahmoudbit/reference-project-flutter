import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF00BF6D);
const kDefaultPadding = 20.0;
const kErrorColor = Color(0xFFF03738);
const kContentColorLightTheme = Color(0xFF1D1D35);


enum ChatMessageType { text, audio, image, video }
enum MessageStatus { not_sent, not_view, viewed }
