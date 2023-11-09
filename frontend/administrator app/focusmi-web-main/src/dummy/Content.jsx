import { useState } from 'react';
import {FaTrashAlt} from 'react-icons/fa';

const Content = () => {
    const [items,setItems] = useState ([
        {
            id: 1,
            checked: true,
            item: "One half pound of cocoa covered Almonds unsalted"
        },
        {
            id: 2,
            checked: false,
            item: "Item 2"
        },
        {
            id: 3,
            checked: false,
            item: "Item 3"
        }
    ]);

    const handleCheck = (id) =>{
        const listItems = items.map((item)=> item.id === id ? {...item,checked: !item.checked}: item);
        setItems(listItems);
        // console.log(`key:${id}`)
    } 
  return (
    <main>
        <ul className='list-disc ml-4'>
            {items.map((item)=>(
                <li className='bg-slate-600 my-6' key={item.id}>
                    <input 
                        type="checkbox"
                        onChange={()=>{handleCheck(item.id)}}
                        checked= {item.checked}/>
                    <lable className='bg-slate-600'>{item.item}</lable>
                    <FaTrashAlt 
                        role='Button' 
                        tabIndex="0"
                    />
                </li>
            ))}
        </ul>
    </main>
  )
}

export default Content





// const Content = () => {
//     const [name, setName] =  useState('Dasuni');
//     const [count,setCount] = useState (0);
//     const handleNameChange =()=>{
//         const names=['Dasuni','Dewni','Pamudi'];
//         const int= Math.floor(Math.random()*3);
//         setName (names[int]);
//     };
// const handleClick =() => {
//     setCount(count+1)
//     console.log (count);
// }
// const handleClick1 =(name) => {
//     console.log (`${name} clicked it`);
// }
// const handleClick2 =(e) => {
//     console.log (e.target.innerText);
// }
//   return (
//     <main>
//         <p onDoubleClick={handleClick}>
//           hello {name}!
//         </p>
//         <button onClick={handleNameChange} className='bg-gradient-to-r from-purple-500 via-pink-500 to-red-500 hover:from-pink-500 hover:via-purple-500 hover:to-red-500 text-white font-semibold py-2 px-4 rounded-md shadow-lg hover:shadow-xl transition-all duration-300'>
//             Change Name
//         </button>
//         <button onClick={handleClick} className='bg-gradient-to-r from-purple-500 via-pink-500 to-red-500 hover:from-pink-500 hover:via-purple-500 hover:to-red-500 text-white font-semibold py-2 px-4 rounded-md shadow-lg hover:shadow-xl transition-all duration-300'>
//             Click here
//         </button>
//         <button onClick={()=>{handleClick1('Dasuni')}} className='bg-gradient-to-r from-purple-500 via-pink-500 to-red-500 hover:from-pink-500 hover:via-purple-500 hover:to-red-500 text-white font-semibold py-2 px-4 rounded-md shadow-lg hover:shadow-xl transition-all duration-300'>
//             Click here
//         </button>
//         <button onClick={(e)=>handleClick2(e)} className='bg-gradient-to-r from-purple-500 via-pink-500 to-red-500 hover:from-pink-500 hover:via-purple-500 hover:to-red-500 text-white font-semibold py-2 px-4 rounded-md shadow-lg hover:shadow-xl transition-all duration-300'>
//             Click here
//         </button>
//     </main>
//   )
// }

// export default Content