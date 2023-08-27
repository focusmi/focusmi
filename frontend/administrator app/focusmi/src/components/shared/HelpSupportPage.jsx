// HelpSupportPage.js
import React from 'react';
import FAQSection from './FAQSection';
import ContactSection from './ContactSection';

const HelpSupportPage = () => {
  return (
    <div className="bg-gray-100 max-h-[50vh] p-8">
      <h1 className="text-3xl font-extrabold text-[#55a06a] mb-4 flex flex-col items-center">Help and Support</h1>
      
      <div className="grid grid-rows-2 gap-4">
        {/* FAQs Card */}
        <div className="bg-white p-6 rounded-2xl shadow">
          <FAQSection />
        </div>
        
        {/* Support Card */}
        <div className="bg-white p-6 rounded-2xl h-[200px] shadow mb-10">
          <ContactSection />
        </div>
      </div>
    </div>
  );
};

export default HelpSupportPage;
