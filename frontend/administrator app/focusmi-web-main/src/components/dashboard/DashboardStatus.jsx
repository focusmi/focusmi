import React from 'react';
import DashboardSalesChart from './DashboardSalesChart';
import { FiUsers } from 'react-icons/fi';
import {PiUsersThreeBold} from 'react-icons/pi';
import { MdInstallMobile, MdDataUsage} from "react-icons/md";
import { TbUsersPlus} from "react-icons/tb";


function DashboardStatus() {
  return (
    <div className='flex gap-4  mx-auto  '>
        <BoxWrapper>
          <div className='flex flex-row gap-4 mx-auto'> 
            <div className='flex items-center text-[#55a06a]'><PiUsersThreeBold size={30}/></div>
            <div >
              <h1 className='text-xs'>Total Active users</h1>
              <h1 className='text-s font-bold flex justify-center'>18,892</h1>
            </div>
          </div>
        </BoxWrapper>
        <BoxWrapper>
            <div className='flex flex-row gap-4 mx-auto'> 
              <div className='flex items-center text-[#55a06a]'><MdInstallMobile size={30}/></div>
              <div >
                <h1 className='text-xs'>Total Installed</h1>
                <h1 className='text-s font-bold flex justify-center'>29,892</h1>
              </div>
            </div>
        </BoxWrapper>
        <BoxWrapper>
            <div className='flex flex-row gap-4 mx-auto'> 
              <div className='flex items-center text-[#55a06a]'><TbUsersPlus size={30}/></div>
              <div >
                <h1 className='text-xs'>New Users</h1>
                <h1 className='text-s font-bold flex justify-center'>1,892</h1>
              </div>
            </div>
        </BoxWrapper>
        <BoxWrapper>
            <div className='flex flex-row gap-4 mx-auto'> 
              <div className='flex items-center text-[#55a06a]'>< MdDataUsage size={30}/></div>
              <div >
                <h1 className='text-xs'>App Usage</h1>
                <h1 className='text-s font-bold flex justify-center'>69%</h1>
              </div>
            </div>
        </BoxWrapper>
        
    </div>
  )
}

export default DashboardStatus

function BoxWrapper({children}){
    return <div className='bg-white shadow-xl flex justify-between items-center rounded-md p-4 w-[250px] m-4 h-[100px] '>{children} </div>
}
