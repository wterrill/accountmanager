// ignore_for_file: file_names
// ignore_for_file: prefer_asserts_with_message
// ignore_for_file: avoid_types_on_closure_parameters
// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: avoid_returning_null
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: parameter_assignments
// ignore_for_file: join_return_with_assignment
// ignore_for_file: prefer_const_constructors
// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: prefer_final_locals

import 'package:flutter/material.dart';

class TimeTracking extends StatelessWidget {
  const TimeTracking({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
          400,
          (400 * 1)
              .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
      painter: RPSCustomPainter(),
    );
  }
}
//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path path_0 = Path();
    path_0.moveTo(size.width * 0.8125000, size.height * 0.04687500);
    path_0.lineTo(size.width * 0.8568359, size.height * 0.1798828);
    path_0.lineTo(size.width * 0.3724609, size.height * 0.1798828);
    path_0.lineTo(size.width * 0.3724609, size.height * 0.8048828);
    path_0.lineTo(size.width * 0.8724609, size.height * 0.8048828);
    path_0.lineTo(size.width * 0.8724609, size.height * 0.3673828);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xfffdbf92).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Color(0xfffdb683).withOpacity(1.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(size.width * 0.1562500, size.height * 0.7968750,
                size.width * 0.2500000, size.height * 0.1562500),
            bottomRight: Radius.circular(size.width * 0.07812500),
            bottomLeft: Radius.circular(size.width * 0.07812500),
            topLeft: Radius.circular(size.width * 0.07812500),
            topRight: Radius.circular(size.width * 0.07812500)),
        paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.5000000, size.height * 0.2500000);
    path_2.close();
    path_2.moveTo(size.width * 0.5000000, size.height * 0.06250000);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Color(0xffffb431).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.4687500, size.height * 0.1718750);
    path_3.lineTo(size.width * 0.5312500, size.height * 0.1718750);
    path_3.lineTo(size.width * 0.5312500, size.height * 0.2812500);
    path_3.lineTo(size.width * 0.4687500, size.height * 0.2812500);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = Color(0xffc7483c).withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = Color(0xfffdb683).withOpacity(1.0);
    canvas.drawCircle(Offset(size.width * 0.5312500, size.height * 0.5937500),
        size.width * 0.3281250, paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.3437500, size.height * 0.3437500);
    path_5.lineTo(size.width * 0.2454238, size.height * 0.2454238);
    path_5.lineTo(size.width * 0.2050215, size.height * 0.2858262);
    path_5.lineTo(size.width * 0.3033477, size.height * 0.3841523);
    path_5.close();

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = Color(0xffc7483c).withOpacity(1.0);
    canvas.drawPath(path_5, paint_5_fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.6562500, size.height * 0.3437500);
    path_6.lineTo(size.width * 0.7545762, size.height * 0.2454238);
    path_6.lineTo(size.width * 0.7949785, size.height * 0.2858262);
    path_6.lineTo(size.width * 0.6966523, size.height * 0.3841523);
    path_6.close();

    Paint paint_6_fill = Paint()..style = PaintingStyle.fill;
    paint_6_fill.color = Color(0xffc7483c).withOpacity(1.0);
    canvas.drawPath(path_6, paint_6_fill);

    Paint paint_7_fill = Paint()..style = PaintingStyle.fill;
    paint_7_fill.color = Color(0xffd65246).withOpacity(1.0);
    canvas.drawCircle(Offset(size.width * 0.5000000, size.height * 0.5625000),
        size.width * 0.3281250, paint_7_fill);

    Paint paint_8_fill = Paint()..style = PaintingStyle.fill;
    paint_8_fill.color = Color(0xff2c86d1).withOpacity(1.0);
    canvas.drawCircle(Offset(size.width * 0.5000000, size.height * 0.5625000),
        size.width * 0.2656250, paint_8_fill);

    Paint paint_9_fill = Paint()..style = PaintingStyle.fill;
    paint_9_fill.color = Color(0xff348ed8).withOpacity(1.0);
    canvas.drawCircle(Offset(size.width * 0.5000000, size.height * 0.5625000),
        size.width * 0.2187500, paint_9_fill);

    Path path_10 = Path();
    path_10.moveTo(size.width * 0.4375000, size.height * 0.1093750);
    path_10.lineTo(size.width * 0.5625000, size.height * 0.1093750);
    path_10.lineTo(size.width * 0.5625000, size.height * 0.1718750);
    path_10.lineTo(size.width * 0.4375000, size.height * 0.1718750);
    path_10.close();

    Paint paint_10_fill = Paint()..style = PaintingStyle.fill;
    paint_10_fill.color = Color(0xffd65246).withOpacity(1.0);
    canvas.drawPath(path_10, paint_10_fill);

    Path path_11 = Path();
    path_11.moveTo(size.width * 0.4843750, size.height * 0.7187500);
    path_11.lineTo(size.width * 0.5156250, size.height * 0.7187500);
    path_11.lineTo(size.width * 0.5156250, size.height * 0.7812500);
    path_11.lineTo(size.width * 0.4843750, size.height * 0.7812500);
    path_11.close();

    Paint paint_11_fill = Paint()..style = PaintingStyle.fill;
    paint_11_fill.color = Color(0xffffb431).withOpacity(1.0);
    canvas.drawPath(path_11, paint_11_fill);

    Path path_12 = Path();
    path_12.moveTo(size.width * 0.4843750, size.height * 0.3437500);
    path_12.lineTo(size.width * 0.5156250, size.height * 0.3437500);
    path_12.lineTo(size.width * 0.5156250, size.height * 0.4062500);
    path_12.lineTo(size.width * 0.4843750, size.height * 0.4062500);
    path_12.close();

    Paint paint_12_fill = Paint()..style = PaintingStyle.fill;
    paint_12_fill.color = Color(0xffffb431).withOpacity(1.0);
    canvas.drawPath(path_12, paint_12_fill);

    Path path_13 = Path();
    path_13.moveTo(size.width * 0.5781250, size.height * 0.6936309);
    path_13.lineTo(size.width * 0.6093750, size.height * 0.6936309);
    path_13.lineTo(size.width * 0.6093750, size.height * 0.7561309);
    path_13.lineTo(size.width * 0.5781250, size.height * 0.7561309);
    path_13.close();

    Paint paint_13_fill = Paint()..style = PaintingStyle.fill;
    paint_13_fill.color = Color(0xffffb431).withOpacity(1.0);
    canvas.drawPath(path_13, paint_13_fill);

    Path path_14 = Path();
    path_14.moveTo(size.width * 0.3906250, size.height * 0.3688691);
    path_14.lineTo(size.width * 0.4218750, size.height * 0.3688691);
    path_14.lineTo(size.width * 0.4218750, size.height * 0.4313691);
    path_14.lineTo(size.width * 0.3906250, size.height * 0.4313691);
    path_14.close();

    Paint paint_14_fill = Paint()..style = PaintingStyle.fill;
    paint_14_fill.color = Color(0xffffb431).withOpacity(1.0);
    canvas.drawPath(path_14, paint_14_fill);

    Path path_15 = Path();
    path_15.moveTo(size.width * 0.6467559, size.height * 0.6250000);
    path_15.lineTo(size.width * 0.6780039, size.height * 0.6250000);
    path_15.lineTo(size.width * 0.6780039, size.height * 0.6875000);
    path_15.lineTo(size.width * 0.6467559, size.height * 0.6875000);
    path_15.close();

    Paint paint_15_fill = Paint()..style = PaintingStyle.fill;
    paint_15_fill.color = Color(0xffffb431).withOpacity(1.0);
    canvas.drawPath(path_15, paint_15_fill);

    Path path_16 = Path();
    path_16.moveTo(size.width * 0.3219961, size.height * 0.4375000);
    path_16.lineTo(size.width * 0.3532441, size.height * 0.4375000);
    path_16.lineTo(size.width * 0.3532441, size.height * 0.5000000);
    path_16.lineTo(size.width * 0.3219961, size.height * 0.5000000);
    path_16.close();

    Paint paint_16_fill = Paint()..style = PaintingStyle.fill;
    paint_16_fill.color = Color(0xffffb431).withOpacity(1.0);
    canvas.drawPath(path_16, paint_16_fill);

    Path path_17 = Path();
    path_17.moveTo(size.width * 0.6562500, size.height * 0.5468750);
    path_17.lineTo(size.width * 0.7187500, size.height * 0.5468750);
    path_17.lineTo(size.width * 0.7187500, size.height * 0.5781250);
    path_17.lineTo(size.width * 0.6562500, size.height * 0.5781250);
    path_17.close();

    Paint paint_17_fill = Paint()..style = PaintingStyle.fill;
    paint_17_fill.color = Color(0xffffb431).withOpacity(1.0);
    canvas.drawPath(path_17, paint_17_fill);

    Path path_18 = Path();
    path_18.moveTo(size.width * 0.2812500, size.height * 0.5468750);
    path_18.lineTo(size.width * 0.3437500, size.height * 0.5468750);
    path_18.lineTo(size.width * 0.3437500, size.height * 0.5781250);
    path_18.lineTo(size.width * 0.2812500, size.height * 0.5781250);
    path_18.close();

    Paint paint_18_fill = Paint()..style = PaintingStyle.fill;
    paint_18_fill.color = Color(0xffffb431).withOpacity(1.0);
    canvas.drawPath(path_18, paint_18_fill);

    Path path_19 = Path();
    path_19.moveTo(size.width * 0.3063711, size.height * 0.6406250);
    path_19.lineTo(size.width * 0.3688711, size.height * 0.6406250);
    path_19.lineTo(size.width * 0.3688711, size.height * 0.6718730);
    path_19.lineTo(size.width * 0.3063711, size.height * 0.6718730);
    path_19.close();

    Paint paint_19_fill = Paint()..style = PaintingStyle.fill;
    paint_19_fill.color = Color(0xffffb431).withOpacity(1.0);
    canvas.drawPath(path_19, paint_19_fill);

    Path path_20 = Path();
    path_20.moveTo(size.width * 0.5625000, size.height * 0.3844941);
    path_20.lineTo(size.width * 0.6250000, size.height * 0.3844941);
    path_20.lineTo(size.width * 0.6250000, size.height * 0.4157441);
    path_20.lineTo(size.width * 0.5625000, size.height * 0.4157441);
    path_20.close();

    Paint paint_20_fill = Paint()..style = PaintingStyle.fill;
    paint_20_fill.color = Color(0xffffb431).withOpacity(1.0);
    canvas.drawPath(path_20, paint_20_fill);

    Path path_21 = Path();
    path_21.moveTo(size.width * 0.3750000, size.height * 0.7092559);
    path_21.lineTo(size.width * 0.4375000, size.height * 0.7092559);
    path_21.lineTo(size.width * 0.4375000, size.height * 0.7405059);
    path_21.lineTo(size.width * 0.3750000, size.height * 0.7405059);
    path_21.close();

    Paint paint_21_fill = Paint()..style = PaintingStyle.fill;
    paint_21_fill.color = Color(0xffffb431).withOpacity(1.0);
    canvas.drawPath(path_21, paint_21_fill);

    Paint paint_22_fill = Paint()..style = PaintingStyle.fill;
    paint_22_fill.color = Color(0xffffb431).withOpacity(1.0);
    canvas.drawCircle(Offset(size.width * 0.5000000, size.height * 0.5625000),
        size.width * 0.04687500, paint_22_fill);

    Path path_23 = Path();
    path_23.moveTo(size.width * 0.5141133, size.height * 0.4843750);
    path_23.lineTo(size.width * 0.7001719, size.height * 0.4843750);
    path_23.lineTo(size.width * 0.7001719, size.height * 0.5156250);
    path_23.lineTo(size.width * 0.5141133, size.height * 0.5156250);
    path_23.close();

    Paint paint_23_fill = Paint()..style = PaintingStyle.fill;
    paint_23_fill.color = Color(0xffffb431).withOpacity(1.0);
    canvas.drawPath(path_23, paint_23_fill);

    Paint paint_24_fill = Paint()..style = PaintingStyle.fill;
    paint_24_fill.color = Color(0xfffdc8a2).withOpacity(1.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(size.width * 0.04687500, size.height * 0.3281250,
                size.width * 0.2500000, size.height * 0.1562500),
            bottomRight: Radius.circular(size.width * 0.07812500),
            bottomLeft: Radius.circular(size.width * 0.07812500),
            topLeft: Radius.circular(size.width * 0.07812500),
            topRight: Radius.circular(size.width * 0.07812500)),
        paint_24_fill);

    Paint paint_25_fill = Paint()..style = PaintingStyle.fill;
    paint_25_fill.color = Color(0xfffdc8a2).withOpacity(1.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(size.width * 0.04687500, size.height * 0.4843750,
                size.width * 0.2500000, size.height * 0.1562500),
            bottomRight: Radius.circular(size.width * 0.07812500),
            bottomLeft: Radius.circular(size.width * 0.07812500),
            topLeft: Radius.circular(size.width * 0.07812500),
            topRight: Radius.circular(size.width * 0.07812500)),
        paint_25_fill);

    Paint paint_26_fill = Paint()..style = PaintingStyle.fill;
    paint_26_fill.color = Color(0xfffdc8a2).withOpacity(1.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(size.width * 0.09375000, size.height * 0.6406250,
                size.width * 0.2500000, size.height * 0.1562500),
            bottomRight: Radius.circular(size.width * 0.07812500),
            bottomLeft: Radius.circular(size.width * 0.07812500),
            topLeft: Radius.circular(size.width * 0.07812500),
            topRight: Radius.circular(size.width * 0.07812500)),
        paint_26_fill);

    Paint paint_27_fill = Paint()..style = PaintingStyle.fill;
    paint_27_fill.color = Color(0xfffdc8a2).withOpacity(1.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(size.width * 0.1250000, size.height * 0.7968750,
                size.width * 0.2500000, size.height * 0.1562500),
            bottomRight: Radius.circular(size.width * 0.07812500),
            bottomLeft: Radius.circular(size.width * 0.07812500),
            topLeft: Radius.circular(size.width * 0.07812500),
            topRight: Radius.circular(size.width * 0.07812500)),
        paint_27_fill);

    Paint paint_28_fill = Paint()..style = PaintingStyle.fill;
    paint_28_fill.color = Color(0xfffdb683).withOpacity(1.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(size.width * 0.1093750, size.height * 0.4687500,
                size.width * 0.1250000, size.height * 0.03125000),
            bottomRight: Radius.circular(size.width * 0.01562500),
            bottomLeft: Radius.circular(size.width * 0.01562500),
            topLeft: Radius.circular(size.width * 0.01562500),
            topRight: Radius.circular(size.width * 0.01562500)),
        paint_28_fill);

    Paint paint_29_fill = Paint()..style = PaintingStyle.fill;
    paint_29_fill.color = Color(0xfffdb683).withOpacity(1.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(size.width * 0.1406250, size.height * 0.6250000,
                size.width * 0.09375000, size.height * 0.03125000),
            bottomRight: Radius.circular(size.width * 0.01353125),
            bottomLeft: Radius.circular(size.width * 0.01353125),
            topLeft: Radius.circular(size.width * 0.01353125),
            topRight: Radius.circular(size.width * 0.01353125)),
        paint_29_fill);

    Paint paint_30_fill = Paint()..style = PaintingStyle.fill;
    paint_30_fill.color = Color(0xfffdb683).withOpacity(1.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(size.width * 0.1875000, size.height * 0.7812500,
                size.width * 0.09375000, size.height * 0.03125000),
            bottomRight: Radius.circular(size.width * 0.01353125),
            bottomLeft: Radius.circular(size.width * 0.01353125),
            topLeft: Radius.circular(size.width * 0.01353125),
            topRight: Radius.circular(size.width * 0.01353125)),
        paint_30_fill);

    Path path_31 = Path();
    path_31.moveTo(size.width * 0.9670996, size.height * 0.3211367);
    path_31.lineTo(size.width * 0.8264746, size.height * 0.03988672);
    path_31.lineTo(size.width * 0.8482266, size.height * 0.1051602);
    path_31.lineTo(size.width * 0.8327090, size.height * 0.1206777);
    path_31.cubicTo(
        size.width * 0.8306348,
        size.height * 0.1215332,
        size.width * 0.8123848,
        size.height * 0.1074219,
        size.width * 0.8101797,
        size.height * 0.1061309);
    path_31.cubicTo(
        size.width * 0.8100059,
        size.height * 0.1060293,
        size.width * 0.8098320,
        size.height * 0.1059355,
        size.width * 0.8096582,
        size.height * 0.1058379);
    path_31.lineTo(size.width * 0.7631855, size.height * 0.05935352);
    path_31.lineTo(size.width * 0.7227891, size.height * 0.09975000);
    path_31.lineTo(size.width * 0.6808555, size.height * 0.09975000);
    path_31.lineTo(size.width * 0.7058555, size.height * 0.1185195);
    path_31.lineTo(size.width * 0.7996055, size.height * 0.1185195);
    path_31.lineTo(size.width * 0.7058555, size.height * 0.1185195);
    path_31.lineTo(size.width * 0.6752305, size.height * 0.1123008);
    path_31.lineTo(size.width * 0.7689805, size.height * 0.1123008);
    path_31.cubicTo(
        size.width * 0.9585254,
        size.height * 0.1123008,
        size.width * 1.112730,
        size.height * -0.04190430,
        size.width * 1.112730,
        size.height * -0.2314492);
    path_31.lineTo(size.width * 1.159189, size.height * -0.2779004);
    path_31.lineTo(size.width * 1.118791, size.height * -0.3182969);
    path_31.lineTo(size.width * 1.112568, size.height * -0.3120742);
    path_31.lineTo(size.width * 1.095756, size.height * -0.3625254);
    path_31.lineTo(size.width * 1.230191, size.height * -0.09364844);
    path_31.lineTo(size.width * 1.230191, size.height * 0.3401621);
    path_31.lineTo(size.width * 0.8551914, size.height * 0.3401621);
    path_31.lineTo(size.width * 0.8551914, size.height * 0.3714121);
    path_31.lineTo(size.width * 1.230191, size.height * 0.3714121);
    path_31.lineTo(size.width * 1.230191, size.height * -0.06608789);
    path_31.close();
    path_31.moveTo(size.width * 0.7943418, size.height * -0.2309746);
    path_31.lineTo(size.width * 0.7318418, size.height * -0.2309746);
    path_31.lineTo(size.width * 0.7318418, size.height * -0.2622246);
    path_31.lineTo(size.width * 0.7943418, size.height * -0.2622246);
    path_31.close();
    path_31.moveTo(size.width * 0.7474668, size.height * -0.2309746);
    path_31.lineTo(size.width * 0.7787168, size.height * -0.2309746);
    path_31.lineTo(size.width * 0.7787168, size.height * -0.1993594);
    path_31.cubicTo(
        size.width * 0.7683438,
        size.height * -0.1998203,
        size.width * 0.7578184,
        size.height * -0.1998203,
        size.width * 0.7474668,
        size.height * -0.1993594);
    path_31.close();
    path_31.moveTo(size.width * 0.7630918, size.height * -0.3243594);
    path_31.lineTo(size.width * 0.7630918, size.height * -0.3399844);
    path_31.lineTo(size.width * 0.7630918, size.height * -0.4024844);
    path_31.lineTo(size.width * 0.6693418, size.height * -0.4024844);
    path_31.lineTo(size.width * 0.6693418, size.height * -0.3399844);
    path_31.lineTo(size.width * 0.6693418, size.height * -0.3243594);
    path_31.close();
    path_31.moveTo(size.width * 0.3789414, size.height * -0.07435938);
    path_31.lineTo(size.width * 0.3633164, size.height * -0.08998438);
    path_31.lineTo(size.width * 0.4037168, size.height * -0.1303809);
    path_31.lineTo(size.width * 0.4473281, size.height * -0.08676953);
    path_31.quadraticBezierTo(size.width * 0.4359785, size.height * -0.07716016,
        size.width * 0.4254531, size.height * -0.06656836);
    path_31.close();
    path_31.moveTo(size.width * 0.2783535, size.height * 0.1834316);
    path_31.lineTo(size.width * 0.3721035, size.height * 0.1834316);
    path_31.lineTo(size.width * 0.2783535, size.height * 0.1834316);
    path_31.close();
    path_31.moveTo(size.width * 0.3877285, size.height * 0.4021816);
    path_31.lineTo(size.width * 0.4814785, size.height * 0.4021816);
    path_31.close();
    path_31.moveTo(size.width * 0.6064785, size.height * 0.5584316);
    path_31.lineTo(size.width * 0.5127285, size.height * 0.5584316);
    path_31.lineTo(size.width * 0.6064785, size.height * 0.5584316);
    path_31.close();
    path_31.moveTo(size.width * 0.8096035, size.height * 0.4959316);
    path_31.lineTo(size.width * 0.8365977, size.height * 0.4803496);
    path_31.lineTo(size.width * 0.8209727, size.height * 0.4532832);
    path_31.lineTo(size.width * 0.7885352, size.height * 0.4720078);
    path_31.lineTo(size.width * 0.8211172, size.height * 0.4720078);
    path_31.lineTo(size.width * 0.8211172, size.height * 0.4407617);
    path_31.lineTo(size.width * 0.7885410, size.height * 0.4407617);
    path_31.cubicTo(
        size.width * 0.9448867,
        size.height * 0.4558809,
        size.width * 1.071244,
        size.height * 0.5933301,
        size.width * 1.071244,
        size.height * 0.7518457);
    path_31.cubicTo(
        size.width * 1.071244,
        size.height * 0.9241602,
        size.width * 0.9310566,
        size.height * 1.064346,
        size.width * 0.7587441,
        size.height * 1.064346);
    path_31.close();
    path_31.moveTo(size.width * 1.024369, size.height * 0.4458242);
    path_31.lineTo(size.width * 1.064766, size.height * 0.4862207);
    path_31.lineTo(size.width * 1.021133, size.height * 0.5298535);
    path_31.close();

    Paint paint_31_fill = Paint()..style = PaintingStyle.fill;
    paint_31_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_31, paint_31_fill);

    Path path_32 = Path();
    path_32.moveTo(size.width * 0.5000000, size.height * 0.2812500);
    path_32.lineTo(size.width * 0.5202305, size.height * 0.3050625);
    path_32.lineTo(size.width * 0.5073398, size.height * 0.3335352);
    path_32.cubicTo(
        size.width * 0.6624180,
        size.height * 0.3335352,
        size.width * 0.7885898,
        size.height * 0.2073633,
        size.width * 0.7885898,
        size.height * 0.05228516);
    path_32.cubicTo(
        size.width * 0.7885898,
        size.height * -0.1027930,
        size.width * 0.6624180,
        size.height * -0.2289648,
        size.width * 0.5073398,
        size.height * -0.2289648);
    path_32.close();

    Paint paint_32_fill = Paint()..style = PaintingStyle.fill;
    paint_32_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_32, paint_32_fill);

    Path path_33 = Path();
    path_33.moveTo(size.width * 0.4843750, size.height * 0.7187500);
    path_33.lineTo(size.width * 0.5156250, size.height * 0.7187500);
    path_33.lineTo(size.width * 0.5156250, size.height * 0.7812500);
    path_33.lineTo(size.width * 0.4843750, size.height * 0.7812500);
    path_33.close();

    Paint paint_33_fill = Paint()..style = PaintingStyle.fill;
    paint_33_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_33, paint_33_fill);

    Path path_34 = Path();
    path_34.moveTo(size.width * 0.4843750, size.height * 0.3437500);
    path_34.lineTo(size.width * 0.5156250, size.height * 0.3437500);
    path_34.lineTo(size.width * 0.5156250, size.height * 0.4062500);
    path_34.lineTo(size.width * 0.4843750, size.height * 0.4062500);
    path_34.close();

    Paint paint_34_fill = Paint()..style = PaintingStyle.fill;
    paint_34_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_34, paint_34_fill);

    Path path_35 = Path();
    path_35.moveTo(size.width * 0.5781250, size.height * 0.6936309);
    path_35.lineTo(size.width * 0.6093750, size.height * 0.6936309);
    path_35.lineTo(size.width * 0.6093750, size.height * 0.7561309);
    path_35.lineTo(size.width * 0.5781250, size.height * 0.7561309);
    path_35.close();

    Paint paint_35_fill = Paint()..style = PaintingStyle.fill;
    paint_35_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_35, paint_35_fill);

    Path path_36 = Path();
    path_36.moveTo(size.width * 0.3906250, size.height * 0.3688691);
    path_36.lineTo(size.width * 0.4218750, size.height * 0.3688691);
    path_36.lineTo(size.width * 0.4218750, size.height * 0.4313691);
    path_36.lineTo(size.width * 0.3906250, size.height * 0.4313691);
    path_36.close();

    Paint paint_36_fill = Paint()..style = PaintingStyle.fill;
    paint_36_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_36, paint_36_fill);

    Path path_37 = Path();
    path_37.moveTo(size.width * 0.6467559, size.height * 0.6250000);
    path_37.lineTo(size.width * 0.6780039, size.height * 0.6250000);
    path_37.lineTo(size.width * 0.6780039, size.height * 0.6875000);
    path_37.lineTo(size.width * 0.6467559, size.height * 0.6875000);
    path_37.close();

    Paint paint_37_fill = Paint()..style = PaintingStyle.fill;
    paint_37_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_37, paint_37_fill);

    Path path_38 = Path();
    path_38.moveTo(size.width * 0.3219961, size.height * 0.4375000);
    path_38.lineTo(size.width * 0.3532441, size.height * 0.4375000);
    path_38.lineTo(size.width * 0.3532441, size.height * 0.5000000);
    path_38.lineTo(size.width * 0.3219961, size.height * 0.5000000);
    path_38.close();

    Paint paint_38_fill = Paint()..style = PaintingStyle.fill;
    paint_38_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_38, paint_38_fill);

    Path path_39 = Path();
    path_39.moveTo(size.width * 0.6562500, size.height * 0.5468750);
    path_39.lineTo(size.width * 0.7187500, size.height * 0.5468750);
    path_39.lineTo(size.width * 0.7187500, size.height * 0.5781250);
    path_39.lineTo(size.width * 0.6562500, size.height * 0.5781250);
    path_39.close();

    Paint paint_39_fill = Paint()..style = PaintingStyle.fill;
    paint_39_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_39, paint_39_fill);

    Path path_40 = Path();
    path_40.moveTo(size.width * 0.5625000, size.height * 0.3844941);
    path_40.lineTo(size.width * 0.6250000, size.height * 0.3844941);
    path_40.lineTo(size.width * 0.6250000, size.height * 0.4157441);
    path_40.lineTo(size.width * 0.5625000, size.height * 0.4157441);
    path_40.close();

    Paint paint_40_fill = Paint()..style = PaintingStyle.fill;
    paint_40_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_40, paint_40_fill);

    Path path_41 = Path();
    path_41.moveTo(size.width * 0.3750000, size.height * 0.7092559);
    path_41.lineTo(size.width * 0.4375000, size.height * 0.7092559);
    path_41.lineTo(size.width * 0.4375000, size.height * 0.7405059);
    path_41.lineTo(size.width * 0.3750000, size.height * 0.7405059);
    path_41.close();

    Paint paint_41_fill = Paint()..style = PaintingStyle.fill;
    paint_41_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_41, paint_41_fill);

    Path path_42 = Path();
    path_42.moveTo(size.width * 0.4531250, size.height * 0.5625000);
    path_42.lineTo(size.width * 0.6024570, size.height * 0.4753906);
    path_42.lineTo(size.width * 0.5867109, size.height * 0.4483984);
    path_42.lineTo(size.width * 0.4373574, size.height * 0.5355254);
    path_42.close();
    path_42.moveTo(size.width * 0.4842324, size.height * 0.5199004);
    path_42.close();

    Paint paint_42_fill = Paint()..style = PaintingStyle.fill;
    paint_42_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_42, paint_42_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
