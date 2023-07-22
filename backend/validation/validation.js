const { body, validationResult } = require('express-validator');
// Validation rules
const validateInput = [
  body('name').notEmpty().withMessage('Name is required.'),
  body('email').notEmpty().withMessage('Email is required.').isEmail().withMessage('Invalid email address.'),
  body('password').notEmpty().withMessage('Password is required.').isLength({ min: 6 }).withMessage('Password should be at least 6 characters long.'),
];
// Validation middleware function
const validate = (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }
  next();
};

module.exports = {
  validateInput,
  validate,
};
