import axios from 'axios';
import React, { useEffect, useState } from 'react';
import * as yup from 'yup';


const AddCounsellors = ({ isOpen, onClose, onAdd }) => {
  const [formData, setFormData] = useState({
    name: '',
    contactNumber: '',
    nic: '',
    email: '',
    licenseImage: null,
  });

  const [errors, setErrors] = useState({
    name: '',
    contactNumber: '',
    nic: '',
    email: '',
    licenseImage: '',
  });

  const handleChange = (event) => {
    const { name, value } = event.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }));

    validateField(name, value);
  };

  const handleFileChange = (event) => {
    const file = event.target.files[0];
    setFormData((prevData) => ({
      ...prevData,
      licenseImage: file,
    }));
  };


  const validateField = async (name, value) => {
    try {
      // Define a validation schema for the specific field
      const fieldSchema = yup.object().shape({
        name: yup.string().required('Name is required'),
        contactNumber: yup.string().required('Contact number is required'),
        nic: yup.string().required('NIC is required'),
        email: yup.string().email('Invalid email format').required('Email is required'),
      });

      // Validate the field
      await fieldSchema.validateAt(name, { [name]: value });

      // Clear the validation error for this field
      setErrors((prevErrors) => ({
        ...prevErrors,
        [name]: '',
      }));
    } catch (validationError) {
      // Set the validation error for this field
      setErrors((prevErrors) => ({
        ...prevErrors,
        [name]: validationError.message,
      }));
    }
  };


  







  const handleSubmit = async (event) => {
    event.preventDefault();
    // Create a FormData object to send the form data
    //const formDataToSend = new FormData(event.target);
    //formDataToSend.append('name',formData.name);
    //formDataToSend.append('email',formData.email);
    //formDataToSend.append('contactNumber',formData.contactNumber);
    try {
      await validationSchema.validate(formData, { abortEarly: false });
      setErrors({});
      const response = await axios.post('http://localhost:3001/api/create-therapist', formData);

      console.log('Form data submitted:', formData);
      console.log('Server response:', response.data);
      // formData.forEach((value, key) =>{
      //   console.log(key + ':' + value);
      // }) 

      // Handle the response from the server as needed
      window.location.reload();
      onClose(); 
    } catch (error) {
      console.error(error);
      // Handle errors here
    }
  };

  const validationSchema = yup.object().shape({
    name: yup.string().required('Name is required'),
    contactNumber: yup.string().required('Contact number is required'),
    nic: yup.string().required('NIC is required'),
    email: yup.string().email('Invalid email format').required('Email is required'),
    licenseImage: yup.mixed().required('License image is required'),
  });


  useEffect(() => {
    validationSchema.validate(formData, { abortEarly: false })
      .then(() => setErrors({})) // No errors initially
      .catch((validationErrors) => {
        const newErrors = {};
        validationErrors.inner.forEach((error) => {
          newErrors[error.path] = error.message;
        });
        setErrors(newErrors);
      });
  }, []);

 
  

  return (
    <div className={`fixed top-0 left-0 w-full h-full flex items-center justify-center ${isOpen ? '' : 'hidden'}`}>
      <div className="absolute top-0 left-0 w-full h-full bg-gray-800 opacity-75" onClick={onClose}></div>
      <div className="max-w-md p-6 bg-white rounded shadow-lg relative z-10">
        <h2 className="text-xl font-semibold mb-4">Add Counsellor</h2>
        <form onSubmit={handleSubmit}>
          <div className="mb-4">
            <div>
            <label htmlFor="name" className="block font-medium mb-1">Name</label>
            </div>
            <div className='flex gap-2'> 

            <div className='w-1/4 '>
            
            <select 
              id="status"
              name="status"
              className="w-full border rounded p-2"
              value={formData.status}
              onChange={handleChange}
            >
              <option value="Mr.">Mr.</option>
              <option value="Mrs.">Mrs.</option>
              <option value="Ms.">Ms.</option>
            </select>
              
            </div>
            <div className='w-3/4'>

              <input
                type="text"
                name="name"
                value={formData.name}
                onChange={handleChange}
                className="w-full px-3 py-2 mb-4 border rounded focus:outline-none active:outline-none"
              />

              {errors.name && <div className="text-red-500">{errors.name}
              </div>}
            </div>
            </div>
            

          </div>

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

          <label className="block mb-2">Profile Image</label>
          <input
            type="file"
            accept="image/*"
            onChange={handleFileChange}
            className="mb-4"
          />
          <div className='  flex justify-center'>
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
