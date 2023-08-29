'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('sub_task', {
      stask_id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      task_id: {
        type: Sequelize.INTEGER,
        references:{
          model:'task',
          key:'task_id'
        }
      },
      sub_priority: {
        type: Sequelize.TEXT
      },
      sub_label: {
        type: Sequelize.TEXT
      },
      sub_status: {
        type: Sequelize.TEXT
      },
      created_time: {
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
    await queryInterface.dropTable('sub_task');
  }
};