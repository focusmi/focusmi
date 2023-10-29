import axios from 'axios';
import React, { useState } from 'react';



const EditLevelPopup = ({ levelData, courseID, onSave }) => {
  const [errors, setErrors] = useState({});
  const [courseLevelData, setCourseLevelData] = useState({...levelData });
  const validateForm = () => {
    const newErrors = {};

    if (!courseLevelData.description.trim()) {
      newErrors.description = 'Description is required';
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  


 const handleInputChange = (e) => {
  const { name, value } = e.target;
  setCourseLevelData((prevData) => ({
    ...prevData,
    [name]: value,
  }));
};

  const handleAudioUpload = (e) => {
    const audioFile = e.target.files[0];
    setCourseLevelData({
      ...courseLevelData,
      audio: audioFile,
    });
  };

//   const handleSubmit = async (e) => {
//     e.preventDefault();
//     try {
//       const formData = new FormData();
//       // formData.append('course_id', courseLevelData.course_id);
//       formData.append('course_id', courseID);
//       formData.append('level_name', courseLevelData.level_name);
//       formData.append('level_description', courseLevelData.level_description);
//       formData.append('reference', courseLevelData.reference);
//       formData.append('media_type', courseLevelData.media_type);
//       formData.append('audio', courseLevelData.audio);

//       const response = await axios.post('http://localhost:3001/api/create-course-level', formData, {
//         headers: {
//           'Content-Type': 'multipart/form-data',
//         },
//       });

//       console.log('Course level created:', response.data);
//       // You can handle the response or navigation after creating the course level
//       window.location.reload();
//     } catch (error) {
//       console.error('Error creating course level:', error);
//     }
//   };
const handleSave = () => {
    onSave(courseLevelData);
  };

  return (
    <div className='flex flex-col items-center' >
      <div className="bg-white shadow-2xl p-4 rounded-md mt-9 w-[800px] h-[400px] pt-10 ml-8 relative ">
        <form onSubmit={handleSave} className="w-full" >
        <div className="flex justify-center gap-10 py-2">
          <label className="flex items-center text-black w-[300px]" style={{ display: 'none' }}>Course ID </label>
          <input
            type="text"
            name="course_id"
            value={courseID}
            onChange={handleInputChange}
            className="w-[500px] p-2 border rounded"
            style={{ display: 'none' }}
            readOnly
            disabled // Disable the input to prevent user modification
          />
        </div>
        <div className="flex justify-center gap-10 py-2">
              <label htmlFor="title" className="flex items-center text-black w-[300px]">
                Title
              </label>
              <input
                type="text"
                name="level_name"
                value={courseLevelData.level_name}
                onChange={handleInputChange}
                className="w-[500px] p-2 border rounded"
                required
              />
        </div>

        <div className='flex justify-center gap-10 py-2'>
              <label className="flex items-center text-black w-[300px] ">
                  Add Description
                  </label>
              <textarea
                name="level_description"
                value={courseLevelData.level_description}
                onChange={handleInputChange}
                className={`border p-2 rounded w-[500px] ${
                  errors.description ? 'border-red-500' : ''
                }`}
              />
              {errors.description && (
                <p className="text-red-500 text-sm mt-1">{errors.description}</p>
              )}

        </div>
        <div className='flex justify-center gap-10 py-2'>
              <label className="flex items-center text-black w-[300px] ">
                  Reference
                  </label>
              <input
                type="text"
                name="reference"
                value={courseLevelData.reference}
                onChange={handleInputChange}
                className="w-[500px] p-2 border rounded"
                required
              />
             

        </div>
        <div className='flex justify-center gap-10 py-2'>
          <label className="flex items-center text-black w-[300px]">
            Select an Audio
            </label>
            <input
              type="file"
              id="file"
              name='audio'
              accept="audio/*"
              multiple
              onChange={handleAudioUpload}
              className="w-[500px] p-2 border rounded mt-3"
            />
        </div>
        <div className='flex flex-row justify-center gap-10 py-2'>
          <div className="m-2">
          <button
            type='submit'
            className="my-2 text-white px-4 py-2 rounded mr-2 bg-[#83DE70] hover:bg-[#55a06a]"
          >
            Update Level   
          </button>
          
          </div>

          
          </div>
      </form>
      </div>
    </div>


);
};

export default EditLevelPopup;
