import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_ta_ke_7/core/models/category_model.dart';
import 'package:project_ta_ke_7/core/utils/dialog_utils.dart';
import 'package:project_ta_ke_7/core/viewmodels/category/category_provider.dart';
import 'package:project_ta_ke_7/ui/constant/constant.dart';
import 'package:project_ta_ke_7/ui/router/router_generator.dart';
import 'package:project_ta_ke_7/ui/widget/input_widget.dart';
import 'package:project_ta_ke_7/ui/widget/primary_button.dart';
import 'package:provider/provider.dart';

class CreateCategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Buat Kategori",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: CreateCategoryBody(),
    );
  }
}


class CreateCategoryBody extends StatefulWidget {

  @override
  _CreateCategoryBodyState createState() => _CreateCategoryBodyState();
}

class _CreateCategoryBodyState extends State<CreateCategoryBody> {
  int icon;
  var nameController = TextEditingController();

  //* Pick custom icon
  void pickCategory() async {
    IconData _icon = await FlutterIconPicker.showIconPicker(
      context, 
      iconPackMode: IconPack.material,
      title: Text("Pilih Icon Kategori"),
      searchHintText: "Cari",
      closeChild: Text("Batalkan"));

    if (_icon != null) {
      setState(() {
        icon = _icon.codePoint;
      });
    }
  }

  //* FUnction create category
  void createCategory() async {
    if (icon != null) {
      if (nameController.text.isNotEmpty) {

        //* Data to send
        var category = CategoryModel(
          icon: icon,
          name: nameController.text
        );
        final categoryProv = Provider.of<CategoryProvider>(context, listen: false);
        categoryProv.create(category, context);
        
      } else {
        DialogUtils.instance.showInfo(context, "Masukkan nama kategori", Icons.error, "OK");
      }
    } else {
      DialogUtils.instance.showInfo(context, "Silahkan pilih icon kategori", Icons.error, "OK");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          _fieldIconName(),
          SizedBox(height: 20),
          _buttonCreate()
        ],
      ),
    );
  }

  Widget _fieldIconName() {
    return Row(
      children: <Widget>[
        _fieldIcon(),
        SizedBox(width: 10),
        Expanded(child: _fieldName())
      ],
    );
  }

  Widget _fieldIcon() {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        shape: BoxShape.circle
      ),
      child: Material(
        type: MaterialType.transparency,
        color: Colors.transparent,
        child: InkWell(
          onTap: () => pickCategory(),
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: icon == null
              ? SvgPicture.asset("${iconAsset}/category.svg", width: 24, height: 24, color: Colors.white)
              : Icon(IconData(icon, fontFamily: "MaterialIcons"), color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _fieldName() {
    return InputWidget(
      controller: nameController,
      type: TextInputType.text,
      action: TextInputAction.done,
      hintText: "Nama kategori",
    );
  }

  Widget _buttonCreate() {
    return PrimaryButton(
      text: "Submit",
      color: primaryColor,
      onPress: () => createCategory(),
    );
  }
}