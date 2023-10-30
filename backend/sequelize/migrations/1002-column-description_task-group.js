const daily_tip = require('../models/daily_tip');

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.addColumn('task_group','description',{
          type: Sequelize.TEXT,
          allowNull: true,
          
        },
    );
     
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.removeColumn('daily_tip','reminder_time');
    
  }
};