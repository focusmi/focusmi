/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.addColumn('administrative_user','title',{
          type: Sequelize.TEXT,
          allowNull: true,
        },
    );
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.removeColumn('administrative_user','title');
  }
};