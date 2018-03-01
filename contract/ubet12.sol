pragma solidity ^0.4.19;
contract Ubet {


  // beginning of stuff that matters
    uint  betID = 0;
     uint   gID = 0;
     address owner = msg.sender;
     uint public NumOfGames = 3;
     int vig= 3;
    address ubetowner = 0x2C6D57D76B3388f71281Be375841516ab2310316;




  struct game  {
      string    favTeam;
      int     favTotalBets;
      uint      favNumOfBets;
      int      favScore;
      int     favNumNotCovered;
      uint      favBetLastCovered ;

      string    dogTeam;
      int     dogTotalBets;
      uint      dogNumOfBets;
      int      dogSore;
      int     dogNumNotCovered;
      uint      dogBetLastCovered;

     int     deltaFavDog;
      int      spread;
      bool      gameplayed ;

      mapping (uint => bet) favBets;
      mapping (uint => bet) dogBets;

     }



      struct bet{
          bool favorite;
          uint  game;
          uint betID;
          int amountBet;
          string  wAddress;
          address txAdrress;
          bool betTotallyCovered;
          int   betAmountCovered;
          uint amountPaid;
          int  fee;


      }

  mapping (uint => game) Games;



  /* Constructor */
    function Ubet()  public payable  {

        // data for each of the games, spread is x 10
     Games[1].favTeam =    "Lions";
     Games[1].dogTeam =    "Bears";
     Games[1].spread =          50;
     Games[1].gameplayed =  false;

     Games[2].favTeam =    "Chargers";
     Games[2].dogTeam =    "Chief";
     Games[2].spread =  10;
     Games[2].gameplayed =  false;

     Games[3].favTeam =    "Eagles";
     Games[3].dogTeam =    "Giants";
     Games[3].spread =          75;
     Games[3].gameplayed =  false;


    }

    event someOneadded(address addressAdded, string  name);
    event aNewBet( address _bAddr, uint _bAmount, bool _fav, uint _totalBets);

    // an account needs to be createed before a bet can be placed.
    function  tester() public constant returns(address txxt) {
           txxt = msg.sender ;

    }





    function checkGame(uint _game) constant public
    returns( uint gamesNum, string Favorit_Team, string Dog_Team, int Spread,
             int Fav_Tot_Bets, int Dog_Tot_Bets, bool gplayed){
        return(
        _game,
        Games[_game].favTeam,
         Games[_game].dogTeam,
         Games[_game].spread,
         Games[_game].favTotalBets,
         Games[_game].dogTotalBets,
         Games[_game].gameplayed
        );
    }


    function checkGameBets(uint _game) constant public
    returns( uint gg, int Fav_Tot_Bets ,  uint Fav_Num_ofBets,
        int Dog_Tot_Bets ,  uint Dog_Num_ofBets,  bool played ){
        return(
        _game,
        Games[_game].favTotalBets,
        Games[_game].favNumOfBets,
        Games[_game].dogTotalBets,
        Games[_game].dogNumOfBets,
        Games[_game].gameplayed
        );
    }



    function checkGameFavBet  (uint _game, uint _bID, string _played) constant public
        returns(uint[2] Bet_ID ,string Favorite , int[3] Bet_Amount,string Played,
         string Wallet_Address, uint AmtPaid){

           Bet_ID[0] = Games[_game].favBets[_bID].betID;
           Bet_ID[1] =  _game;

           Favorite = Games[_game].favTeam;
           Bet_Amount[0] = Games[_game].favBets[_bID].amountBet;
           Bet_Amount[1] = Games[_game].favBets[_bID].betAmountCovered;
           Bet_Amount[2] = Games[_game].favBets[_bID].fee;
           Played = _played;
           Wallet_Address = Games[_game].favBets[_bID].wAddress;
           AmtPaid = Games[_game].favBets[_bID].amountPaid;


        }

     function checkGameDogBet (uint _game, uint _bID, string _played) constant public
        returns (uint[2] Bet_ID, string Underdog ,int[3] Bet_Amount, string Played,
        string Wallet_Address, uint AmtPaid ){

          Bet_ID[0] = Games[_game].dogBets[_bID].betID;
          Bet_ID[1] =  _game;

          Underdog = Games[_game].dogTeam;
          Bet_Amount[0] =  Games[_game].dogBets[_bID].amountBet;
          Bet_Amount[1] =  Games[_game].dogBets[_bID].betAmountCovered;
          Bet_Amount[2] = Games[_game].dogBets[_bID].fee;
          Played = _played;
          Wallet_Address = Games[_game].dogBets[_bID].wAddress;
          AmtPaid = Games[_game].dogBets[_bID].amountPaid;



        }

    /*
        function CancelMyBet(int _bID,  string _password) public{

         address key = msg.sender;

         if ( keccak256(gambler[msg.sender].password) == keccak256(_password)){

         }
     }
    */


     function checkMyBet  (string adr ) constant public
        returns( uint[4] gamebet,   bool[4] team,
                    int[4] wageAmt, int[4] amtCovered, bool[4] gplayed, uint[4] BetPaid ){

            uint ubetnum = 0;

        uint cc =0;
        for (uint i = 1; i <= 3; i ++){
          if(Games[i].favNumOfBets > Games[i].dogNumOfBets){
              cc =Games[i].favNumOfBets;
            }
          else{ cc =Games[i].dogNumOfBets; }
          uint j = 1;
          for ( j = 1; j <= cc; j++){
              if(keccak256(adr) == keccak256(Games[i].favBets[j].wAddress) && j <= Games[i].favNumOfBets){
                 gamebet[ubetnum] = i;
                 team[ubetnum] = Games[i].favBets[j].favorite;
                 wageAmt[ubetnum] = Games[i].favBets[j].amountBet;
                 amtCovered[ubetnum] = Games[i].favBets[j].betAmountCovered;
                 gplayed[ubetnum] = Games[i].gameplayed;
                 BetPaid[ubetnum] = Games[i].favBets[j].amountPaid;
                 ubetnum ++;
              }
               if(keccak256(adr) == keccak256(Games[i].dogBets[j].wAddress) && j <=Games[i].dogNumOfBets){
                 gamebet[ubetnum] = i;

                 team[ubetnum] = Games[i].dogBets[j].favorite;
                 wageAmt[ubetnum] = Games[i].dogBets[j].amountBet;
                 amtCovered[ubetnum] = Games[i].dogBets[j].betAmountCovered;
                 gplayed[ubetnum] = Games[i].gameplayed;
                 BetPaid[ubetnum] = Games[i].dogBets[j].amountPaid;
                 ubetnum ++;
              }
          }

        }
        }


   function makeAbet(string adr, uint _game, uint _favOrDog) payable public
    {

    bool _fav = true;
    if(_favOrDog == 1) _fav = true; else _fav = false;


    int currentWager  = int (msg.value);
    int remainder = currentWager;

        if(_fav){
             int _avail =  Games[_game].dogTotalBets - Games[_game].favTotalBets;
             Games[_game].favNumOfBets +=1;
             uint bID = Games[_game].favNumOfBets ;
            Games[_game].favBets[bID].betID = bID;
            Games[_game].favBets[bID].wAddress = adr;
            Games[_game].favBets[bID].txAdrress = msg.sender;
            Games[_game].favBets[bID].amountBet = currentWager;
            Games[_game].favBets[bID].favorite = _fav;



           uint firstNotcovered = Games[_game].dogBetLastCovered + 1;

            if ( _avail > 0){
                if(_avail > currentWager){
                    Games[_game].favBets[bID].betTotallyCovered =true;
                    Games[_game].favBets[bID].betAmountCovered =
                        Games[_game].favBets[bID].amountBet;
                    int _betAmountCovered = Games[_game].favBets[bID].betAmountCovered;
                    Games[_game].favBetLastCovered = bID;

                    while ( remainder > 0 && firstNotcovered <= Games[_game].dogNumOfBets){
                        int notCovered = Games[_game].dogBets[firstNotcovered].amountBet -
                                        Games[_game].dogBets[firstNotcovered].betAmountCovered;

                        if(remainder == notCovered){
                             Games[_game].dogBetLastCovered += 1;
                             Games[_game].dogBets[firstNotcovered].betAmountCovered += remainder;
                            remainder = 0;
                             firstNotcovered +=1;

                        }

                        if(remainder < notCovered  ){
                            Games[_game].dogBets[firstNotcovered].betAmountCovered += remainder;
                            remainder = 0;
                        }

                        if(remainder > notCovered){
                            Games[_game].dogBets[firstNotcovered].betAmountCovered =
                                Games[_game].dogBets[firstNotcovered].amountBet;

                            firstNotcovered +=1;
                            Games[_game].dogBetLastCovered += 1;
                            remainder -=  notCovered;
                        }
                    }
                }
                if(_avail< currentWager){
                    Games[_game].favBets[bID].betAmountCovered = _avail;
                     _betAmountCovered = Games[_game].favBets[bID].betAmountCovered;
                     firstNotcovered = Games[_game].dogBetLastCovered+1;
                    for(uint i = firstNotcovered; i <= Games[_game].dogNumOfBets; i++){
                        Games[_game].dogBets[i].betAmountCovered =
                            Games[_game].dogBets[i].amountBet;
                        Games[_game].dogBetLastCovered += 1;
                    }
                }
                if(_avail == currentWager){
                     Games[_game].favBets[bID].betAmountCovered = currentWager;
                      _betAmountCovered = Games[_game].favBets[bID].betAmountCovered;
                     Games[_game].favBetLastCovered +=1;
                         firstNotcovered = Games[_game].dogBetLastCovered+1;
                        for( i = firstNotcovered; i <= Games[_game].dogNumOfBets; i++){
                            Games[_game].dogBets[i].betAmountCovered =
                                Games[_game].dogBets[i].amountBet;
                            Games[_game].dogBetLastCovered += 1;
                        }


                }

            }
         Games[_game].favTotalBets += currentWager;

        }

        if(!_fav){

             _avail =  Games[_game].favTotalBets - Games[_game].dogTotalBets;

             Games[_game].dogNumOfBets +=1;
            bID = Games[_game].dogNumOfBets ;
            Games[_game].dogBets[bID].betID = uint(bID);
            Games[_game].dogBets[bID].wAddress = adr;
            Games[_game].dogBets[bID].txAdrress= msg.sender;
            Games[_game].dogBets[bID].amountBet = currentWager;

           Games[_game].dogBets[bID].favorite = _fav;

             firstNotcovered = Games[_game].favBetLastCovered + 1;

            if ( _avail > 0){
                if(_avail > currentWager){
                    Games[_game].dogBets[bID].betTotallyCovered =true;
                    Games[_game].dogBets[bID].betAmountCovered =
                        Games[_game].dogBets[bID].amountBet;
                         _betAmountCovered = Games[_game].dogBets[bID].betAmountCovered;
                    Games[_game].dogBetLastCovered = bID;



                    while ( remainder > 0 && firstNotcovered <= Games[_game].favNumOfBets){
                         notCovered = Games[_game].favBets[firstNotcovered].amountBet -
                                        Games[_game].favBets[firstNotcovered].betAmountCovered;

                        if(remainder == notCovered){
                             Games[_game].favBetLastCovered += 1;
                             Games[_game].favBets[firstNotcovered].betAmountCovered += remainder;
                            remainder = 0;
                             firstNotcovered +=1;

                        }

                        if(remainder < notCovered  ){
                            Games[_game].favBets[firstNotcovered].betAmountCovered += remainder;
                            remainder = 0;
                        }

                        if(remainder > notCovered){
                            Games[_game].favBets[firstNotcovered].betAmountCovered =
                                Games[_game].favBets[firstNotcovered].amountBet;

                            firstNotcovered +=1;
                            Games[_game].favBetLastCovered += 1;
                            remainder -=  notCovered;
                        }
                    }
                }
                if(_avail< currentWager){
                    Games[_game].dogBets[bID].betAmountCovered = _avail;
                    _betAmountCovered = Games[_game].dogBets[bID].betAmountCovered;
                     firstNotcovered = Games[_game].favBetLastCovered+1;
                    for( i = firstNotcovered; i <= Games[_game].favNumOfBets; i++){
                        Games[_game].favBets[i].betAmountCovered =
                            Games[_game].favBets[i].amountBet;
                        Games[_game].favBetLastCovered += 1;
                    }
                }
                if(_avail == currentWager){
                     Games[_game].dogBets[bID].betAmountCovered = currentWager;
                     _betAmountCovered = Games[_game].dogBets[bID].betAmountCovered;
                     Games[_game].dogBetLastCovered +=1;
                         firstNotcovered = Games[_game].favBetLastCovered+1;
                        for( i = firstNotcovered; i <= Games[_game].favNumOfBets; i++){
                            Games[_game].favBets[i].betAmountCovered =
                                Games[_game].favBets[i].amountBet;
                            Games[_game].favBetLastCovered += 1;
                        }

                }

            }
         Games[_game].dogTotalBets += currentWager;

        }

    }

     function enterGameScores  (uint _game, int _favScore, int _dogScore) public returns (uint _begBalnce, uint _endBalance) {
         Games[_game].favScore = _favScore * 10;
         Games[_game].dogSore = _dogScore *10;

         _begBalnce = this.balance;
         int delta = Games[_game].favScore -
            Games[_game].dogSore - Games[_game].spread;



         if ( delta == 0) Push(_game);
         if ( delta >  0) favWins(_game);
         if ( delta <  0) dogWins(_game);


         Games[_game].gameplayed = true;

          _endBalance = this.balance;

     }

     function dogWins(uint _game) internal {
         for ( uint i = 1; i <= Games[_game].dogNumOfBets; i += 1){

             int betAmt = Games[_game].dogBets[i].betAmountCovered * (100-vig)/100;
             uint  payoff = uint (Games[_game].dogBets[i].amountBet +
                    betAmt) ;

            int vigfee = Games[_game].dogBets[i].betAmountCovered * (vig)/100;
            Games[_game].dogBets[i].fee = vigfee;
            ubetowner.transfer(uint(vigfee));

            Games[_game].dogBets[i].amountPaid = payoff;
            Games[_game].dogBets[i].txAdrress.transfer(payoff );

         }

          uint lastcovered = Games[_game].favBetLastCovered +1;
          for ( i = lastcovered; i <= Games[_game].favNumOfBets; i +=1){
             uint betReturned = uint(Games[_game].favBets[i].amountBet -
                   Games[_game].favBets[i].betAmountCovered);
            Games[_game].favBets[i].txAdrress.transfer(betReturned);
            Games[_game].favBets[i].amountPaid = betReturned;

          }

     }

     function favWins(uint _game) internal {

          for (uint i = 1; i <= Games[_game].favNumOfBets; i += 1){
            int  betAmt = Games[_game].favBets[i].betAmountCovered *(100-vig)/100;
             uint payoff = uint (Games[_game].favBets[i].amountBet +
                     betAmt);

            int vigfee = Games[_game].favBets[i].betAmountCovered   * (vig)/100;
            Games[_game].favBets[i].fee = vigfee;
            ubetowner.transfer(uint(vigfee));

            Games[_game].favBets[i].amountPaid = payoff;
            Games[_game].favBets[i].txAdrress.transfer(payoff );

             }

          uint lastcovered = Games[_game].dogBetLastCovered +1;
          for ( i = lastcovered; i <= Games[_game].dogNumOfBets; i +=1){
             uint betReturned = uint(Games[_game].dogBets[i].amountBet -
                    Games[_game].dogBets[i].betAmountCovered);
            Games[_game].dogBets[i].txAdrress.transfer(betReturned);
            Games[_game].dogBets[i].amountPaid = betReturned;
          }

     }

     function   Push(uint _game) internal  {

         for (uint i = 1; i <= Games[_game].favNumOfBets; i += 1){
             uint payoff = uint (Games[_game].favBets[i].amountBet) ;
             Games[_game].favBets[i].txAdrress.transfer(payoff );
             Games[_game].favBets[i].amountPaid = payoff;
             Games[_game].favBets[i].fee = 0;


         }

         for ( i = 1; i <= Games[_game].dogNumOfBets; i += 1){
              payoff = uint (Games[_game].dogBets[i].amountBet) ;
             Games[_game].dogBets[i].txAdrress.transfer(payoff );
             Games[_game].dogBets[i].amountPaid = payoff;
            Games[_game].dogBets[i].fee = 0;
         }

     }

    function() public  payable{

    }

    /* Function to recover the funds on the contract */
    function reset() public {

        if (msg.sender == owner) {

            selfdestruct(owner);
    }

    }




}
