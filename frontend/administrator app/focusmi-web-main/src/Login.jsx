import React, { useState } from 'react';
import logo from './Assets/logo.png';
import { FiMail,FiLock } from 'react-icons/fi';
import { Link,useNavigate } from 'react-router-dom';
import Footer from './dummy/Footer';



function Login() {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
  });

  // Function to handle form field changes
  const handleInputChange = (event) => {
    const { name, value } = event.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  // Function to handle form submission
  const handleSubmit = (event) => {
    event.preventDefault();
    console.log('Form data submitted:', formData);
    // You can perform further actions here, like sending data to a server
  };
    let navigate = useNavigate(); 
    const routeChange = () =>{ 
      let path = `dashboard`; 
      navigate(path);
    }
  return (
    <>
    <div className='bg-neutral-500 w-full h-screen  flex justify-center items-center text-white'>

        <div className='bg-gradient-to-r from-[#55a06a] to-neutral-300 shadow-2xl w-1/2 h-3/4 mx-auto  rounded-2xl p-4 '>

          <h2 className='flex justify-center mt-2 ' >Welcome back to</h2>
          <div> <img src={logo} alt="focusMi" className='h-[30px] w-auto mx-auto' /> </div>

          <h1 className='text-[30px] font-semibold text-center m-5 uppercase'>Login</h1>

          <div className='flex flex-col justify-center items-center'>
            <form onSubmit={handleSubmit}>
            <div className='w-[400px] mx-10 my-5 flex flex-col '>
                <label className=' pb-1 flex flex-row gap-3 '><FiMail size={20}/><span>Email</span> </label>
                <input className='border-b border-white  leading-4 focus:outline-none focus:bg-transparent bg-transparent active:outline-none '
                    type="email"
                    name="email"
                    value={formData.email}
                    onChange={handleInputChange}
                />
            </div>
            <div className='w-[400px] mx-10 flex flex-col'>
                <label className='pb-1 flex flex-row gap-3'><FiLock size={20}/><span>Password</span> </label>
                <input className='border-b border-white  leading-4 focus:outline-none focus:bg-transparent bg-transparent active:outline-none' 
                type="password"
                name="password"
                value={formData.password}
                onChange={handleInputChange}
                />
            </div>
            <div className=' w-[400px] mx-10 my-5 flex flex-col items-center   m-4'>
              
              <button type="submit" className='font-bold w-full h-[50px] rounded-full bg-[#55a06a] hover:bg-neutral-200 uppercase mt-10' onClick={routeChange}>Login</button>
              
              <Link to={'/forgotpw'}><span className='text-blue-900 text-sm underline p-4'>Forgot password ?</span></Link>
              
            </div>
            
            </form>
          </div>
          <div className='flex justify-center mt-5'>
            Terms of use | Privacy Policy
          </div>
          <div >{<Footer/>} </div>
        </div>
        
        
      </div> 
      
      </>
            
        
  
  )
}

export default Login