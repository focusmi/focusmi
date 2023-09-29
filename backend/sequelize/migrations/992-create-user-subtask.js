'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('user_subtask', {
      user_id: {
        type: Sequelize.INTEGER,
        references:{
          model:'application_user',
          key:'user_id'
        }
      },
      stask_id: {
        type: Sequelize.INTEGER,
        references:{
          model:'sub_task',
          key:'stask_id'
        }
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
    await queryInterface.dropTable('user_task');
  }
};