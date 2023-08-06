'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.addColumn('task_group','status',{
          type: Sequelize.STRING,
          allowNull: true,
          
        },
    );
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.removeColumn('task_group','status');
  }
};