import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:therapist_app/constants/global_variables.dart';
import 'package:therapist_app/features/blog/screen/create_blog_screen.dart';
import 'package:therapist_app/features/blog/screen/edit_blog_screen.dart';
import 'package:therapist_app/features/blog/service/blogService.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BlogScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  BlogService crudMethods = new BlogService();
  ScrollController _scrollController = ScrollController();
  bool _showFlexibleSpaceTitle = false;
  bool isToolbarVisible = false; // Track toolbar visibility
  int selectedBlogId = -1; // Store the selected blog ID

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
                      subTitle: blogsData[index]['subtitle'] ?? 'null',
                      title: blogsData[index]['title'],
                      description: blogsData[index]['description'],
                      blogId: blogsData[index]['blog_id'],
                      imgUrl: '${uri}/${blogsData[index]['image']}',
                      onLongPress: () {
                        // Toggle the toolbar visibility on blog tile tap
                        toggleToolbarVisibility();
                        // Set the selected blog ID when a blog tile is long-pressed
                        setSelectedBlogId(blogsData[index]['blog_id']);
                      },
                      onTap: () {
                        hideToolbar();
                      },
                    );
                  },
                ),
              ],
            ),
          )
        // : Container(
        //     alignment: Alignment.center,
        //     child: CircularProgressIndicator(),
        //   );
        : Center(
            child: Container(
            height: 200,
            margin: const EdgeInsets.only(top: 200),
            child: Lottie.asset('assets/images/Comp.json', fit: BoxFit.cover),
          ));
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
      isToolbarVisible = true;
    });
  }

  void hideToolbar() {
    setState(() {
      isToolbarVisible = false;
    });
  }

  // Function to set the selected blog ID
  void setSelectedBlogId(int blogId) {
    setState(() {
      selectedBlogId = blogId;
    });
  }

  Future<void> fetchBlogs() async {
    try {
      List data = await BlogService.getData(context);
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
            expandedHeight: isToolbarVisible ? 0 : 90,
            backgroundColor: _showFlexibleSpaceTitle || isToolbarVisible
                ? GlobalVariables.primaryText
                : Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'Blogs',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _showFlexibleSpaceTitle || isToolbarVisible
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
            actions: [
              if (isToolbarVisible)
                Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditBlog(blogID: selectedBlogId),
                            ),
                          );
                          if (result == true) {
                            fetchBlogs();
                          }
                        },
                        icon: Icon(Icons.edit, color: Colors.white, size: 30.0),
                      ),
                      IconButton(
                        onPressed: () async {
                          if (await BlogService.deleteBlog(
                              context: context, blog_id: selectedBlogId)) {
                            fetchBlogs();
                            hideToolbar();
                          }
                          ;
                        },
                        icon:
                            Icon(Icons.delete, color: Colors.white, size: 30.0),
                      ),
                    ],
                  ),
                ),
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
  final String imgUrl, title, description, subTitle;
  final int blogId;
  final VoidCallback? onLongPress;
  final VoidCallback? onTap;

  BlogsTile({
    required this.imgUrl,
    required this.title,
    required this.description,
    required this.subTitle,
    required this.blogId,
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
    return GestureDetector(
      onLongPress: () {
        setState(() {
          isLongPressed = true;
        });
        if (widget.onLongPress != null) {
          widget.onLongPress!();
        }
      },
      onTap: () async {
        setState(() {
          isOnTap = false;
          isLongPressed = false;
        });
        if (widget.onTap != null) {
          widget.onTap!();
        }

        var push = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SliverAppBarExample(BlogId: widget.blogId),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        height: 170,
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
                color: isLongPressed && !isOnTap
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
                    widget.subTitle != 'null'
                        ? Text(
                            widget.subTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : SizedBox(
                            height: 0,
                          ),
                    SizedBox(
                      height: 4,
                    ),
                    Text("″${widget.description}″",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow
                            .ellipsis, // Handle overflow by showing "..."
                        maxLines: 2),
                    SizedBox(
                      height: 4,
                    ),
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

class SliverAppBarExample extends StatefulWidget {
  late final int BlogId;
  SliverAppBarExample({required this.BlogId});

  @override
  _SliverAppBarExampleState createState() => _SliverAppBarExampleState();
}

class _SliverAppBarExampleState extends State<SliverAppBarExample> {
  bool _pinned = false;
  bool _snap = false;
  bool _floating = false;
  String imgUrl = 'assets/images/blogs-images/default.png', title = '', description = '', subTitle = '';

  Future<void> fetchBlogs() async {
    try {
      List data = await BlogService.getData(context);
      Map blogWithId = data.firstWhere(
          (blog) => blog['blog_id'] == widget.BlogId,
          orElse: () => null);

      if (blogWithId != null) {
        setState(() {
          title = blogWithId['title'] ?? '';
          description = blogWithId['description'] ?? '';
          subTitle = blogWithId['subtitle'] ?? '';
          imgUrl = blogWithId['image'] ?? '';
        });
      } else {
        print('Blog not found.');
      }
    } catch (e) {
      print('Error fetching blog data: $e');
    }
  }

  @override
  void initState() {
    fetchBlogs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 240.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                '${title}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              background: CachedNetworkImage(
                imageUrl: uri + '/' + imgUrl,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Center(
                  child: Text(
                    '${subTitle}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          '${description}',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 5),
                        Text('˗ˏˋ ★★★ ˎˊ˗'),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
