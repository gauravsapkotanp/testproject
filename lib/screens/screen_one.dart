import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:testproject/models/question_data.dart';
import 'package:testproject/screens/screen_two.dart';
import 'package:testproject/widgets/slide_to_act.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({super.key});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  final TextEditingController _textController = TextEditingController();
  final PageController _pageController = PageController();
  final GlobalKey<SlideActionState> key = GlobalKey<SlideActionState>(debugLabel: UniqueKey().toString());

  int topicIndex = 0;
  late Topic currentTopic;
  int currentQuestionIndex = 0;
  String userAnswer = '';
  bool isRecording = false;

  // Speech to text
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _speechEnabled = false;
  String lastWords = '';

  @override
  void initState() {
    super.initState();
    currentTopic = topicsData[topicIndex];
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _textController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _toggleRecording() async {
    if (!isRecording) {
      // Start recording
      if (_speechEnabled) {
        userAnswer = _textController.text; // Save current text before recording
        debugPrint('🎤 Starting speech recognition...');
        debugPrint('📝 Current text before recording: "$userAnswer"');

        await _speechToText.listen(
          onResult: (result) {
            setState(() {
              lastWords = result.recognizedWords;

              // Log the recognized words
              debugPrint('🔊 Recognized words: "${result.recognizedWords}"');
              debugPrint('✅ Is final result: ${result.finalResult}');
              debugPrint('💬 Confidence: ${result.confidence}');

              // Update text field with recognized words
              if (userAnswer.isNotEmpty) {
                _textController.text = '$userAnswer ${result.recognizedWords}';
              } else {
                _textController.text = result.recognizedWords;
              }

              debugPrint('📄 Updated text field: "${_textController.text}"');
            });
          },
        );
        setState(() {
          isRecording = true;
        });
      } else {
        debugPrint('❌ Speech recognition not enabled');
      }
    } else {
      // Stop recording
      debugPrint('⏹️ Stopping speech recognition...');
      await _speechToText.stop();
      setState(() {
        isRecording = false;
        userAnswer = _textController.text; // Update final answer
      });
      debugPrint('📝 Final recorded text: "$userAnswer"');
    }
  }

  void _goToNextTopic() {
    if (topicIndex < topicsData.length - 1) {
      setState(() {
        topicIndex++;
        currentTopic = topicsData[topicIndex];
        currentQuestionIndex = 0;
        _textController.clear();
        userAnswer = '';
        isRecording = false;
        _pageController.jumpToPage(0);
      });
    } else {
      // All topics completed - navigate to screen two
      Navigator.push(context, MaterialPageRoute(builder: (context) => const ScreenTwo()));
    }
  }

  void _goToPreviousTopic() {
    if (topicIndex > 0) {
      setState(() {
        topicIndex--;
        currentTopic = topicsData[topicIndex];
        currentQuestionIndex = 0;
        _textController.clear();
        userAnswer = '';
        isRecording = false;
        _pageController.jumpToPage(0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = (topicIndex + 1) / topicsData.length;

    return Scaffold(
      backgroundColor: const Color(0xFF2B1414),
      body: SafeArea(
        child: Column(
          children: [
            // Progress bar
            SizedBox(
              height: 2,
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[800],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.1), width: 1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Topic ${topicIndex + 1}/${topicsData.length}:\n${currentTopic.name}',
                    style: TextStyle(color: Colors.grey[400], fontSize: 13, height: 1.4),
                  ),
                  Text(
                    'Swipe left and right until you find\na question you like in this topic.',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.grey[500], fontSize: 11, height: 1.4),
                  ),
                ],
              ),
            ),

            // Question Section with PageView
            Expanded(
              child: Column(
                children: [
                  // Swipeable Questions
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          currentQuestionIndex = index;
                        });
                      },
                      itemCount: currentTopic.questions.length,
                      itemBuilder: (context, index) {
                        final question = currentTopic.questions[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              // Question with swipe icon
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      question.text,
                                      style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600, height: 1.3),
                                    ),
                                  ),
                                  Icon(Icons.swipe, color: Colors.grey[500], size: 24),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // Answer input area
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text field with no decoration
                        TextField(
                          controller: _textController,
                          minLines: 1,
                          maxLines: 5,
                          onChanged: (value) {
                            setState(() {
                              userAnswer = value;
                            });
                          },
                          style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.6),
                          decoration: InputDecoration(
                            hintText: 'Write your Answer here',
                            hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        Divider(color: Colors.grey[700]),
                        // Recording status display
                        if (isRecording)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                                ),
                                const SizedBox(width: 8),
                                Text('Recording...', style: TextStyle(color: Colors.grey[400], fontSize: 14)),
                              ],
                            ),
                          ),
                        // Navigation and action buttons
                        SlideAction(
                          height: 60,
                          key: key,
                          reversed: isRecording ? true : false,
                          onSubmit: () async {
                            _toggleRecording();
                            await Future.delayed(const Duration(milliseconds: 300));
                            key.currentState!.reset();
                          },
                          outerColor: isRecording ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 238, 237, 237),
                          text: isRecording ? 'Stop Recording' : 'Record',
                          icon: !isRecording ? Icons.mic : Icons.stop,
                          textColor: isRecording ? Colors.white : Colors.black,
                          innerColor: isRecording ? Colors.red.shade700 : Colors.black,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (topicIndex > 0)
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey[700]!, width: 1),
                            ),
                            child: IconButton(
                              onPressed: _goToPreviousTopic,
                              icon: Icon(Icons.arrow_back, color: Colors.grey[400]),
                            ),
                          ),
                        if (topicIndex < topicsData.length - 1) Spacer(),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey[700]!, width: 1),
                          ),
                          child: IconButton(
                            onPressed: () {
                              _goToNextTopic();
                            },
                            icon: Icon(Icons.arrow_forward, color: Colors.grey[400]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
