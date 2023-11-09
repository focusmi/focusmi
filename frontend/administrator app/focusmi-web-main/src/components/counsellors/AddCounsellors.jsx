import React, { useState } from 'react';

const AddCounsellors = ({ isOpen, onClose, onAdd }) => {
  const [formData, setFormData] = useState({
    name: '',
    contactNumber: '',
    nic: '',
    email: '',
    licenseImage: null,
  });

  const handleChange = (event) => {
    const { name, value } = event.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  const handleFileChange = (event) => {
    const file = event.target.files[0];
    setFormData((prevData) => ({
      ...prevData,
      licenseImage: file,
    }));
  };

  const handleSubmit = (event) => {
    event.preventDefault();
    onAdd(formData); // Call a function to handle submission
    onClose(); // Close the modal
  };

  return (
    <div className={`fixed top-0 left-0 w-full h-full flex items-center justify-center ${isOpen ? '' : 'hidden'}`}>
      <div className="absolute top-0 left-0 w-full h-full bg-gray-800 opacity-75" onClick={onClose}></div>
      <div className="max-w-md p-6 bg-white rounded shadow-lg relative z-10">
        <h2 className="text-xl font-semibold mb-4">Add Counsellor</h2>
        <form onSubmit={handleSubmit}>
        <label className="block mb-2">Name</label>
        <input
          type="text"
          name="name"
          value={formData.name}
          onChange={handleChange}
          className="w-full px-3 py-2 mb-4 border rounded focus:outline-none active:outline-none"
        />

        <label className="block mb-2">Contact Number</label>
        <input
          type="text"
          name="contactNumber"
          value={formData.contactNumber}
          onChange={handleChange}
          className="w-full px-3 py-2 mb-4 border rounded focus:outline-none active:outline-none"
        />

        <label className="block mb-2">NIC</label>
        <input
          type="text"
          name="nic"
          value={formData.nic}
          onChange={handleChange}
          className="w-full px-3 py-2 mb-4 border rounded focus:outline-none active:outline-none"
        />

        <label className="block mb-2">Email Address</label>
        <input
          type="email"
          name="email"
          value={formData.email}
          onChange={handleChange}
          className="w-full px-3 py-2 mb-4 border rounded focus:outline-none active:outline-none"
        />

        <label className="block mb-2">Doctor's License Image</label>
        <input
          type="file"
          accept="image/*"
          onChange={handleFileChange}
          className="mb-4"
        />

        <div className='flex justify-center'>
        <button
          type="submit"
          className="bg-[#83DE70] hover:bg-[#55a06a] text-white px-4 py-2 rounded "
        >
          Add Counselor
        </button>

        </div>

      </form>
      </div>
    </div>
  );
};

export default AddCounsellors;
