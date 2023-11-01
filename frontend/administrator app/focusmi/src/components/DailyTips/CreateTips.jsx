import React, { useState } from 'react';
import axios from 'axios';

const DailyTipsAdmin = () => {
  const [newTip, setNewTip] = useState({
    text:'',
    day : '',
    image: null,
  });
  const daysOfWeek = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setNewTip((prevTip) => ({ ...prevTip, [name]: value }));
  };

  const handleImageChange = (e) => {
    const image = e.target.files[0];
    setNewTip((prevTip) => ({ ...prevTip, image }));
  };

 

  // const handleSave=()=>{
  //   console.log('New tip:', newTip);
  //   axios.post('http://localhost:3001/api/create-daily-tips',newTip)
  //   .then(res=>console.log(res.data))
  //   .catch(err=>console.log(err))
  //   setNewTip(null);
  //   window.location.reload();
  // }
  const handleSubmit = async(e) => {
    e.preventDefault();
    // console.log(file);
    // console.log();
    try {
      const formData=new FormData();
      formData.append('image',newTip.image)
      formData.append('text',newTip.text);
      formData.append('day',newTip.day);
      const response = await axios.post('http://localhost:3001/api/create-daily-tips',formData,{
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      });

      const newCourseId = response.data[0];
      window.location.reload();

      // console.log('Form data submitted:', courseData);
      // console.log('Server response:', response.data);
      // window.location.reload();
  
    } catch (error) {
      console.error('Error:', error);
    }

  };


  return (
    <div  className="text-center w-full relative"> 
      <form onSubmit={handleSubmit} className="w-full" >
            <div className="mb-3 flex items-center">
              <label htmlFor="description" className="font-semibold mb-2 w-1/4 flex items-center">
                Description
              </label>
              <textarea
                id="description"
                name="text"
                value={newTip.text}
                onChange={handleInputChange}
                className="w-3/4 p-2 border rounded"
                required
              />
            </div>  
            <div className="mb-3 flex items-center">
              <label htmlFor="courseType" className="font-semibold mb-2 w-1/4 flex items-center">
                Day
              </label>
              <select
                name="day"
                value={newTip.day}
                onChange={handleInputChange}
                className="w-3/4 p-2 border rounded"
              >
                <option value="">Select a day</option>
                {daysOfWeek.map((day, index) => (
                  <option key={index} value={day}>{day}</option>
                ))}
              </select>

              {/* <select
                id="course_type"
                name="course_type"
                value=''
                onChange={handleInputChange}
                className="w-4/5 p-2 border rounded"
              >
                <option value="" disabled>Choose a Course Type</option>
                <option value="meditation">Meditation</option>
                <option value="stress relief">Stress relief</option>
                <option value="sleep well">Sleep well</option>
                <option value="focus">Focus</option>
              </select> */}
            </div>

            <div className="mb-3 flex items-center">
              <label htmlFor="file" className="font-semibold mb-2 w-1/4 flex items-center">
                Tip Image
              </label>
              <input
                type="file"
                id="file"
                name="image"
                onChange={handleImageChange}
                className="w-3/4 p-2 border rounded"
                accept="image/*"
                required
              />
            </div>
            <button
              type="submit"
              className="w-full  text-white py-2 rounded bg-[#83DE70] hover:bg-[#55a06a] focus:outline-none focus:ring focus:border-green-700"
            >
              Add Tip
            </button>
          </form>
    </div>
  );
};

export default DailyTipsAdmin;


    // <div className="flex justify-center items-center h-screen">
    //   <div className="bg-white p-6 rounded-lg shadow-2xl w-[800px]">
    //     <h2 className="text-2xl font-bold text-[#55a06a] mb-4 ">Create Daily Tips</h2>
    //     <div className="mb-4">
    //       <label className="block text-gray-700 font-semibold mb-2">
    //         Tip Title:
    //       </label>
    //       <input
    //         type="text"
    //         name="title"
    //         value={newTip.title}
    //         onChange={handleInputChange}
    //         className="w-full p-2 border rounded"
    //       />
    //     </div>
    //     <div className="mb-4">
    //       <label className="block text-gray-700 font-semibold mb-2">
    //         Add Description:
    //       </label>
    //       <textarea
    //         name="description"
    //         value={newTip.description}
    //         onChange={handleInputChange}
    //         placeholder="Add description..."
    //         className="w-full p-2 border rounded"
    //       />
    //     </div>
    //     <div className="mb-4">
    //       <label className="block text-gray-700 font-semibold mb-2">
    //         Day of the Week:
    //       </label>
    //       <select
    //         name="day"
    //         value={newTip.day}
    //         onChange={handleInputChange}
    //         className="w-full p-2 border rounded"
    //       >
    //         <option value="">Select a day</option>
    //         {daysOfWeek.map((day, index) => (
    //           <option key={index} value={day}>{day}</option>
    //         ))}
    //       </select>
    //     </div>
    //     <div className="mb-4">
    //       <label className="block text-gray-700 font-semibold mb-2">
    //         Image:
    //       </label>
    //       <input
    //         type="file"
    //         accept="image/*"
    //         onChange={handleImageChange}
    //         className="w-full p-2 border rounded"
    //       />
    //     </div>
    //     <div className="flex justify-between">
    //       <button
    //         onClick={handleSaveDraft}
    //         className=" text-white px-4 py-2 rounded bg-[#83DE70] hover:bg-[#55a06a] focus:outline-none focus:ring focus:border-green-700"
    //       >
    //         Save as Draft
    //       </button>
    //       <button
    //         onClick={handlePostTip}
    //         className=" text-white px-4 py-2 rounded bg-[#83DE70] hover:bg-[#55a06a] focus:outline-none focus:ring focus:border-green-700"
    //       >
    //         Post Tip
    //       </button>
    //     </div>
    //     {/* <div className="mt-8">
    //       <h3 className="text-lg font-semibold mb-2">Drafts</h3>
    //       <ul>
    //         {drafts.map((tip, index) => (
    //           <li key={index} className="mb-2">{tip.title}</li>
    //         ))}
    //       </ul>
    //     </div>
    //     <div className="mt-8">
    //       <h3 className="text-lg font-semibold mb-2">Posted Tips</h3>
    //       <ul>
    //         {postedTips.map((tip, index) => (
    //           <li key={index} className="mb-2">{tip.title}</li>
    //         ))}
    //       </ul>
    //     </div> */}
    //   </div>
    // </div>