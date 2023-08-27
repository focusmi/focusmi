import React, { useState } from 'react';
import Header from './Header';
import {Outlet} from 'react-router-dom';
import Sidebar from './Sidebar';


function Layout() {
  
  return (
    <div className='flex flex-row h-screen w-screen overflow-hidden'>
        <div>
            <Sidebar/>
        </div>
        
        <div className='flex-1'><Header/>
            <div>ggftgdh</div>
        </div>
        
    </div>
    
  )
}

export default Layout