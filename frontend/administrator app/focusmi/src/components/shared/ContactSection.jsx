// ContactSection.js
import React from 'react';

const ContactSection = () => {
  return (
    <div>
      <h2 className="text-xl font-semibold mb-4">Contact Information</h2>
      <p>If you need further assistance, you can contact our support team:</p>
      <ul className="list-disc pl-6 space-y-2 mt-2">
        <li>Email: <a href="mailto:focusmi@example.com" className="text-blue-500 hover:underline">focusmi@gmail.com</a></li>
        <li>Phone: 011-456-7890</li>
      </ul>
    </div>
  );
};

export default ContactSection;

