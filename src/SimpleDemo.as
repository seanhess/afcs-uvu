package {
	import com.adobe.rtc.authentication.AdobeHSAuthenticator;
	import com.adobe.rtc.pods.SharedWhiteBoard;
	import com.adobe.rtc.session.ConnectSession;
	
	import mx.containers.Canvas;

	public class SimpleDemo extends Canvas
	{
		public static const ADMIN_USER:String = "seanhess@gmail.com";
		public static const ADMIN_PASS:String = "cocomo";
		public static const ROOM_URL:String = "http://connectnow.acrobat.com/seanhessnet/uvuclass";
		
		private var session:ConnectSession;
		private var admin:AdobeHSAuthenticator;
		private var board:SharedWhiteBoard;
		
		public function SimpleDemo()
		{
			connect();		
			addBoard();
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
		
		private function addBoard():void
		{
			board = new SharedWhiteBoard();
			board.width = 800;
			board.height = 600;
			
			addChild(board);
		}
	}
}
