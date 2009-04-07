package {
	import com.adobe.rtc.authentication.AdobeHSAuthenticator;
	import com.adobe.rtc.events.SharedPropertyEvent;
	import com.adobe.rtc.session.ConnectSession;
	import com.adobe.rtc.sharedModel.SharedProperty;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.containers.Canvas;
	import mx.controls.Image;

	public class Custom extends Canvas
	{
		public static const ADMIN_USER:String = "seanhess@gmail.com";
		public static const ADMIN_PASS:String = "cocomo";
		public static const ROOM_URL:String = "http://connectnow.acrobat.com/seanhessnet/uvuclass";
		
		private var session:ConnectSession;
		private var admin:AdobeHSAuthenticator;
		private var location:Point;
		private var property:SharedProperty;
		private var square:Image;
		private var dragging:Boolean = false;
		
		public function Custom()
		{
			this.percentHeight = 100;
			this.percentWidth = 100;
			connect();	
			addSquare();
			addSharedProperty();
		}
		
		private function connect():void
		{
			session = new ConnectSession();
			admin = new AdobeHSAuthenticator();
			admin.userName = ADMIN_USER;
			admin.password = ADMIN_PASS;
			session.authenticator = admin;
			session.roomURL = ROOM_URL;
			session.login();
		}
		
		private function addSquare():void
		{
			square = new Image();
			square.source = "common/fish.jpg";
			square.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			square.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			addChild(square);
		}
		
		private function onMouseDown(event:Event):void
		{
			square.startDrag();
			dragging = true;
		}
		
		private function onMouseUp(event:Event):void
		{
			property.value = new Point(square.x, square.y);
			square.stopDrag();
			dragging = false;
		}
		
		private function addSharedProperty():void
		{
			property = new SharedProperty();
			property.connectSession = session;
			property.sharedID = "point";
			property.addEventListener(SharedPropertyEvent.CHANGE, onChange);
			property.subscribe();
		}
		
		private function onChange(event:SharedPropertyEvent):void
		{
			var point:* = property.value;

			if (point && !dragging)
			{
				square.x = point.x;
				square.y = point.y;
			}
		}
	}
}
