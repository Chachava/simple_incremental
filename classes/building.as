package classes {
	
	import flash.display.MovieClip;

	public class building extends MovieClip {
		
		private var _id:String;
		private var _name:String;
		public function building(id, name ,cost) {
			_id = "b" + id;
			_name = name;
			bName_tf.text = name;
			bCount_tf.text = "0";
			bCost_tf.text = cost.toString();
			mouseChildren = false;
			buttonMode = true;
		}
		
		public function addBuilding(count):void{
		}
		
		public function get id():String{
			return _id;
		}
		
	}
	
}
