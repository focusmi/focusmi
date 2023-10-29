const {administrative_user} = require("../sequelize/models")

class UserTherapist{
    constructor(user_id, username, full_name, role, email, phone_number, about, account_status, years_of_experience, tot_clients, password, title,nic,image){
        this.user_id = user_id
        this.username = username
        this.full_name =  full_name
        this.role = role
        this.email = email
        this.phone_number = phone_number
        this.about = about
        this.account_status = account_status
        this.years_of_experience = years_of_experience
        this.tot_clients = tot_clients
        this.password = password
        this.title = title
        this.nic = nic
        this.image = image
    }

    static  async createTherapist(user){
        administrative_user.create(
            {
                username:user.username,
                full_name:user.name,
                role:'therapist',
                email:user.email,
                phone_number:user.contactNumber,
                about:user.about,
                account_status:user.account_status,
                years_of_experience:user.years_of_experience,
                tot_clients:user.tot_clients,
                password:user.password,
                title:user.status,
                nic:user.nic
            }
        )

    }

    static async getTherapist(){
        var result = administrative_user.findAll({
            where: {
              role: 'therapist'
            }
          }

        );
        return result
    }

    static async deleteuser(userid){
        administrative_user.destroy({
            where:{
                user_id:userid
            }
        })
    }

    static async updateuser(userid, user){
        administrative_user.update({
            full_name:user.full_name,
            role:'therapist',
            email:user.email,
            phone_number:user.phone_number,
            nic:user.nic
    },{
        where:{
            user_id:userid
        }
    })
    }
}

module.exports = UserTherapist