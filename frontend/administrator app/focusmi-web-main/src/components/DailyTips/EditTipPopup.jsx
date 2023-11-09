import React, { useState } from 'react'



const EditTipPopup=({tip,onSave,onClose})=> {
    const [editedTip, setEditedTip] = useState({ ...tip });

    const handleFieldChange = (field, value) => {
        setEditedTip((prevTip) => ({ ...prevTip, [field]: value }));
      };
    
      const handleSave = () => {
        onSave(editedTip);
      };





  return (
    <div className="fixed inset-0 flex items-center justify-center bg-gray-500 bg-opacity-50">
        <div className="bg-white p-8 rounded-md shadow-md w-1/2">
        <h2 className="text-xl font-semibold mb-4">Edit  {editedTip.title}</h2>
        <form>
          <label className="block mb-2">
            Title
            <input
              type="text"
              className="border rounded px-2 py-1 w-full"
              value={editedTip.title}
              onChange={(e) => handleFieldChange('title', e.target.value)}
            />
          </label>
          <label className="block mb-2">
            Description
            <input
              type="text"
              className="border rounded px-2 py-1 w-full"
              value={editedTip.description}
              onChange={(e) => handleFieldChange('description', e.target.value)}
            />
          </label>
          <label className="block mb-2">
            Day
            <input
              type="text"
              className="border rounded px-2 py-1 w-full"
              value={editedTip.day}
              onChange={(e) => handleFieldChange('day', e.target.value)}
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
  )
}

export default EditTipPopup