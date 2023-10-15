import React, { useState } from 'react';
import EditUserPopup from './EditUserPopup';
import axios from 'axios';




const UsersTable = ({ users }) => {
  const [showActions, setShowActions] = useState(false);
  const [editedUser, setEditedUser] = useState(null);
  const [showAddUserForm, setShowAddUserForm] = useState(false);

  const toggleActionVisibility = () => {
    setShowActions(!showActions);
  };
  const handleEditClick = (user) => {
    setEditedUser(user);
  };

  const handleAddUserClick = () => {
    setShowAddUserForm(true);
  };


  const handleSaveEdit=(updatedUser)=>{
    console.log('Updated User:', updatedUser);
    axios.put('http://localhost:3001/api/update-therapist',updatedUser)
    .then(res=>console.log(res.data))
    .catch(err=>console.log(err))
    setEditedUser(null);
    window.location.reload();
  }

  return (
    <div className="bg-white rounded-md  p-4">
      <table className="w-full shadow-2xl">
        <thead>
          <tr>
            <th className="py-2 px-4 bg-gray-200 border">User ID</th>
            <th className="py-2 px-4 bg-gray-200 border">Name</th>
            <th className="py-2 px-4 bg-gray-200 border">NIC No</th>
            <th className="py-2 px-4 bg-gray-200 border">Contact No</th>
            <th className="py-2 px-4 bg-gray-200 border">Email</th>
            <th className="py-2 px-4 bg-gray-200 border" onClick={toggleActionVisibility}>
              Actions
            </th>
          </tr>
        </thead>
        <tbody>
          {users.map((user) => (
            <tr key={user.id}>
              <td className="py-2 px-4">{user.user_id}</td>
              <td className="py-2 px-4">{user.full_name}</td>
              <td className="py-2 px-4">{user.nic}</td>
              <td className="py-2 px-4">{user.phone_number}</td>
              <td className="py-2 px-4">{user.email}</td>
              <td className="py-2 px-4">
                {showActions && (
                  <>
                    <button
                      className="bg-[#83DE70] text-white px-2 py-1 rounded mr-2 hover:bg-[#55a06a]"
                      onClick={() => handleEditClick(user)}
                    >
                      Edit
                    </button>
                    <button className="bg-red-500 text-white px-2 py-1 rounded hover:bg-red-600">
                       Deactivate
                    </button>
                  </>
                )}
              </td>
            </tr>
          ))}
        </tbody>
      </table>
      {editedUser && (
        <EditUserPopup user={editedUser} onSave={handleSaveEdit} onClose={() => setEditedUser(null)} />
      )}
    </div>
  );
};

export default UsersTable;
