import 'package:flutter/material.dart';

class InputFieldWidget extends StatefulWidget {
  final String hint;
  final IconData prefixIcon;
  final String prefixImage;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscure;
  final bool enable;
  final bool textAlignCenter;
  final int maxlines;
  final focusNode;
  final Function onChange;
  final showDropDown;

  InputFieldWidget(
      {this.focusNode,
      this.hint,
      this.prefixIcon,
      this.prefixImage,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.obscure = false,
      this.enable = true,
      this.textAlignCenter = false,
      this.maxlines,
      this.onChange,
      this.showDropDown = false});

  @override
  _InputFieldWidgetState createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  bool obscure;

  @override
  void initState() {
    super.initState();
    obscure = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode ?? null,
      style: TextStyle(fontSize: 14),
      maxLines: widget.maxlines == null ? 1 : widget.maxlines,
      onChanged: widget.onChange,
      enabled: widget.enable,
      controller: widget.controller,
      textAlign:
          widget.textAlignCenter == true ? TextAlign.center : TextAlign.start,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscure ? obscure : widget.obscure,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        filled: false,
        fillColor: Colors.white,
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffB1B1B1))),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffB1B1B1))),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffB1B1B1))),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff707070))),
        disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffB1B1B1))),
        prefixIconConstraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.width * 0.5,
          maxWidth: MediaQuery.of(context).size.width * 0.5,
        ),
        prefixIcon: widget.prefixIcon != null
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  widget.prefixIcon,
                  color: IconTheme.of(context).color,
                ),
              )
            : widget.prefixImage != null
                ? Container(
                    width: 20,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Image.asset(widget.prefixImage))
                : null,
        suffixIcon: !widget.obscure
            ? widget.showDropDown
                ? Icon(
                    Icons.arrow_drop_down,
                    size: 23,
                  )
                : null
            : GestureDetector(
                onTap: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
                child: Icon(
                  obscure ? Icons.visibility : Icons.visibility_off,
                  size: 23,
                ),
              ),
      ),
    );
  }
}
