import { extend } from "jquery"
import React, { Component, useEffect, useState,Link } from "react"
import "../../styles/index.css"
import Administrative_User from "../../models/administrative_user";
import { useNavigate } from "react-router-dom";
import axios from 'axios';
import { FiLock,FiMail} from "react-icons/fi";
import logo from '../../Assets/logo.png';


export default function LoginPage(props){
       
        let navigate = useNavigate();
        const initialUserState = {
            email:"",
            id:"",
            password:"",
            user_name:""
        }
        
        let type=0
        
        const [user, setUser] = useState(initialUserState);
       
        const [response,setRes] =useState(0)
        
        const handleInputChange = event =>{
            const {name, value }= event.target;
            setUser({...user, [name]: value})
           
        }

        const login=(event) =>{
                event.preventDefault();
                axios.post("http://localhost:3001/api/admin-signin",{user:{

                        email:user.email,
                        password:user.password
                    }}
                    ,
                     {
                        headers: { "Content-Type": "application/json" },
                        withCredentials: false,
                    }
                ).then((result)=>{
                    if(result!=null){
                        const user={
                                
                                "user_id":(result.data[0]).user_id,
                                "token":(result.data[0]).token,
                                "email":(result.data[0]).email,
                                "username":(result.data[0]).username,
                        }
                    
                        props.login(JSON.stringify(result.data[0]));
                        console.log(JSON.stringify(result.data[0]))
                        window.localStorage.setItem('user',JSON.stringify(user));
                        console.log("User- "+ window.localStorage.setItem('user',JSON.stringify(user)))
                   }
                      
                    
                    navigate('/mantee')
                    
                }).catch(result=>{
                    setRes(result.response.data.type)
                    console.log("Promise error catch")
                    navigate('/login')
                     
                })   
        
        }
    
        return (
            <div className='bg-neutral-500 w-full h-screen  flex justify-center items-center text-white'>
                        <div className='bg-gradient-to-r from-[#55a06a] to-neutral-300 shadow-2xl w-1/2 h-3/4 mx-auto  rounded-2xl p-4 '>
                        <h3 className='flex justify-center' >Welcome back to</h3>
                        <div> <img src={logo} alt="focusMi" className='h-[30px] w-auto mx-auto' /> </div>
                        
                        <h2 className='text-[30px] font-semibold text-center uppercase mt-4'>Login</h2>


                        <div className='flex flex-col justify-center items-center bg-[#55a06a]'>
                            {response!=0?"Wrong username or password":''}
                        </div> 
                <div className='flex flex-col justify-center items-center'>
                <form>
                    <div className='w-[400px] mx-10 my-5 flex flex-col '>
                        <label for="exampleInputEmail1" className=' pb-1 flex flex-row gap-3 '><FiMail size={20}/><span>Email</span> </label>
                        <input className='border-b border-white  leading-4 focus:outline-none focus:bg-transparent bg-transparent active:outline-none '
                            type="email"
                            name="email"
                            id="exampleInputEmail1"
                            value={user.email}
                            onChange={handleInputChange}
                        />
                    </div>
                    <div className='w-[400px] mx-10 flex flex-col'>
                        <label className='pb-1 flex flex-row gap-3'><FiLock size={20}/><span>Password</span> </label>
                        <input className='border-b border-white  leading-4 focus:outline-none focus:bg-transparent bg-transparent active:outline-none' 
                        type="password"
                        name="password"
                        id="exampleInputPassword1"
                        value={user.password}
                        onChange={handleInputChange}
                        />
                    </div>

                    <div className=' w-[400px] mx-10 my-5 flex flex-col items-center   m-4'>                        
                        <button type="submit" className='font-bold w-full h-[50px] rounded-full bg-[#55a06a] hover:bg-neutral-200 uppercase '  onClick={login}>Login</button>   
                    </div>
                </form>
                </div>
                <div className='flex justify-center '>
                    Terms of use | Privacy Policy
                </div>
                </div>
            </div>
            

        );
    
}
