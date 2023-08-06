'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('task_plan', {
      plan_id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      group_id: {
        type: Sequelize.INTEGER,
        references:{
          model:'task_group',
          key:'group_id'
        }
      },
      plan_name: {
        type: Sequelize.TEXT
      },
      location: {
        type: Sequelize.TEXT
      },
      scheduled_date: {
        type: Sequelize.DATE
      },
      scheduled_time: {
        type: Sequelize.TIME
      },
      schdule_type: {
        type: Sequelize.TEXT
      },
      reminder_status: {
        type: Sequelize.TEXT
      },
      user_id: {
        type: Sequelize.INTEGER
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
    await queryInterface.dropTable('task_plan');
  }
};