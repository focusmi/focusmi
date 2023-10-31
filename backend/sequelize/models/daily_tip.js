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
    

    }
  }
  chat.init({
    tip_id:{
      type:DataTypes.INTEGER,
      primaryKey:true
      ,autoIncrement:true
    } ,
    day: DataTypes.STRING,
    text: DataTypes.STRING,
    content_location:DataTypes.STRING
  }, {
    sequelize,
    modelName: 'daily_tip',
    underscored:true,
    freezeTableName:true,
  });
  return chat;
};