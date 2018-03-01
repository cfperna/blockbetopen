contractAddress ="0xd7df64fb36554e383b2d67ac3ad392bbe1e639d7";


ABI =
[
	{
		"constant": true,
		"inputs": [],
		"name": "tester",
		"outputs": [
			{
				"name": "txxt",
				"type": "address"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "NumOfGames",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "_game",
				"type": "uint256"
			}
		],
		"name": "checkGame",
		"outputs": [
			{
				"name": "gameNum",
				"type": "uint256"
			},
			{
				"name": "Favorit_Team",
				"type": "string"
			},
			{
				"name": "scorses",
				"type": "int256[2]"
			},
			{
				"name": "Dog_Team",
				"type": "string"
			},
			{
				"name": "Spread",
				"type": "int256"
			},
			{
				"name": "Fav_Tot_Bets",
				"type": "int256"
			},
			{
				"name": "Dog_Tot_Bets",
				"type": "int256"
			},
			{
				"name": "gplayed",
				"type": "bool"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "_game",
				"type": "uint256"
			}
		],
		"name": "checkGameBets",
		"outputs": [
			{
				"name": "gg",
				"type": "uint256"
			},
			{
				"name": "Fav_Tot_Bets",
				"type": "int256"
			},
			{
				"name": "Fav_Num_ofBets",
				"type": "uint256"
			},
			{
				"name": "Dog_Tot_Bets",
				"type": "int256"
			},
			{
				"name": "Dog_Num_ofBets",
				"type": "uint256"
			},
			{
				"name": "played",
				"type": "bool"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "adr",
				"type": "string"
			}
		],
		"name": "checkMyBet",
		"outputs": [
			{
				"name": "gamebet",
				"type": "uint256[4]"
			},
			{
				"name": "team",
				"type": "bool[4]"
			},
			{
				"name": "wageAmt",
				"type": "int256[4]"
			},
			{
				"name": "amtCovered",
				"type": "int256[4]"
			},
			{
				"name": "gplayed",
				"type": "bool[4]"
			},
			{
				"name": "BetPaid",
				"type": "uint256[4]"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "_game",
				"type": "uint256"
			},
			{
				"name": "_bID",
				"type": "uint256"
			},
			{
				"name": "_played",
				"type": "string"
			}
		],
		"name": "checkGameFavBet",
		"outputs": [
			{
				"name": "Bet_ID",
				"type": "uint256[2]"
			},
			{
				"name": "Favorite",
				"type": "string"
			},
			{
				"name": "Bet_Amount",
				"type": "int256[3]"
			},
			{
				"name": "Played",
				"type": "string"
			},
			{
				"name": "Wallet_Address",
				"type": "string"
			},
			{
				"name": "AmtPaid",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "_game",
				"type": "uint256"
			},
			{
				"name": "_bID",
				"type": "uint256"
			},
			{
				"name": "_played",
				"type": "string"
			}
		],
		"name": "checkGameDogBet",
		"outputs": [
			{
				"name": "Bet_ID",
				"type": "uint256[2]"
			},
			{
				"name": "Underdog",
				"type": "string"
			},
			{
				"name": "Bet_Amount",
				"type": "int256[3]"
			},
			{
				"name": "Played",
				"type": "string"
			},
			{
				"name": "Wallet_Address",
				"type": "string"
			},
			{
				"name": "AmtPaid",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"payable": true,
		"stateMutability": "payable",
		"type": "constructor"
	},
	{
		"payable": true,
		"stateMutability": "payable",
		"type": "fallback"
	},
	{
		"constant": false,
		"inputs": [],
		"name": "reset",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "_bAddr",
				"type": "address"
			},
			{
				"indexed": false,
				"name": "_bAmount",
				"type": "uint256"
			},
			{
				"indexed": false,
				"name": "_fav",
				"type": "bool"
			},
			{
				"indexed": false,
				"name": "_totalBets",
				"type": "uint256"
			}
		],
		"name": "aNewBet",
		"type": "event"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "adr",
				"type": "string"
			},
			{
				"name": "_game",
				"type": "uint256"
			},
			{
				"name": "_favOrDog",
				"type": "uint256"
			}
		],
		"name": "makeAbet",
		"outputs": [],
		"payable": true,
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_game",
				"type": "uint256"
			},
			{
				"name": "_favScore",
				"type": "int256"
			},
			{
				"name": "_dogScore",
				"type": "int256"
			}
		],
		"name": "enterGameScores",
		"outputs": [
			{
				"name": "_begBalnce",
				"type": "uint256"
			},
			{
				"name": "_endBalance",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "addressAdded",
				"type": "address"
			},
			{
				"indexed": false,
				"name": "name",
				"type": "string"
			}
		],
		"name": "someOneadded",
		"type": "event"
	}
]
