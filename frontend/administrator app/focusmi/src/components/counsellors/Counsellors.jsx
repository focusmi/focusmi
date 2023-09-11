import React, { useState } from 'react';
import AddCounsellors from './AddCounsellors';
import UsersTable from './UsersTable';
import { FiUserPlus } from 'react-icons/fi';


const usersData = [
  { id: 1, name: 'John Doe', nic: '123456789X', contact: '1234567890', email: 'john@example.com' },
  { id: 2, name: 'Jane Smith', nic: '987654321Y', contact: '9876543210', email: 'jane@example.com' },
  { id: 2, name: 'Jane Smith', nic: '987654321Y', contact: '9876543210', email: 'jane@example.com' },  
  { id: 2, name: 'Jane Smith', nic: '987654321Y', contact: '9876543210', email: 'jane@example.com' },
  { id: 1, name: 'John Doe', nic: '123456789X', contact: '1234567890', email: 'john@example.com' },
  { id: 2, name: 'Jane Smith', nic: '987654321Y', contact: '9876543210', email: 'jane@example.com' },
  { id: 2, name: 'Jane Smith', nic: '987654321Y', contact: '9876543210', email: 'jane@example.com' },
  { id: 2, name: 'Jane Smith', nic: '987654321Y', contact: '9876543210', email: 'jane@example.com' },  
  { id: 2, name: 'Jane Smith', nic: '987654321Y', contact: '9876543210', email: 'jane@example.com' },
  { id: 1, name: 'John Doe', nic: '123456789X', contact: '1234567890', email: 'john@example.com' },
  { id: 2, name: 'Jane Smith', nic: '987654321Y', contact: '9876543210', email: 'jane@example.com' },
];



function Counsellors() {
  const [isModalOpen, setIsModalOpen] = useState(false);

  const handleOpenModal = () => {
    setIsModalOpen(true);
  };

  const handleCloseModal = () => {
    setIsModalOpen(false);
  };

  const handleAddCounselor = (formData) => {
    // Handle form submission logic here
    console.log('Counselor added:', formData);
  };
 
      
  return (
    <div className='w-11/12 mx-auto my-10 max-h-[70vh] overflow-y-scroll'>
        <h1 className='text-[25px] font-extrabold text-center mt-5 uppercase text-[#55a06a]'>Counsellors</h1>
      <div className='flex justify-end'>       
        <button onClick={handleOpenModal} className="bg-[#83DE70] text-white px-3 py-2 rounded mx-8 hover:bg-[#55a06a]  flex gap-2 items-center">
            <FiUserPlus/> Add New Counsellor
        </button>
        <AddCounsellors isOpen={isModalOpen} onClose={handleCloseModal} onAdd={handleAddCounselor} />
      </div>
        <div>
          <UsersTable users={usersData} />
        </div>
      
      
    </div>
  )
}

export default Counsellors
