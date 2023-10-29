import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { Link } from 'react-router-dom';

const CourseCard = ({ course }) => {


  const maxDescriptionLength = 40; // Define the maximum number of characters

  // Function to truncate the description text if it's too long
  const truncateDescription = (description) => {
    if (description.length > maxDescriptionLength) {
      return description.slice(0, maxDescriptionLength) + '...';
    }
    return description;
  };

  const truncatedDescription = truncateDescription(course.description);

  return (
    <div className="bg-white rounded-lg shadow-md p-4 m-4 max-w-xs w-full relative">
      <div className="mb-4">
        <img src={`http://localhost:3001/api/assets/image/mind-course/${course.image}`} alt={course.title} className="w-full h-40 object-cover" />
      </div>
      <div className='h-40'>
        <h3 className="text-lg font-semibold mb-2">{course.title}</h3>
        <p className="text-gray-600">{truncatedDescription}</p>
      </div>
      <Link to={`/courses/${course.course_id}`} className='no-underline absolute bottom-2 left-0 right-0 flex justify-center'>
        <button className="absolute bottom-0 flex item-center mt-4 px-4 py-2  text-white rounded bg-[#83DE70] hover:bg-[#55a06a] focus:outline-none focus:ring focus:border-blue-700">
          Edit Course
        </button>
      </Link>
    </div>
  );
};

export default CourseCard;

