import 'package:dooit/core/colors.dart';
import 'package:dooit/data/models/data.dart';
import 'package:dooit/data/repositories/alarm_repository.dart';
import 'package:dooit/data/repositories/user_repository.dart';
import 'package:dooit/presentation/providers/check_provider.dart';
import 'package:dooit/presentation/screens/alarm_screen.dart';
import 'package:dooit/presentation/screens/exercise_analysis_screen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import '../components/custom_swiper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserRepository userRepository = UserRepository();
  AlarmRepository alarmRepository = AlarmRepository();
  CheckProvider checkProvider = CheckProvider();

  void handleTap(int index) {
    switch (index) {
      case 0:
        // _launchURL(url0);
        break;
      case 1:
        // _launchURL(url1);
        break;
      case 2:
        // _launchURL(url2);
        break;
    }
  }

  Color getGradientColor(int duration, {int maxDuration = 7200}) {
    final ratio = (duration / maxDuration).clamp(0.0, 1.0);

    return Color.lerp(Colors.white, Colors.blue.shade800, ratio)!;
  }

  String formatMinutes(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    final formatted = '${hours}h ${mins.toString().padLeft(2, '0')}m';
    return formatted;
  }

  String getWeeklyExerciseMessage(int minutes) {
    if (minutes <= 0) {
      return '이번 주 운동 기록이 없어요 😫';
    } else if (minutes < 60) {
      return '이번 주는 거의 안 움직였어요';
    } else if (minutes < 180) {
      return '그래도 몸 좀 풀긴 했네요! 👍';
    } else if (minutes < 360) {
      return '운동 습관 들이기 좋아요!';
    } else if (minutes < 600) {
      return '와! 운동 루틴이 잡혀가고 있어요! 🔥';
    } else {
      return '프로 운동러 멋져요~! 🏆';
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      userRepository
        ..getRank()
        ..userInfo()
        ..getTime();
      alarmRepository.getAlarm();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6EFE9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/home_screen_title.png',
                    width: 250,
                    height: 100,
                  ),
                  Spacer(),
                  Container(
                    width: 70,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Color(0xffF1E7DE),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/glowing_star.png',
                          width: 25,
                          height: 25,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '${data.totalPoint ?? 0}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Pretendard',
                          ),
                        ),
                        Text(
                          '개',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  AlarmScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                                const begin = Offset(1, 0);
                                const end = Offset.zero;
                                const curve = Curves.ease;
                                var tween = Tween(
                                  begin: begin,
                                  end: end,
                                ).chain(CurveTween(curve: curve));
                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                        ),
                      );
                    },
                    child: Icon(
                      Icons.notifications,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 350,
              height: 350,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/timer_bg.png',
                    color: Colors.green,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text(
                      // '${data.}',
                      // style: TextStyle(color: Colors.black),
                      // ),
                      Row(children: []),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 180,
                    height: 65,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/pin.png',
                          width: 35,
                          height: 35,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '헬스장 찾기',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 180,
                    height: 65,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade500,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/biceps.png',
                          width: 35,
                          height: 35,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Check-in',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            CustomSwiper(
              items: List.generate(5, (index) {
                return Image.asset(
                  'assets/images/banner${index + 1}.png',
                  fit: BoxFit.cover,
                );
              }),
              height: 100,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              onTap: (index) => handleTap(index),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '이번 주 운동 시간',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        formatMinutes(data.weekStat_time!),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 43,
                          fontFamily: 'HSSanTokki',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${getWeeklyExerciseMessage(data.weekStat_time?.toInt() ?? 0)}' ??
                            '0',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: 'Prendard',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: 60),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      ExerciseAnalysisScreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: 135,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(200),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '운동 분석 보기',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(7, (index) {
                  final dayData = data.weekStats[index];
                  final duration = dayData['duration'] ?? 0;
                  final maxHeight = 120.0;
                  final maxDuration = 3600;
                  final barHeight = ((duration / maxDuration) * maxHeight)
                      .clamp(0, maxHeight);

                  return duration != 0
                      ? Container(
                          width: 40,
                          height: 140,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: 40,
                            height: barHeight,
                            decoration: BoxDecoration(
                              color: getGradientColor(duration),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        )
                      : DottedBorder(
                          options: RoundedRectDottedBorderOptions(
                            dashPattern: [7, 5],
                            strokeWidth: 1.3,
                            radius: Radius.circular(20),
                            padding: EdgeInsets.zero,
                          ),
                          child: Container(
                            width: 40,
                            height: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        );
                }),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(7, (index) {
                final workDateStr = data.weekStats[index]['work_date'];
                if (workDateStr == null) return const Text('-');

                final workDate = DateTime.parse(workDateStr);
                const weekdayNames = ['월', '화', '수', '목', '금', '토', '일'];

                // DateTime weekday는 1(월) ~ 7(일)
                final weekday = weekdayNames[workDate.weekday - 1];

                return Text(
                  weekday,
                  style: TextStyle(
                    fontWeight: (workDateStr == data.daily)
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: (workDateStr == data.daily)
                        ? Colors.black
                        : Colors.grey,
                  ),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(7, (index) {
                  final dayData = data.weekStats[index];
                  final workDateStr = dayData['work_date']; // 예: '2025-06-29'
                  final todayStr = data.daily; // 예: '2025-06-29'

                  if (workDateStr == null) return const Text('-');

                  final workDate = DateTime.parse(workDateStr);
                  final isToday = (todayStr != null && workDateStr == todayStr);

                  return Text(
                    '${workDate.day}',
                    style: TextStyle(
                      fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                      color: isToday ? Colors.black : Colors.grey,
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Image.asset(
                      'assets/images/chart.png',
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: 5),
                    Text(
                      '이번 주 평균 운동 시간',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 15,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Text(
                      data.weeklyDailyAverageWorkoutDuration != null
                          ? formatMinutes(
                              data.weeklyDailyAverageWorkoutDuration!,
                            )
                          : '운동 기록이 없어요',
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 30),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Image.asset(
                      'assets/images/fire.png',
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: 5),
                    Text(
                      '이번 주 최대 운동 시간',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 15,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Text(
                      ('${data.weeklyMaxWorkoutDuration}' ?? '운동 기록이 없어요'),
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 30),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
