import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:votingmobile/common/ui/radio_button/radio_model.dart';

class CustomRadioGroupWidget extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final List<RadioModel> radioList;

  const CustomRadioGroupWidget({Key key, this.radioList, this.onChanged})
      : super(key: key);

  @override
  _CustomRadioGroupWidgetState createState() => _CustomRadioGroupWidgetState();
}

class _CustomRadioGroupWidgetState extends State<CustomRadioGroupWidget> {
  String _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 8.0, bottom: 32.0),
      child: _buildRoundRadioGroup(),
    );
  }

  Widget _buildRoundRadioGroup() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.radioList.length,
      itemBuilder: (BuildContext context, int index) {
        return RoundRadioItem(
          widget.radioList[index],
          onTap: () {
            setState(() {
              widget.radioList.forEach((element) => element.isSelected = false);
              widget.radioList[index].isSelected = true;
              _selectedValue = widget.radioList[index].text;
              _publishSelection(_selectedValue);
            });
          },
        );
      },
    );
  }

  void _publishSelection(selectedValue) {
    if (widget.onChanged != null) {
      widget.onChanged(selectedValue);
    }
  }
}

class RoundRadioItem extends StatelessWidget {
  final RadioModel _item;
  final VoidCallback onTap;

  RoundRadioItem(this._item, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
            left: 25.0, right: 25.0, top: 8.0, bottom: 8.0),
        height: 60.0,
        width: double.infinity,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _item.assetPath != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SvgPicture.asset(
                        _item.assetPath,
                        height: 24,
                      ),
                    )
                  : Container(),
              Text(
                _item.text,
                style: new TextStyle(
                    color: _item.isSelected ? Colors.white : Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0, // has the effect of softening the shadow
              spreadRadius: 3.0, // has the effect of extending the shadow
              offset: Offset(
                5.0, // horizontal, move right 10
                5.0, // vertical, move down 10
              ),
            )
          ],
          color: _item.isSelected ? _item.selectedColor : Colors.white,
          border: Border.all(
              width: 1.0,
              color: _item.isSelected ? _item.selectedColor : Colors.white),
          borderRadius:
              const BorderRadius.all(const Radius.elliptical(100.0, 100.0)),
        ),
      ),
    );
  }
}
