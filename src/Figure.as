package
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import Math;
	
	public class Figure extends Shape
	{
		protected var cage:Shape;
		
		public var rotation_num:int = 0;
		public var zeroCell:Array = [0, 4];
		public var figureType:int = Math.round(Math.random() * 6);
		
		public var rotations:Array;
		public var shape:Array;
		
		public function drawCage(x:int, y:int):void
		{
			
			graphics.beginFill(0x00CED1, 1);
			graphics.drawRect(x, y, 20, 20);
			graphics.endFill();
		}
		
		public function addFigure():void
		{
			shape = rotations[rotation_num];
			for (var i:int = 0; i < shape.length; i++)
			{
				for (var j:int = 0; j < shape[i].length; j++)
				{
					if (shape[i][j] != 0)
					{
						cage = new Shape();
						
						cage.x = (j + zeroCell[1]) * 22;
						cage.y = (i + zeroCell[0]) * 22;
						drawCage(cage.x, cage.y);
						
					}
				}
			}
		}
		
		public function Figure()
		{
			
			switch (figureType)
			{
			case 0://"J": 
				rotations = [[[0, 1], [0, 1], [1, 1]], [[1, 0, 0], [1, 1, 1]], [[1, 1], [1, 0], [1, 0]], [[1, 1, 1], [0, 0, 1]]];
				break;
			case 1:// "O": 
				rotations = [[[1, 1], [1, 1]], [[1, 1], [1, 1]], [[1, 1], [1, 1]], [[1, 1], [1, 1]]];
				break;
			case 2://"L": 
				rotations = [[[1, 0], [1, 0], [1, 1]], [[1, 1, 1], [1, 0, 0]], [[1, 1], [0, 1], [0, 1]], [[0, 0, 1], [1, 1, 1]]];
				break;
			case 3://"S": 
				
				rotations = [[[0, 1, 1], [1, 1, 0]], [[1, 0], [1, 1], [0, 1]], [[0, 1, 1], [1, 1, 0]], [[1, 0], [1, 1], [0, 1]]];
				break;
			case 4://"Z": 
				
				rotations = [[[1, 1, 0], [0, 1, 1]], [[0, 1], [1, 1], [1, 0]], [[1, 1, 0], [0, 1, 1]], [[0, 1], [1, 1], [1, 0]]];
				break;
			case 5://"T": 
				
				rotations = [[[1, 1, 1], [0, 1, 0]], [[0, 1], [1, 1], [0, 1]], [[0, 1, 0], [1, 1, 1]], [[1, 0], [1, 1], [1, 0]]];
				break;
			case 6://"I": 
				
				rotations = [[[1], [1], [1], [1]], [[1, 1, 1, 1]], [[1], [1], [1], [1]], [[1, 1, 1, 1]]];
				break;
			}
			
			addFigure();
		
		}
	
	}

}