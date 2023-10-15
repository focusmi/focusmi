'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('therapy_session', {
      session_id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      user_id: {
        type: Sequelize.INTEGER,
        references:{
          model:'administrative_user',
          key:'user_id'
        }
      },
      fee: {
        type: Sequelize.REAL
      },
      day: {
        type: Sequelize.TEXT
      },
      session_time: {
        type: Sequelize.DATE
      },
      session_end_time: {
        type: Sequelize.TIME
      },
      created_at: {
        type: Sequelize.DATE
      },
      updated_at: {
        type: Sequelize.DATE
      },
      image:{
        type: Sequelize.TEXT
      } 
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('therapy_session');
  }
};