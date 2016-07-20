package
{
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class Cell extends Shape
	{
		public var type:int = 0;
		public var i:int;
		public var j:int;
		
		public function Cell(x:int, y:int, posI:int, posJ:int)
		{
			
			i = posI;
			j = posJ;
			
			super.x = x;
			super.y = y;
		}
		
		public function drawCell(misha:Sprite):void
		{
			switch (type)
			{
			case 0: 
				graphics.beginFill(0xE6E6FA, 1);
				graphics.drawRect(super.x, super.y, 20, 20);
				graphics.endFill();
				break;
			case 1: 
				graphics.beginFill(0xFFD700, 1);
				graphics.drawRect(super.x, super.y, 20, 20);
				graphics.endFill();
				break;
			
			default: 
				break;
			}
		}
	
	}

}