package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.elements.TextFlow;
	
	public class MainMenu extends Sprite
	{
		public var setModes:TextField = new TextField;
		public var tf:TextFormat;
		
		private var design:MainMenuDesign;
		
		public function MainMenu()
		{
			design = new MainMenuDesign();
			design.btn_play.TF.text = "Play";
			design.btn_settings.TF.text = "Settings"
			tf = new TextFormat("Times New Roman", 30, 0x000000, false);
			
			switch (SettingMenu.time)
			{
			case 300: 
				setModes.text = "Mode:easy"
				break;
			case 200: 
				setModes.text = "Mode:normal"
				break;
			case 100: 
				setModes.text = "Mode:hard"
			}
			setModes.x = 90;
			setModes.y = 170;
			setModes.width = 200;
			
			setModes.setTextFormat(tf);
			addChild(setModes)
			addChild(design);
			ButtonHelper.initButton(design.btn_play, onPlayBtnClick);
			ButtonHelper.initButton(design.btn_settings, onSettingsBtnClick);
		
		}
		
		private function onPlayBtnClick(e:MouseEvent):void
		{
			var main:Sprite = this.parent as Sprite;
			main.removeChild(this);
			main.addChild(new TetrisGame());
		
		}
		
		private function onSettingsBtnClick(e:MouseEvent):void
		{
			var main:Sprite = this.parent as Sprite;
			main.removeChild(this);
			main.addChild(new SettingMenu());
		
		}
	}

}