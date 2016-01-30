package classes {
	
	public class buildingData {
		
		private var _bId:int;
		private var _bCost:int;
		private var _bBase:int;
		private var _bCostMultiplier:Number;
		private var _bCount:int;
		private var _bMaxCount:int;
		
		public function buildingData(id, cost, base) {
			_bId = id;
			_bCost = cost;
			_bBase = base;
			_bCount = 0;
			_bMaxCount = 0;
			_bCostMultiplier = 1.15;
		}
		
		public function get cost():int{
			return _bCost;
		}
		public function get count():int{
			return _bCount;
		}
		public function get base():int{
			return _bBase;
		}
		public function buy(amt:int):void{
			_bCount += amt;
			if(_bCount > _bMaxCount){
				_bMaxCount = _bCount;
			}
			_bCost = _bCost * _bCostMultiplier;
		}
	}
	
}
