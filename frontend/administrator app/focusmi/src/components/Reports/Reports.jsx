import React from 'react';
import { Link } from 'react-router-dom';


const Reports = () => {
  return (
    <div className="flex flex-col h-full p-8 bg-gray-100">
      <h1 className='text-[25px] font-extrabold text-center mt-5 uppercase text-[#55a06a]'>Reports</h1>
      <div className="grid grid-cols-2 gap-4">
        <Link to={'income-statement'}>
        <div className="bg-white p-4 rounded shadow-md">
          <h2 className="text-lg font-semibold mb-2">Income Statements</h2>          
        </div>
        </Link>
        <div className="bg-white p-4 rounded shadow-md">
          <h2 className="text-lg font-semibold mb-2">Task Progress Report</h2>
          {/* Task Progress Report content */}
        </div>
        <div className="bg-white p-4 rounded shadow-md">
          <h2 className="text-lg font-semibold mb-2">Task Progress Report</h2>
          {/* Task Progress Report content */}
        </div>
        <div className="bg-white p-4 rounded shadow-md">
          <h2 className="text-lg font-semibold mb-2">Task Progress Report</h2>
          {/* Task Progress Report content */}
        </div>
      </div>
    </div>
  );
};

export default Reports;
