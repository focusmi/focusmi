const daily_tip = require('../models/daily_tip');

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.addColumn('daily_tip','created_at',{
          type: Sequelize.DATE,
          allowNull: true,
          
        },
    );
     await queryInterface.addColumn('daily_tip','updated_at',{
          type: Sequelize.DATE,
          allowNull: true,
        },
    );
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.removeColumn('daily_tip','reminder_time');
    await queryInterface.removeColumn('daily_tip','reminder_date');
  }
};