'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class payment extends Model {
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
  payment.init({
    payment_id: {
      type:DataTypes.INTEGER,
      primaryKey:true
      ,autoIncrement:true
    } ,
    user_id: DataTypes.INTEGER,
    payment_status: DataTypes.TEXT,
    amount: DataTypes.REAL,
    complete_date: DataTypes.DATE,
    complete_time: DataTypes.TIME,
    create_time: DataTypes.TIME
  }, {
    sequelize,
    modelName: 'payment',
    underscored:true,
    freezeTableName:true,
  });
  return payment;
};