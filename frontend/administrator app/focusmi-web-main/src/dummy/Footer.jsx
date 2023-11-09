import React from 'react'

const Footer = () => {
    const today = new Date();
  return (
    <footer className=' text-white py-4 mb-0'>
      <p className=' container mx-auto text-center mt-auto'>Copyright &copy; {today.getFullYear()}</p>
    </footer>
  )
}

export default Footer
