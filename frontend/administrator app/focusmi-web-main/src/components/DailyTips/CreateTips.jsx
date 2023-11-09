import React, { useState } from 'react';

const DailyTipsAdmin = () => {
  const [newTip, setNewTip] = useState({ title: '', description: '', image: '', day: '' });
  const [ setDrafts] = useState([]);
  const [ setPostedTips] = useState([]);
  const daysOfWeek = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setNewTip((prevTip) => ({ ...prevTip, [name]: value }));
  };

  const handleImageChange = (e) => {
    const image = e.target.files[0];
    setNewTip((prevTip) => ({ ...prevTip, image }));
  };

  const handleSaveDraft = () => {
    setDrafts((prevDrafts) => [...prevDrafts, newTip]);
    setNewTip({ title: '', description: '', image: '', day: '' });
  };

  const handlePostTip = () => {
    setPostedTips((prevPostedTips) => [...prevPostedTips, newTip]);
    setNewTip({ title: '', description: '', image: '', day: '' });
  };

  return (
    <div className="flex justify-center items-center h-screen">
      <div className="bg-white p-6 rounded-lg shadow-2xl w-[800px] mb-10">
        <h2 className="text-2xl font-bold text-[#55a06a] mb-4 flex flex-col items-center">Create Daily Tips</h2>
        <div className="mb-4">
          <label className="block text-gray-700 font-semibold mb-2">
            Tip Title:
          </label>
          <input
            type="text"
            name="title"
            value={newTip.title}
            onChange={handleInputChange}
            className="w-full p-2 border rounded"
          />
        </div>
        <div className="mb-4">
          <label className="block text-gray-700 font-semibold mb-2">
            Add Description:
          </label>
          <textarea
            name="description"
            value={newTip.description}
            onChange={handleInputChange}
            placeholder="Add description..."
            className="w-full p-2 border rounded"
          />
        </div>
        <div className="mb-4">
          <label className="block text-gray-700 font-semibold mb-2">
            Day of the Week:
          </label>
          <select
            name="day"
            value={newTip.day}
            onChange={handleInputChange}
            className="w-full p-2 border rounded"
          >
            <option value="">Select a day</option>
            {daysOfWeek.map((day, index) => (
              <option key={index} value={day}>{day}</option>
            ))}
          </select>
        </div>
        <div className="mb-4">
          <label className="block text-gray-700 font-semibold mb-2">
            Image:
          </label>
          <input
            type="file"
            accept="image/*"
            onChange={handleImageChange}
            className="w-full p-2 border rounded"
          />
        </div>
        <div className="flex justify-between">
          <button
            onClick={handleSaveDraft}
            className=" text-white px-4 py-2 rounded bg-[#83DE70] hover:bg-[#55a06a] focus:outline-none focus:ring focus:border-green-700"
          >
            Save as Draft
          </button>
          <button
            onClick={handlePostTip}
            className=" text-white px-4 py-2 rounded bg-[#83DE70] hover:bg-[#55a06a] focus:outline-none focus:ring focus:border-green-700"
          >
            Post Tip
          </button>
        </div>
        {/* <div className="mt-8">
          <h3 className="text-lg font-semibold mb-2">Drafts</h3>
          <ul>
            {drafts.map((tip, index) => (
              <li key={index} className="mb-2">{tip.title}</li>
            ))}
          </ul>
        </div>
        <div className="mt-8">
          <h3 className="text-lg font-semibold mb-2">Posted Tips</h3>
          <ul>
            {postedTips.map((tip, index) => (
              <li key={index} className="mb-2">{tip.title}</li>
            ))}
          </ul>
        </div> */}
      </div>
    </div>
  );
};

export default DailyTipsAdmin;

