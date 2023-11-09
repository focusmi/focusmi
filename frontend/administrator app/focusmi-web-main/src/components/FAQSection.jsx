// FAQSection.js
import React from 'react';

const FAQSection = () => {
  const faqs = [
    {
      question: 'How do I reset my password?',
      answer: 'You can reset your password by clicking on the "Forgot Password" link on the login page and following the instructions.',
    },
    {
      question: 'How do I update my account information?',
      answer: 'To update your account information, go to the "Settings" page and modify your details.',
    },
     
    {
        question: 'How can I change my email address?',
        answer: 'You can change your email address by navigating to the "Account" section and updating your email settings.',
      },
    // Add more FAQ items
  ];

  return (
    <div>
      <h2 className="text-xl font-semibold mb-4">Frequently Asked Questions</h2>
      <ul className="list-disc pl-6 space-y-2">
        {faqs.map((faq, index) => (
          <li key={index}>
            <p className="font-semibold">{faq.question}</p>
            <p>{faq.answer}</p>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default FAQSection;

