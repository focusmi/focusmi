'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class therapy_session extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      this.hasMany(models.therapy_session,{foreignKey:'session_id'})
      this.belongsTo(models.administrative_user,{foreignKey:'user_id'})
    }
  }
  therapy_session.init({
    session_id: {
      type:DataTypes.INTEGER,
      primaryKey:true
      ,autoIncrement:true
    } ,
    user_id: DataTypes.INTEGER,
    fee: DataTypes.REAL,
    day: DataTypes.TEXT,
    session_time: DataTypes.TIME,
    session_end_time: DataTypes.TIME
  }, {
    sequelize,
    modelName: 'therapy_session',
    underscored:true,
  });
  return therapy_session;
};