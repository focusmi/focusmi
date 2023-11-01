import React from 'react';
import { FaEdit, FaTrash } from 'react-icons/fa';
import { Link } from 'react-router-dom';

const TipCard = ({ tip }) => {

  return (

    <div className='flex' >
    {tip.map((tip, index) => (
    <div key={index} className="bg-white rounded-lg shadow-md p-4 m-4 max-w-xs w-full relative ">
      <div className="mb-4">
        <img src={`http://localhost:3001/api/assets/image/mind-course/${tip.content_location}`} alt={tip.day} className="w-full h-40 object-cover" />
        </div>
        <div className='h-40'>
          <h3 className="text-lg font-semibold mb-2">{tip.text}</h3>
        </div>
        <Link to={`/daily_tips/1`} className='no-underline absolute bottom-2 left-0 right-0 flex justify-center'>
          <button className="absolute bottom-0 flex item-center mt-4 px-4 py-2  text-white rounded bg-[#83DE70] hover:bg-[#55a06a] focus:outline-none focus:ring focus:border-blue-700">
            Edit Tip
          </button>
        </Link>
      </div>
    ))}
    </div>









    // <div className="bg-white rounded-lg shadow-md p-4 m-4 max-w-xs w-full relative">
    //   {tip.map((tip, index) => (
    //   <div key={index}>          
              // <div className="mb-4">
              //   <img src={`http://localhost:3001/api/assets/image/mind-course/${tip.content_location}`} alt={tip.day} className="w-full h-40 object-cover" />
              // </div>
              // <div className='h-40'>
              //   <h3 className="text-lg font-semibold mb-2">{tip.text}</h3>
              // </div>
              // <Link to={`/daily_tips/1`} className='no-underline absolute bottom-2 left-0 right-0 flex justify-center'>
              //   <button className="absolute bottom-0 flex item-center mt-4 px-4 py-2  text-white rounded bg-[#83DE70] hover:bg-[#55a06a] focus:outline-none focus:ring focus:border-blue-700">
              //     Edit Tip
              //   </button>
              // </Link>
    //   </div>
    //     ))}
    // </div>
  );
};

export default TipCard;

// <div className="bg-white p-4 rounded-lg shadow-xl w-full  mb-4 flex justify-between items-center">
//   <div className='flex flex-row'>
//     <div className='flex items-center'>
//     <img src='' alt='dddd' className=" w-32 h-32 object-cover rounded-md" />
//     </div>
//     <div className='flex flex-col ml-5'>
//     <h2 className="text-lg font-semibold mt-2">dddddddddd</h2>
//     <p className="text-sm text-gray-500">dddddd</p>
//     <p className="text-gray-700 mt-2">dddddd</p>
//     </div>
//   </div>


//   <div className= 'flex flex-row items-end'>
//     {/* <button className="text-[#55a06a] mr-7 text-xl ">
//       <FaEdit />
//     </button> */}

//     <Link to= {`/edit-tip/1`} >
//      < button className="text-green-600 hover:text-green-800"
//     >
//       <FaEdit className="text-xl mr-7 " />
//       </button>
//     </Link>

//     {/* <button
//       onClick={() => handleDeleteTip(tip.id)} 
//       className="text-red-600 hover:text-red-800"
//     >
//       <FaTrash className="text-xl" />
//     </button> */}
//     <Link >
//     <button className="text-red-500 text-xl">
//       <FaTrash />
//     </button>
//     </Link>
//   </div>
// </div>