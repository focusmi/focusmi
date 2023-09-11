'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class chat extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      this.belongsTo(models.task_group,{foreignKey:'group_id'})

    }
  }
  chat.init({
    chat_id:{
      type:DataTypes.INTEGER,
      primaryKey:true
      ,autoIncrement:true
    } ,
    group_id: DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'chat',
    underscored:true,
    freezeTableName:true,
  });
  return chat;
};