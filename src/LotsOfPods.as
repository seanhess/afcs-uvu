package {
	import com.adobe.rtc.authentication.AdobeHSAuthenticator;
	import com.adobe.rtc.pods.FileShare;
	import com.adobe.rtc.pods.Note;
	import com.adobe.rtc.pods.Roster;
	import com.adobe.rtc.pods.SimpleChat;
	import com.adobe.rtc.pods.WebCamera;
	import com.adobe.rtc.session.ConnectSession;
	
	import mx.containers.VBox;

	public class LotsOfPods extends VBox
	{
		public static const ADMIN_USER:String = "seanhess@gmail.com";
		public static const ADMIN_PASS:String = "cocomo";
		public static const ROOM_URL:String = "http://connectnow.acrobat.com/seanhessnet/uvuclass";
		
		private var session:ConnectSession;
		private var admin:AdobeHSAuthenticator;
		
		public function LotsOfPods()
		{
			connect();		
			addEverything();
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
		
		private function addEverything():void
		{
			addChild(new FileShare());
			addChild(new Roster());
			addChild(new Note());
			addChild(new SimpleChat());
			addChild(new WebCamera());
		}
	}
}
