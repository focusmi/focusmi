import React,{useState} from 'react'
import { FiHome,FiAward,FiUser,FiFile,FiSun,FiChevronDown,FiMenu,FiBell,FiMessageSquare} from "react-icons/fi";
import admin1 from '../Assets/admin.jpg';
import {Link} from 'react-router-dom';


const Header = () => {
  const [nav ,setNav] = useState (false)

  const handleNav = () => {
      setNav(!nav)

  }
  return (
    <header className="h-[100px] text-white">
      <div className={nav ? 'flex justify-between items-center h-[100px]  mx-auto px-4 text-white bg-[#83DE70]' : 'flex justify-between items-center h-[100px]  mx-auto px-4 text-white bg-[#80DE70] ml-[150px]'}>
        
        <div  className='block p-10 h-30'>
          <FiMenu size={30} onClick={handleNav}/>             
        </div>

        <h1 className='w-full text-3xl font-bold '>FocusMi</h1>
        <ul className='hidden md:flex'>
            <li className='p-2 my-auto'><FiBell size={30}/></li>
            <li className='p-2 my-auto'><FiMessageSquare size={30}/></li>
            <li className='p-4 my-auto'>Y.Nimantha</li>
            <li className='w-[80px] h-[80px]  rounded-full mx-4 my-auto'><img src={admin1} alt='Profile  img' className='w-[80px] h-[80px] rounded-full'/></li>
            <li className=' my-auto'><FiChevronDown size={30} className='mr-4'/></li>
        </ul>

        <div className={!nav ? 'fixed  left-0 top-0 w-[250px] h-full  bg-[#83DE70] ease-in-out duration-300' : 'fixed left-[-100%]'}>
            <div  className='h-[100px] flex items-center justify-center'>
              <FiMenu size={30} onClick={handleNav}/>
            </div>
            
            <ul className='mt-10 p-4'>
                <li className='p-4 flex'><FiHome size={30} className='mr-4'/> <Link to={"/dashboard"}>Dashboard</Link></li>
                <li className='p-4 flex'><FiUser size={30} className='mr-4'/><Link to={"/counsellors"}>Counsellors</Link></li>
                <li className='p-4 flex'><FiFile size={30} className='mr-4'/>Reports</li>
                <li className='p-4 flex'><FiAward size={30} className='mr-4'/>Courses</li>
                <li className='p-4 flex'><FiSun size={30} className='mr-4'/>Daily Tips</li>
            </ul>
        </div>
      </div>



      {/* <div className="container mx-auto p-4">
        <h1 className="text-2xl font-bold">FocusMi</h1>
        <nav className="mt-4 ">
          <ul className="flex space-x-4">
            <li><a href="#" className="hover:text-gray-200">Home</a></li>
            <li><a href="#" className="hover:text-gray-200">About</a></li>
            <li><a href="#" className="hover:text-gray-200">Services</a></li>
            <li><a href="#" className="hover:text-gray-200">Contact</a></li>
          </ul>
        </nav>
      </div> */}
    </header>
  );
};

export default Header;


// const Header = () => {
//   return (
//     <header className='w-screen h-fit bg-gray-800'>
//         <h1 className='p text-4xl font-poppins font-bold text-green-600 underline-offset-2 bg-gray-800 py-4 px-4'>Groceries List</h1>
        
//     </header>
//   )
// }

// export default Header