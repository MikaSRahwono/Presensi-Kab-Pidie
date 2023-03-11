part of '_widgets.dart';

class HelperBigText extends StatelessWidget {
  Color color;
  final String text;
  int maxLines;
  double size;
  FontWeight fontWeight;
  TextOverflow overFlow;

  HelperBigText({Key? key, this.color = const Color(0xFF332d2b),
    required this.text,
    this.maxLines = 1,
    this.size = 12,
    this.fontWeight = FontWeight.w400,
    this.overFlow=TextOverflow.ellipsis }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overFlow,
      style: TextStyle(
          fontFamily: 'Poppins',
          color: color,
          fontSize: size,
          fontWeight: fontWeight
      ),
    );
  }
}
