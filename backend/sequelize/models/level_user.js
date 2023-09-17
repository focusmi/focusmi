'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class level_user extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  level_user.init({
    level_id:{
      type:DataTypes.INTEGER,
      primaryKey:true
    } ,
    user_id:{
      type:DataTypes.INTEGER,
      primaryKey:true
    } ,
    
    
  }, {
    sequelize,
    modelName: 'level_user',
    underscored:true,
    freezeTableName:true,
  });
  return level_user;
};