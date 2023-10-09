'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class user_chat extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  user_chat.init({
    message_id: {
      type:DataTypes.INTEGER,
      primaryKey:true,
      autoIncrement:true
    },
    user_id: {
      type:DataTypes.INTEGER,
    } ,
    chat_id: {
      type:DataTypes.INTEGER,
    } ,
    message_text: DataTypes.TEXT,
    message_type: DataTypes.TEXT,
    image: DataTypes.TEXT,
    create_time: DataTypes.TIME
  }, {
    sequelize,
    modelName: 'user_chat',
    underscored:true,
    freezeTableName:true,
  });
  return user_chat;
};