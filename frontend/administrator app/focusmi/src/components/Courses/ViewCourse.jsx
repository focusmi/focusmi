import axios from 'axios';
import React, { useEffect, useState } from 'react'
import { Link, useParams } from 'react-router-dom';
import CourseRating from './CourseRating';
import { FiEdit,FiPlus,FiXSquare } from 'react-icons/fi';
import EditLevelPopup from './EditLevelPopup';
import LevelContentEditor from './LevelContentEditor';



const ViewCourse =() => {
    const { courseID } = useParams();
    let userdata = window.localStorage.getItem('user');
    const [user, setUser] = useState(JSON.parse(userdata));
    const [courseData, setcourseData] = useState([]);
    const [levelData, setLevelData] = useState([]);
    const [isEditing, setIsEditing] = useState(false);
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [levelToEdit, setLevelToEdit] = useState(null);



    const requestData = () => {
        axios.request({
          headers: {
            authorization: `Bearer ${user.token}`
          },
          method: "GET",
          url: `http://localhost:3001/api/get-course/${courseID}`
        }).then(response => {
        //   console.log(response.data)
          setcourseData(response.data);
        //   console.log(courseData);      
        });
        
      };
     
        useEffect(()=>{
          requestData(); 
        },[])


        const requestLevel = () => {
          axios.request({
            headers: {
              authorization: `Bearer ${user.token}`
            },
            method: "GET",
            url: `http://localhost:3001/api/get-course-levels/${courseID}`
          }).then(response => {
            // console.log(response.data)
            setLevelData(response.data);
            // console.log(courseData);      
          });
          
        };
       
          useEffect(()=>{
            requestLevel();
          },[])
          




          const toggleEditing = () => {
            setIsEditing(!isEditing);
          };
      
          const openModal = (level) => {
            setLevelToEdit(level);
            setIsModalOpen(true);
          };
          
          const closeModal = () => {
            setIsModalOpen(false);
          };
          const handleSaveEdit=(updatedLevel)=>{
            console.log('Updated Level:', updatedLevel);
            axios.put('  ',updatedLevel)
            .then(res=>console.log(res.data))
            .catch(err=>console.log(err))
            setLevelToEdit(null);
            window.location.reload();
          }
          

  return (
    <div className="max-h-[80vh] overflow-y-scroll bg-gray-300 ">
          <div className='bg-grey-300 flex-col'>
            <div className=''>
                <section className="bg-gray-300">
                    <div className="grid max-w-screen p-4 mx-10 gap-4 grid-cols-12">
                        <div className="mr-auto place-self-center col-span-7">
                            <h1 className="text-black mb-0 font-extrabold  leading-none text-3xl ">{courseData.title}</h1>
                            <div className='flex mb-3'>
                                <span class="bg-green-100 text-green-800 text-xs font-sm mr-2 px-2.5 py-0.5 rounded dark:bg-green-900 dark:text-green-300 flex items-center">{courseData.subscription_type}</span>
                                <CourseRating rating= {4} />
                            </div>
                            <h6 className='text-black font-bold'>Description</h6>
                            <p className=" mb-4 font-light text-black   text-sm">{courseData.description}</p>
                            
                        </div>
                        <div className=" lg:col-span-5 lg:flex rounded-lg">
                            <img src={`http://localhost:3001/api/assets/image/mind-course/${courseData.image}`} alt="mockup" class="rounded-lg"/>
                        </div>                
                    </div>
                    
                </section>
                <section className="bg-gray-400" >
                  <div className="max-w-screen p-4 mx-10  grid-cols-12 flex-col ">
                    {levelData.map((level, level_id) => (
                      <div  className="bg-white p-2 my-2 flex gap-4 items-center" key={level_id}>
                        <div className='w-1/6 h-[30vh] bg-[#55a06a] flex items-center justify-center '>
                          <h4 className='text-white'> Level {level_id + 1}</h4>
                        </div>
                        <div className='w-4/6'>
                        
                          <p>Level Title: {level.level_name}</p>
                          <p>Level Description: {level.level_description}</p>
                          <p>Level Reference: {level.reference}</p>
                          <p>Level Created at: {level.createdAt}</p>
                          <p>Audio file:
                          <audio controls>
                            <source src={`http://localhost:3001/api/assets/image/mind-course/${level.content_location}`} type="audio/mpeg" />
                            Your browser does not support the audio element.
                          </audio>
                          </p>
                        </div>
                        <div className='w-1/6 h-[30vh] bg-white flex items-end justify-center '>
                          <button className='bg-[#55a06a] shadow-2xl flex items-center justify-center rounded-lg' onClick={() => openModal(level)}>
                          <h5 className='text-white flex items-center justify-center m-4'> <FiEdit/> Edit </h5>
                          </button>
                        </div>
                        
                      </div>
                    ))}

                    <div className="max-w-screen p-4 mx-10  grid-cols-12 flex-col ">
                      <div className="bg-white p-2 my-2 flex gap-4 items-center justify-center h-[20vh] w-full">
                        <button className='flex items-center justify-center w-full h-full p-1 border-dashed border-3 border-sky-500 gap-3'  onClick={toggleEditing}>  <FiPlus className='text-3xl '/>Add New Course Level</button>

                      </div>
                      {isEditing && (
                        <div className="mt-2">
                          <LevelContentEditor
                            courseID={courseID}
                            onSave={(content) => console.log(content)}
                          />
                        </div>
                      )}
                    </div>
                  </div>
                  
                </section>
                {courseData.course_status === 'drafted' ? (
                  <section className="bg-gray-300">
                    <div className="bottom-0 w-full flex items-center justify-center">
                      <Link to="/courses">
                      <button
                        className="bottom-0 left-0 mt-10 ml-10 mb-5 text-white px-4 py-2 rounded mr-2 bg-[#83DE70] hover:bg-[#55a06a]"
                      >
                        Save as Draft
                      </button>
                      </Link>
                      <button
                        // onClick={handleLaunch}
                        className="bottom-0 right-0 mt-10 mr-6 mb-5 text-white px-4 py-2 rounded bg-[#83DE70] hover:bg-[#55a06a]"
                      >
                        Launch the Course
                      </button>
                    </div>
                  </section>
                ) : null}
            </div>
            
        </div>
        {isModalOpen && (
          <div className="fixed top-0 left-0 w-full h-full flex items-center justify-center bg-gray-800 bg-opacity-50">
            <div className="bg-white p-4 rounded-lg">
              <div className='flex justify-center relative'>
                <h4>Edit Level</h4>
                  <button
                      className="text-white bg-red-600 hover:bg-red-300 p-2 rounded absolute top-0 right-0 "
                      onClick={closeModal}
                    >
                      <FiXSquare className='text-2xl'/>
                    </button>
              </div>
              {/* Your edit form goes here */}

              <EditLevelPopup 
              levelData={levelToEdit} 
              courseID={courseID}  
              onSave={handleSaveEdit}
              />
              {/* Include an "Update" button to save the changes */}
              
            </div>
          </div>
        )}
        
    </div>
  )
}

export default ViewCourse


