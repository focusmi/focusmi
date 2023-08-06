'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.addColumn('task_group','member_count',{
          type: Sequelize.INTEGER,
          allowNull: true,
        },
    );
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.removeColumn('task_group','member_count');
  }
};