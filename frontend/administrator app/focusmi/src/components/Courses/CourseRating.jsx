import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faStar } from '@fortawesome/free-solid-svg-icons';

const CourseRating = ({ rating }) => {
  // Calculate the number of full stars and empty stars
  const fullStars = Math.floor(rating);
  const emptyStars = 5 - fullStars;

  return (
    <div className="course-rating flex gap-2 items-center m-2">
      
      <div className="flex">
        {[...Array(fullStars)].map((_, index) => (
          <FontAwesomeIcon key={index} icon={faStar} color="#55a06a" />
        ))}
        {[...Array(emptyStars)].map((_, index) => (
          <FontAwesomeIcon key={index} icon={faStar} color="white" />
        ))}
      </div>
    </div>
  );
        };

export default CourseRating;
