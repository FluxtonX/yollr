// lib/features/pools/pool_question_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yollr/core/constants/assets.dart';
import 'package:yollr/core/theme/pallete.dart';
import 'package:yollr/core/utils/responsive_utils.dart';
import 'package:yollr/features/pools/models/pool_qusetion.dart';
import 'package:yollr/features/pools/widgets/top_nav_bar.dart';
import 'package:yollr/features/pools/widgets/pool_question_card.dart';
import 'package:yollr/features/pools/widgets/pool_action_button.dart';

class PoolQuestionScreen extends StatefulWidget {
  final int questionIndex;
  const PoolQuestionScreen({super.key, required this.questionIndex});

  @override
  State<PoolQuestionScreen> createState() => _PoolQuestionScreenState();
}

class _PoolQuestionScreenState extends State<PoolQuestionScreen> {
  int? _selectedAnswer;
  late PageController _pageController;
  int _currentPage = 0;

  final List<PoolQuestion> _questions = [
    PoolQuestion(
      emoji: Assets.iconsPoolStarSmile,
      text: 'Their smile makes my heart melts',
      answers: [
        'Brett Harvey',
        'Casey Adams',
        'Andy Fitzgerald',
        'Kevin Scott',
      ],
      progress: '1 of 4',
    ),
    PoolQuestion(
      emoji: Assets.avatarsGirl10th,
      text: 'Who do you secretly admire?',
      answers: [
        'Brett Harvey',
        'Casey Adams',
        'Andy Fitzgerald',
        'Kevin Scott',
      ],
      progress: '2 of 4',
    ),
    PoolQuestion(
      emoji: Assets.avatarsBoy12th,
      text: 'Should DJ every party',
      answers: [
        'Brett Harvey',
        'Casey Adams',
        'Andy Fitzgerald',
        'Kevin Scott',
      ],
      progress: '3 of 4',
    ),
    PoolQuestion(
      emoji: Assets.iconsPoolHouse,
      text: 'Let\'s be bored in the house together',
      answers: [
        'Brett Harvey',
        'Casey Adams',
        'Andy Fitzgerald',
        'Kevin Scott',
      ],
      progress: '4 of 4',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _currentPage = widget.questionIndex;
    _pageController = PageController(initialPage: widget.questionIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _selectAnswer(int index) {
    if (_selectedAnswer == index) return;
    setState(() => _selectedAnswer = index);

    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted || !_pageController.hasClients) return;
      final nextPage = _currentPage + 1;
      if (nextPage < _questions.length) {
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
        setState(() {
          _currentPage = nextPage;
          _selectedAnswer = null;
        });
      }
    });
  }

  void _shuffleAnswers() {
    setState(() {
      _questions[_currentPage].answers.shuffle();
    });
  }

  void _skipQuestion() {
    if (!_pageController.hasClients) return;
    final nextPage = _currentPage + 1;
    if (nextPage < _questions.length) {
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage = nextPage;
        _selectedAnswer = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final spacing = ResponsiveUtils.spacingScale(context);
    final font = ResponsiveUtils.fontScale(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Pallete.secondaryColor, Pallete.primaryColor],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20 * spacing),
              // TOP BAR
              const TopNavBar(inboxBadge: 3, activeTab: 'Yollr'),

              SizedBox(height: 20 * spacing),

              // PROGRESS TEXT
              Text(
                _questions[_currentPage].progress,
                style: GoogleFonts.poppins(
                  fontSize: 14 * font,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.85),
                ),
              ),

              SizedBox(height: 40 * spacing),

              // QUESTION PAGES
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _questions.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final q = _questions[index];
                    return PoolQuestionCard(
                      emoji: q.emoji,
                      text: q.text,
                      answers: q.answers,
                      selectedAnswer: _selectedAnswer,
                      onSelectAnswer: _selectAnswer,
                    );
                  },
                ),
              ),

              // BOTTOM ACTIONS
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32 * spacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PoolActionButton(
                      icon: Assets.iconsShuffle,
                      label: 'Shuffle',
                      onTap: _shuffleAnswers,
                    ),
                    PoolActionButton(
                      icon: Assets.iconsSkip,
                      label: 'Skip',
                      onTap: _skipQuestion,
                    ),
                  ],
                ),
              ),

              SizedBox(height: MediaQuery.of(context).padding.bottom + 28),
            ],
          ),
        ),
      ),
    );
  }
}
