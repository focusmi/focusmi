const multer = require('multer');// Create multer object
const imageUpload = multer({
    dest: '../public/assets/images/mindfulness-courses',
});

module.exports = imageUpload