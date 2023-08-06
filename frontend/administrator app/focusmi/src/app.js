import React, { Component, useState } from "react";
import NavBar from "./components/Navbar";
import { BrowserRouter, Route, Routes } from 'react-router-dom';
import LoginPage from "./features/screens/login";



export default function App(){
    
        const [user, setUser] = React.useState(null);
        async function login(user = null){
            setUser(user)
        }

        async function logout(user = null){
            setUser(null)
        }

        return (
            <React.Fragment>
                <BrowserRouter>
                    <Routes>
                        <Route exact path="/login"  element = {<LoginPage login={login}/>} />
                        <Route exact path="/mantee" element={<NavBar user={user}/>} />
                    </Routes>
               </BrowserRouter>
            </React.Fragment>
        );
}