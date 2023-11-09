import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:therapist_app/common/widgets/custom_button.dart';
import 'package:therapist_app/constants/global_variables.dart';
import 'package:therapist_app/features/blog/service/blogService.dart';

class CreateBlog extends StatefulWidget {
  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  late String subTitle, title, desc;
  File? selectedImage;

  bool _isLoading = false;
  BlogService crudMethods = new BlogService();

  Future getImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        selectedImage = File(pickedImage.path);
      }
    });
  }

  uploadBlog() async {
    if (selectedImage != null) {
      setState(() {
        _isLoading = true;
      });

      Map<String, String> blogMap = {
        "title": title,
        "sub_title": subTitle,
        "desc": desc
      };
      crudMethods
          .addBlogDataAndImage(blogMap, context, selectedImage!)
          .then((result) {
        Navigator.pop(context, true);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Create Blogs",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: GlobalVariables.primaryText,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              uploadBlog();
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16), child: Text("")),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: _isLoading
            ? Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              )
            : Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          getImage();
                        },
                        child: selectedImage != null
                            ? Container(
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                height: 170,
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.file(
                                    selectedImage!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                height: 270,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6)),
                                width: MediaQuery.of(context).size.width,
                                child: Lottie.asset('assets/images/blog.json',
                                    fit: BoxFit.contain),
                              )),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            decoration: InputDecoration(hintText: "Title"),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            onChanged: (val) {
                              title = val;
                            },
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          TextField(
                            decoration: InputDecoration(hintText: "Sub Title"),
                            onChanged: (val) {
                              subTitle = val;
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextField(
                            decoration:
                                InputDecoration(hintText: "Description"),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            onChanged: (val) {
                              desc = val;
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 67,
                    ),
                    CustomButton(
                      text: 'Add Blog',
                      onTap: () {
                        uploadBlog();
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
