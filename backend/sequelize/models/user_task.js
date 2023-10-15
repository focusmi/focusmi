'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class user_task extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      this.belongsTo(models.task,{foreignKey:'task_id'});
      this.belongsTo(models.application_user,{foreignKey:'user_id'});
    }
  }
  user_task.init({
    user_id: {
      type:DataTypes.INTEGER,
      primaryKey:true
    } ,
    task_id: {
      type:DataTypes.INTEGER,
      primaryKey:true
    } ,
  }, {
    sequelize,
    modelName: 'user_task',
    underscored:true,
    freezeTableName:true,
  });
  return user_task;
};