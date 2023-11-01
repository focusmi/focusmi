const express = require('express');
const blogRouterTherapist = express.Router();
const User = require('../models/therapist');
const auth = require('../middleware/auth');
const multer = require('multer'); // Add this line to import multer for handling file uploads
const path = require('path');

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, path.join(__dirname, '../public/assets/images/blogs-images'));
  },
  filename: function (req, file, cb) {
    const uniqueSuffix = req.params.id + '-' + Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, uniqueSuffix + path.extname(file.originalname));
  },
});

const upload = multer({ storage: storage });

blogRouterTherapist.post('/apis/user/add-blog/:id',upload.single('blog_image'), async (req, res) => {
  console.log("called")
  try {
    const { title, description, sub_title} = req.body;

    const user = await User.findOneById(req.params.id);
    if (!user) {
      return res.status(400).json({ msg: 'User not found!' });
    }
    const filePath = req.file.path;
      const parts = filePath.split('assets')[1];
    const url =  '/'+parts
    if (true) {
      await User.addBlog(req.params.id, title, sub_title, description, url);

    } else {
      console.log('Path not found in the inpfdfdut string.');
    }
   
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

blogRouterTherapist.get('/apis/user/fetch-blog/:id', auth, async (req, res) => {
  try {
    const user = await User.findOneById(req.params.id);
    if (!user) {
      return res.status(404).json({ msg: 'User not found!' });
    }
    const blogs = await User.fetchBlogs(req.params.id);
    res.json(blogs);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

blogRouterTherapist.delete('/apis/user/:id/delete-blog/:blog', auth, async (req, res) => {
  try {
    console.log(req.params)
    const user = await User.findOneById(req.params.id);
    if (!user) {
      return res.status(404).json({ msg: 'User not found!' });
    }
    await User.deleteBlog(req.params.id,req.params.blog);
    res.status(200).json({ message: 'Blog deleted successfully' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

blogRouterTherapist.put('/apis/user/:id/edit-blog/:blog',upload.single('blog_image'), async (req, res) => {
  try {
    const { title, description, sub_title} = req.body;

    const user = await User.findOneById(req.params.id);
    if (!user) {
      return res.status(400).json({ msg: 'User not found!' });
    }
    const filePath = req.file.path;
    const parts = filePath.split('\\');
    const index = parts.indexOf('assets');
    if (index !== -1) {
      const path = parts.slice(index).join('/');
      await User.updateBlog(req.params.id, title, sub_title, description, path, req.params.blog);

    } else {
      console.log('Path not found in the input string.');
    }
   
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});



module.exports = blogRouterTherapist;
