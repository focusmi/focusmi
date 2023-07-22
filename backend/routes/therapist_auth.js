const express = require('express');
const authRouterTherapist = express.Router();
const User = require('../models/therapist');
const bcrypt = require('bcryptjs');
const validation = require('../validation/validation');
const jwt = require('jsonwebtoken');
const auth = require('../middleware/auth');


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

    const token =  jwt.sign({id:user.admin_user_ID}, "passwordKey");
    res.json({ success: true,token, ...user});
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

authRouterTherapist.put('/apis/user/:id',validation.validateInput, validation.validate, auth, async (req, res) => {
  try {
    const {user_name ,email} = JSON.parse(req.body);
    const user = await User.findOneById(req.params.id);
    if (!user) {
      return res.status(404).json({ msg: 'User not found!' });
    }
    const id = {id: req.params.id }.id
    const updatedUser = await User.updateUser(id, user_name, email);
    res.json({ success: true, msg: 'User updated successfully!', user: updatedUser });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

authRouterTherapist.put('/apis/user/:id/change-password',auth, async (req, res) => {
  
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
    if(!token) return res.json(false);

    const verified =  jwt.verify(token, "passwordKey");
    if(!verified) return res.json(false);

    const user = await User.findOneById(verified.id);
    if(!user) return res.json(false);

    res.json(true);

  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

authRouterTherapist.get('/', auth, async(req,res)=>{
  const user = await User.findOneById(req.user);
  res.json({...user, token: req.token})
})

module.exports = authRouterTherapist;
