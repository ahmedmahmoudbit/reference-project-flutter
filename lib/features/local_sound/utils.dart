import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

const kPrimaryColor = Color(0xFFebbe8b);

// playlist songs
List<Audio> songs = [
  Audio('assets/s1.mp3',
          metas: Metas(
          title: 'الصوت الاول',
          artist: 'الصوت الاول',
          image: const MetasImage.asset('assets/img/background/image-1.png'))),
  Audio('assets/s2.mp3',
          metas: Metas(
          title: 'الصوت الثاني',
          artist: 'الصوت الثاني',
          image: const MetasImage.asset('assets/img/background/image-1.png'))),
  Audio('assets/s3.mp3',
          metas: Metas(
          title: 'الصوت الثالث',
          artist: 'الصوت الثالث',
          image: const MetasImage.asset('assets/img/background/image-1.png'))),
  Audio('assets/s4.mp3',
          metas: Metas(
          title: 'الصوت الرابع',
          artist: 'الصوت الرابع',
          image: const MetasImage.asset('assets/img/background/image-1.png'))),

];

String durationFormat(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return '$twoDigitMinutes:$twoDigitSeconds';
  // for example => 03:09
}

// get song cover image colors
Future<PaletteGenerator> getImageColors(AssetsAudioPlayer player) async {
  var paletteGenerator = await PaletteGenerator.fromImageProvider(
    AssetImage(player.getCurrentAudioImage?.path ?? ''),
  );
  return paletteGenerator;
}