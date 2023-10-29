/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.addColumn('user_chat','message_id',{
      
            allowNull:false,
            autoIncrement:true,
            primaryKey: true,
            type: Sequelize.INTEGER
          
          
        },
    );
    
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.removeColumn('user_chat','message_id');
    
  }
};