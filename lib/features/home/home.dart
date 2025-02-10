// lib/screens/home_view.dart
import 'package:collectics/config/utils/global_widgets/main_scaffold.dart';
import 'package:collectics/config/utils/theme/theme.dart';
import 'package:collectics/features/home/models/cards_model.dart';
import 'package:collectics/features/home/models/pull_state.dart';
import 'package:collectics/features/home/widgets/cards_widget.dart';
import 'package:collectics/features/home/widgets/pull_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late PullState _pullState;
  final List<CardModel> _cards = [];
  bool _showGrid = false;

  @override
  void initState() {
    super.initState();
    _initPullState();
  }

  void _initPullState() {
    final now = DateTime.now();
    _pullState = PullState(
      remainingPulls: 12,
      lastPullReset: now,
    );
  }

  Future<void> _pullCard() async {
    if (_pullState.remainingPulls <= 0) return;

    setState(() {
      _pullState = _pullState.copyWith(isPulling: true);
    });

    await Future.delayed(const Duration(milliseconds: 800));

    setState(() {
      _cards.add(
        CardModel(
          id: _cards.length,
          imageUrl: 'https://picsum.photos/300/400?random=${_cards.length}',
          name: 'Card ${_cards.length + 1}',
          offset: _cards.length * 15.0,
        ),
      );
      _pullState = _pullState.copyWith(
        isPulling: false,
        remainingPulls: _pullState.remainingPulls - 1,
      );
    });
  }

  List<Widget> _buildStackedCards() {
    final lastThreeCards = _cards.length > 3 
      ? _cards.sublist(_cards.length - 3) 
      : _cards;
      
    return lastThreeCards.asMap().entries.map((entry) {
      return Positioned(
        top: entry.key * 15.0,
        child: CardWidget(card: entry.value),
      );
    }).toList();
  }

  List<Widget> _buildGridCards() {
    return _cards.map((card) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: CardWidget(
          card: card,
          isGridView: true,
        ),
      );
    }).toList().reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/currency.svg',
                      color: AppColors.primary,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '1,500',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Pulls: ${_pullState.remainingPulls}/${_pullState.maxPulls}'),
                    if (_cards.isNotEmpty)
                      IconButton(
                        icon: Icon(_showGrid ? Icons.grid_off : Icons.grid_on),
                        onPressed: () => setState(() => _showGrid = !_showGrid),
                      ),
                  ],
                ),
              ],
            ),
          ),
          if (_cards.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/dice_icon.svg',
                      width: 200,
                      height: 250,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 24),
                    PullButton(
                      pullState: _pullState,
                      onPull: _pullCard,
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: _showGrid 
                ? SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        ..._buildGridCards(),
                        SizedBox(height: 20),
                        PullButton(
                          pullState: _pullState,
                          onPull: _pullCard,
                        ),
                      ],
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          width: 350,
                          height: 500,
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: _buildStackedCards(),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      PullButton(
                        pullState: _pullState,
                        onPull: _pullCard,
                      ),
                    ],
                  ),
            ),
        ],
      ),
    );
  }
}