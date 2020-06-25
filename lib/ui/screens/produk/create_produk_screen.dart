import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_ta_ke_7/core/models/category_model.dart';
import 'package:project_ta_ke_7/core/models/produk_model.dart';
import 'package:project_ta_ke_7/core/utils/dialog_utils.dart';
import 'package:project_ta_ke_7/core/viewmodels/product/product_provider.dart';
import 'package:project_ta_ke_7/ui/constant/constant.dart';
import 'package:project_ta_ke_7/ui/router/router_generator.dart';
import 'package:project_ta_ke_7/ui/widget/input_widget.dart';
import 'package:project_ta_ke_7/ui/widget/primary_button.dart';
import 'package:provider/provider.dart';

class CreateProdukScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Buat Produk",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: CreateProdukBody()
      ),
    );
  }
}

class CreateProdukBody extends StatefulWidget {
  @override
  _CreateProdukBodyState createState() => _CreateProdukBodyState();
}

class _CreateProdukBodyState extends State<CreateProdukBody> {

  var titleController = TextEditingController();
  var stockController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var categoryController = TextEditingController();
  
  CategoryModel selectedCategory;

  File imageProduk;
  void pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageProduk = image;
      });
    }
  }

  void pickCategory() async {
    var result = await Navigator.pushNamed(context, RouterGenerator.routeChooseCategory);
    if (result != null) {
      setState(() {
        selectedCategory = result;
      });
      categoryController.text = selectedCategory.name;
    }
  }

  void createProduct() {
    
    //* check field conditions
    if (titleController.text.isNotEmpty && stockController.text.isNotEmpty
      && descriptionController.text.isNotEmpty && priceController.text.isNotEmpty
      && categoryController.text.isNotEmpty) {

      //* Data to send
      var product = ProdukModel(
        title: titleController.text,
        stock: int.parse(stockController.text),
        description: descriptionController.text,
        price: int.parse(priceController.text),
        categoryId: selectedCategory.id,
        image: base64Encode(imageProduk.readAsBytesSync())
      );
      Provider.of<ProductProvider>(context, listen: false).create(product, context);

    } else {
      DialogUtils.instance.showInfo(context, 
        "Semua bagian tidak boleh kosong", 
        Icons.error, "OK");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _fieldTitle(),
          SizedBox(height: 10),
          _fieldStock(),
          SizedBox(height: 10),
          _fieldDescription(),
          SizedBox(height: 10),
          _fieldPrice(),
          SizedBox(height: 10),
          _fieldCategory(),
          SizedBox(height: 10),
          _fieldImage(),
          SizedBox(height: 30),
          _buttonCreate()
        ],
      ),
    );
  }


  Widget _fieldTitle() {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Title",
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 15)
            ),
            SizedBox(height: 10),
            InputWidget(
              controller: titleController,
              action: TextInputAction.done,
              type: TextInputType.text,
              hintText: "Enter your product title",
            )
          ],
        );
      },
    );
  }

  Widget _fieldStock() {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Stok",
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 15)
            ),
            SizedBox(height: 10),
            InputWidget(
              controller: stockController,
              action: TextInputAction.done,
              type: TextInputType.number,
              hintText: "Enter your stock",
            )
          ],
        );
      },
    );
  }

  Widget _fieldDescription() {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Description",
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 15)
            ),
            SizedBox(height: 10),
            InputWidget(
              controller: descriptionController,
              action: TextInputAction.newline,
              type: TextInputType.multiline,
              hintText: "Enter your description",
            )
          ],
        );
      },
    );
  }

  Widget _fieldPrice() {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Price",
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 15)
            ),
            SizedBox(height: 10),
            InputWidget(
              controller: priceController,
              action: TextInputAction.done,
              type: TextInputType.number,
              hintText: "Enter your price",
            )
          ],
        );
      },
    );
  }

  Widget _fieldCategory() {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Category",
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 15)
            ),
            SizedBox(height: 10),
            InputWidget(
              controller: categoryController,
              action: TextInputAction.done,
              type: TextInputType.text,
              readOnly: true,
              onClick: () => pickCategory(),
              hintText: "Press to get category",
            )
          ],
        );
      },
    );
  }

  Widget _fieldImage() {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Image",
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 15)
            ),
            SizedBox(height: 10),
            Center(
              child: imageProduk == null 
                ? _imageWidget()
                : _imageFillWidget()
            )
          ],
        );
      },
    );
  }

  Widget _imageFillWidget() {
    return Builder(
      builder: (context) {
        return InkWell(
          onTap: () => pickImage(),
          borderRadius: BorderRadius.circular(60),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor.withOpacity(0.1),
              image: DecorationImage(
                image: FileImage(imageProduk),
                fit: BoxFit.cover
              )
            ),
           
          ),
        );
      },
    );
  }

  Widget _imageWidget() {
    return Builder(
      builder: (context) {
        return Container(
          height: 100,
          width: 100,
          child: Stack(
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor.withOpacity(0.1)
                ),
                child: Material(
                  type: MaterialType.transparency,
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => pickImage(),
                    borderRadius: BorderRadius.circular(60),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: SvgPicture.asset("${iconAsset}/product.svg", color: primaryColor),
                    ),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26.withOpacity(0.1),
                        offset: Offset(0, 5),
                        blurRadius: 13,
                        spreadRadius: 1
                      )
                    ]
                  ),
                  child: Material(
                    type: MaterialType.transparency,
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => pickImage(),
                      borderRadius: BorderRadius.circular(60),
                      child: Icon(Icons.add, color: Colors.green)
                    )
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buttonCreate() {
    return PrimaryButton(
      text: "Submit",
      color: primaryColor,
      onPress: () => createProduct(),
    );
  }
  
}