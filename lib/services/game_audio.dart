import 'package:audioplayers/audioplayers.dart';

class GameAudio {

  final AudioPlayer _player = AudioPlayer();

  // Play Correct Sound
  void correctAnswer() {
    Source audioSource = AssetSource('audio/correct.wav');
    _player.play(audioSource, volume: 1);
  }

  // Play Incorrect Sound
  void incorrectAnswer() {
    Source audioSource = AssetSource('audio/incorrect.wav');
    _player.play(audioSource, volume: 1);
  }

  // Play Congratulations Sound
  void congratulations() {
    Source audioSource = AssetSource('audio/congratulations.wav');
    _player.play(audioSource, volume: 1);
  }

  // Play Flop Sound
  void flop() {
    Source audioSource = AssetSource('audio/flop.ogg');
    _player.play(audioSource, volume: 1);
  }


}