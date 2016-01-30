package classes {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import classes.mainButton;
	import classes.gameData;
	import classes.building;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.utils.*;
	
	public class Game extends MovieClip {
		private var _gameData:gameData;
		private var _xmlLoader:URLLoader;
		private var timer:Timer = new Timer(1000, 0);
		
		public function Game() {
			// Instantiate a fresh gameData object;
			_gameData = new gameData();
			//	Set up the eventHandler on the button
			mainButton.addEventListener(MouseEvent.CLICK, onButtonClick);
			
			//	Generate building buttons from xml file
			var url:URLRequest = new URLRequest("data/buildings.xml");
			_xmlLoader = new URLLoader(url);
			_xmlLoader.addEventListener(Event.COMPLETE, displayBuildings);
			
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, gameLoop);
			updateDisplay();
		}
		
		private function onButtonClick(e:MouseEvent){
			_gameData.buttonClick();
			updateDisplay();
		}
		
		private function displayBuildings(e:Event):void{
			var xml:XML = new XML(_xmlLoader.data);
			var buildingList:XMLList = xml.building;
			var len:int = buildingList.length();
			for( var i:int = 0; i < len; i++){
				//	Cycle through the list of buildings and generate buttons for them. 
				var bName = buildingList[i].@name;
				var bCost = buildingList[i].@cost;
				var bId = buildingList[i].@id;
				var newBuilding = new building(bId, bName, bCost);
				newBuilding.name = "b" + bId;
				newBuilding.x = 10;
				newBuilding.y = 4 + (i *64);
				buildingPanel.addChild(newBuilding);
				newBuilding.addEventListener(MouseEvent.CLICK, buildingClick);
			}
			// Send buildingList to _gameData to add the relevant data
			_gameData.addBuildings(buildingList);
			
			updateDisplay();
		}
		private function buildingClick(e:MouseEvent):void{
			//	When a building is clicked to buy one
			//	first checks to see if the 
			var bId = e.target.id;
			if(_gameData.buyBuilding(bId, 1)){
				//	If you successfully bought the building
				//	update the button to reflect the new values
				var newCost:int = _gameData.getBCost(bId);
				var newCount:int = _gameData.getBCount(bId);
				var uBuilding = buildingPanel.getChildByName(bId);
				uBuilding.bCount_tf.text = newCount.toString();
				uBuilding.bCost_tf.text = newCost.toString();
			}
			updateDisplay();
		}
		
		private function updateDisplay(){
			//	Updates the display
			currencyPanel.coinsCount_tf.text = _gameData.Coins.toString();
			currencyPanel.oCoinsCount_tf.text = _gameData.oCoins.toString();
			currencyPanel.clickReward_tf.text = _gameData.clickReward.toString();
			currencyPanel.coinsSec_tf.text = _gameData.coinsSec.toString();
			statsPanel.coinsTotal_tf.text = _gameData.coinsTotal.toString();
			statsPanel.clickTotal_tf.text = _gameData.Clicks.toString();
		}
		
		private function gameLoop(e:TimerEvent):void{
			_gameData.addCPS();
			updateDisplay();
		}
	}
	
}
