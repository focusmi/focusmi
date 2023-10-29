/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.addColumn('mindfulness_course','image',{
          type: Sequelize.STRING,
          allowNull: true,
          
        },
    );
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.removeColumn('mindfulness_course','image');
  }
};