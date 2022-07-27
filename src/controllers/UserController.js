import User from "../models/User";

class UserController {
  async index(req, res) {
    const novoUser = await User.create({
      nome: 'Maria',
      email: 'maria@email.com',
      password: '123456',
    });
    res.json(novoUser);
  }
}

export default new UserController();
