import React from 'react';

const CourseCard = ({ course }) => {
  return (
    <div className="bg-white rounded-lg shadow-md p-4 m-4 max-w-xs w-full">
         <div className="mb-4">
        <img src={course.image} alt={course.title} className="w-full h-40 object-cover" />
      </div>
      <h3 className="text-lg font-semibold mb-2">{course.title}</h3>
      <p className="text-gray-600">{course.description}</p>
      <button className="mt-4 px-4 py-2  text-white rounded bg-[#83DE70] hover:bg-[#55a06a] focus:outline-none focus:ring focus:border-blue-700">
        View Course
      </button>
    </div>
  );
};

export default CourseCard;