import React from 'react';
 import { Link } from 'react-router-dom';
 import { FaPlus } from 'react-icons/fa';
import TipCard from './TipCard';
import { Tab, Tabs, TabList, TabPanel } from 'react-tabs';




const PostedTips = [
    {
      id: 1,
      title: 'Tip 1',
      day: 'Monday',
      description:' Eat healthy.  It will make you feel better',
      image: require ('../../Assets/m2.jpeg'),
    },
    {
      id: 2,
      title: 'Tip 2',
      day: 'Tuesday',
      description: 'Did you know meditating every day is good.',
      image: require ('../../Assets/m4.jpeg'),
    },
    {
      id: 3,
      title: 'Tip 3',
      day: 'Wednesday',
      description: 'Are You a procastinator?',
      image: require ('../../Assets/m3.jpeg'),
    },
    {
      id: 4,
      title: 'Tip 4',
      day: 'Thursday',
      description: 'Always think Positive',
      image: require ('../../Assets/m5.jpeg'),
    },
    {
      id: 5,
      title: 'Tip 5',
      day: 'Friday',
      description: 'Always keep positive vibes',
      image: require ('../../Assets/m7.jpeg'),
    },
    {
      id: 6,
      title: 'Tip 6',
      day: 'Saturday',
      description: 'Keep yor ambitions high',
      image: require ('../../Assets/m6.jpeg'),
    },
    {
      id: 7,
      title: 'Tip 7',
      day: 'Sunday',
      description: 'Learn the fundamentals of React.js',
      // image: require ('../assets/img3.jpg'),
    },
    {
      id: 8,
      title: 'JavaScript for Beginners',
      description: 'A beginner-friendly guide to JavaScript programming',
     
    },
    {
      id: 9,
      title: 'Advanced CSS Techniques',
      description: 'Master advanced CSS concepts and techniques',
    },
    // Add more courses as needed
  ];
  
  const DraftedTips = [
      {
        id: 1,
        title: 'Tip 5',
        description: 'How many hours do you sleep for a day? ',
        image: require ('../../Assets/m10.jpeg'),
      },
      {
        id: 2,
        title: 'Tip 10',
        description: 'Benefits of doing Yoga',
        image: require ('../../Assets/m11.jpeg'),
      },
      {
        id: 3,
        title: 'Tip 20',
        description: 'Meditation',
        
        image: require ('../../Assets/m12.jpeg'),
      },
      {
        id: 4,
        title: 'Tip 25',
        description: 'Effectivity is simple',

        image: require ('../../Assets/m13.jpeg'),
      },
      {
        id: 5,
        title: 'Tip 21',
        description: 'Keep chasing your aims',
        image: require ('../../Assets/m14.jpeg'),
      },
      {
        id: 6,
        title: 'Tip 8',
        description: 'Life is a valuable chance',
        image: require ('../../Assets/m15.jpeg'),
      },
      {
        id: 7,
        title: 'Introduction to React',
        description: 'Learn the fundamentals of React.js',
        // image: require ('../assets/img3.jpg'),
      },
      {
        id: 8,
        title: 'JavaScript for Beginners',
        description: 'A beginner-friendly guide to JavaScript programming',
       
      },
      {
        id: 9,
        title: 'Advanced CSS Techniques',
        description: 'Master advanced CSS concepts and techniques',
      },
      // Add more courses as needed
    ];
    
    
    
    const DailyTipsMain = () => {
    
  return (
    <div className="flex justify-center items-center max-h-screen pt-5 ">
      <div className=" p-6 rounded-lg shadow-2xl w-3/4 bg-white  ">
        <h1 className="text-2xl font-bold mb-4 flex flex-col items-center text-[#55a06a]">Daily Tips</h1>
        <div className="flex flex-col items-end gap-4">
          {/* <Link to="/posted-tips" className="text-blue-500">
            Posted Tips
          </Link> */}
          {/* <Link to="/drafted-tips" className="text-blue-500">
            Drafted Tips
          </Link> */}
          <div className="flex justify-between items-center mb-4 ">
          <Link to={"/create-tips"}>
          <button className="bg-[#83DE70] hover:bg-[#55a06a] top=0 right-0 text-white rounded px-4 py-2 flex items-center">
            <FaPlus className="mr-2" />
            Create New Tip
          </button>
          </Link> 
          </div>

  
<Tabs>
    <div className="flex justify-center text-white ">
        <TabList className="flex bg-gray-200 ml-6">
          <Tab className="flex-grow px-4 py-2 cursor-pointer bg-[#606264] rounded-l ">Posted Tips</Tab>
          <Tab className="flex-grow px-4 py-2 cursor-pointer bg-[#606264] rounded-r">Drafted Tips</Tab>
        </TabList>
     </div>
    <TabPanel>
    
    <div className="flex flex-wrap justify-center max-h-[50vh] overflow-y-scroll">
        
      {DraftedTips.map((tip) => (
        <TipCard key={tip.id} tip={tip} />
      ))}
    </div>
    </TabPanel>

    <TabPanel>
    
    <div className="flex flex-wrap justify-center max-h-[50vh] overflow-y-scroll">
        
      {PostedTips.map((tip) => (
        <TipCard key={tip.id} tip={tip} />
      ))}
    </div>
    </TabPanel>



    </Tabs>
          
        </div>
        
      </div>
    </div>
  );
};

export default DailyTipsMain;