import React, { useEffect, useState } from 'react';
import AddCounsellors from './AddCounsellors';
import UsersTable from './UsersTable';
import { FiUserPlus } from 'react-icons/fi';
import axios from 'axios';




// var usersData = [
//   { id: 1, name: 'John Doe', nic: '123456789X', contact: '1234567890', email: 'john@example.com' },
//   ];




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



    let userdata = window.localStorage.getItem('user');
    const [user, setUser] = useState(JSON.parse(userdata));
    // console.log(user.email)
    const [usersData, setUsersData] = useState([]);


    const requestData = () => {
      axios.request({
        headers: {
          authorization: `Bearer ${user.token}`
        },
        method: "GET",
        url: `http://localhost:3001/api/get-therapist`
      }).then(response => {
       
        setUsersData(response.data);
  
        // console.log(usersData);
       
      });
      
    };
   
    useEffect(()=>{
      requestData();
    },[])

   
      
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
