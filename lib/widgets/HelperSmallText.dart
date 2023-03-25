part of '_widgets.dart';

class HelperSmallText extends StatelessWidget {
  Color color;
  final String text;
  int maxLines;
  double size;
  TextOverflow overFlow;
  double height;

  HelperSmallText(
      {Key? key,
      this.color = const Color(0xFFccc7c5),
      required this.text,
      this.maxLines = 1,
      this.size = 12,
      this.overFlow = TextOverflow.ellipsis,
      this.height = 1.2})
      : super(key: key);

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
        height: height,
      ),
    );
  }
}
