package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	

	public class SettingMenu extends Sprite
	
	{
		static public var time:int = 300;
		private var design:SettingMenuDesign;
		
		public function SettingMenu()
		
		{
			design = new SettingMenuDesign();
			design.btnEasy.TF.text = "Easy";
			design.btnMedium.TF.text = "Normal";
			design.btnHard.TF.text = "Hard";
			addChild(design);
			
			ButtonHelper.initButton(design.btnEasy, onEasyBtnClick);
			ButtonHelper.initButton(design.btnMedium, onMediumBtnClick);
			ButtonHelper.initButton(design.btnHard, onHardBtnClick);
		}
		
		private function onEasyBtnClick(e:MouseEvent):void
		{
			time = 300;
			var main:Sprite = this.parent as Sprite;
			main.removeChild(this);
			main.addChild(new MainMenu());
		
		}
		
		private function onMediumBtnClick(e:MouseEvent):void
		{
			time = 200;
			var main:Sprite = this.parent as Sprite;
			main.removeChild(this);
			main.addChild(new MainMenu());
		
		}
		
		private function onHardBtnClick(e:MouseEvent):void
		{
			time = 100;
			var main:Sprite = this.parent as Sprite;
			main.removeChild(this);
			main.addChild(new MainMenu());
		}
	
	}

}