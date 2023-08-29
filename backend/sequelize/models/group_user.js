'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class group_user extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      this.belongsTo(models.task_group,{foreignKey:'group_id'})
      this.belongsTo(models.application_user,{foreignKey:'user_id'})
      
    }
  }
  group_user.init({
    group_id: {
      type:DataTypes.INTEGER,
      primaryKey:true
    } ,
    user_id: {
      type:DataTypes.INTEGER,
      primaryKey:true
    } ,
    previlage:{
      type:DataTypes.STRING
    }
  }, {
    sequelize,
    modelName: 'group_user',
    underscored:true,
    freezeTableName:true,
  });
  return group_user;
};