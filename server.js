require('dotenv').config();

import app from "./app";

const port = process.env.SERVER_PORT;

app.listen(port, () => {
  console.log(`Servidor rodando na porta ${port}`);
  console.log(`CTRL + Clique: http://localhost:${port}`);
});
