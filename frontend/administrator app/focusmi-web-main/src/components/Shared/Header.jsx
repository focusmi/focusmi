import React,{Fragment} from 'react';
import { FiSearch,FiBell,FiMessageSquare } from 'react-icons/fi';
import { Popover,Transition,Menu} from '@headlessui/react';
import classNames from 'classnames';
import { Navigate, useNavigate } from 'react-router-dom';

function Header() {
  const navigate = useNavigate();
  return (
    <div className='h-[100px] mx-auto px-4 bg-[#55a06a] text-white flex justify-between items-center'>
      {/* ********************************** */}

      <div className='relative flex pl-2 border rounded-sm bg-white text-[#55a06a]' >
        <FiSearch className='my-auto'/>
        <input type="text" placeholder='Search ...' className='text-sm  focus:outline-none active:outline-none  h-10 w-[300px] p-3'/>

      </div>
      <div className='flex itemes-center gap-2 mr-2 h-10'>

          <Popover className="relative">
            {({ open }) => (
              <>
                <Popover.Button className= {classNames(open && 'bg-slate-50',"p-2 rounded-sminline-flex items-center focus:outline-none hover:text-opacity-100 active:bg-[#eef2ed]")}>
                  <FiMessageSquare size={20}/>
                </Popover.Button>

                      <Transition
                          as={Fragment}
                          enter="transition ease-out duration-200"
                          enterFrom="opacity-0 translate-y-1"
                          enterTo="opacity-100 translate-y-0"
                          leave="transition ease-in duration-150"
                          leaveFrom="opacity-100 translate-y-0"
                          leaveTo="opacity-0 translate-y-1"
                  >
                <Popover.Panel className= "absolute right-0 z-10 mt-2.5 w-80">
                  <div className='bg-white rounded-sm shadow-md ring-1 ring-black ring-opacity-5 px-4 py-2.5 text-black'>
                    <strong className='font-medium'>Messages</strong>
                    <div className='mt-1 py-1 text-sm'>
                      This is messages panel.
                    </div>
                  </div>
                </Popover.Panel>
                </Transition>
              </>
            )}
          </Popover>

          <Popover className="relative">
            {({ open }) => (
              <>
                <Popover.Button className= {classNames(open && 'bg-slate-50',"p-2 rounded-sminline-flex items-center focus:outline-none hover:text-opacity-100 active:bg-[#eef2ed]")}>
                  <FiBell size={20}/>
                </Popover.Button>

                      <Transition
                          as={Fragment}
                          enter="transition ease-out duration-200"
                          enterFrom="opacity-0 translate-y-1"
                          enterTo="opacity-100 translate-y-0"
                          leave="transition ease-in duration-150"
                          leaveFrom="opacity-100 translate-y-0"
                          leaveTo="opacity-0 translate-y-1"
                  >
                <Popover.Panel className= "absolute right-0 z-10 mt-2.5 w-80">
                  <div className='bg-white rounded-sm shadow-md ring-1 ring-black text-black ring-opacity-5 px-4 py-2.5'>
                    <strong className='font-medium'>Notifications</strong>
                    <div className='mt-1 py-1 text-sm'>
                      This is Notifications panel.
                    </div>
                  </div>
                </Popover.Panel>
                </Transition>
              </>
            )}
          </Popover> 

          {/* ************Menu************ */}
          <Menu as="div" className="relative inline-block text-left">
        <div>
              <Menu.Button className=" ml-2 my-auto inline-flex rounded-full focus:outline-none focus:ring-2 focus:ring-slate-500">
                <span className='sr-only'>Open User Menu</span>

                <div className='h-10 w-10 rounded-full bg-slate-300 bg-cover bg-no-repeat bg-center' style={{backgroundImage: 'url("https://images.unsplash.com/photo-1580489944761-15a19d654956?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1361&q=80")'}}>
                  <span className='sr-only'>Silva</span>
                </div>
              </Menu.Button>
            </div>
            <Transition
              as={Fragment}
              enter="transition ease-out duration-100"
              enterFrom="transform opacity-0 scale-95"
              enterTo="transform opacity-100 scale-100"
              leave="transition ease-in duration-75"
              leaveFrom="transform opacity-100 scale-100"
              leaveTo="transform opacity-0 scale-95"
            >
              <Menu.Items className="absolute right-0 mt-2 w-56 origin-top-right divide-y divide-gray-100 rounded-sm bg-white shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none">
                <div className="px-1 py-1 ">
                  <Menu.Item>
                    {({ active }) => (
                      <button
                        className={`${
                          active ? 'bg-[#83DE70] text-white' : 'text-gray-900'
                        } group flex w-full items-center rounded-md px-2 py-2 text-sm`}

                        onClick={()=> Navigate('/profile')}
                      >            
                        Profile
                      </button>
                    )}
                  </Menu.Item>
                  <Menu.Item>
                    {({ active }) => (
                      <button
                        className={`${
                          active ? 'bg-[#83DE70] text-white' : 'text-gray-900'
                        } group flex w-full items-center rounded-md px-2 py-2 text-sm`}

                        onClick={()=> Navigate('/settings')}
                      >            
                        Settings
                      </button>
                    )}
                  </Menu.Item>
                  <Menu.Item>
                    {({ active }) => (
                      <button
                        className={`${
                          active ? 'bg-[#83DE70] text-white' : 'text-gray-900'
                        } group flex w-full items-center rounded-md px-2 py-2 text-sm`}

                        onClick={()=> Navigate('/profile')}
                      >            
                        Logout
                      </button>
                    )}
                  </Menu.Item>
              </div>
            </Menu.Items>
          </Transition>
        </Menu>
        
      </div>

      
    </div>
  )
}

export default Header
