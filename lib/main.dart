import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gesture-Controlled Interface',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: GestureHomeScreen(),
    );
  }
}

class GestureHomeScreen extends StatefulWidget {
  @override
  _GestureHomeScreenState createState() => _GestureHomeScreenState();
}

class _GestureHomeScreenState extends State<GestureHomeScreen> {
  // ============================================================
  // STATE VARIABLES
  // ============================================================
  
  // For Tap Gesture
  String _tapMessage = "Tap anywhere in the blue box!";
  Color _tapBoxColor = Colors.blue.shade100;
  int _tapCount = 0;
  
  // For Long Press Gesture
  String _longPressMessage = "Long press the green box!";
  Color _longPressBoxColor = Colors.green.shade100;
  bool _isLongPressing = false;
  
  // For Double Tap Gesture
  String _doubleTapMessage = "Double tap the orange box!";
  Color _doubleTapBoxColor = Colors.orange.shade100;
  int _doubleTapCount = 0;
  
  // For Swipe Gesture
  String _swipeMessage = "Swipe left or right on the purple box!";
  Color _swipeBoxColor = Colors.purple.shade100;
  String _swipeDirection = "None";
  
  // Feedback message for all gestures
  String _globalFeedback = "Perform a gesture to see the result!";
  Color _feedbackColor = Colors.grey.shade700;
  
  // ============================================================
  // GESTURE HANDLERS
  // ============================================================
  
  // 1. TAP GESTURE HANDLER
  void _handleTap() {
    setState(() {
      _tapCount++;
      _tapMessage = "✓ Tap detected! You've tapped $_tapCount time(s)";
      _tapBoxColor = Colors.blue.shade300;
      _globalFeedback = "Tap gesture triggered! Count: $_tapCount";
      _feedbackColor = Colors.blue;
      
      // Reset color after 500ms (refinement for better UX)
      Future.delayed(Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _tapBoxColor = Colors.blue.shade100;
          });
        }
      });
    });
  }
  
  // 2. LONG PRESS GESTURE HANDLER
  void _handleLongPress() {
    setState(() {
      _isLongPressing = true;
      _longPressMessage = "✓ Long press detected! Holding down...";
      _longPressBoxColor = Colors.green.shade400;
      _globalFeedback = "Long press gesture triggered! Hold for 1 second";
      _feedbackColor = Colors.green;
      
      // Simulate an action after long press (refinement)
      Future.delayed(Duration(milliseconds: 800), () {
        if (mounted) {
          setState(() {
            _longPressMessage = "✓ Long press completed! Action performed ✓";
            _isLongPressing = false;
            _globalFeedback = "Long press action completed!";
            
            // Reset after delay
            Future.delayed(Duration(milliseconds: 1000), () {
              if (mounted) {
                setState(() {
                  _longPressMessage = "Long press the green box!";
                  _longPressBoxColor = Colors.green.shade100;
                });
              }
            });
          });
        }
      });
    });
  }
  
  // 3. DOUBLE TAP GESTURE HANDLER
  void _handleDoubleTap() {
    setState(() {
      _doubleTapCount++;
      _doubleTapMessage = "✓✓ Double tap detected! You've double-tapped $_doubleTapCount time(s)";
      _doubleTapBoxColor = Colors.orange.shade400;
      _globalFeedback = "Double tap gesture triggered! Count: $_doubleTapCount";
      _feedbackColor = Colors.orange;
      
      // Reset color after 500ms (refinement for better UX)
      Future.delayed(Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _doubleTapBoxColor = Colors.orange.shade100;
          });
        }
      });
    });
  }
  
  // 4. SWIPE GESTURE HANDLER
  void _handleSwipe(String direction) {
    setState(() {
      _swipeDirection = direction;
      _swipeMessage = "✓ Swipe detected! You swiped $direction";
      _swipeBoxColor = Colors.purple.shade300;
      _globalFeedback = "Swipe gesture triggered! Direction: $direction";
      _feedbackColor = Colors.purple;
      
      // Reset after delay (refinement for better UX)
      Future.delayed(Duration(milliseconds: 800), () {
        if (mounted) {
          setState(() {
            _swipeMessage = "Swipe left or right on the purple box!";
            _swipeBoxColor = Colors.purple.shade100;
            _swipeDirection = "None";
          });
        }
      });
    });
  }
  
  // ============================================================
  // BUILD METHOD
  // ============================================================
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gesture-Controlled Interface'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ============================================================
            // GLOBAL FEEDBACK SECTION (Improves usability)
            // ============================================================
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _feedbackColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _feedbackColor, width: 1),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.feedback_outlined,
                    color: _feedbackColor,
                    size: 32,
                  ),
                  SizedBox(height: 8),
                  Text(
                    _globalFeedback,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: _feedbackColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 24),
            
            // ============================================================
            // GESTURE 1: TAP GESTURE
            // ============================================================
            Text(
              "1. TAP GESTURE",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: _handleTap,
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: _tapBoxColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blue, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.touch_app, size: 40, color: Colors.blue),
                      SizedBox(height: 8),
                      Text(
                        _tapMessage,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 24),
            
            // ============================================================
            // GESTURE 2: LONG PRESS GESTURE
            // ============================================================
            Text(
              "2. LONG PRESS GESTURE",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onLongPress: _handleLongPress,
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: _longPressBoxColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.green, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.touch_app, size: 40, color: Colors.green),
                      SizedBox(height: 8),
                      Text(
                        _longPressMessage,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      if (_isLongPressing)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 24),
            
            // ============================================================
            // GESTURE 3: DOUBLE TAP GESTURE
            // ============================================================
            Text(
              "3. DOUBLE TAP GESTURE",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onDoubleTap: _handleDoubleTap,
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: _doubleTapBoxColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.orange, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.touch_app, size: 40, color: Colors.orange),
                      SizedBox(height: 8),
                      Text(
                        _doubleTapMessage,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 24),
            
            // ============================================================
            // GESTURE 4: SWIPE GESTURE
            // ============================================================
            Text(
              "4. SWIPE GESTURE",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onHorizontalDragEnd: (details) {
                // Detect swipe direction based on velocity
                if (details.primaryVelocity != null) {
                  if (details.primaryVelocity! > 0) {
                    _handleSwipe("RIGHT →");
                  } else if (details.primaryVelocity! < 0) {
                    _handleSwipe("LEFT ←");
                  }
                }
              },
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: _swipeBoxColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.purple, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _swipeDirection == "LEFT ←" 
                            ? Icons.swipe_left 
                            : (_swipeDirection == "RIGHT →" 
                                ? Icons.swipe_right 
                                : Icons.swipe),
                        size: 40,
                        color: Colors.purple,
                      ),
                      SizedBox(height: 8),
                      Text(
                        _swipeMessage,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      if (_swipeDirection != "None")
                        Text(
                          "Direction: $_swipeDirection",
                          style: TextStyle(fontSize: 12, color: Colors.purple),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 24),
            
            // ============================================================
            // RESET BUTTON (Bonus: Additional interaction)
            // ============================================================
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  // Reset all states
                  _tapCount = 0;
                  _tapMessage = "Tap anywhere in the blue box!";
                  _doubleTapCount = 0;
                  _doubleTapMessage = "Double tap the orange box!";
                  _swipeDirection = "None";
                  _globalFeedback = "All gestures reset! Try them again.";
                  _feedbackColor = Colors.grey.shade700;
                });
              },
              icon: Icon(Icons.refresh),
              label: Text("Reset All Gestures"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
            ),
            
            SizedBox(height: 16),
            
            // ============================================================
            // INSTRUCTION NOTE
            // ============================================================
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.grey.shade700),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "💡 Try each gesture: Tap, Long Press, Double Tap, and Swipe left/right!",
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
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