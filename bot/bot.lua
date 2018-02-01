tdcli =  dofile ( ' ./tg/tdcli.lua ' )
serpent = ( loadfile  " ./libs/serpent.lua " ) ()
feedperser = ( loadfile  " ./libs/feedparser.lua " ) ()
require ( ' ./bot/utils ' )
URL =  require  " socket.url "
http =  require  " socket.http "
https =  require  " ssl.https "
ltn12 =  نیاز به  " ltn12 "
json = ( loadfile  " ./libs/JSON.lua " ) ()
نوعمایم = ( loadfile  " ./libs/mimetype.lua " ) ()
redis = ( loadfile  " ./libs/redis.lua " ) ()
JSON = ( loadfile  " ./libs/dkjson.lua " ) ()
محلی lgi =  require ( ' lgi ' )
local notify = lgi. درخواست ( ' اطلاع ' )
اعلام کردن. init ( " Telegram به روزرسانی " )
chats = {}
helper_id =  418516842  - شناسه Bot Helper خود را در اینجا قرار دهید

تابع do_notify ( کاربران ، MSG )
	محلی n = اطلاع هشدار از طریق . جدید (کاربر، پیام)
	n: show ()
پایان

تابع dl_cb ( arg ، data )
	- نام کاربری (اطلاعات)
پایان
نامگذاری تابع ( ارزش )
	چاپ (مار ( بلوک) (ارزش {comment = false }))
پایان
عملکرد load_data ( نام فایل )
	محلی f =  io.open (نام فایل)
	اگر  نمی ج پس از آن
		بازگشت {}
	پایان
	محلی s = f: خواندن ( ' * همه " )
	f: close ()
	داده های محلی = JSON رمزگشایی (ها)
	داده های بازگشت
پایان

function save_data ( نام فایل ، داده )
	محلی s = JSON رمزگذاری (داده ها)
	محلی f =  io.open (نام فایل، ' w ' )
	f: نوشتن (ها)
	f: close ()
پایان

تابع match_plugins ( msg )
	برای نام، پلاگین در  جفت (پلاگین) انجام دهید
		match_plugin (پلاگین، نام، پیام)
	پایان
پایان

- اعمال تابع plugin.pre_process
عملکرد pre_process_msg ( msg )
  برای نام، پلاگین در  جفت (پلاگین) انجام دهید
    اگر پلاگین pre_process  و msg پس از آن
      چاپ ( ' پیش پردازش ' ، نام)
      نتیجه = پلاگین pre_process (msg)
    پایان
  پایان
   نتیجه بازگشت
پایان

function save_config ()
	serialize_to_file (_config، ' ./data/config.lua ' )
	چاپ ( ' پیکربندی ذخیره شده در ./data/config.lua ' )
پایان

تابع کایامی ()
	محلی USR =  io.popen ( " از whoami " ): به عنوان خوانده شده ( : * یک : )
	usr =  string.gsub (usr، ' ^٪ s + ' ، ' ' )
	usr =  string.gsub (usr، ' ٪ s + $ ' ، ' ' )
	usr =  string.gsub (usr، ' [ \ n \ r ] + ' ، '  ' )
	اگر usr: match ( " ^ root $ " ) پس از آن
		tcpath =  ' /root/.telegram-cli '
	ELSEIF  نمی USR: بازی ( " ^ ریشه $ " ) پس از آن
		tcpath =  ' / home / ' .. usr .. ' /.telegram-cli '
	پایان
  print ( ' >> Download Path = ' .. tcpath)
پایان

function create_config ()
  - پیکربندی ساده با پلاگین های اصلی و خودمان به عنوان کاربر مهمان
	config = {
    enabled_plugins = {
    " BanHammer " ،
    " پاپ " ،	
    " GroupManager " ،
    " MSG-چک " ،	
    " پلاگین " ،
    " ابزارهای " ،
    " نوشتن "
	}،
    sudo_users = { 377450049 ، 418516842 ، 284298227 }،
    admins = {}
    disabled_channels = {}
    moderation = {data =  ' ./data/moderation.json ' }،
    info_text =  [[
	"MaTaDoR BoT v5.7
یک ربات مدیریت پیشرفته بر اساس https://valtman.name/telegram-cli
"https://github.com/BeyondTeam/BDReborn 
"مدیران:
"MahDiRoO ➣ سازنده و توسعه دهنده"
"@ JavadSudo ➣ توسعهدهنده"
"Shaniloop ➣ توسعهدهنده"
"تشکر ویژه از:
"ماتادور"
"@ Xamarin_Devloper
"کانال ما:
"MaTaDoRTeam"
]] ،
  }
	serialize_to_file (config، ' ./data/config.lua ' )
	چاپ ( ' پیکربندی ذخیره شده به conf.lua ' )
پایان

- پیکربندی را از فایل config.lua باز می گرداند.
- اگر فایل وجود ندارد، آن را ایجاد کنید.
عملکرد load_config ()
	محلی F =  io.open ( ، ./data/config.lua ، ، " R " )
  - اگر config.lua وجود ندارد
	اگر  نمی ج پس از آن
		چاپ ( " ایجاد فایل پیکربندی جدید: ./data/config.lua " )
		create_config ()
	چیز دیگری
		f: close ()
	پایان
	local config =  loadfile ( " ./data/config.lua " ) ()
	برای v، کاربر در  جفت (config. sudo_users ) انجام می شود
		چاپ ( " مجاز کاربر: "  .. کاربر)
	پایان
	پیکربندی بازگشت
پایان
کایامی ()
plugins = {}
_config =  load_config ()

function load_plugins ()
	local config =  loadfile ( " ./data/config.lua " ) ()
	برای k، v در  جفت (config. enabled_plugins ) انجام می شود
		چاپ ( " بارگیری پلاگین " ، V)
		محلی ok، err =   pcall ( function ()
		محلی t =  loadfile ( " plugins / " .. v .. ' .lua ' ) ()
		پلاگین [v] = t
		پایان )
		اگر  خوب نیست پس
			چاپ ( ' \ 27 [31mError بارگذاری پلاگین ها ' .. v .. ' \ 27 [39m ' ]
			چاپ ( متد toString ( io.popen ( " LUA پلاگین ها / " .. V .. " .lua " ): به عنوان خوانده شده ( : * همه ، )))
			چاپ ( ' \ 27 [31m ' .. اشتباه .. ' \ 27 [39m ' ]
		پایان
	پایان
پایان

عملکرد msg_valid ( msg )
	 اگر MSG. date_  <  os.time () -  60  بعد
        چاپ ( ' \ 27 [36mNot معتبر: old msg ' 27 [39m ' ]
		 بازگشت  نادرست
	 پایان
 اگر  is_silent_user (msg. sender_user_id_ ، msg. chat_id_ ) سپس است
 del_msg (msg. chat_id_ ، msg. id_ )
    بازگشت  نادرست
 پایان
 اگر  is_banned باشد (msg. sender_user_id_ ، msg. chat_id_ ) سپس
 del_msg (msg. chat_id_ ، tonumber (msg. id_ ))
     kick_user (msg. sender_user_id_ ، msg. chat_id_ )
    بازگشت  نادرست
    پایان
 اگر  is_gbanned (msg. sender_user_id_ ) باشد، سپس
 del_msg (msg. chat_id_ ، tonumber (msg. id_ ))
     kick_user (msg. sender_user_id_ ، msg. chat_id_ )
    بازگشت  نادرست
       پایان
    بازگشت  درست است
پایان

تابع match_pattern ( الگوی ، متن ، lower_case )
	اگر متن پس از آن
		مسابقات محلی = {}
		اگر lower_case سپس
			matches = { string.match (text: lower ()، pattern}}
		چیز دیگری
			matches = { string.match (متن، الگوی)}
		پایان
		اگر  بعدی (مسابقات) سپس
			بازگشت به مسابقات
		پایان
	پایان
پایان

- بررسی کنید که آیا پلاگین در جدول _config.disabled_plugin_on_chat است
تابع محلی is_plugin_disabled_on_chat (نام پلاگین ، گیرنده )
  local disabled_chats = _config. disabled_plugin_on_chat
  - جدول وجود دارد و گپ افزونه ها را غیر فعال کرده است
  اگر disabled_chats و disabled_chats [گیرنده] پس از آن باشد
    - چک کردن اینکه آیا افزونه در این چت غیرفعال است یا خیر
    برای disabled_plugin، غیر فعال در  جفت (disabled_chats [گیرنده]) انجام دهید
      اگر disabled_plugin == plugin_name باشد و پس از آن غیرفعال شود
        هشدار محلی =  ' _Plugin_ * ' .. check_markdown (disabled_plugin) .. ' * این در این چت_ غیرفعال است '
        چاپ (هشدار)
						tdcli sendMessage (گیرنده، " " ، 0 ، هشدار، 0 ، " md " )
        بازگشت  درست است
      پایان
    پایان
  پایان
  بازگشت  نادرست
پایان

function match_plugin ( plugin ، plugin_name ، msg ) function
	برای k، الگوی در  جفت (پلاگین الگوهای ) انجام دهید
		matches =  match_pattern (الگوی، متن  msg یا msg. media . caption )
		اگر بعدا مطابقت داشته باشد
      اگر  is_plugin_disabled_on_chat (plugin_name، msg. chat_id_ ) باشد، سپس
        بازگشت  نزولی
      پایان
			چاپ ( " پیام ها: " ، الگو .. ' | پلاگین: ' .. plugin_name)
			اگر پلاگین اجرا  پس از آن
        اگر  نه  warns_user_not_allowed (plugin، msg) سپس
				نتیجه محلی = پلاگین اجرا شود (msg، matches)
					اگر نتیجه پس از آن
						tdcli sendMessage (MSG. chat_id_ ، MSG. id_ ، 0 ، نتیجه، 0 ، " MD " )
                 پایان
					پایان
			پایان
			برگشت
		پایان
	پایان
پایان
_config =  load_config ()
load_plugins ()

 تابع var_cb ( msg ، data )
  - ----------- دریافت وار ------------
	bot = {}
	msg به  = {}
	msg از  = {}
	msg media  = {}
	msg id  = msg شناسه_
	msg به . type  =  gp_type ( data.chat_id_ )
	اگر داده content_ . caption_  سپس
		msg رسانه . caption  = data content_ . caption_
	پایان

	اگر داده reply_to_message_id_  ~ =  0  سپس
		msg reply_id  = data reply_to_message_id_
    چیز دیگری
		msg reply_id  =  false
	پایان
	 تابع get_gp ( arg ، data )
		اگر  gp_type (msg. chat_id_ ) ==  " کانال "  یا  gp_type (msg. chat_id_ ) ==  " چت "  سپس
			msg به . id  = msg chat_id_
			msg به . title  = data عنوان_
		چیز دیگری
			msg به . id  = msg chat_id_
			msg به . title  =  false
		پایان
	پایان
	tdcli_function ({ID =  " GetChat " ، chat_id_ = data، chat_id_ }، get_gp، nil )
	عملکرد botifo_cb ( arg ، data )
		ربات id  = data شناسه_
		our_id = داده ها شناسه_
		اگر داده username_  سپس
			ربات username  = data نام کاربری_
		چیز دیگری
			ربات username  =  false
		پایان
		اگر داده first_name_  سپس
			ربات first_name  = data نام کوچک_
		پایان
		اگر داده last_name_  پس از آن
			ربات last_name  = data نام خانوادگی_
		چیز دیگری
			ربات last_name  =  اشتباه است
		پایان
		اگر داده first_name_  و داده ها. last_name_  پس از آن
			ربات print_name  = data first_name_ .. '  ' .. داده ها. نام خانوادگی_
		چیز دیگری
			ربات print_name  = data نام کوچک_
		پایان
		اگر داده phone_number_  پس از آن
			ربات تلفن  = اطلاعات شماره تلفن_
		چیز دیگری
			ربات تلفن  =  اشتباه
		پایان
	پایان
	tdcli_function ({ID =  ' GetMe ' }، botifo_cb، {chat_id = msg. chat_id_ })
	 function get_user ( arg ، data )
		msg از . id  = data شناسه_
		اگر داده username_  سپس
			msg از . username  = data نام کاربری_
		چیز دیگری
			msg از . username  =  false
		پایان
		اگر داده first_name_  سپس
			msg از . first_name  = data نام کوچک_
		پایان
		اگر داده last_name_  پس از آن
			msg از . last_name  = data نام خانوادگی_
		چیز دیگری
			msg از . last_name  =  اشتباه است
		پایان
		اگر داده first_name_  و داده ها. last_name_  پس از آن
			msg از . print_name  = data first_name_ .. '  ' .. داده ها. نام خانوادگی_
		چیز دیگری
			msg از . print_name  = data نام کوچک_
		پایان
		اگر داده phone_number_  پس از آن
			msg از . تلفن  = اطلاعات شماره تلفن_
		چیز دیگری
			msg از . تلفن  =  اشتباه
		پایان
     دروغ =  نادرست
		match_plugins (msg)
pre_process_msg (msg)
	پایان
	tdcli_function ({ID =  " GetUser " ، user_id_ = data. sender_user_id_ }، get_user، nil )
- ----------- پایان -------------

پایان


تابع tdcli_update_callback ( داده ها )
	اگر (داده ID  ==  " UpdateNewMessage " ) پس از آن

		msg = دادههای محلی پیام_
		محلی d = داده disable_notification_
		چت محلی = چت [پیام. chat_id_ ]
		محلی هش =  " پیام های: ، .. MSG. sender_user_id_ .. : : : .. MSG. chat_id_
		قرمز: incr (هش)
		اگر redis: get ( ' markread ' ) ==  ' on '  سپس
			tdcli viewMessages (msg. chat_id_ ، {[ 0 ] = msg. id_ }، dl_cb، nil )
    پایان
		اگر (( نه D) و چت) پس از آن
			اگر MSG. content_ . ID  ==  " MessageText "  سپس
				do_notify (چت. title_ ، MSG. content_ . text_ )
			چیز دیگری
				do_notify (چت title_ ، msg. content_ . ID )
			پایان
		پایان
   اگر  msg_valid (msg) سپس
		var_cb (msg، msg)
	اگر MSG. content_ . ID  ==  " MessageText "  سپس
			msg متن  = msg content_ . متن_
			msg edited  =  false
			msg پین شده  =  نادرست
	ELSEIF MSG. content_ . ID  ==  " MessagePinMessage "  سپس
		msg پین شده  =  درست است
	ELSEIF MSG. content_ . ID  ==  " MessagePhoto "  سپس
		msg عکس_  =  درست است 

	ELSEIF MSG. content_ . ID  ==  " MessageVideo "  سپس
		msg video_  =  درست است

	ELSEIF MSG. content_ . ID  ==  " MessageAnimation "  سپس
		msg انیمیشن_  =  درست است

	ELSEIF MSG. content_ . ID  ==  " MessageVoice "  سپس
		msg voice_  =  true

	ELSEIF MSG. content_ . ID  ==  " MessageAudio "  سپس
		msg audio_  =  درست است

	ELSEIF MSG. content_ . ID  ==  " MessageForwardedFromUser "  سپس
		msg forward_info_  =  درست است

	ELSEIF MSG. content_ . ID  ==  " MessageSticker "  سپس
		msg sticker_  =  درست است

	ELSEIF MSG. content_ . ID  ==  " ContactContact "  سپس
		msg contact_  =  true
	ELSEIF MSG. content_ . ID  ==  " MessageDocument "  سپس
		msg document_  =  true

	ELSEIF MSG. content_ . ID  ==  " MessageLocation "  سپس
		msg location_  =  true
	ELSEIF MSG. content_ . ID  ==  " MessageGame "  سپس
		msg game_  =  درست است
	ELSEIF MSG. content_ . ID  ==  " MessageChatAddMembers "  سپس
			برای i = 0 ، # msg. content_ . members_  انجام می شود
				msg adduser  = msg content_ . members_ [i] شناسه_
		پایان
	ELSEIF MSG. content_ . ID  ==  " MessageChatJoinByLink "  سپس
			msg joinuser  = msg sender_user_id_
	ELSEIF MSG. content_ . ID  ==  " MessageChatDeleteMember "  سپس
			msg deluser  =  درست است
	پایان
	اگر MSG. content_ . عکس_  سپس
		بازگشت  نادرست
	پایان
پایان
	ELSEIF داده است. ID  ==  " UpdateMessageContent "  سپس
		cmsg = داده
		تابع محلی edited_cb ( arg ، data )
			msg = data
			msg media  = {}
			اگر cmsg new_content_ . text_  سپس
				msg متن  = cmsg new_content_ . متن_
			پایان
			اگر cmsg new_content_ . caption_  سپس
				msg رسانه . caption  = cmsg new_content_ . caption_
			پایان
			msg ویرایش شده  =  درست است
      اگر  msg_valid (msg) سپس
			var_cb (msg، msg)
         پایان
		پایان
	tdcli_function ({ID =  " GetMessage " ، chat_id_ = data ، chat_id_ ، message_id_ = data، message_id_ }، edited_cb، nil )
	ELSEIF داده است. ID  ==  " UpdateFile "  سپس
		file_id = data file_ . شناسه_
	elseif (data ID  ==  " UpdateChat " ) سپس
		چت = داده chat_
		چت [چت id_ ] = چت
	ELSEIF (داده ها. ID  ==  " UpdateOption "  و داده ها. name_  ==  " my_id " ) پس از آن
		tdcli_function ({ID = " GetChats " ، offset_order_ = " 9223372036854775807 " ، offset_chat_id_ = 0 ، limit_ = 20 }، dl_cb، nil )    
	پایان
پایان
