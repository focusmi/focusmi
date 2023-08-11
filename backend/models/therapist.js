const pool = require("../database/dbconnection");

const User = {
  findOneByEmail: async (email) => {
    try {
      const query = `SELECT * FROM  administrative_user WHERE email = '${email}'`;
      const user = await pool.cQuery(query);
      return user["0"];
    } catch (error) {
      throw new Error('Error finding user:', error);
    }
  },
  findOneById: async (id) => {
    try {
      const query = `SELECT * FROM  administrative_user WHERE "admin_user_ID" = '${id}'`;
      const user = await pool.cQuery(query);
      return user["0"];
    } catch (error) {
      throw new Error('Error finding user:', error);
    }
  },
  createUser: async (name, email, password) => {
    try {
      const query = `INSERT INTO  administrative_user(user_name, email, password) VALUES('${name}', '${email}', '${password}')`;
      await pool.cQuery(query);
      console.log('User created successfully');
    } catch (error) {
      throw new Error('Error creating user:', error);
    }
  },

  updateUser: async (id, name, email, years_of_experience,phone_number,about) => {
    try {
      const query = `UPDATE  administrative_user SET user_name = '${name}', email = '${email}', phone_number = '${phone_number}', years_of_experience = '${years_of_experience}', about = '${about}'  WHERE "admin_user_ID" = '${id}'`;
      await pool.cQuery(query);
      console.log('User updated successfully');
    } catch (error) {
      throw new Error('Error updating user:', error);
    }
  },

  deleteUser: async (id) => {
    try {
      const query = `DELETE FROM  administrative_user WHERE "admin_user_ID" = '${id}'`;
      await pool.cQuery(query);
      console.log('User deleted successfully');
    } catch (error) {
      throw new Error('Error deleting user:', error);
    }
  },

  updateUserPassword: async (id, newHashedPassword) => {
    try {
      const query = `UPDATE  administrative_user SET password = '${newHashedPassword}' WHERE "admin_user_ID" = '${id}'`;
      await pool.cQuery(query);
      console.log('User password updated successfully');
    } catch (error) {
      throw new Error('Error updating user password:', error);
    }
  }
};

module.exports = User;
