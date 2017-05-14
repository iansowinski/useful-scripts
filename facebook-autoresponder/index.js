#! /usr/bin/env node
"use strict";

const login = require("facebook-chat-api");
const request = require("request");

login({email: "", password: ""}, function callback(err, api) {
  if (err) return console.error(err);
  
  var listen = api.listen(function callback(err, message) {
    if (err) return console.error(err);
    let msg = message.body.toLowerCase();
    var id = message.senderID
    //When message received
    api.getUserInfo(id, function callback(err, obj){
      var friend = obj[id]['isFriend']
      if (message.isGroup === false && friend === true) {
        if (msg) {
          api.sendMessage("", message.threadID);
        }
      }
    });
  });
});