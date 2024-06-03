import express from "express"
import { dirname } from "path";
import { fileURLToPath } from "url";
import bodyParser from "body-parser";
import pg from 'pg';

const { Pool, Client } = pg
 
const pool = new Pool({
  user: 'postgres',
  password: '0627',
  host: 'localhost',
  port: 5432,
  database: 'music',
})
 
const __dirname = dirname(fileURLToPath(import.meta.url));

const app = express();
const port = 3000;

app.use(bodyParser.urlencoded({ extended: true }));

app.get("/", (req, res) => {
  res.sendFile(__dirname + "/public/index.html");
});

app.post("/register", async(req, res) => {
  
  pool.on('error', (err, client) => {
    console.error('Unexpected error on idle client', err)
    process.exit(-1)
  })
   
  const client = await pool.connect()
  const text = 'INSERT INTO users(userid, username, email, userpassword) VALUES($1, $2, $3, $4) RETURNING *'
  var userid = 105;
  var username = req.body["username"];
  var email = req.body["email"];
  var password = req.body["password"];
  const values = [userid, username, email, password];
  const result = await client.query(text, values);
  console.log(result.rows[0]);
  
  client.release();
  res.sendFile(__dirname + "/public/login.html");

  /*
  await client.connect()
  const text = 'INSERT INTO users(userid, username, email, userpassword) VALUES($1, $2, $3, $4) RETURNING *'
  var userid = 100;
  var username = req.body["username"];
  var email = req.body["email"];
  var password = req.body["password"];
  const values = [userid, username, email, password];
 
  await client.query(text, values)
  
  */
});

app.post("/login", async(req, res) => {

  pool.on('error', (err, client) => {
    console.error('Unexpected error on idle client', err)
    process.exit(-1)
  })
   
  const client = await pool.connect()

  var password = req.body["password"];
  var username = req.body["username"];
  const text = `SELECT userpassword FROM users WHERE username = $1`;
  const values = [password];

  const result = await client.query(text, values);
  if (result.rows[0] != undefined && result.rows[0]["userpassword"] == password) {
    res.send(`<h1>Welcome back, </h1><h2>${username}✌️</h2>`);
  } else {
    res.redirect("/");
  }
  
  client.release();

});

app.listen(port, ()=> {
    console.log(`Server running on port ${port}.`);
});


