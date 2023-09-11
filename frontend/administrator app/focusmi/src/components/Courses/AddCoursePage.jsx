import React, { useState } from 'react';
import { Link } from 'react-router-dom';

const AddCoursePage = () => {
  const [courseData, setCourseData] = useState({
    title: '',
    description: '',
    levels: '',
    skillType: '',
    file: null,
  });

  const handleChange = (e) => {
    const { name, value } = e.target;
    setCourseData((prevData) => ({ ...prevData, [name]: value }));
  };

  const handleFileChange = (e) => {
    const file = e.target.files[0];
    setCourseData((prevData) => ({ ...prevData, file }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    // Perform form submission or validation here
  };

  return (
    <div className="bg-white flex items-center justify-center ">
      <div className="bg-white mt-5 p-4 rounded shadow-2xl w-[800px] md:max-w-md flex flex-col items-center mb-10">

           


        <div className="text-center mb-3">
        <h2 className="text-2xl font-bold text-[#55a06a] mb-3">Add Course</h2>
        </div>
        <div className="flex items-center justify-center ">
        <form onSubmit={handleSubmit} className="w-full" >
            
          <div className="mb-3">
            <label htmlFor="title" className="block font-semibold mb-2">
              Course Title
            </label>
            <input
              type="text"
              id="title"
              name="title"
              value={courseData.title}
              onChange={handleChange}
              className="w-full p-2 border rounded"
              required
            />
          </div>

          <div className="mb-3">
            <label htmlFor="description" className="block font-semibold mb-2">
              Description
            </label>
            <textarea
              id="description"
              name="description"
              value={courseData.description}
              onChange={handleChange}
              className="w-full p-2 border rounded"
              required
            />
          </div>

          <div className="mb-3">
            <label htmlFor="levels" className="block font-semibold mb-2">
              Number of Levels
            </label>
            <input
              type="number"
              id="levels"
              name="levels"
              value={courseData.levels}
              onChange={handleChange}
              className="w-full p-2 border rounded"
              required
            />
          </div>

          <div className="mb-3">
            <label htmlFor="skillType" className="block font-semibold mb-2">
              Skill Type
            </label>
            <input
              type="text"
              id="skillType"
              name="skillType"
              value={courseData.skillType}
              onChange={handleChange}
              className="w-full p-2 border rounded"
              required
            />
          </div>

          <div className="mb-3">
            <label htmlFor="file" className="block font-semibold mb-2">
              Upload an image
            </label>
            <input
              type="file"
              id="file"
              name="file"
              onChange={handleFileChange}
              className="w-full p-2 border rounded"
              accept=".pdf, .doc, .docx"
              required
            />
          </div>
          <Link to={"/create-courses"}>
          <button
            type="submit"
            className="w-full  text-white py-2 rounded bg-[#83DE70] hover:bg-[#55a06a] focus:outline-none focus:ring focus:border-green-700"
          >
            Add Course
          </button>
          </Link>
        </form>
      </div>
    </div>
   </div> 
  );
};

export default AddCoursePage;
