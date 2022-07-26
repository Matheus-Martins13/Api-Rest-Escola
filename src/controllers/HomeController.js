import Aluno from "../models/Aluno";

class HomeController {
  async index(req, res) {
    const novoAluno = await Aluno.create({
      nome: 'Matheus',
      sobrenome: 'Martins',
      email: 'email@email.com',
      idade: 20,
      peso: 50.5,
      altura: 1.7
    });
    res.json(novoAluno);
  }
}

export default new HomeController();
