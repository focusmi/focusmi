import React, { useEffect, useState } from 'react';
import { Tab, Tabs, TabList, TabPanel } from 'react-tabs';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faPlus } from '@fortawesome/free-solid-svg-icons';
import 'react-tabs/style/react-tabs.css';
import CourseCard from './CourseCard';
import { Link } from 'react-router-dom';
import axios from 'axios';


const CoursesPage = () => {

  let userdata = window.localStorage.getItem('user');
  const [user, setUser] = useState(JSON.parse(userdata));
  const [courseData, setcourseData] = useState([]);


  const requestData = () => {
    axios.request({
      headers: {
        authorization: `Bearer ${user.token}`
      },
      method: "GET",
      url: `http://localhost:3001/api/get-all-courses`
    }).then(response => {
      // console.log(response.data)
      setcourseData(response.data);
      // console.log(courseData);      
    });
    
  };
 
    useEffect(()=>{
      requestData();
    },[])


    const publishedCourses = courseData.filter(course => course.course_status === 'published');
    const draftedCourses = courseData.filter(course => course.course_status === 'drafted');

  
  return (
    <div className="text-center w-full relative">
      <h1 className='text-[25px] font-extrabold text-[#55a06a] m-4 uppercase'>Courses </h1> 

      <Link to={"/add-courses"} className='no-underline'>
      <button className="absolute top-0 right-0 mt-0 mr-4 flex items-center px-4 py-2 bg-green-500 text-white rounded hover:bg-green-600 focus:outline-none focus:ring focus:border-green-700">
              <FontAwesomeIcon icon={faPlus} className="mr-2" />
         Create New Course
      </button>
      </Link>
  
      <div >
        <Tabs >
          <TabList className="flex rounded-r border-2 justify-center">
            <Tab className="p-2 cursor-pointer  border-2  w-1/2 ">Launched Courses</Tab>
            <Tab className="p-2 cursor-pointer border-2 w-1/2 ">Drafted Courses</Tab>
          </TabList>
          <TabPanel className="relative">
          <div className="flex flex-wrap justify-center max-h-[60vh] overflow-y-scroll">
            {publishedCourses.map((course) => (
              <CourseCard key={course.id} course={course} />
            ))}
           </div>
          </TabPanel>
          <TabPanel>
          <div className="flex flex-wrap justify-center max-h-[60vh] overflow-y-scroll">
            {draftedCourses.map((course) => (
              <CourseCard key={course.id} course={course} />
            ))}
          </div>
          </TabPanel>
        </Tabs>
      </div>


    </div>   
  );
};

export default CoursesPage;






    // <div className="text-center mt-8 ">
    // <h1 className='text-[25px] font-extrabold text-[#55a06a] text-center m-5 uppercase'>Courses</h1>   
    //   <div className="flex justify-between items-center mb-4">

    //     <Link to={"/add-courses"}>
    //     <button className="absolute top- right-0 mt-5 mr-5 flex items-center mx-auto mb-4 px-4 py-2 bg-[#83DE70] hover:bg-[#55a06a] text-white rounded focus:outline-none focus:ring focus:border-green-700">
    //       <FontAwesomeIcon icon={faPlus} className="mr-2" />
    //       Create New Course
    //     </button>
    //     </Link>
    //   </div>
    // {/* <div className="text-center mt-8">
    // //   <div className="mb-4">
    // //     <h1 className="text-3xl font-extrabold uppercase mb-4">Courses</h1>
    // //     <button className="flex items-center px-4 py-2 bg-green-500 text-white rounded hover:bg-green-600 focus:outline-none focus:ring focus:border-green-700">
    // //       <FontAwesomeIcon icon={faPlus} className="mr-2" />
    // //       Create New Course
    // //     </button>
    // //   </div> // */}
    // <Tabs className="w-full">
    // {/* <div className="flex justify-center text-white bg-black"> */}
    //     <TabList className="flex bg-gray-200 rounded-1 w-full">
    //       <Tab className="flex-grow px-4 py-2 cursor-pointer  rounded-r ">Launched Courses</Tab>
    //       <Tab className="flex-grow px-4 py-2 cursor-pointer rounded-r">Drafted Courses</Tab>
    //     </TabList>
    //  {/* </div> */}
    // <TabPanel>
    
    // <div className="flex flex-wrap justify-center max-h-[60vh] overflow-y-scroll">
        
    //   {draftedCourses.map((course) => (
    //     <CourseCard key={course.id} course={course} />
    //   ))}
    // </div>
    // </TabPanel>

    // <TabPanel>
    
    // <div className="flex flex-wrap justify-center max-h-[60vh] overflow-y-scroll">
        
    //   {publishedCourses.map((course) => (
    //     <CourseCard key={course.id} course={course} />
    //   ))}
    // </div>
    // </TabPanel>
    // </Tabs>
    // </div>