const multer = require('multer');// Create multer object
const path = require('path')

const storage = multer.diskStorage({
    destination:(req, file, cb) => {
        cb(null,'public/assets/images/mindfulness-courses/' )
    },
    filename: (req, file, cb) =>{
        console.log(file)
        var filen = Date.now()+path.extname(file.originalname)
        cb(null,filen)
        req.filname =  filen
    }
})


const imageUpload = multer({
    storage:storage
});

module.exports = imageUpload