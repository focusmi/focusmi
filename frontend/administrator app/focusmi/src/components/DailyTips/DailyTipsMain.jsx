import React, { useState , useEffect } from 'react';
 import { Link } from 'react-router-dom';
 import { FaPlus } from 'react-icons/fa';
import TipCard from './TipCard';
import { Tab, Tabs, TabList, TabPanel } from 'react-tabs';
import axios from 'axios';
import DailyTipsAdmin, { createTips } from './CreateTips';
import { FiXSquare } from 'react-icons/fi';



    
    
    const DailyTipsMain = () => {

      
    let userdata = window.localStorage.getItem('user');
    const [user, setUser] = useState(JSON.parse(userdata));
    const [tipData, setTipData] = useState([]);
    const [isOpenPopup , setOpenPopup] = useState(false);
    const [tip,setTip]=([]);

    const openPopup=()=>{
      setOpenPopup(true);
    }
    const closePopup =() =>{
      setOpenPopup(false);
    }


    const requestData = () => {
      axios.request({
        headers: {
          authorization: `Bearer ${user.token}`
        },
        method: "GET",
        url: `http://localhost:3001/api/get-all-tips`
      }).then(response => {
        // console.log(response.data)
        setTipData(response.data);
        console.log(tipData);      
      });
      
    };
  
      useEffect(()=>{
        requestData();
      },[])
      useEffect(() => {
        console.log(tipData); // Log tipData whenever it changes
      }, [tipData]);

      const mondayTip = tipData.filter(tip => tip.day === 'Monday');
      const tuesdayTip = tipData.filter(tip => tip.day === 'Tuesday');
      const wednesdayTip = tipData.filter(tip => tip.day === 'Wednesday');
      const thursdayTip = tipData.filter(tip => tip.day === 'Thursday');
      const fridayTip = tipData.filter(tip => tip.day === 'Friday');
      const saturdayTip = tipData.filter(tip => tip.day === 'Saturday');
      const sundayTip = tipData.filter(tip => tip.day === 'Sunday');

    
  return (

    <div className="text-center w-full relative">
      <h1 className='text-[25px] font-extrabold text-[#55a06a] m-4 uppercase'>Daily Tips </h1> 
      

      <Link to={""} className='no-underline'>
      <button className="absolute top-0 right-0 mt-0 mr-4 flex items-center px-4 py-2 bg-green-500 text-white rounded hover:bg-green-600 focus:outline-none focus:ring focus:border-green-700" onClick={openPopup}>
              <FaPlus className="mr-2" />
         Create New Tip 
      </button>
      </Link>
  
      <div >
      
        <Tabs >
          <TabList className="flex rounded-r border-2 justify-center">
            <Tab className="p-2 cursor-pointer  border-2  w-1/2 ">Monday</Tab>
            <Tab className="p-2 cursor-pointer border-2 w-1/2 ">Tuesday</Tab>
            <Tab className="p-2 cursor-pointer border-2 w-1/2 ">Wednsday</Tab>
            <Tab className="p-2 cursor-pointer border-2 w-1/2 ">Thursday</Tab>
            <Tab className="p-2 cursor-pointer border-2 w-1/2 ">Friday</Tab>
            <Tab className="p-2 cursor-pointer border-2 w-1/2 ">Saturday</Tab>
            <Tab className="p-2 cursor-pointer border-2 w-1/2 ">Sunday</Tab>
          </TabList>
          <TabPanel className="relative">
          <div className="flex flex-wrap justify-center max-h-[60vh] overflow-y-scroll">
            <TipCard tip={mondayTip} /> 
           </div>
          </TabPanel>
          <TabPanel>
          <div className="flex flex-wrap justify-center max-h-[60vh] overflow-y-scroll">
          <TipCard tip={tuesdayTip} />
          </div>
          </TabPanel>
          <TabPanel>
          <div className="flex flex-wrap justify-center max-h-[60vh] overflow-y-scroll">
          <TipCard tip={wednesdayTip} />
          </div>
          </TabPanel>
          <TabPanel>
          <div className="flex flex-wrap justify-center max-h-[60vh] overflow-y-scroll">
          <TipCard tip={thursdayTip} />
          </div>
          </TabPanel>
          <TabPanel>
          <div className="flex flex-wrap justify-center max-h-[60vh] overflow-y-scroll">
          <TipCard tip={fridayTip} />
          </div>
          </TabPanel>
          <TabPanel>
          <div className="flex flex-wrap justify-center max-h-[60vh] overflow-y-scroll">
          <TipCard tip={saturdayTip} />
          </div>
          </TabPanel>
          <TabPanel>
          <div className="flex flex-wrap justify-center max-h-[60vh] overflow-y-scroll">
          <TipCard tip={sundayTip} />
          </div>
          </TabPanel>
        </Tabs>
      </div>
      {isOpenPopup && (
        <div className="fixed top-0 left-0 w-full h-full flex items-center justify-center bg-gray-800 bg-opacity-50">
        <div className="bg-white p-4 rounded-lg">
          <div className='flex justify-center relative'>
          <h2 className="text-2xl font-bold text-[#55a06a] mb-4 ">Create Daily Tip</h2>

              <button
                  className="text-white bg-red-600 hover:bg-red-300 p-2 rounded absolute top-0 right-0 "
                  onClick={closePopup}
                >
                  <FiXSquare className='text-2xl'/>
                </button>
          </div>
          {/* Your edit form goes here */}

          <DailyTipsAdmin />
          {/* Include an "Update" button to save the changes */}
          
        </div>
      </div>
      )}


    </div> 
  );
};

export default DailyTipsMain;


