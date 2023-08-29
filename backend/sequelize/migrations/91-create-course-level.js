'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('course_level', {
      level_id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      course_id: {
        type: Sequelize.INTEGER,
        references:{
          model:'mindfulness_course',
          key:'course_id'
        }
      },
      level_name: {
        type: Sequelize.TEXT
      },
      level_description: {
        type: Sequelize.TEXT
      },
      reference: {
        type: Sequelize.TEXT
      },
      media_type: {
        type: Sequelize.TEXT
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
    await queryInterface.dropTable('course_level');
  }
};