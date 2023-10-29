'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class notification extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      this.belongsTo(models.application_user,{foreignKey:'user_id'})
    }
  }
  notification.init({
    noti_id: {
      type:DataTypes.INTEGER,
      primaryKey:true
      ,autoIncrement:true
    } ,
    user_id:DataTypes.INTEGER,
    status:DataTypes.TEXT,
    text: DataTypes.TEXT,
    type: DataTypes.TEXT,
    group_id: DataTypes.INTEGER,
    task_id: DataTypes.INTEGER,
    payment_id:DataTypes.INTEGER,
    created_at:DataTypes.DATE,
    updated_at:DataTypes.DATE,
  }, {
    sequelize,
    modelName: 'notification',
    underscored:true,
    freezeTableName:true,
  });
  return notification;
};