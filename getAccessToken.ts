// 作り途中

import googleapis from "https://esm.sh/googleapis";
import key from './android/app/google-services.json

const { google } = googleapis;
// import http from "https://esm.sh/http";
// let server = http.createServer(function(req, res) {
//   // アクセストークン取得
//   const r = getAccessToken();
//   r.then( (val) => {
//     // アクセストークンが取得成功したらトークンを描画
//     res.write(val);
//     res.end();
//  } );
// }).listen(8080); // 8080ポートで待ち受け

// アクセストークン取得関数
function getAccessToken() {
    return new Promise((resolve, reject) => {
        // var key = require('./web-push-test-202006-firebase-adminsdk-vbnax-xxxxxxxxxx.json');
        var jwtClient = new google.auth.JWT(
          key.client_email,
          null,
          key.private_key,
           [
             'https://www.googleapis.com/auth/firebase.messaging',
           ],
          null
        );
        jwtClient.authorize(function(err, tokens) {
          if (err) {
            reject(err);
            return;
          }
          resolve(tokens.access_token);
        });
      });
}

console.log("99999");