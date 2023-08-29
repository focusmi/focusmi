'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.addColumn('task','task_name',{
          type: Sequelize.STRING,
          allowNull: true,
        },
    );
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.removeColumn('task','task_name');
  }
};