/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.addColumn('administrative_user','image',{
          type: Sequelize.STRING,
          allowNull: true,
          
        },
    );
     await queryInterface.addColumn('administrative_user','nic',{
          type: Sequelize.STRING,
          allowNull: true,
        },
    );
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.removeColumn('administrative_user','image');
    await queryInterface.removeColumn('administrative_user','nic');
  }
};