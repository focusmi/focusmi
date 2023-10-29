'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('user_chat', {
     
      user_id: {
        type: Sequelize.INTEGER
      },
      chat_id: {
        type: Sequelize.INTEGER
      },
      message_text: {
        type: Sequelize.TEXT
      },
      message_type: {
        type: Sequelize.TEXT
      },
      image: {
        type: Sequelize.TEXT
      },
      create_time: {
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
    await queryInterface.dropTable('user_chat');
  }
};