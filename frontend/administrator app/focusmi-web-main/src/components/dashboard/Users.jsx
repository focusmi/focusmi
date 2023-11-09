import React from 'react';

const Users = ({ users }) => {
  return (
    <div className="bg-white rounded-md shadow-md p-4 flex flex-col items-center">
      <h2 className="text-xl font-semibold mb-4 text-[#55a06a]">Users</h2>
      <table className='w-[2/3] shadow-lg'>
        <thead>
          <tr>
            <th className="py-2 px-4 bg-gray-200 border">User ID</th>
            <th className="py-2 px-4 bg-gray-200 border">Name</th>
            <th className="py-2 px-4 bg-gray-200 border">NIC No</th>
            <th className="py-2 px-4 bg-gray-200 border">Contact No</th>
            <th className="py-2 px-4 bg-gray-200 border">Email</th>
          </tr>
        </thead>
        <tbody>
          {users.map((user) => (
            <tr key={user.id} className="border">
              <td className="py-2 px-4">{user.id}</td>
              <td className="py-2 px-4">{user.name}</td>
              <td className="py-2 px-4">{user.nic}</td>
              <td className="py-2 px-4">{user.contact}</td>
              <td className="py-2 px-4">{user.email}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default Users;
