import 'package:flutter/material.dart';
import 'package:votingmobile/common/ui/radio_button/radio_model.dart';

class CustomRadioGroupWidget<T> extends StatefulWidget {
  final ValueChanged<T> onChanged;
  final List<RadioModel<T>> radioList;

  const CustomRadioGroupWidget({Key key, this.radioList, this.onChanged}) : super(key: key);

  @override
  _CustomRadioGroupWidgetState<T> createState() => _CustomRadioGroupWidgetState<T>();
}

class _CustomRadioGroupWidgetState<T> extends State<CustomRadioGroupWidget<T>> {
  T _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 8.0, bottom: 32.0),
      child: _buildRoundRadioGroup(),
    );
  }

  Widget _buildRoundRadioGroup() {
    return Column(
      children: List.generate(widget.radioList.length, (index) {
        return RoundRadioItem<T>(
          widget.radioList[index],
          onTap: () {
            setState(() {
              if (widget.radioList[index].isSelected == true) {
                widget.radioList[index].isSelected = false;
                _selectedValue = null;
                _publishSelection(_selectedValue);
              } else {
                widget.radioList.forEach((element) => element.isSelected = false);
                widget.radioList[index].isSelected = true;
                _selectedValue = widget.radioList[index].value;
                _publishSelection(_selectedValue);
              }
            });
          },
        );
      }),
    );
  }

  void _publishSelection(T selectedValue) {
    widget.onChanged?.call(selectedValue);
  }
}

@visibleForTesting
class RoundRadioItem<T> extends StatelessWidget {
  final RadioModel<T> _item;
  final VoidCallback onTap;

  const RoundRadioItem(this._item, {this.onTap});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 25.0, right: 25.0, top: 8.0, bottom: 8.0),
        height: 60.0,
        width: double.infinity,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _item.assetPath != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image.asset(
                        _item.assetPath,
                        height: 24,
                        width: 24,
                      ),
                    )
                  : Container(),
              Text(
                _item.displayText,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
              spreadRadius: 3.0,
              offset: Offset(5.0, 5.0),
            )
          ],
          color: _item.isSelected ? _item.selectedColor : backgroundColor,
          border: Border.all(
            width: 1.0,
            color: _item.isSelected ? _item.selectedColor : backgroundColor,
          ),
          borderRadius: const BorderRadius.all(const Radius.elliptical(100.0, 100.0)),
        ),
      ),
    );
  }
}
