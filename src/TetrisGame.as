package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import Math;
	import flash.text.TextField;
	import flash.utils.getTimer;
	

	public class TetrisGame extends Sprite
	{
		
		var placed:Array;
		
		public var timer:Timer = new Timer(SettingMenu.time);

		var figure:Figure;
		var score:int;
		var scoreField:TextField;
		var text:TextField;
		
		var leftKey:Key;
		var rightKey:Key;
		var upKey:Key;
		var downKey:Key;
		
		public function TetrisGame()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			this.removeChildren();
			
			leftKey = new Key();
			rightKey = new Key();
			upKey = new Key();
			downKey = new Key();
			
			score = 0;
			scoreField = new TextField();
			scoreField.x = 320;
			scoreField.y = 30;
			text = new TextField();
			text.x = 300;
			text.y = 200;
			text.text = "Press Esc to exit"
			addChild(scoreField);
			addChild(text);
			placed = new Array(13)
			for (var i:int = 0; i < placed.length; i++)
			{
				placed[i] = new Vector.<Cell>(20);
				for (var j:int = 0; j < placed[i].length; j++)
				{
					placed[i][j] = new Cell(i * 11, j * 11, i, j);
					addChild(placed[i][j]);
					placed[i][j].drawCell(this);
					
				}
			}
			
			figure = new Figure();
			addChild(figure);
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			stage.focus = this;
			stage.addEventListener(Event.ENTER_FRAME, move);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, startMove);
			stage.addEventListener(KeyboardEvent.KEY_UP, stopMove);
			timer.addEventListener(TimerEvent.TIMER, refresh);

			timer.start();
			
		
		}
		
		private function falling():Boolean
		{
			
			for (var i:int = 0; i < figure.shape.length; i++)
			{
				for (var j:int = 0; j < figure.shape[i].length; j++)
				{
					if (figure.shape[i][j] != 0)
					{
						
						if (i + figure.zeroCell[0] + 1 > placed[0].length - 1 || placed[j + figure.zeroCell[1]][i + figure.zeroCell[0] + 1].type != 0)
						{
							return false;
						}
						
					}
				}
				
			}
			return true;
		}
		
		private function refresh(e:TimerEvent):void
		{
			
			scoreField.text = "Score: " + score.toString();
			clearFullRows();
			
			if (falling())
			{
				
				figure.zeroCell[0]++;
				figure.graphics.clear();
				figure.addFigure();

				
			}
			else
			{
				for (var i:int = 0; i < figure.shape.length; i++)
				{
					for (var j:int = 0; j < figure.shape[i].length; j++)
					{
						if (figure.shape[i][j] != 0)
						{
							placed[j + figure.zeroCell[1]][i + figure.zeroCell[0]].type = 1;
							placed[j + figure.zeroCell[1]][i + figure.zeroCell[0]].drawCell(this);
							
						}
					}
					
				}
				removeChild(figure);
				figure = new Figure();
				
				if (newFigure())
				{
					
					addChild(figure);
				}
				else
				{
					gameOver();
				}
			}
		}
		

		
		private function canMoveRight():Boolean
		{
			
			for (var i:int = 0; i < figure.shape.length; i++)
			{
				for (var j:int = 0; j < figure.shape[i].length; j++)
				{
					if (figure.shape[i][j] != 0)
					{
						if (figure.figureType == 6)
						{
							if (i + figure.zeroCell[1] + 1 > placed.length + 2 || placed[j + figure.zeroCell[1] + 1][i + figure.zeroCell[0]].type != 0)
							{
								return false;
							}
						}
						else
						{
							if (i + figure.zeroCell[1] + 1 > placed.length || placed[j + figure.zeroCell[1] + 1][i + figure.zeroCell[0]].type != 0)
							{
								return false;
							}
						}
						
					}
				}
				
			}
			return true;
		}
		
		private function canMoveLeft():Boolean
		{
			
			for (var i:int = 0; i < figure.shape.length; i++)
			{
				for (var j:int = 0; j < figure.shape[i].length; j++)
				{
					if (figure.shape[i][j] != 0)
					{
						
						if (i + figure.zeroCell[1] - 1 < 0 || placed[j + figure.zeroCell[1] - 1][i + figure.zeroCell[0]].type != 0)
						{
							return false;
						}
						
					}
				}
				
			}
			return true;
		}
		
		private function startMove(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{
			
			case Keyboard.LEFT:
				
				leftKey.isPressed = true;
				
				leftKey.whenPressed = getTimer();
				
				break;
			case Keyboard.RIGHT:
				
				rightKey.isPressed = true;
				rightKey.whenPressed = getTimer();
				
				break;
			case Keyboard.DOWN:
				
				downKey.isPressed = true;
				downKey.whenPressed = getTimer();
				
				break;
			case Keyboard.UP:
				
				upKey.isPressed = true;
				upKey.whenPressed = getTimer();
				
				break;
			case Keyboard.ESCAPE:
				
				this.removeChildren();
				addChild(new MainMenu());
				
			}
		}
		
		private function stopMove(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{
			case Keyboard.LEFT:
				
				leftKey.isPressed = false;
				leftKey.wasPressed = false;
				
				break;
			case Keyboard.RIGHT:
				
				rightKey.isPressed = false;
				rightKey.wasPressed = false;
				break;
			case Keyboard.DOWN:
				
				downKey.isPressed = false;
				downKey.wasPressed = false;
				break;
			case Keyboard.UP:
				
				upKey.isPressed = false;
				upKey.wasPressed = false;
			}
		
		}
		
		private function move(e:Event):void
		{
			if (leftKey.isPressed == true)
				
			{
				if (leftKey.wasPressed == false || getTimer() - leftKey.whenPressed > 200)
				{
					if (canMoveLeft())
					{
						
						figure.zeroCell[1]--;
						figure.graphics.clear();
						figure.addFigure();
						leftKey.wasPressed = true;
					}
				}
			}
			if (rightKey.isPressed == true)
			{
				if (rightKey.wasPressed == false || getTimer() - rightKey.whenPressed > 200)
				{
				if (canMoveRight())
				{
					
					figure.zeroCell[1]++;
					figure.graphics.clear();
					figure.addFigure();
					rightKey.wasPressed = true;
				}
			}
			}
			if (downKey.isPressed == true)
			{
				if (downKey.wasPressed == false || getTimer() - downKey.whenPressed > 200)
				{
				if (falling())
				{
					
					figure.zeroCell[0]++;
					figure.graphics.clear();
					figure.addFigure();
					downKey.wasPressed = true;
				}
			}
			}
			if (upKey.isPressed == true)
			{
				if (upKey.wasPressed == false || getTimer() - upKey.whenPressed > 200)
				{
				if (canRotate())
				{
					
					if (figure.rotation_num < 3)
					{
						figure.rotation_num++;
					}
					else
					{
						figure.rotation_num = 0;
					}
					
					figure.graphics.clear();
					figure.addFigure();
					upKey.wasPressed = true;
					
				}
				}
			}
		
		}
		
		private function canRotate():Boolean
		{
			var nextShape:Array
			if (figure.rotation_num < 3)
			{
				nextShape = figure.rotations[figure.rotation_num + 1];
			}
			else
			{
				nextShape = figure.rotations[0];
			}
			
			for (var i:int = 0; i < nextShape.length; i++)
			{
				for (var j:int = 0; j < nextShape[i].length; j++)
				{
					if (nextShape[i][j] != 0)
					{
						
						if (placed[j + figure.zeroCell[1]][i + figure.zeroCell[0]].type != 0)
						{
							return false;
						}
						
					}
				}
				
			}
			return true;
		}
		
		private function gameOver():void
		{
			timer.stop();
			placed.length = 0;
			graphics.clear();
			init();
		}
		
		private function newFigure():Boolean
		{
			for (var i:int = 0; i < figure.shape.length; i++)
			{
				for (var j:int = 0; j < figure.shape[i].length; j++)
				{
					if (figure.shape[i][j] != 0)
					{
						
						if (placed[j + figure.zeroCell[1]][i + figure.zeroCell[0]].type != 0)
						{
							return false;
						}
						
					}
				}
				
			}
			return true;
		}
		
		private function isFullRow(num:int):Boolean
		{
			for (var i:int = 0; i < placed.length; i++)
			{
				if (placed[i][num].type == 0)
				{
					return false;
				}
			}
			return true;
		}
		
		private function clearFullRows():void
		{
			for (var i:int = 0; i < placed[0].length; i++)
			{
				if (isFullRow(i))
				{
					if (SettingMenu.time == 300)
					{
						score++;
					}
					else if (SettingMenu.time == 200)
					{
						score += 10;
					}
					else
					{
						score += 20;
					}
					for (var j:int = 0; j < placed.length; j++)
					{
						placed[j][i].graphics.clear();
						placed[j].splice(i, 1);
						
					}
					for (var z:int = 0; z < placed.length; z++)
					{
						for (var x:int = 0; x < i; x++)
						{
							placed[z][x].j++;
							placed[z][x].y += 11;
							
						}
						placed[z].unshift(new Cell(z * 11, 0, z, 0));
						addChild(placed[z][0]);
						
					}
					
					for each (var cells:Vector.<Cell> in placed)
					{
						for each (var cell:Cell in cells)
						{
							cell.graphics.clear();
							cell.drawCell(this);
						}
					}
					
				}
			}
		
		}
	
	}

}

