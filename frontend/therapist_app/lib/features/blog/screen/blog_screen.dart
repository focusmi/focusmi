import 'package:flutter/material.dart';
import 'package:therapist_app/constants/global_variables.dart';
import 'package:therapist_app/features/blog/screen/create_blog_screen.dart';
import 'package:therapist_app/features/blog/service/blogService.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BlogScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  CrudMethods crudMethods = new CrudMethods();
  ScrollController _scrollController = ScrollController();
  bool _showFlexibleSpaceTitle = false;
  bool isToolbarVisible = false; // Track toolbar visibility

  List blogsData = [];

  Widget BlogsList(List blogsData) {
    return blogsData != null && blogsData.isNotEmpty
        ? SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: blogsData.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return BlogsTile(
                        authorName: blogsData[index]['authorName'] ?? 'Unknown',
                        title: blogsData[index]['title'],
                        description: blogsData[index]['description'],
                        imgUrl: '${uri}/${blogsData[index]['image']}',
                        onLongPress: () {
                          // Toggle the toolbar visibility on blog tile tap
                          toggleToolbarVisibility();
                        },
                        onTap: () {
                          hideToolbar();
                        });
                    // NetworkImage(uri + '/' + _profilePictureUrl!)
                  },
                ),
              ],
            ),
          )
        : Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateFlexibleSpaceTitleVisibility);
    fetchBlogs();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateFlexibleSpaceTitleVisibility);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateFlexibleSpaceTitleVisibility() {
    setState(() {
      _showFlexibleSpaceTitle = _scrollController.hasClients &&
          _scrollController.offset >= (kToolbarHeight - kToolbarHeight / 4);
    });
  }

  // Function to show/hide the top toolbar
  void toggleToolbarVisibility() {
    setState(() {
      isToolbarVisible = !isToolbarVisible;
    });
  }

  void hideToolbar() {
    setState(() {
      isToolbarVisible = false;
    });
  }
  

  Future<void> fetchBlogs() async {
    try {
      List data = await CrudMethods.getData(context);
      setState(() {
        blogsData = data;
      });
    } catch (e) {
      print('Error fetching blog data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 0,
            expandedHeight: 90,
            backgroundColor: _showFlexibleSpaceTitle
                ? GlobalVariables.primaryText
                : Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Blogs",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _showFlexibleSpaceTitle ? Colors.white : Colors.black,
                ),
              ),
            ),
            actions: [
              if (isToolbarVisible) TopToolbar(),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 15),
            sliver: SliverToBoxAdapter(
              child: Container(child: BlogsList(blogsData)),
            ),
          )
        ],
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateBlog(),
                  ),
                );
                if (result == true) {
                  fetchBlogs();
                }
              },
              child: Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}

class BlogsTile extends StatefulWidget {
  final String imgUrl, title, description, authorName;
  final VoidCallback? onLongPress;
  final VoidCallback? onTap;

  BlogsTile({
    required this.imgUrl,
    required this.title,
    required this.description,
    required this.authorName,
    this.onLongPress,
    this.onTap,
  });

  @override
  _BlogsTileState createState() => _BlogsTileState();
}

class _BlogsTileState extends State<BlogsTile> {
  bool isLongPressed = false;
  bool isOnTap = false;

  @override
  Widget build(BuildContext context) {
    print(isLongPressed);
    return GestureDetector(
      onLongPress: () {
        setState(() {
          isLongPressed = true;
        });
        if (widget.onLongPress != null) {
          widget.onLongPress!();
        }
      },
      onTap: () {
        setState(() {
          isOnTap = false;
          isLongPressed = false;
        });
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        height: 150,
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: widget.imgUrl,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 170,
              decoration: BoxDecoration(
                color: isLongPressed
                    ? Color.fromARGB(255, 77, 228, 87).withOpacity(0.3)
                    : Colors.black45.withOpacity(0.3),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "″${widget.description}″",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      widget.authorName,
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopToolbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              // Handle edit button tap
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              // Handle delete button tap
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
