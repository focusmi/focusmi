import React, { useState } from 'react';
import EditUserPopup from './EditUserPopup';
import { FiTrash } from 'react-icons/fi';



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

  const handleSaveEdit = (updatedUser) => {
    // Here you can update the user data in your state or API
    // For this example, I'll just console.log the updated user
    console.log('Updated User:', updatedUser);

    setEditedUser(null);
  };

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
              <td className="py-2 px-4">{user.id}</td>
              <td className="py-2 px-4">{user.name}</td>
              <td className="py-2 px-4">{user.nic}</td>
              <td className="py-2 px-4">{user.contact}</td>
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
                       Delete
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
