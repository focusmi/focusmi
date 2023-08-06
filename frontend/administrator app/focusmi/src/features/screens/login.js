import { extend } from "jquery"
import React, { Component, useEffect, useState } from "react"
import "../../styles/index.css"
import Administrative_User from "../../models/administrative_user";
import { useNavigate } from "react-router-dom";
import axios from 'axios';

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
                   const user={
                     "user_id":(result.data[0]).user_id,
                     "token":(result.data[0]).token,
                     "email":(result.data[0]).email,
                     "username":(result.data[0]).username,
                   
                   }
                    props.login(JSON.stringify(result.data[0]));
                    window.localStorage.setItem('user',JSON.stringify(user));
                      
                    
                    navigate('/mantee')
                    
                }).catch(result=>{
                    setRes(result.response.data.type)
                    
                    navigate('/login')
                     
                })   
        
        }
    
        return (
            <div class="d-flex align-items-start flex-column" style={{height: "200px"}}>
                            <div class="error-text">
                                {response!=0?"Wrong username or password":''}
                            </div> 
                <form>
                    <section clas="mb-auto p-2">
                        <div class="form-group mb-auto p-2">
                            <label for="exampleInputEmail1">Email address</label>
                            <input type="email" class="form-control" name="email" id="exampleInputEmail1" value={user.email} onChange ={handleInputChange} placeholder="Enter email"/>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">Password</label>
                            <input type="password" class="form-control" name="password" id="exampleInputPassword1" value={user.password} onChange ={handleInputChange} placeholder="Password"/>
               
                        </div>
                    </section>
                    <section class="p-2">
                        <button type="submit" class="btn btn-primary" onClick={login}>Submit</button>
                    </section>
                </form>
            </div>
            

        );
    
}
