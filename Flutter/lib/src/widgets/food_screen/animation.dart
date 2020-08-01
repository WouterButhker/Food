import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:student/src/entities/group.dart';
import 'package:student/src/widgets/food_screen/day_summary.dart';
import 'package:student/src/widgets/food_screen/models/dayOrWeekModel.dart';

class MyAnimationWidget extends StatefulWidget {
  final Group _group;

  MyAnimationWidget(this._group);

  @override
  State<StatefulWidget> createState() {
    return _MyAnimationState(this._group);
  }
}

class _MyAnimationState extends State<MyAnimationWidget>
    with TickerProviderStateMixin {
  final Group _group;

  _MyAnimationState(this._group);

  @override
  Widget build(BuildContext context) {
    return _StatelessAnimationWidget(this._group, this);
  }
}

class _StatelessAnimationWidget extends StatelessWidget {
  final Group _group;
  final TickerProviderStateMixin _tickerProviderStateMixin;

  _StatelessAnimationWidget(this._group, this._tickerProviderStateMixin);

  @override
  Widget build(BuildContext context) {
    AnimationController _animationController = AnimationController(
        vsync: _tickerProviderStateMixin, duration: Duration(seconds: 1));

    Provider.of<DayOrWeekModel>(context, listen: false).animationController = _animationController;

    Animation<Offset> _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.1, 0),
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeIn));

    return SlideTransition(
      position: _offsetAnimation,
      child: DaySummary(this._group),
    );
  }
}
