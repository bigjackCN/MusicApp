import express from "express"
import { dirname } from "path";
import { fileURLToPath } from "url";
import bodyParser from "body-parser";
import { v4 as uuidv4 } from 'uuid';
import pg from 'pg';

const { Pool, Client } = pg
 
const pool = new Pool({
  user: 'postgres',
  password: '0627', // for testing
  //password: 'admin',
  host: 'localhost',
  port: 5432,
  database: 'postgres',
})
 
const __dirname = dirname(fileURLToPath(import.meta.url));

const app = express();
const port = 3000;

app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static('public'))

app.get("/", (req, res) => {
  res.sendFile(__dirname + "/public/index.html");
});

app.post("/register", async(req, res) => {
  
  pool.on('error', (err, client) => {
    console.error('Unexpected error on idle client', err)
    process.exit(-1)
  })
   
  const client = await pool.connect()

  const userid = uuidv4();
  const username = req.body["username"];
  const email = req.body["email"];
  const password = req.body["password"];

  const text = 'INSERT INTO users(userid, username, email, userpassword) VALUES($1, $2, $3, $4) RETURNING *'
  const values = [userid, username, email, password];
  const result = await client.query(text, values);
  console.log(result.rows[0]);
  
  client.release();
  res.sendFile(__dirname + "/public/index.html");

});

app.post("/login", async(req, res) => {

  pool.on('error', (err, client) => {
    console.error('Unexpected error on idle client', err)
    process.exit(-1)
  })
   
  const client = await pool.connect()

  const password = req.body["password"];
  const username = req.body["username"];
  const text = `SELECT userpassword FROM users WHERE username = $1`;
  const values = [username];

  const result = await client.query(text, values);
  console.log(result)
  if (result.rows[0] != undefined && result.rows[0]["userpassword"] == password) {
    res.send(`<h1>Welcome back, </h1><h2>${username}✌️</h2>`);
  } else {
    res.sendFile(__dirname + "/public/index.html");
  }
  
  client.release();

});

app.post("/reset", async(req, res) => {
  
  pool.on('error', (err, client) => {
    console.error('Unexpected error on idle client', err)
    process.exit(-1)
  })
   
  const client = await pool.connect()

  const username = req.body["username"];
  const email = req.body["email"];
  const password = req.body["password"];
/*
  const query = {
    // give the query a unique name
    name: 'reset-password',
    text: 'UPDATE users SET userpassword = $1 WHERE username = $2 AND email = $3',
    values: [password, username, email],
  }
  
  const result = await client.query(query)
  */
  const text = `UPDATE users SET userpassword = $1 WHERE username = $2 AND email = $3`;
  const values = [password, username, email];
  const result = await client.query(text, values);
  console.log(result.rows[0]);
  
  client.release();
  res.sendFile(__dirname + "/public/index.html");

});

app.listen(port, ()=> {
    console.log(`Server running on port ${port}.`);
});


