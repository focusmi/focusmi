import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:therapist_app/common/widgets/custom_button.dart';
import 'package:therapist_app/constants/global_variables.dart';
import 'package:therapist_app/features/blog/service/blogService.dart';

class EditBlog extends StatefulWidget {
  final int blogID;
  @override
  _EditBlogState createState() => _EditBlogState();
  EditBlog({required this.blogID});
}

class _EditBlogState extends State<EditBlog> {
  late String authorName, title, desc;
  File? selectedImage;
  bool _isLoading = false;
  BlogService crudMethods = new BlogService();
  TextEditingController titleController = TextEditingController(text: '');
  TextEditingController desController = TextEditingController(text: '');

  Future getImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedImage != null) {
        selectedImage = File(pickedImage.path);
      }
    });
  }

  updateBlog() async {
    print(title);
  }
  @override
  void initState() {
    super.initState();
    fetchBlogById(widget.blogID);
  }

  fetchBlogById(int blogId) async {
    try {
      List data = await BlogService.getData(context);
      Map<String, dynamic>? desiredBlog = data
          .firstWhere((blog) => blog['blog_id'] == blogId, orElse: () => null);

      if (desiredBlog != null) {
        setState(() {
          titleController.text = desiredBlog['title'];
          desController.text = desiredBlog['description'];
        });
        
      } else {
        print('Blog not found.');
      }
    } catch (e) {
      print('Error fetching blog data: $e');
    }
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
              "Edit Blog",
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
              updateBlog();
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("")),
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
                      height: 8,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            decoration:
                                InputDecoration(hintText: "Author Name"),
                            onChanged: (val) {
                              authorName = val;
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextField(
                            controller: titleController,
                            decoration: InputDecoration(hintText: "Title"),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            onChanged: (val) {
                              title = val;
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextField(
                            controller: desController,
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
                      text: 'Edit Blog',
                      onTap: () {
                        updateBlog();
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
