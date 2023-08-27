import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faEdit } from '@fortawesome/free-solid-svg-icons';

// const Level = ({ levelNumber, onEdit }) => {
//   return (
//     <div className="flex items-center justify-between border p-2 mb-2 bg-white">
//       <span>Level {levelNumber}</span>
//       <button onClick={() => onEdit(levelNumber)}>
//         <FontAwesomeIcon icon={faEdit} />
//       </button>
//     </div>
//   );
// };
const Level = ({ levelNumber }) => {
    return (
      <div className="flex items-center justify-between border p-2 mb-2 bg-white">
        <span>Level {levelNumber}</span>
        <Link to={'/edit-levels'}>
        <button className="bg-transparent border-none p-0 cursor-pointer">
         
            <FontAwesomeIcon icon={faEdit} />
          
        </button>
        </Link>
      </div>
    );
  };

const CreateCoursePage = () => {
  const [levels, setLevels] = useState([1, 2, 3, 4, 5]);

  const handleEditLevel = (levelNumber) => {
    // Handle edit logic for the selected level
    console.log(`Editing Level ${levelNumber}`);
  };

  const handleAddNewLevel = () => {
    const newLevelNumber = levels.length + 1;
    setLevels([...levels, newLevelNumber]);
  };

  const handleDeleteLastLevel = () => {
    if (levels.length > 0) {
      const updatedLevels = levels.slice(0, levels.length - 1);
      setLevels(updatedLevels);
    }
  };


  return (
    <div className="bg-white min-h-screen flex items-center justify-center">
      <div className="bg-white p-8 rounded shadow-xl w-full max-w-xl mb-20 max-h-[70vh] overflow-y-scroll">
        <h1 className="text-[#55a06a] text-2xl font-bold mb-4 flex flex-col items-center">Create Course</h1>
        <div className="space-y-2">
          {levels.map((levelNumber) => (
            <Level
              key={levelNumber}
              levelNumber={levelNumber}
              onEdit={handleEditLevel}
            />
          ))}
        </div>
        <div className="flex justify-between mt-4">
        <button
          onClick={handleAddNewLevel}
          className=" text-white px-4 py-2 rounded-full bg-[#83DE70] hover:bg-[#55a06a] focus:outline-none focus:ring focus:border-green-800 mt-4"
        >
          Add New Level
        </button>

        <button
            onClick={handleDeleteLastLevel}
            className="  text-white px-4 py-2 rounded-full bg-[#83DE70] hover:bg-[#55a06a] focus:outline-none focus:ring focus:border-green-800 mt-4"
          >
            Back
          </button>

        </div>
      </div>
    </div>
  );
};

export default CreateCoursePage;
