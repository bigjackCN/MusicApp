import express from "express"

const app = express();
const port = 3000;

app.listen(port, ()=> {
    console.log(`Server running on port ${port}.`);
});

var client_id = 'e6e44eeb658e4d5989f3ad9cf2211eb4';
var client_secret = '891589ed2ebe4135b6132c735688dd33';
export var artist_id;

async function getToken() {
  const response = await fetch('https://accounts.spotify.com/api/token', {
    method: 'POST',
    body: new URLSearchParams({
      'grant_type': 'client_credentials',
    }),
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Basic ' + (Buffer.from(client_id + ':' + client_secret).toString('base64')),
    },
  });

  return await response.json();
}

async function getTrackInfo(access_token) {
  const response = await fetch("https://api.spotify.com/v1/tracks/4cOdK2wGLETKBW3PvgPWqT", {
    method: 'GET',
    headers: { 'Authorization': 'Bearer ' + access_token },
  });

  return await response.json();
}

async function getIDByArtist(access_token, artist) {
  const response = await fetch("https://api.spotify.com/v1/search" + `?q=${artist}&type=artist&limit=1`, {
    method: 'GET',
    headers: { 'Authorization': 'Bearer ' + access_token },
  });

  return await response.json();
}

async function getTracksByArtist(access_token, artist_id) {
  const response = await fetch(`https://api.spotify.com/v1/artists/${artist_id}/top-tracks?country=US`, {
    method: 'GET',
    headers: { 'Authorization': 'Bearer ' + access_token },
  });

  return await response.json();
}

/*
getToken().then(response => {
  getTrackInfo(response.access_token).then(profile => {
    console.log(profile)
  })
});
*/
var artist = "周杰伦"

getToken().then(response => {
  getIDByArtist(response.access_token, artist).then(result => {
    if (result["artists"]["items"].length == 0) {
      console.log("No artist with this name exists...")
      return None
    } else {
      artist_id = result["artists"]["items"][0]["id"]  
    }
    getTracksByArtist(response.access_token, artist_id).then(result => {
      console.log(result);
      app.get("/", (req, res) => {
        res.send(result);
      })
    })
    })  
});

