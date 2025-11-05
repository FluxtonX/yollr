import 'package:flutter/material.dart';
import 'package:yollr/core/theme/pallete.dart';
import 'package:yollr/core/utils/responsive_utils.dart';
import 'package:yollr/features/inbox/wisgets/inbox_message_card.dart';
import 'package:yollr/features/inbox/wisgets/see_who_button.dart';
import 'package:yollr/features/pools/widgets/top_nav_bar.dart';

enum MessageGender { girl, boy, nonBinary }

class InboxMessage {
  final MessageGender gender;
  final String time;

  const InboxMessage({required this.gender, required this.time});

  String get displayText => switch (gender) {
    MessageGender.girl => 'From A Girl',
    MessageGender.boy => 'From A Boy',
    MessageGender.nonBinary => 'From A Non-Binary',
  };

  Color get flameColor => switch (gender) {
    MessageGender.girl => const Color(0xFF4A90E2),
    MessageGender.boy => const Color(0xFFD4722B),
    MessageGender.nonBinary => const Color(0xFF00C853),
  };
}

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 1;

  final List<InboxMessage> _messages = const [
    InboxMessage(gender: MessageGender.girl, time: '2 Min'),
    InboxMessage(gender: MessageGender.boy, time: '2 Min'),
    InboxMessage(gender: MessageGender.girl, time: '2 Min'),
    InboxMessage(gender: MessageGender.nonBinary, time: '2 Min'),
    InboxMessage(gender: MessageGender.boy, time: '2 Min'),
    InboxMessage(gender: MessageGender.girl, time: '2 Min'),
    InboxMessage(gender: MessageGender.nonBinary, time: '2 Min'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1)
      ..addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      setState(() => _selectedTabIndex = _tabController.index);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _onSeeWhoLikeYou() => debugPrint('See who like you tapped');

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveUtils.paddingScale(context);
    final spacing = ResponsiveUtils.spacingScale(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Pallete.secondaryColor, Pallete.primaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const TopNavBar(inboxBadge: 3, activeTab: 'Inbox'),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14 * padding,
                          vertical: 16 * spacing,
                        ),
                        itemCount: _messages.length,
                        separatorBuilder: (_, __) =>
                            SizedBox(height: 12 * spacing),
                        itemBuilder: (context, index) =>
                            InboxMessageCard(message: _messages[index]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        24 * padding,
                        16 * spacing,
                        24 * padding,
                        MediaQuery.of(context).padding.bottom + 20,
                      ),
                      child: SeeWhoButton(onPressed: _onSeeWhoLikeYou),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
