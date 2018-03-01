import { Template } from 'meteor/templating';
import { ReactiveVar } from 'meteor/reactive-var';
import { Mongo } from 'meteor/mongo';

import './main.html';
const myBets = new Mongo.Collection(null);
const GamesToBet = new Mongo.Collection(null);
const Data = new Mongo.Collection(null);

myContract = web3.eth.contract(ABI).at(contractAddress);


var addstring = EthAccounts.find().fetch();
console.log(addstring[0].address);
acct = EthAccounts.find().fetch();
act4 = EthAccounts.find().fetch();

//console.log(act4[0].address);
Session.set("adr",act4[0].address);

var NofGames
myContract.NumOfGames(function(err,results){

 NofGames = JSON.parse(results);
 var i =0;
 var j = 0;
     for(i=1;i<=NofGames;i++) {
       myContract.checkGameBets(i,function(err,res){
         gamen = res[0]/1;
         numOfFav = res[2]/1;
         gamePlayed = JSON.stringify(res[5]);

         aa ={game: res[0]/1, NumofFav: res[2]/1, Played: res[5]};

         Data.insert(aa);

         for(j=1;j<=numOfFav;j++){

           myContract.checkGameFavBet(gamen,j,gamePlayed,function(err,res2){

             dd = {Bid: (res2[0][0]/1)+"F", Game: res2[0][1]/1, Team: res2[1],
               BetAmount: (res2[2][0]/1e18).toFixed(3), BetAmtCvd: (res2[2][1]/1e18).toFixed(3),
               Fee: (res2[2][2]/1e18).toFixed(3), Played: res2[3], WalletAdr:res2[4],
               AmtPaid: (res2[5]/1e18).toFixed(3)};

                console.log(JSON.stringify(res2[2][1]));
               console.log(JSON.stringify(res2[2][2]));

               if(res2[4] == addstring[0].address){
                   myBets.insert(dd);
               }
           });
         }
       });
     }


     for(i=1;i<=NofGames;i++) {
       myContract.checkGameBets(i,function(err,res){
         gamen = res[0]/1
         numOfDog = res[4]/1;
         gamePlayed = JSON.stringify(res[5]);
         aa ={game: res[0]/1, NumofDog: res[4]/1, Played: res[5]};

         Data.insert(aa);
         for(j=1;j<=numOfDog;j++){
           myContract.checkGameDogBet(gamen,j,gamePlayed,function(err,res2){
             dd = {Bid: (res2[0][0]/1)+"U", Game: res2[0][1]/1, Team: res2[1],
               BetAmount: (res2[2][0]/1e18).toFixed(3), BetAmtCvd: (res2[2][1]/1e18).toFixed(3),
               Fee: (res2[2][2]/1e18).toFixed(3),Played: res2[3], WalletAdr:res2[4],
               AmtPaid: (res2[5]/1e18).toFixed(3)};

               if(res2[4] == addstring[0].address){
                   myBets.insert(dd);
               }
           });
         }
       });
     }

    });


  Template.betsP2.helpers({
    FavGame(){
      return  myBets.find({},{sort:{Game:1}}).fetch();
    }
  });



 myContract.NumOfGames(function(err,res){
   var numOfG = JSON.parse(res);
   var i

   for (i=1; i <= numOfG; i++){

     myContract.checkGame(i,function(err,res2){
       aa = {GameNum: res2[0]/1, Favorite: res2[1], FavScore: res2[2][0]/10, Underdog: res2[3],
         DogScore: res2[2][1]/10, Spread: (res2[4]/10).toFixed(1), FavTotBets: (res2[5]/1e18).toFixed(3),
         DogTotBets: (res2[6]/1e18).toFixed(3), GamePlayed: JSON.stringify(res2[7])};
      GamesToBet.insert(aa);

    });

   }

  });



  Template.info.helpers({



   game() {
     return GamesToBet.find({},{sort:{GameNum:1}}).fetch();
   }

  });



function callWhenMined(txHash, callback) {
            web3.eth.getTransactionReceipt(txHash, function (error, rcpt) {

                if (error) {
                    console.error(error);
                } else {
                    if (rcpt == null) {
                        setTimeout(function () {
                            callWhenMined(txHash, callback);
                        }, 500);
                    } else {
                        callback();
                    }
                }
            })
        }








Template.info.onCreated(function (){
    Session.set('ngame',1);
    //Session.set('gamestoBet',myContract.Games);

//myContract.checkMyBet(console.log);

});



//=====================================================================
Template.hello.helpers({

  balance() {
    var template =  Template.instance();
    acct = EthAccounts.find().fetch();
    web3.eth.getBalance(acct[0].address,
      function(err,res){
        if(!err){
        bal = EthTools.formatBalance(res, '0.00[000]');
        TemplateVar.set(template, "balance",  EthTools.formatBalance(res, '0.00[000]'));
        }
        else{
          TemplateVar.set(template, "balance"," **You are not conneted to MetaMask**");
        }
  })

  },
    wAddress(){
      var template = Template.instance();
      TemplateVar.set(template, "wAddress",acct[0].address);

    },







  });


//=================================================================



Template.info.events({
  "submit .lookupGame": function(event){
  //  var template = Template.instance();
     //game = event.target.nflGame.value;

    //Session.set('ngame',1);
  }
});
//=====================================================================


Template.makebet.events({
  "submit .placebet": function (event) {
    var gBet = event.target.gNum.value;
    var choice  = event.target.gChoice.value;
    var betamount = event.target.betAmt.value
   if (choice == "Favorite")  fd = 1;
   if (choice == "Underdog")  fd = 0;

  console.log(Session.get("adr"));



  var pollTxReceipt = require('poll-tx-receipt')(web3);
   myContract.makeAbet(Session.get("adr"), gBet, fd, { value: web3.toWei(betamount,'ether') },
     function(err,res){
       console.log(res)

     }) ;


  }
});


//============================================================================
Template.gameScores.events({
  "submit .gameResults": function(event){
    var gBet = event.target.gNum.value;
    var FScore = event.target.FavScore.value;
    var DScore = event.target.DogScore.value;
    myContract.enterGameScores(gBet, FScore,DScore, console.log);
  }
});
