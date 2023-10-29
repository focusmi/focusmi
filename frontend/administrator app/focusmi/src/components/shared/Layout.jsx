import React, { useState } from 'react';
import Header from './Header';
import {Outlet} from 'react-router-dom';
import Sidebar from './Sidebar';


function Layout(props) {
  let userdata = window.localStorage.getItem('user')
  const [user, setUser] = useState(JSON.parse(userdata));
  
  return (
    <div className='flex flex-column h-screen w-screen overflow-hidden'>
      <div><Header/></div>
      <div className='flex flex-row h-screen w-screen overflow-hidden '>
        <div> <Sidebar/></div>
        <div className="h-screen overflow-hidden w-screen">{<Outlet/>}</div>
      </div>
    </div>   
    
  )
}

export default Layout




        // <div>
        //     <Sidebar/>
        // </div>
        // <div className='flex-1'><Header/>
          
        //     {/* <div>{user?user.username:'FocusMi'}</div> */}
        //     <div className="overflow-y-auto">{<Outlet/>}</div>
        // </div>
   