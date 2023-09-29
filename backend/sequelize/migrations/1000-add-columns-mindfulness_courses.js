/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.addColumn('mindfulness_course','course_status',{
          type: Sequelize.STRING,
          allowNull: true,
          
        },
    );
     await queryInterface.addColumn('mindfulness_course','subscription_type',{
          type: Sequelize.STRING,
          allowNull: true,
        },
    );
     await queryInterface.addColumn('mindfulness_course','course_type',{
          type: Sequelize.STRING,
          allowNull: true,
        },
    );
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.removeColumn('mindfulness_course','course_status');
    await queryInterface.removeColumn('mindfulness_course','subscription_type');
    await queryInterface.removeColumn('mindfulness_course','course_type');
  }
};