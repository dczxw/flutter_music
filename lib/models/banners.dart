
class Banners {

  String pic;
  int targetId;
  Object adid;
  int targetType;
  String titleColor;
  String typeTitle;
  String url;
  Object adurlV2;
  bool exclusive;
  Object monitorImpress;
  Object monitorClick;
  Object monitorType;
  List<Object> monitorImpressList;
  List<Object> monitorClickList;
  Object monitorBlackList;
  Object extMonitor;
  Object extMonitorInfo;
  Object adSource;
  Object adLocation;
  String encodeId;
  Object program;
  Object event;
  Object video;
  Object dynamicVideoData;
  Object song;
  String bannerId;
  Object alg;
  String scm;
  String requestId;
  bool showAdTag;
  Object pid;
  Object showContext;
  Object adDispatchJson;

	Banners.fromJsonMap(Map<String, dynamic> map): 
		pic = map["pic"],
		targetId = map["targetId"],
		adid = map["adid"],
		targetType = map["targetType"],
		titleColor = map["titleColor"],
		typeTitle = map["typeTitle"],
		url = map["url"],
		adurlV2 = map["adurlV2"],
		exclusive = map["exclusive"],
		monitorImpress = map["monitorImpress"],
		monitorClick = map["monitorClick"],
		monitorType = map["monitorType"],
		monitorImpressList = map["monitorImpressList"],
		monitorClickList = map["monitorClickList"],
		monitorBlackList = map["monitorBlackList"],
		extMonitor = map["extMonitor"],
		extMonitorInfo = map["extMonitorInfo"],
		adSource = map["adSource"],
		adLocation = map["adLocation"],
		encodeId = map["encodeId"],
		program = map["program"],
		event = map["event"],
		video = map["video"],
		dynamicVideoData = map["dynamicVideoData"],
		song = map["song"],
		bannerId = map["bannerId"],
		alg = map["alg"],
		scm = map["scm"],
		requestId = map["requestId"],
		showAdTag = map["showAdTag"],
		pid = map["pid"],
		showContext = map["showContext"],
		adDispatchJson = map["adDispatchJson"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['pic'] = pic;
		data['targetId'] = targetId;
		data['adid'] = adid;
		data['targetType'] = targetType;
		data['titleColor'] = titleColor;
		data['typeTitle'] = typeTitle;
		data['url'] = url;
		data['adurlV2'] = adurlV2;
		data['exclusive'] = exclusive;
		data['monitorImpress'] = monitorImpress;
		data['monitorClick'] = monitorClick;
		data['monitorType'] = monitorType;
		data['monitorImpressList'] = monitorImpressList;
		data['monitorClickList'] = monitorClickList;
		data['monitorBlackList'] = monitorBlackList;
		data['extMonitor'] = extMonitor;
		data['extMonitorInfo'] = extMonitorInfo;
		data['adSource'] = adSource;
		data['adLocation'] = adLocation;
		data['encodeId'] = encodeId;
		data['program'] = program;
		data['event'] = event;
		data['video'] = video;
		data['dynamicVideoData'] = dynamicVideoData;
		data['song'] = song;
		data['bannerId'] = bannerId;
		data['alg'] = alg;
		data['scm'] = scm;
		data['requestId'] = requestId;
		data['showAdTag'] = showAdTag;
		data['pid'] = pid;
		data['showContext'] = showContext;
		data['adDispatchJson'] = adDispatchJson;
		return data;
	}
}
