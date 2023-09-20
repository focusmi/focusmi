import React, { useState } from 'react';

const EditUserPopup = ({ user, onSave, onClose }) => {
  const [editedUser, setEditedUser] = useState({ ...user });

  const handleFieldChange = (field, value) => {
    setEditedUser((prevUser) => ({ ...prevUser, [field]: value }));
  };

  const handleSave = () => {
    onSave(editedUser);
  };

  return (
    <div className="fixed inset-0 flex items-center justify-center bg-gray-500 bg-opacity-50">
      <div className="bg-white p-8 rounded-md shadow-md">
        <h2 className="text-xl font-semibold mb-4">Edit User</h2>
        <form>
          <label className="block mb-2">
            Name:
            <input
              type="text"
              className="border rounded px-2 py-1 w-full"
              value={editedUser.name}
              onChange={(e) => handleFieldChange('name', e.target.value)}
            />
          </label>
          <label className="block mb-2">
            NIC No:
            <input
              type="text"
              className="border rounded px-2 py-1 w-full"
              value={editedUser.nic}
              onChange={(e) => handleFieldChange('nic', e.target.value)}
            />
          </label>
          <label className="block mb-2">
            Contact No:
            <input
              type="text"
              className="border rounded px-2 py-1 w-full"
              value={editedUser.contact}
              onChange={(e) => handleFieldChange('contact', e.target.value)}
            />
          </label>
          <label className="block mb-2">
            Email:
            <input
              type="email"
              className="border rounded px-2 py-1 w-full"
              value={editedUser.email}
              onChange={(e) => handleFieldChange('email', e.target.value)}
            />
          </label>
        </form>
        <div className="mt-4 flex justify-end">
          <button className="bg-blue-500 text-white px-2 py-1 rounded mr-2" onClick={handleSave}>
            Save
          </button>
          <button className="bg-gray-500 text-white px-2 py-1 rounded" onClick={onClose}>
            Cancel
          </button>
        </div>
      </div>
    </div>
  );
};

export default EditUserPopup;
