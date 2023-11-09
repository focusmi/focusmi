import React from 'react';
import DashboardStatus from './DashboardStatus'
import DashboardSalesChart from './DashboardSalesChart';
import DashboardUsageChart from './DashboardUsageChart';
import UsersTable from '../counsellors/UsersTable';
import Users from './Users';
import Revenue from './Revenue';
import { GiReceiveMoney,GiPayMoney} from "react-icons/gi";


import { BarChart, Bar } from "recharts";
import Income from './Income';

const usersData = [
  { id: 1, name: 'John Doe', nic: '123456789X', contact: '1234567890', email: 'john@example.com' },
  { id: 2, name: 'Jane Smith', nic: '987654321Y', contact: '9876543210', email: 'jane@example.com' },
  { id: 2, name: 'Jane Smith', nic: '987654321Y', contact: '9876543210', email: 'jane@example.com' },  
  { id: 2, name: 'Jane Smith', nic: '987654321Y', contact: '9876543210', email: 'jane@example.com' },
  { id: 1, name: 'John Doe', nic: '123456789X', contact: '1234567890', email: 'john@example.com' },
  { id: 2, name: 'Jane Smith', nic: '987654321Y', contact: '9876543210', email: 'jane@example.com' },
  { id: 2, name: 'Jane Smith', nic: '987654321Y', contact: '9876543210', email: 'jane@example.com' },
  { id: 2, name: 'Jane Smith', nic: '987654321Y', contact: '9876543210', email: 'jane@example.com' },  
  { id: 2, name: 'Jane Smith', nic: '987654321Y', contact: '9876543210', email: 'jane@example.com' },
  { id: 1, name: 'John Doe', nic: '123456789X', contact: '1234567890', email: 'john@example.com' },
  { id: 2, name: 'Jane Smith', nic: '987654321Y', contact: '9876543210', email: 'jane@example.com' },
];




function Dashboard() {
  return (
    <div className='max-h-[80vh] overflow-y-scroll'>
    <div className='flex flex-col ' >      
      <DashboardStatus/>         
    </div>
    <div className='flex flex-col-1 gap-4 m-8'>
      <div className='w-1/2 flex flex-col items-center shadow-lg rounded-md'>
      <h1 className='font-semibold text-[#55a06a]'> Revenue </h1>
      <Revenue/>
      </div>


      <div className='w-1/3 flex flex-col items-center gap-4 rounded-md'>
        <div className='w-full h-1/2 flex flex-col justify-center items-center shadow-lg rounded-md'>
          <div className='flex'>
            <h1  className='font-semibold text-[#55a06a]'>
              Income-{new Date().toLocaleString("en-US", { month: "long" })}
            </h1>
          </div>
          <div>
            <Income fill="#4dc26c"/>
          </div>
          <div>
            <h1 className='flex items-center gap-4 text-[#4dc26c] text-[40px] font-semibold'><GiReceiveMoney/> $56,788</h1>
          </div>
        </div>
        <div className='w-full h-1/2 flex flex-col justify-center items-center shadow-lg rounded-md'>
          <div className='flex'>
            <h1  className='font-semibold text-[#55a06a]'>
              Expenses-{new Date().toLocaleString("en-US", { month: "long" })}
            </h1>
          </div>
          <div>
            <Income fill="#e65555"/>
          </div>
          <div>
            <h1 className='flex gap-4 text-[#e65555] text-[40px] font-semibold'><GiPayMoney className='mt-3'/> $40,508</h1>
          </div>
        </div>
      
      </div>
      
      
      
      <div className='w-1/3 space-y-auto'>
        <div className=' w-full  shadow-lg rounded-md flex flex-col items-center'>
        <h1 className='font-semibold text-[#55a06a]'> Task Planner Usage</h1> 
        <DashboardUsageChart/>
        </div>
        <div className=' w-full  shadow-lg rounded-md flex flex-col items-center '>
        <h1 className='font-semibold text-[#55a06a]'> Course Usage</h1> 
        <DashboardUsageChart/>
        </div>
      </div>
    </div>
    <div>
      <Users users={usersData} />
    </div>
    </div>
  )
}

export default Dashboard
