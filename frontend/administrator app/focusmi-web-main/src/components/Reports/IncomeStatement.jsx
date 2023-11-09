import React, { useState } from 'react';

const IncomeStatement = () => {
  const [selectedPeriod, setSelectedPeriod] = useState('');
  const [selectedComparisonMonth, setSelectedComparisonMonth] = useState('');
  const [selectedReportFormat, setSelectedReportFormat] = useState('');

  const handleGenerateReport = () => {
    // Logic to generate the income statement report based on selected options
    // This is where you would use the selectedPeriod, selectedComparisonMonth, and selectedReportFormat
  };
  const [selectedDate, setSelectedDate] = useState("");

  const handleDateChange = (event) => {
    setSelectedDate(event.target.value);
  };
  const months = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];

  const [selectedMonth, setSelectedMonth] = useState("");

  const handleMonthChange = (event) => {
    setSelectedMonth(event.target.value);
  };

  return (
    <div className=" flex justify-center items-center">
      <div className=" p-8 rounded shadow-md w-3/4 m-8">
      <h1 className='text-[25px] font-extrabold text-center mt-5 uppercase text-[#55a06a]'>Income Statement</h1>
        <div className="mb-4">
          <h1>Select Period</h1>
          <div className='flex flex-row gap-10'>
            <div className='flex flex-row m-1'>
                <label htmlFor="dateInput" className="block font-medium mr-5">From</label>
                <input className='bg-neutral-200'
                        type="date"
                        id="dateInput"
                        value={selectedDate}
                        onChange={handleDateChange}
                />
            </div>
            <div className='flex flex-row m-1'>
                <label htmlFor="dateInput" className="block font-medium mr-5 ">To</label>
                <input className='bg-neutral-200'
                        type="date"
                        id="dateInput"
                        value={selectedDate}
                        onChange={handleDateChange}
                />
          </div>
          </div>
        </div>
        
        <div className="mb-4">
        <label htmlFor="monthSelect">Select a Month: </label>
      <select
        id="monthSelect"
        value={selectedMonth}
        onChange={handleMonthChange}
      >
        <option value="">Select Month</option>
        {months.map((month, index) => (
          <option key={index} value={month}>
            {month}
          </option>
        ))}
      </select>
        </div>
        <div className="mb-4">
          <label htmlFor="reportFormat" className="block font-medium mb-1">Select Report Format:</label>
          <select
            id="reportFormat"
            className="w-full border rounded px-3 py-2"
            value={selectedReportFormat}
            onChange={(e) => setSelectedReportFormat(e.target.value)}
          >
            <option value="">Select...</option>
            <option value="pdf">PDF</option>
            <option value="excel">Excel</option>
          </select>
        </div>
        <button
          className="bg-[#83DE70] hover:bg-[#55a06a] text-white px-4 py-2 rounded "
          onClick={handleGenerateReport}
        >
          Generate Report
        </button>
      </div>
    </div>
  );
};

export default IncomeStatement;
