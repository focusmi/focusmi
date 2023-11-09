// import React from 'react';
// import { FaPlus } from 'react-icons/fa';
// import TipCard from './TipCard';
// import { Link } from 'react-router-dom';

// const postedTips = [
//   { id: 1, title: 'Posted Tip 1', day: 'Monday', description: 'Description 1', image: 'url1' },
//   // ... other posted tips
// ];

// const PostedTips = () => {
//   return (
//     <div className="flex justify-center items-center h-screen">
//       <div className="bg-white p-6 rounded-lg shadow-md w-[600px]">
//         <div className="flex justify-between items-center mb-4">
//           <h1 className="text-2xl font-bold">Posted Tips</h1>

//           <Link to={"/create-tips"}>
//           <button className="bg-green-500 text-white rounded px-4 py-2 flex items-center">
//             <FaPlus className="mr-2" />
//             Create New Tip
//           </button>
//           </Link> 
//         </div>
//         {postedTips.map((tip) => (
//           <TipCard key={tip.id} tip={tip} />
//         ))}
//       </div>
//     </div>
//   );
// };

// export default PostedTips;
