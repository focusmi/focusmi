import React from 'react';
import Dashboard from './components/dashboard/Dashboard';
import Layout from './components/Shared/Layout';
import {
  BrowserRouter as Router,
  Routes,
  Route,
} from "react-router-dom";
import Counsellors from './components/counsellors/Counsellors';
import Login from './Login';
import AddCounselors from './components/counsellors/AddCounsellors';
import CoursesPage from './components/Courses/CoursesPage';
import AddCoursePage from './components/Courses/AddCoursePage';
import CreateCoursePage from './components/Courses/CreateCoursePage';
import LevelContentEditor from './components/Courses/LevelContentEditor';
import CreateTips from './components/DailyTips/CreateTips';
import DailyTipsMain from './components/DailyTips/DailyTipsMain';

// import EditTipPage from './components/DailyTips/EditTipPage';

// import PostedTips from './components/DailyTips/PostedTips';
// import DraftedTips from './components/DailyTips/DraftedTips';

import Reports from './components/Reports/Reports';
import IncomeStatement from './components/Reports/IncomeStatement';
import HelpSupportPage from './components/HelpSupportPage';


function App() {
  
  return (
    <Router>
      <Routes>
        
        <Route path="/" element={<Layout/>}>
          <Route path="login/dashboard" element={<Dashboard/>}/>
          <Route path="counsellors" element={<Counsellors/>}/>
          <Route path="add-counsellors" element={<AddCounselors/>}/>
          <Route path="courses" element={<CoursesPage/>}/>
          <Route path="add-courses" element={<AddCoursePage/>}/>
          <Route path="create-courses" element={<CreateCoursePage/>}/>

          <Route path="edit-levels" element={<LevelContentEditor/>}/>
          <Route path="daily-tips" element={<DailyTipsMain/>}/>
          <Route path="create-tips" element={<CreateTips/>}/>
          <Route path="support" element={<HelpSupportPage/>}/>

          
          
          

                   
          <Route path="reports" element={<Reports/>}/>
          <Route path="reports/income-statement" element={<IncomeStatement/>}/>



        </Route>
        <Route path="Login" element={<Login/>}/>
      </Routes>
    </Router>
  );
}

export default App;
