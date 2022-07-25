#!/bin/bash

# Entrada do usuário
echo 'Digite o nome do projeto: '
read PROJECT_NAME
echo 'Digite o nome do autor do projeto: '
read AUTHOR

# Package.json
echo "{
  \"name\": \"$PROJECT_NAME\",
  \"version\": \"1.0.0\",
  \"description\": \"\",
  \"main\": \"app.js\",
  \"scripts\": {
    \"test\": \"echo \\\"Error: no test specified\\\" && exit 1\",
    \"start\": \"node server.js\", 
    \"dev\": \"nodemon server.js\"
  },
  \"keywords\": [],
  \"author\": \"\",
  \"license\": \"ISC\",
  \"dependencies\": {},
  \"devDependencies\": {}
}" > package.json


# Configuração do editorconfig
echo '
root = true
[*]
indent_style = space
indent_size = 2
end_of_line = lf
charset = utf-8
trim_trailing_whitespace = false
insert_final_newline = false
' > .editorconfig

# Configuração da árvore de diretórios
mkdir src
cd src
mkdir config database models routes controllers middlewares
cd controllers

# Confugurando o HomeController
echo "
class HomeController {
  index(req, res) {
    res.json('Tudo certo');
  }
}
export default new HomeController();
" > HomeController.js

cd ..
cd routes

# Configurando as rotas
echo "
import { Router } from 'express';
import homeController from '../controllers/HomeController';
const router = new Router();
router.get('/', homeController.index);
export default router;
" > homeRoutes.js

cd ../..

# Configurando o app.js
echo "
import dotenv from 'dotenv';
dotenv.config();
import express from 'express';
import homeRoutes from './src/routes/homeRoutes';
class App {
  constructor() {
    this.app = express();
    this.middlewares();
    this.routes();
  }
  middlewares() {
    this.app.use(express.json());
    this.app.use(express.urlencoded({ extended: true }));
  }
  routes() {
    this.app.use('/', homeRoutes);
  }
}
export default new App().app;
" > app.js

# Configurando o server.js
echo "
import app from './app';
const port = 3001;
app.listen(port, () => {
  console.log();
  console.log('Escutando na porta ' + port);
  console.log('CTRL + clique em http://localhost:' + port);
});
" > server.js

# Configuração do nodemon
echo '{
    "execMap": {
        "js": "node -r sucrase/register"
    }
}' > nodemon.json

# Instalando e configurando o dotenv
npm install express dotenv

touch .env

echo 'node_modules
.env
' > .gitignore

npm install -D sucrase nodemon eslint

npx eslint --init

npm run dev
