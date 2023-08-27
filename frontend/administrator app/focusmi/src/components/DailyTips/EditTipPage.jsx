// import React, { useState } from 'react';

// const EditTipForm = ({ tip, onSave,onCancel }) => {
//   const [editedTip, setEditedTip] = useState({
//     title: tip.title,
//     description: tip.description,
//     day: tip.day,
//     // Add other fields as needed
//   });

//   const handleInputChange = (e) => {
//     const { name, value } = e.target;
//     setEditedTip((prevTip) => ({
//       ...prevTip,
//       [name]: value,
//     }));
//   };

//   const handleSave = () => {
//     onSave(editedTip);
//   };

//   return (
//     <div className="bg-white p-4 mb-4 shadow-md rounded-lg">
//       <h2 className="text-xl font-semibold mb-2">Edit Tip</h2>
//       <form>
//         <div className="mb-4">
//           <label htmlFor="title" className="block text-sm font-medium text-gray-700">
//             Title
//           </label>
//           <input
//             type="text"
//             id="title"
//             name="title"
//             value={editedTip.title}
//             onChange={handleInputChange}
//             className="mt-1 p-2 w-full border rounded-md"
//           />
//         </div>

//         <div className="mb-4">
//           <label htmlFor="description" className="block text-sm font-medium text-gray-700">
//             Description
//           </label>
//           <textarea
//             id="description"
//             name="description"
//             value={editedTip.description}
//             onChange={handleInputChange}
//             className="mt-1 p-2 w-full border rounded-md"
//             rows="3"
//           />
//         </div>

//         <div className="mb-4">
//           <label htmlFor="day" className="block text-sm font-medium text-gray-700">
//             Day of the Week
//           </label>
//           <select
//             id="day"
//             name="day"
//             value={editedTip.day}
//             onChange={handleInputChange}
//             className="mt-1 p-2 w-full border rounded-md"
//           >
//             <option value="monday">Monday</option>
//             <option value="tuesday">Tuesday</option>
//             <option value="tuesday">Wednesday</option>
//             <option value="tuesday">Thursday</option>
//             <option value="tuesday">Friday</option>
//             <option value="tuesday">Saturday</option>
//             <option value="tuesday">SUnday</option>
          
//           </select>
//         </div>

//         {/* Add image input */}
//         <div className="mb-4">
//           <label htmlFor="image" className="block text-sm font-medium text-gray-700">
//             Image
//           </label>
//           <input
//             type="file"
//             id="image"
//             name="image"
//             onChange={handleInputChange}
//             className="mt-1"
//           />
//         </div>

//         <button
//           type="button"
//           onClick={handleSave}
//           className="px-4 py-2 bg-green-500 text-white rounded hover:bg-green-600"
//         >
//           Save
//         </button>

//         <button
//           type="button"
//           onClick={onCancel}
//           className="px-4 py-2 bg-green-500 text-white rounded hover:bg-green-600"
//         >
//           Cancel
//         </button>
//       </form>
//     </div>
//   );
// };

// export default EditTipForm;
