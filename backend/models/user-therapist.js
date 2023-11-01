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
        console.log(user)
        administrative_user.create(
            {
                username:user.full_name,
                full_name:user.full_name,
                role:"therapist",
                email:user.email,
                phone_number:user.phone_number,
                about:user.about,
                account_status:"active",
                years_of_experience:user.years_of_experience,
                tot_clients:user.tot_clients,
                password:'$2a$10$agGGVssihbvbYxnWYS2yE.QW8G6.8b0fypf.MFWvaYcqIV52MUXam',
                title:user.title,
                nic:user.nic,
                image:user.image
            }
        )

    }

    static async getTherapist(){
        var result = administrative_user.findAll();
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
        console.log(userid)
        administrative_user.update({
            username:user.username,
            full_name:user.full_name,
            role:user.roler,
            email:user.email,
            phone_number:user.phone_number,
            about:user.about,
            account_status:user.account_status,
            years_of_experience:user.years_of_experience,
            tot_clients:user.tot_client,
            password:user.password,
            title:user.title,
            nic:user.nic,
            image:user.image
        },{
            where:{
                user_id:userid
            }
        })
    }
}

module.exports = UserTherapist