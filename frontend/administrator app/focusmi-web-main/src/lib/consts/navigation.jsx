import { FiHome,FiAward,FiUser,FiFile,FiSun, FiSettings,FiHelpCircle} from "react-icons/fi";


export const DASHBOARD_SIDEBAR_LINKS = [
    {
        key :'dashboard',
        lable : 'Dashboard',
        path : '/login/dashboard',
        icon: <FiHome/>
    },
    {
        key :'counsellors',
        lable : 'Counsellors',
        path : '/counsellors',
        icon: <FiUser/>
    },
    {
        key :'reports',
        lable : 'Reports',
        path : '/reports',
        icon: <FiFile/>
    },
    {
        key :'courses',
        lable : 'Courses',
        path : '/courses',
        icon: <FiAward/>
    },
    {
        key :'daily tips',
        lable : 'Daily Tips',
        path : '/daily-tips',
        icon: <FiSun/>
    },
]

export const DASHBOARD_SIDEBAR_LINKS_BOTTOM = [
    {
        key :'settings',
        lable : 'Settings',
        path : '/settings',
        icon: <FiSettings/>
    },
    {
        key :'support',
        lable : 'Help & Support',
        path : '/support',
        icon: <FiHelpCircle/>
    }
 
]