/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.addColumn('timer','user_id',{
          type: Sequelize.INTEGER,
          allowNull: true,
          references:{
            model:'application_user',
            key:'user_id'
          }
        },
    );
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.removeColumn('timer','user_id');
  }
};