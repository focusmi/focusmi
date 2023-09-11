'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class appointment extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      this.belongsTo(models.application_user, {foreignKey:'user_id'})
      this.belongsTo(models.therapy_session,{foreignKey:'session_id'})
    }
  }
  appointment.init({
    appointment_id: {
      type:DataTypes.INTEGER,
      primaryKey:true
      ,autoIncrement:true
    } ,
    user_id: DataTypes.INTEGER,
    session_id: DataTypes.INTEGER,
    appointment_status: DataTypes.TEXT
  }, {
    sequelize,
    modelName: 'appointment',
    underscored:true,
    freezeTableName:true,
  });
  return appointment;
};