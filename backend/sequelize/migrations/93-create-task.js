'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('task', {
      task_id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      plan_id: {
        type: Sequelize.INTEGER,
        references:{
          model:'task_plan',
          key:'plan_id'
        }
      },
      timer_id: {
        type: Sequelize.INTEGER,
        references:{
          model:'timer',
          key:'timer_id'
        }
      },
     
      duration: {
        type: Sequelize.INTEGER
      },
      color: {
        type:Sequelize.TEXT
      },
      task_status: {
        type: Sequelize.TEXT
      },
      priority: {
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
    await queryInterface.dropTable('task');
  }
};