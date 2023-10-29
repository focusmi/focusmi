import axios from 'axios';
import React, { useState } from 'react';

const AddCoursePage = () => {
  const [courseData, setCourseData] = useState({
    title: '',
    description: '',
    course_type: '',
    subscription_type: '',
    file: null,
  });

  const handleChange = (e) => {
    const { name, value } = e.target;
    setCourseData((prevData) => ({ ...prevData, [name]: value, }));
  };
  const [file,setFile] = useState();
  
  // const handleFileChange = (e) => {
  //   const file = e.target.files[0];
  //   setCourseData((prevData) => ({ ...prevData, file, }));
  // };

  

  const handleSubmit = async(e) => {
    e.preventDefault();
    // console.log(file);
    console.log(courseData.levels);
    try {
      const formData=new FormData();
      formData.append('image',file)
      formData.append('title',courseData.title);
      formData.append('description',courseData.description);
      formData.append('course_type',courseData.course_type);
      formData.append('subscription_type',courseData.subscription_type);
      const response = await axios.post('http://localhost:3001/api/create-course',formData,{
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      });

      const newCourseId = response.data[0];
      console.log(newCourseId);
      window.location.href = `/courses/${newCourseId}`;

      // console.log('Form data submitted:', courseData);
      // console.log('Server response:', response.data);
      // window.location.reload();
  
    } catch (error) {
      console.error('Error:', error);
    }

  };

  return (
    <div className="text-center w-full relative">
      {/* <div className="bg-white mt-5 p-4 rounded shadow-2xl w-[800px] flex flex-col items-center mb-10"> */}
        <h2 className='text-[25px] font-extrabold text-[#55a06a] m-4 '>Course Landing Page</h2>
        <div className="flex items-center justify-center w-3/4 mx-auto ">
        <form onSubmit={handleSubmit} className="w-full" >
            
          <div className="mb-3 flex items-center">
            <label htmlFor="title" className=" font-semibold mb-2 w-1/5 flex items-center">
              Course Title
            </label>
            <input
              type="text"
              id="title"
              name="title"
              value={courseData.title}
              onChange={handleChange}
              className="w-4/5 p-2 border rounded"
              required
            />
          </div>

          <div className="mb-3 flex items-center">
            <label htmlFor="description" className="font-semibold mb-2 w-1/5 flex items-center">
              Description
            </label>
            <textarea
              id="description"
              name="description"
              value={courseData.description}
              onChange={handleChange}
              className="w-4/5 p-2 border rounded"
              required
            />
          </div>

          {/* <div className="mb-3 flex items-center">
            <label htmlFor="levels" className="font-semibold mb-2 w-1/5 flex items-center">
              Number of Levels
            </label>
            <input
              type="number"
              id="levels"
              name="levels"
              value={courseData.levels}
              onChange={handleChange}
              className="w-4/5 p-2 border rounded"
              required
            />
          </div> */}

          <div className="mb-3 flex items-center">
            <label htmlFor="courseType" className="font-semibold mb-2 w-1/5 flex items-center">
              Course Type
            </label>
            <select
              id="course_type"
              name="course_type"
              value={courseData.course_type}
              onChange={handleChange}
              className="w-4/5 p-2 border rounded"
            >
              <option value="" disabled>Choose a Course Type</option>
              <option value="meditation">Meditation</option>
              <option value="stress relief">Stress relief</option>
              <option value="sleep well">Sleep well</option>
              <option value="focus">Focus</option>
            </select>
          </div>

          <div className="mb-3 flex items-center">
            <label htmlFor="courseType" className="font-semibold mb-2 w-1/5 flex items-center">
              Subscription Type
            </label>
            <select
              id="subscription_type"
              name="subscription_type"
              value={courseData.subscription_type}
              onChange={handleChange}
              className="w-4/5 p-2 border rounded"
            >
              <option value="" disabled>Choose a Subscription Type</option>
              <option value="free">Free</option>
              <option value="paid">Paid</option>
            </select>
          </div>

          <div className="mb-3 flex items-center">
            <label htmlFor="file" className="font-semibold mb-2 w-1/5 flex items-center">
              Upload an image
            </label>
            <input
              type="file"
              id="file"
              name="image"
              onChange={e=>setFile(e.target.files[0])}
              className="w-4/5 p-2 border rounded"
              accept="image/*"
              required
            />
          </div>
          <button
            type="submit"
            className="w-full  text-white py-2 rounded bg-[#83DE70] hover:bg-[#55a06a] focus:outline-none focus:ring focus:border-green-700"
          >
            Add Course
          </button>
        </form>
      </div>
   </div> 
  );
};

export default AddCoursePage;
