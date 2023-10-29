/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.addColumn('timer','rturns',{
          type: Sequelize.INTEGER,
          allowNull: true,
          
        },
    );
    
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.removeColumn('timer','rturns');
   
  }
};