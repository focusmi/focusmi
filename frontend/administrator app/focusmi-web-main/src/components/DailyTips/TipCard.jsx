import React, { useState } from 'react';
import { FaEdit, FaTrash } from 'react-icons/fa';
import { Link } from 'react-router-dom';
import EditTipPopup from './EditTipPopup';



const TipCard = ({ tip }) => {
  const { title, day, description, image } = tip;
  const [editedTip, setEditedTip] = useState(null);

  const handleEditClick = (tip) => {
    setEditedTip(tip);
  };
  const handleSaveEdit = (updatedTip) => {
    // Here you can update the user data in your state or API
    // For this example, I'll just console.log the updated user
    console.log('Updated Tip:', updatedTip);
    setEditedTip(null);
  };
  

  return (
    <div className="bg-white p-4 rounded-lg shadow-xl w-full  mb-4 flex justify-between items-center">
      <div className='flex flex-row'>
        <div className='flex items-center'>
        <img src={image} alt={title} className=" w-32 h-32 object-cover rounded-md" />
        </div>
        <div className='flex flex-col ml-5'>
        <h2 className="text-lg font-semibold mt-2">{title}</h2>
        <p className="text-sm text-gray-500">{day}</p>
        <p className="text-gray-700 mt-2">{description}</p>
        </div>
      </div>


      <div className= 'flex flex-row items-end'>
        {/* <button className="text-[#55a06a] mr-7 text-xl ">
          <FaEdit />
        </button> */}

         < button className="text-green-600 hover:text-green-800"
            onClick={()=> handleEditClick(tip)}
        >
          <FaEdit className="text-xl mr-7 " />
          </button>
        
        
        <button className="text-red-500 text-xl">
          <FaTrash />
        </button>
       
      </div>
      {editedTip && (
        <EditTipPopup tip={editedTip} onSave={handleSaveEdit} onClose={() => setEditedTip(null)} />
      )}
    </div>
  );
};

export default TipCard;
