import React, { PureComponent } from 'react';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';

const data = [
  {
    name: 'Jan',
    2023: 4000,
    2022: 2400,
    amt: 2400,
  },
  {
    name: 'Feb',
    2023: 3000,
    2022: 1398,
    amt: 2210,
  },
  {
    name: 'Mar',
    2023: 2000,
    2022: 9800,
    amt: 2290,
  },
  {
    name: 'Apr',
    2023: 2780,
    2022: 3908,
    amt: 2000,
  },
  {
    name: 'May',
    2023: 1890,
    2022: 4800,
    amt: 2181,
  },
  {
    name: 'Jun',
    2023: 2390,
    2022: 3800,
    amt: 2500,
  },
  {
    name: 'Jul',
    2023: 3490,
    2022: 4300,
    amt: 2100,
  },
  
];

function Revenue() {
  return (
    <div style={{width:'600px',height:'300px'}}>
        <ResponsiveContainer width="100%" height="100%">
        <LineChart
          width={500}
          height={300}
          data={data}
          margin={{
            top: 5,
            right: 30,
            left: 20,
            bottom: 5,
          }}
        >
          <CartesianGrid strokeDasharray="3 3" />
          <XAxis dataKey="name" />
          <YAxis />
          <Tooltip />
          <Legend />
          <Line type="monotone" dataKey="2023" stroke="#8884d8" activeDot={{ r: 8 }} />
          <Line type="monotone" dataKey="2022" stroke="#82ca9d" />
        </LineChart>
      </ResponsiveContainer>
    </div>
  )
}

export default Revenue