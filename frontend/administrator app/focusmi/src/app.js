import React, { Component, useState } from "react";
import NavBar from "./components/shared/Navbar";
import { BrowserRouter, Route, Routes } from 'react-router-dom';
import LoginPage from "./features/screens/login";
import Layout from "./components/shared/Layout";
import Dashboard from "./components/dashboard/Dashboard"
import Counsellors from './components/counsellors/Counsellors';
import AddCounselors from './components/counsellors/AddCounsellors';
import CoursesPage from './components/Courses/CoursesPage';
import AddCoursePage from './components/Courses/AddCoursePage';
import CreateCoursePage from './components/Courses/CreateCoursePage';
import LevelContentEditor from './components/Courses/LevelContentEditor';
import CreateTips from './components/DailyTips/CreateTips';
import DailyTipsMain from './components/DailyTips/DailyTipsMain';


import Reports from './components/Reports/Reports';
import IncomeStatement from './components/Reports/IncomeStatement';
import HelpSupportPage from './components/shared/HelpSupportPage';


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
                    {/* <Route exact path="/" element={<NavBar user={user}/>} /> */}
                    <Route path="/" element={<Layout user={user} />}>
                        <Route path="dashboard" element={<Dashboard/>}/>
                        <Route path="counsellors" element={<Counsellors/>}/>
                        <Route path="add-counsellors" element={<AddCounselors/>}/>
                        <Route path="courses" element={<CoursesPage/>}/>
                        <Route path="add-courses" element={<AddCoursePage/>}/>
                        <Route path="create-courses" element={<CreateCoursePage/>}/>
                        <Route path="edit-levels" element={<LevelContentEditor/>}/>
                        <Route path="daily_tips" element={<DailyTipsMain/>}/>
                        <Route path="create-tips" element={<CreateTips/>}/>
                        <Route path="support" element={<HelpSupportPage/>}/>                                
                        <Route path="reports" element={<Reports/>}/>
                        <Route path="income-statement" element={<IncomeStatement/>}/>
                    </Route>
                                       
                        
                
                    <Route exact path="/login"  element = {<LoginPage login={login}/>} />
                    </Routes>
               </BrowserRouter>
            </React.Fragment>
        );
}