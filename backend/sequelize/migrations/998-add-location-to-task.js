/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.addColumn('task','location',{
          type: Sequelize.STRING,
          allowNull: true,
          
        },
    );
    
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.removeColumn('task','location');
    
  }
};