const daily_tip = require('../models/daily_tip');

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.addColumn('therapy_session','booking_status',{
          type: Sequelize.BOOLEAN,
          allowNull: true,
          
        },
    );
    await queryInterface.addColumn('appointment','complete',{
          type: Sequelize.BOOLEAN,
          allowNull: true,
          
        },
    );
     
  
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.removeColumn('daily_tip','reminder_time');
    await queryInterface.removeColumn('daily_tip','reminder_date');
  }
};