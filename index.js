import express from "express"
import { writeFile } from 'node:fs';
import { Buffer } from 'node:buffer';
import { dirname } from "path";
import { fileURLToPath } from "url";
import bodyParser from "body-parser";
import { v4 as uuidv4 } from 'uuid';
import pg from 'pg';

const { Pool, Client } = pg
 
const pool = new Pool({
  user: 'postgres',
  password: 'admin',
  //password: '0627',
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
  const question = req.body["question"];
  const answer = req.body["answer"];

  // if we don't have such user we can insert data into our database
  const text = `INSERT INTO users(UserID, UserName, Email, UserPassword, SecurityQuestion, SecurityAnswer) SELECT $1, $2, $3, $4, $5, $6 WHERE NOT EXISTS(SELECT * FROM users WHERE UserName=$7 OR Email=$8);`
  const values = [userid, username, email, password, question, answer, username, email];
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
  const text = `SELECT UserPassword FROM users WHERE UserName = $1;`;
  const values = [username];

  //
  req.app.locals.username = username;

  const result = await client.query(text, values);
  console.log(result)
  if (result.rows[0] != undefined && result.rows[0]["userpassword"] == password) {
    // Head to User Page
    //res.sendFile(__dirname + "/public/user.html");
    res.render(__dirname + "/public/user.ejs", {
      username: req.app.locals.username,
      tracks: [],
    });
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
  const answer = req.body["answer"];

  const text = `UPDATE users SET UserPassword = $1 WHERE UserName = $2 AND Email = $3 AND EXISTS(SELECT 1 FROM users WHERE UserName=$4 AND SecurityAnswer=$5);`;
  const values = [password, username, email, username, answer];
  const result = await client.query(text, values);
  console.log(result.rows[0]);
  
  client.release();
  res.sendFile(__dirname + "/public/index.html");

});

// Handle search for track
app.post("/search", async(req, res) => {
  
  pool.on('error', (err, client) => {
    console.error('Unexpected error on idle client', err)
    process.exit(-1)
  })
   
  const client = await pool.connect()

  const trackName = req.body["trackName"];
  const text = `SELECT * FROM TrackSearch WHERE TrackTitle=$1;`;
  const values = [trackName];
  const result = await client.query(text, values);

  req.app.locals.trackName = trackName;

  console.log(result.rows);
  if (result.rows[0] == undefined) {
    res.render(__dirname + "/public/user.ejs", {
      username: req.app.locals.username,
      tracks: [],
    });
  } else {
    res.render(__dirname + "/public/user.ejs", {
      username: req.app.locals.username,
      tracks: result.rows,
    });
  }
  
  client.release();
});

app.post("/rate", async(req, res) => {

  pool.on('error', (err, client) => {
    console.error('Unexpected error on idle client', err)
    process.exit(-1)
  });
   
  const client = await pool.connect();

  const trackName = req.app.locals.trackName;
  const rating = req.body["rating"];
  console.log(trackName, rating);
  
  // Now want to update the Track rating and album rating
  // handle update Track rating first
  const text = `UPDATE tracks SET Rating = DIV((SELECT (SELECT Rating from tracks WHERE TrackTitle=$1) ::DECIMAL + $2), 2) WHERE TrackTitle=$3;`;
  const values = [trackName, rating, trackName];
  const result = await client.query(text, values);
  console.log(result.rows[0]);
  
  client.release();
});


app.post("/logout", async(req, res) => {
  res.sendFile(__dirname + "/public/index.html");
});



app.listen(port, ()=> {
    console.log(`Server running on port ${port}.`);
});


