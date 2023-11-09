
import React, { useState } from 'react';

import { FaArrowLeft,FaArrowRight } from 'react-icons/fa'; // Import the back icon


const LevelContentEditor = ({ levelNumber, onSave }) => {
  const [currentLevel, setCurrentLevel] = useState(levelNumber);
  const [content, setContent] = useState({
    description: '',
    images: [],
    audios: [],
    videos: [],
  });

  const [errors, setErrors] = useState({});
  const [isDraft, setIsDraft] = useState(false);

  const handleTitleChange = (e) => {
    setContent((prevContent) => ({
      ...prevContent,
      title: e.target.value,
    }));
  };

  const handleDescriptionChange = (e) => {
    setContent((prevContent) => ({
      ...prevContent,
      description: e.target.value,
    }));
  };

  const handleImageUpload = (e) => {
    const files = Array.from(e.target.files);
    setContent((prevContent) => ({
      ...prevContent,
      images: prevContent.images.concat(files),
    }));
  };

  const handleAudioUpload = (e) => {
    const files = Array.from(e.target.files);
    setContent((prevContent) => ({
      ...prevContent,
      audios: prevContent.audios.concat(files),
    }));
  };

  const handleVideoUpload = (e) => {
    const files = Array.from(e.target.files);
    setContent((prevContent) => ({
      ...prevContent,
      videos: prevContent.videos.concat(files),
    }));
  };

  const handleFinish = () => {
    if (validateForm()) {
      saveContent();
    }
  };

  const handleSaveDraft = () => {
    if (validateForm()) {
      setIsDraft(true);
      saveContent();
    }
  };

  // const handleDiscard = () => {
  //   // Discard changes
  //   clearForm();
  // };


  const handleLaunch = async () => {
    if (validateForm()) {
      // Save the current level content
       saveContent();
  
      // Optional: Perform additional actions for launching the course
      // For example, you can update the course status to "Launched" in your database
  
      console.log('Course launched');
    }
  };


  const handleBack = () => {
    if (currentLevel === 1 && isDraft) {
      const confirmQuit = window.confirm(
        'You have unsaved changes. Are you sure you want to quit?'
      );
      if (!confirmQuit) {
        return;
      }
    }

   

    // Example: Decrement the current level if not at the first level
    if (currentLevel > 1) {
      setCurrentLevel(currentLevel - 1);
    } else {
    //   // Navigate to a different page or perform other actions
     }
  };

 


  const validateForm = () => {
    const newErrors = {};

    if (!content.description.trim()) {
      newErrors.description = 'Description is required';
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const saveContent = () => {
    // Simulate API call or save to state/database
    const savedContent = {
      ...content,
      isDraft,
    };

    // Call onSave to handle saving the content
    onSave(savedContent);

    // Clear the form after saving
    clearForm();
  };

  const clearForm = () => {
    setContent({
      description: '',
      images: [],
      audios: [],
      videos: [],
    });
    setIsDraft(false);
    setErrors({});
  };

  return (
    <div className='flex flex-col items-center'>
      <div className="bg-white shadow-2xl p-4 rounded-md mt-9 w-[1000px] h-[500px] pt-10 ml-8 relative ">
  
  
      <h2 className="text-[30px] font-bold text-[#55a06a] mb-4 flex justify-center"> Level 1 {levelNumber}</h2>
      
      <div className="flex justify-center gap-10">
            <label htmlFor="title" className="block mt-5 text-black w-[300px]">
              Content Title
            </label>
            <input
              type="text"
              id="title"
              name="title"
              
              onChange={handleTitleChange}
              className="w-[500px] p-2 border rounded mt-3 mb-5"
              required
            />
          </div>

      <div className='flex justify-center gap-10'>
      <label className="block mt-5 text-black w-[300px]">
          Add Your Description
          </label>
      <textarea
        value={content.description}
        onChange={handleDescriptionChange}
        placeholder="Add description..."
        className={`border p-2 rounded w-[500px] ${
          errors.description ? 'border-red-500' : ''
        }`}
      />
      {errors.description && (
        <p className="text-red-500 text-sm mt-1">{errors.description}</p>
      )}

      </div>


      <div className='flex justify-center  gap-10'>
      <label className="block mt-5 text-black w-[300px]">
          Select an Image
          </label>
          <input
            type="file"
            accept="image/*"
            multiple
            onChange={handleImageUpload}
            className="w-[500px] p-2 border rounded mt-3"
          />
       </div>

       <div className='flex justify-center gap-10'>
        <label className="block mt-5 text-black w-[300px]">
          Select an Audio
          </label>
          <input
            type="file"
            accept="audio/*"
            multiple
            onChange={handleAudioUpload}
            className="w-[500px] p-2 border rounded mt-3"
          />
          </div>
        
          <div className='flex justify-center gap-10'>
        <label className="block mt-5 text-black w-[300px]">
          Select a Video
          </label>
          <input
            type="file"
            accept="video/*"
            multiple
            onChange={handleVideoUpload}
            className="w-[500px] p-2 border rounded mt-3"
          />
          </div>
        
       <div className='flex flex-row justify-center'>

       <button
          onClick={handleBack}
          className="absolute top-0 left-0 mt-3 ml-3 flex items-center text-[#55a06a] hover:underline focus:outline-none"
        >
           <FaArrowLeft className="mr-1" /> Back
        </button>


      <div className="flex flex-row justify-center">
        <button
          onClick={handleFinish}
          className="absolute top-0 right-0 mt-3 mr-3 flex items-center text-[#55a06a] hover:underline focus:outline-none"
        >
         <FaArrowRight className="ml-1" /> Go to next level
        </button>
        </div>

        

        <div className="mt-8 mb-3 ">
        <button
          onClick={handleSaveDraft}
          className="absolute bottom-0 left-0 mt-10 ml-10 mb-5 text-white px-4 py-2 rounded mr-2 bg-[#83DE70] hover:bg-[#55a06a]"
        >
          Save as Draft
        </button>
        </div>

        {/* <div className="mt-8 mb-3 ">
        <button
          onClick={handleDiscard}
          className="bg-[#327924] text-white px-4 py-2 rounded hover:bg-green-500"
        >
          Discard
        </button>

        </div > */}

        <div className="mt-8 mb-3 ml-2">
         <button
        onClick={handleLaunch}
        className="absolute bottom-0 right-0 mt-10 mr-6 mb-5  text-white px-4 py-2 rounded bg-[#83DE70] hover:bg-[#55a06a]"
        >
          Launch the Course
          </button> 
          </div>
        </div>
      </div>
      </div>

  
  );
};

export default LevelContentEditor;
