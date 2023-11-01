const express = require('express');
const authRouterTherapist = express.Router();
const User = require('../models/therapist');
const bcrypt = require('bcryptjs');
const validation = require('../validation/validation');
const jwt = require('jsonwebtoken');
const auth = require('../middleware/auth');
const multer = require('multer'); // Add this line to import multer for handling file uploads
const path = require('path');


authRouterTherapist.post('/apis/signup', validation.validateInput, validation.validate, async (req, res) => {
  try {
    const { name, email, password } = JSON.parse(req.body);
    const existingUser = await User.findOneByEmail(email);
    if (existingUser) {
      return res.status(400).json({ msg: 'User already exists!' });
    }
    const hashPassword = await bcrypt.hash(password, 8);
    await User.createUser(name, email, hashPassword);
    res.json({ success: req.body });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

authRouterTherapist.post('/apis/signin', async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOneByEmail(email);
    if (!user) {
      return res.status(400).json({ msg: 'User not found!' });
    }

    const isMatch = await bcrypt.compare(password,user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: 'Invalid password!' });
    }

    const token = jwt.sign({ id: user.user_id }, "passwordKey");
    res.json({ success: true, token, ...user });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

authRouterTherapist.delete('/apis/user/:id', auth, async (req, res) => {
  try {
    const user = await User.findOneById(req.params.id);
    if (!user) {
      return res.status(404).json({ msg: 'User not found!' });
    }

    await User.deleteOneById(req.params.id);
    res.json({ success: true, msg: 'User deleted successfully!' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

authRouterTherapist.put('/apis/user/:id', auth, async (req, res) => {
  try {
    const { full_name, email, years_of_experience, phone_number, about } = req.body;
    const user = await User.findOneById(req.params.id);
    if (!user) {
      return res.status(404).json({ msg: 'User not found!' });
    }
    const id = { id: req.params.id }.id
    const updatedUser = await User.updateUser(id, full_name, email, years_of_experience, phone_number, about);
    res.json({ success: true, msg: 'User updated successfully!', user: updatedUser });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

authRouterTherapist.put('/apis/user/:id/change-password', auth, async (req, res) => {

  try {
    const { currentPassword, newPassword } = req.body;
    const user = await User.findOneById(req.params.id);
    if (!user) {
      return res.status(404).json({ msg: 'User not found!' });
    }

    const isMatch = await bcrypt.compare(currentPassword, user.password);
    if (!isMatch) {
      console.log('Invalid current password!')
      return res.status(400).json({ msg: 'Invalid current password!' });
    }

    const hashPassword = await bcrypt.hash(newPassword, 8);
    const updatedUser = await User.updateUserPassword(req.params.id, hashPassword);

    res.json({ success: true, msg: 'Password updated successfully!', user: updatedUser });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


authRouterTherapist.post('/tokenIsValid', async (req, res) => {
  try {

    const token = req.header('x-auth-token');
    if (!token) return res.json(false);

    const verified = jwt.verify(token, "passwordKey");
    if (!verified) return res.json(false);

    const user = await User.findOneById(verified.id);
    if (!user) return res.json(false);

    res.json(true);

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

authRouterTherapist.get('/', auth, async (req, res) => {
  const user = await User.findOneById(req.user);
  res.json({ ...user, token: req.token })
})



const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, path.join(__dirname, '../public/assets/images/user-profiles'));
  },
  filename: function (req, file, cb) {
    const uniqueSuffix = req.params.id;
    cb(null, uniqueSuffix + path.extname(file.originalname));
  },
});

const upload = multer({ storage: storage });


authRouterTherapist.post('/apis/upload-profile-pic/:id', auth, upload.single('profile_picture'), async (req, res) => {
  try {
    const user = await User.findOneById(req.params.id);
    if (!user) {
      return res.status(404).json({ msg: 'User not found!' });
    }

    const profilePicPath = req.file.path;
    console.log(profilePicPath);

    // Extract the path from profilePicPath
    const parts = profilePicPath.split('images')[1];
    const url =  '/'+parts
    if (true) {
      const path = parts.slice(index).join('/');
      const id = req.params.id;
      await User.uploadUserProfilePicture(id, url);
      res.json({ success: true, msg: 'Profile picture uploaded successfully!' });
    } else {
      console.log('Path not found in the input string.');
    }
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


authRouterTherapist.get('/apis/user/profile-picture/:id', auth, async (req, res) => {
  try {
    const user = await User.findOneById(req.params.id);
    if (!user) {
      return res.status(404).json({ msg: 'User not found!' });
    }
    const profilePictureUrl = await User.fetchUserProfilePicture(req.params.id); // Change this to the actual field name in your User model

    if (!profilePictureUrl) {
      return res.status(404).json({ msg: 'Profile picture not found for this user!' });
    }

    res.json(profilePictureUrl);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

authRouterTherapist.post('/apis/forgot-password-email-verify', async (req, res) => {
  try {
    const { email } = req.body;
    const user = await User.findOneByEmail(email);
    if (!user) {
      return res.status(400).json({ msg: 'User not found!' });
    }
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

authRouterTherapist.put('/apis/reset-password', async (req, res) => {
  console.log(req.body)
  try {
    const { password, email } = req.body;
    const user = await User.findOneByEmail(email);
    if (!user) {
      return res.status(404).json({ msg: 'User not found!' });
    }
    const hashPassword = await bcrypt.hash(password, 8);
    const updatedUser = await User.updateUserPassword(user['user_id'], hashPassword);

    res.json({ success: true, msg: 'Password updated successfully!', user: updatedUser });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

authRouterTherapist.put('/apis/user/update-state/:id', async (req, res) => {
  try {
    const { state } = req.body;
    const user = await User.findOneById(req.params.id);
    if (!user) {
      return res.status(404).json({ msg: 'User not found!' });
    }
    const updateStatus = await User.updateUserStatus(req.params.id, state);
    res.json({ success: true, msg: 'State Updated' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = authRouterTherapist;