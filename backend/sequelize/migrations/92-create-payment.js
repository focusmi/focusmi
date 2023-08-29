'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('payment', {
      payment_id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      user_id: {
        type: Sequelize.INTEGER,
        references:{
          model:'application_user',
          key:'user_id'          
        }
      },
      payment_status: {
        type: Sequelize.TEXT
      },
      amount: {
        type: Sequelize.REAL
      },
      complete_date: {
        type: Sequelize.DATE
      },
      complete_time: {
        type: Sequelize.TIME
      },
      create_time: {
        type: Sequelize.TIME
      },
      created_at: {
        type: Sequelize.DATE
      },
      updated_at: {
        type: Sequelize.DATE
      }
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('payment');
  }
};