package 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author me
	 */
	public class ButtonHelper 
	{
		
		static public function initButton(btn:MovieClip, clickCallBack:Function):void
		{
			btn.addEventListener(MouseEvent.CLICK, clickCallBack);
			btn.buttonMode = true;
			btn.mouseChildren = false;
		}
	}

}