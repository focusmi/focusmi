'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('course_user', {
      course_id: {
        type: Sequelize.INTEGER,
        references:{
          model:'mindfulness_course',
          key:'course_id'
        }
      },
      user_id: {
        type: Sequelize.INTEGER,
        references:{
          model:'application_user',
          key:'user_id'
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
    await queryInterface.dropTable('course_user');
  }
};