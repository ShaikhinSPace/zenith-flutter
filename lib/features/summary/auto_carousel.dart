import 'package:flutter/material.dart';
import 'dart:async';

class AutomaticCarousel extends StatefulWidget {
  final List<Widget> items;
  final Duration autoScrollDuration;
  final bool autoScrollEnabled;
  final double height;
  final bool showIndicators;
  final bool showNavigationButtons;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final bool showPause;
  final Function(int)? onPageChanged;

  const AutomaticCarousel({
    Key? key,
    required this.items,
    this.autoScrollDuration = const Duration(seconds: 3),
    this.autoScrollEnabled = true,
    this.height = 200.0,
    this.showIndicators = true,
    this.showNavigationButtons = false,
    this.showPause = false,
    this.padding = const EdgeInsets.all(8.0),
    this.borderRadius = const BorderRadius.all(Radius.circular(12.0)),
    this.onPageChanged,
  }) : super(key: key);

  @override
  State<AutomaticCarousel> createState() => _AutomaticCarouselState();
}

class _AutomaticCarouselState extends State<AutomaticCarousel> {
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;
  bool _isAutoScrollActive = false;

  @override
  void initState() {
    _pageController = PageController();
    _isAutoScrollActive = widget.autoScrollEnabled;
    _startAutoScroll();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    if (!_isAutoScrollActive || widget.items.isEmpty) return;

    _timer?.cancel();
    _timer = Timer.periodic(widget.autoScrollDuration, (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_currentPage + 1) % widget.items.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _stopAutoScroll() {
    _timer?.cancel();
  }

  void _toggleAutoScroll() {
    setState(() {
      _isAutoScrollActive = !_isAutoScrollActive;
      if (_isAutoScrollActive) {
        _startAutoScroll();
      } else {
        _stopAutoScroll();
      }
    });
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    int previousPage =
        _currentPage == 0 ? widget.items.length - 1 : _currentPage - 1;
    _goToPage(previousPage);
  }

  void _nextPage() {
    int nextPage = (_currentPage + 1) % widget.items.length;
    _goToPage(nextPage);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return Container(
        height: widget.height,
        padding: widget.padding,
        child: const Center(child: Text('No items to display')),
      );
    }

    return Padding(
      padding: widget.padding,
      child: Column(
        children: [
          // Carousel Container
          Container(
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                // PageView
                ClipRRect(
                  borderRadius: widget.borderRadius,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                      widget.onPageChanged?.call(index);
                    },
                    itemCount: widget.items.length,
                    itemBuilder: (context, index) {
                      return widget.items[index];
                    },
                  ),
                ),

                // Navigation Buttons
                if (widget.showNavigationButtons) ...[
                  Positioned(
                    left: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: _previousPage,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: _nextPage,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],

                // Auto-scroll toggle button
                widget.showPause
                    ? Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: _toggleAutoScroll,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            _isAutoScrollActive
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    )
                    : SizedBox.shrink(),
              ],
            ),
          ),

          // Indicators
          if (widget.showIndicators && widget.items.length > 1)
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.items.length,
                  (index) => GestureDetector(
                    onTap: () => _goToPage(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: _currentPage == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color:
                            _currentPage == index
                                ? Theme.of(context).primaryColor
                                : Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
