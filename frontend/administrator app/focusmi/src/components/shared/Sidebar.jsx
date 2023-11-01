import React from 'react';
import { FiLogOut} from "react-icons/fi";
import { DASHBOARD_SIDEBAR_LINKS, DASHBOARD_SIDEBAR_LINKS_BOTTOM } from '../lib/consts/navigation';
import { Link , useLocation} from 'react-router-dom';
import {classnames} from 'tailwindcss-classnames';
import { useNavigate } from 'react-router-dom';


const linkClasses = 'flex items-center gap-2 font-light px-5 py-3  hover:bg-neutral-300 hover:no-underline active:bg-neutral-50 rounded-5m text-base w-[250px]'


function Sidebar() {
  let navigate = useNavigate();
  const handleLogout = () => {
    // Clear user session or authentication tokens
    window.localStorage.removeItem('user'); // Remove user data from local storage

    // Navigate to the login page
    navigate('/');
  };
  return (
    <div className='flex flex-col  left-0 top-0 w-[252px] h-full ease-in-out duration-300 bg-[#55a06a] border-r-2'>
      <div className='flex-1 mx-auto mt-[100px] w-[250px] '>
        {DASHBOARD_SIDEBAR_LINKS.map((item) => (
          <SidebarLink key={item.key} item={item}/>
        ))}
      </div>
      <div className='flex flex-col gap-0.5 pt-2 border-t border-[#606264] pb-4'>
        {DASHBOARD_SIDEBAR_LINKS_BOTTOM.map((item) => (
          <SidebarLink key={item.key} item={item}/>
        ))}
        <div onClick={handleLogout}
          className={classnames('text-red-600 cursor-pointer',
          linkClasses
          )}>
          <span className='text-xl'><FiLogOut className='stroke-red-600'/></span>
          Logout
        </div>


      </div>
    </div>

    
  )
}


function SidebarLink({item}){
  const {pathname} = useLocation  ()
  return (
    <Link  to={item.path} className={classnames(pathname === item.path ? 'bg-neutral-300 text-white no-underline' : 'text-white no-underline',linkClasses) }>
    <span className='text-xl '>{item.icon}</span>
    {item.lable}

    </Link>
  )
}
export default Sidebar;