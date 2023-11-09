import React from 'react';
import { Tab, Tabs, TabList, TabPanel } from 'react-tabs';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faPlus } from '@fortawesome/free-solid-svg-icons';
import 'react-tabs/style/react-tabs.css';
import CourseCard from './CourseCard';
import { Link } from 'react-router-dom';
//  import m2 from './assets/m2.jpeg';

const launchedCourses = [
  {
    id: 1,
    title: 'Why mindfulness needs to our life',
    day:'Monday',
    description: 'Learn the fundamentals of Mindfulness',
    image: require ('../../Assets/m2.jpeg'),
  },
  {
    id: 2,
    title: 'How to enhance Mindfulness in Daily Life',
    description: 'Practising Mindfulness for the daily life',
    image: require ('../../Assets/m4.jpeg'),
  },
  {
    id: 3,
    title: 'Mindful Practices for Stress Reduction',
    description: 'How to Use mindfulness to reduce stress',
    image: require ('../../Assets/m3.jpeg'),
  },
  {
    id: 4,
    title: 'Mindful Living: Discovering Inner Peace',
    description: 'Finding Clarity in Chaos',
    image: require ('../../Assets/m5.jpeg'),
  },
  {
    id: 5,
    title: 'Cultivating Presence',
    description: 'How to keep concentration',
    image: require ('../../Assets/m7.jpeg'),
  },
  {
    id: 6,
    title: 'Nurturing Your Inner Self',
    description: 'Be happy with your self',
    image: require ('../../Assets/m6.jpeg'),
  },

];

const draftedCourses = [
    {
      id: 1,
      title: 'Are you Overwhelmed With the workload?',
      description: 'How to manage your heavy workload',
      image: require ('../../Assets/m10.jpeg'),
    },
    {
      id: 2,
      title: 'How to work on to a timeframe',
      description: 'A friendly guide to work on time',
      image: require ('../../Assets/m11.jpeg'),
    },
    {
      id: 3,
      title: 'Enhancing Focus and Productivity',
      description: 'How to make your day effective',
      image: require ('../../Assets/m12.jpeg'),
    },
    {
      id: 4,
      title: ' Equilibrium for Body and Mind',
      description: 'Its important to keep equality always ',
      image: require ('../../Assets/m13.jpeg'),
    },
    {
      id: 5,
      title: 'Cultivating Calm and Inner Harmony',
      description: 'Do you know how to enhance',
      image: require ('../../Assets/m14.jpeg'),
    },
    {
      id: 6,
      title: 'Opening to Self-Compassion',
      description: '',
      image: require ('../../Assets/m15.jpeg'),
    },
   
    // Add more courses as needed
  ];

const CoursesPage = () => {
  return (
    <div className="text-center mt-8 ">
    <h1 className='text-[25px] font-extrabold text-[#55a06a] text-center m-5 uppercase'>Courses</h1>

    
      <div className="flex justify-between items-center mb-4">

        <Link to={"/add-courses"}>
        <button className="absolute top- right-0 mt-5 mr-5 flex items-center mx-auto mb-4 px-4 py-2 bg-[#83DE70] hover:bg-[#55a06a] text-white rounded focus:outline-none focus:ring focus:border-green-700">
          <FontAwesomeIcon icon={faPlus} className="mr-2" />
          Create New Course
        </button>
        </Link>
      </div>
    {/* <div className="text-center mt-8">
    //   <div className="mb-4">
    //     <h1 className="text-3xl font-extrabold uppercase mb-4">Courses</h1>
    //     <button className="flex items-center px-4 py-2 bg-green-500 text-white rounded hover:bg-green-600 focus:outline-none focus:ring focus:border-green-700">
    //       <FontAwesomeIcon icon={faPlus} className="mr-2" />
    //       Create New Course
    //     </button>
    //   </div> // */}

    <Tabs>
    <div className="flex justify-center text-white">
        <TabList className="flex bg-gray-200 ml-6">
          <Tab className="flex-grow px-4 py-2 cursor-pointer bg-[#606264] rounded-l ">Launched Courses</Tab>
          <Tab className="flex-grow px-4 py-2 cursor-pointer bg-[#606264] rounded-r">Drafted Courses</Tab>
        </TabList>
     </div>
    <TabPanel>
    
    <div className="flex flex-wrap justify-center max-h-[60vh] overflow-y-scroll">
        
      {draftedCourses.map((course) => (
        <CourseCard key={course.id} course={course} />
      ))}
    </div>
    </TabPanel>

    <TabPanel>
    
    <div className="flex flex-wrap justify-center max-h-[70vh] overflow-y-scroll">
        
      {launchedCourses.map((course) => (
        <CourseCard key={course.id} course={course} />
      ))}
    </div>
    </TabPanel>



    </Tabs>
    </div>
   
  );
};

export default CoursesPage;
 // image: require ('../assets/img4.png'),