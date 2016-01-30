package classes {
	
	import flash.display.*
	import classes.building;
	import classes.buildingData;
	
	public class gameData extends Sprite{
		//	Holds all the game data...surprisingly
		
		private var _coinCount:int;
		private var _clickReward:int;
		private var _coinTotal:int;
		private var _oCoinCount:int;
		private var _clickCount:int;
		private var _coinsSec:int;
		private var _buildings:Object;
		
		public function gameData() {
			//	For the moment just initialises all values to 0
			_coinCount = 0;
			_coinTotal = 0;
			_oCoinCount = 0;
			_clickCount = 0;
			_clickReward = 1;
			_coinsSec = 0;
		}
		
		public function buttonClick(){
			_coinCount += _clickReward;
			_clickCount++;
			_coinTotal += _clickReward;
		}
		public function addBuildings(bList:XMLList){
			_buildings = new Object();
			var len = bList.length();
			for( var i:int = 0; i < len; i++){
				var bId = bList[i].@id;
				var bCost = bList[i].@cost;
				var bBase = bList[i].@base;
				var newBData = new buildingData(bId, bCost, bBase);
				_buildings["b" + bId] = newBData;
			}
		}
		public function buyBuilding(id, amt):Boolean{
			var cost = _buildings[id].cost;
			if(cost <= _coinCount){
				//	Basically if you can afford the building or not
				_coinCount -= cost;
				_buildings[id].buy(amt);
				calcCPS();
				return true;
			} else {
				return false;
			}
		}
		public function getBCost(id):int{
			return _buildings[id].cost;
		}
		public function getBCount(id):int{
			return _buildings[id].count;
		}
		private function calcCPS(){
			//	Set CPS to 0 and then recalculate it
			_coinsSec = 0;
			for( var id:String in _buildings){
				var count = _buildings[id].count;
				var base = _buildings[id].base;
				_coinsSec += count * base;
			}
		}
		public function addCPS():void{
			_coinCount += _coinsSec;
			_coinTotal += _coinsSec;
		}
		
		//	GETTERS
		public function get Coins():int{
			return _coinCount;
		}
		public function get oCoins():int{
			return _oCoinCount;
		}
		public function get Clicks():int{
			return _clickCount;
		}
		public function get coinsTotal():int{
			return _coinTotal;
		}
		public function get clickReward():int{
			return _clickReward;
		}
		public function get coinsSec():int{
			return _coinsSec;
		}
	}
	
}
