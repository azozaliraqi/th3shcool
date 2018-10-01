--[[
<< تم برمجه وكتابه السورس من قبل المطور >>
<<         @alshmry653  \  >>
]]
local function xboss(msg, matches)
if msg.to.type ~= 'pv' then
if matches[1] == "تفعيل" and not matches[2] then local numusersax = (tonumber(redis:get(boss..':addnumberusers')) or 0) return modadd(msg,numusersax)  end
if matches[1] == "تعطيل" and not matches[2] then return modrem(msg) end end
if msg.to.type ~= 'pv' and redis:get(boss..'group:add'..msg.to.id) then 
if matches[1] == "ايدي" then
if not matches[2] and not msg.reply_id then
if msg.from.username then userxn = "@"..msg.from.username else userxn = "لا يوجد !" end
msgs = tonumber(redis:get(boss..'msgs:'..msg.from.id..':'..msg.to.id) or 1)
if redis:get(boss..'lock_id'..msg.to.id) then
tdcli_function({ID = "GetUserProfilePhotos",user_id_=msg.from.id,offset_=0,limit_=1},function(arg, data)
if data.photos_[0] then
sendPhoto(msg.to.id,msg.id_,0,1,nil,data.photos_[0].sizes_[1].photo_.persistent_id_,'👤¦ معرفك » '..userxn..'\n🎫¦ ايديك  » '..msg.from.id..'\n🎖¦ رتبتـك » '..get_rank(msg)..'\n📨¦ رسائلك » '..msgs..' رسالةة\n⭐️¦ تفاعلك » '..get_ttl(msgs)..'\n➖',dl_cb,nil) else
sendMsg(msg.to.id,msg.id_,'🚸*¦* لا يوجد صوره في بروفايلك ...!\n\n👤*¦* اسمك » ['..check_name(namecut(msg.from.first_name))..']\n🎫*¦* معرفك » ['..userxn..']\n🏷*¦* ايديك » (*'..msg.from.id..'*)\n📮*¦* رتبتك » '..get_rank(msg)..'\n⭐️*¦* تفاعلك » '..get_ttl(msgs)..'\n📨*¦* رسائلك » (*'..msgs..'*) رساله\n➖','md')
end end,nil) else
return '👤*¦* اسمك » ['..check_name(namecut(msg.from.first_name))..']\n🎫*¦* معرفك » ['..userxn..']\n🏷*¦* ايديك » (*'..msg.from.id..'*)\n🎖¦ رتبتـك » '..get_rank(msg)..'\n📨¦ رسائلك » '..msgs..' رسالةة\n⭐️¦ تفاعلك » '..get_ttl(msgs)..'\n➖'
end end
if msg.reply_id and not matches[2] then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {msg_id=msg.id_,chat_id=msg.to.id,cmd="iduser"})
end
if matches[2] then
tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {username=matches[1],msg_id=msg.id_,chat_id=msg.to.id,username=matches[2],cmd="iduser"})
end end
if matches[1] == "تثبيت" and is_mod(msg) and msg.reply_id then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = getChatId(msg.to.id).ID,message_id_ = msg.reply_id,disable_notification_ = 1}, dl_cb, cmd)
return "🙋🏼‍♂️*¦* أهلا عزيزي \n📌*¦* تم تثبيت الرساله \n✓"
end
if matches[1] == "الغاء التثبيت" and is_mod(msg) then
tdcli_function ({ID = "UnpinChannelMessage",channel_id_ = getChatId(msg.to.id).ID}, dl_cb, cmd)
return "🙋🏼‍♂️*¦* أهلا عزيزي \n📃*¦* تم الغاء تثبيت الرساله \n✓"
end
if matches[1] == "تقييد" and is_mod(msg) then
if not matches[2] and msg.reply_id then tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {msg_id=msg.id_,chat_id=msg.to.id,cmd="tqeed"}) end
if matches[2] and string.match(matches[2], '^%d+$') then tdcli_function ({ID = "GetUser",user_id_ = matches[2],}, action_by_id, {chat_id=msg.to.id,user_id=matches[2],msg_id=msg.id_,cmd="tqeed"}) end
if matches[2] and string.match(matches[2], '@[%a%d_]') then tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username,{msg_id=msg.id_,chat_id=msg.to.id,username=matches[2],cmd="tqeed"}) end 
end
if matches[1] == "فك التقييد" and is_mod(msg) then
if not matches[2] and msg.reply_id then tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {msg_id=msg.id_,chat_id=msg.to.id,cmd="fktqeed"}) end
if matches[2] and string.match(matches[2], '^%d+$') then tdcli_function ({ID = "GetUser",user_id_ = matches[2],}, action_by_id, {chat_id=msg.to.id,user_id=matches[2],msg_id=msg.id_,cmd="fktqeed"}) end
if matches[2] and string.match(matches[2], '@[%a%d_]') then tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username,{msg_id=msg.id_,chat_id=msg.to.id,username=matches[2],cmd="fktqeed"}) end 
end
if matches[1] == "رفع عضو مميز" and is_mod(msg) then
if not matches[2] and msg.reply_id then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {chat_id=msg.to.id,msg_id=msg.id_,cmd="setwhitelist"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "GetUser",user_id_ = matches[2],}, action_by_id, {chat_id=msg.to.id,msg_id=msg.id_,user_id=matches[2],cmd="setwhitelist"})
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {msg_id=msg.id_,chat_id=msg.to.id,username=matches[2],cmd="setwhitelist"})
end end
if matches[1] == "تنزيل عضو مميز" and is_mod(msg) then
if not matches[2] and msg.reply_id then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {msg_id=msg.id_,chat_id=msg.to.id,cmd="remwhitelist"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "GetUser",user_id_ = matches[2],}, action_by_id, {chat_id=msg.to.id,msg_id=msg.id_,user_id=matches[2],cmd="remwhitelist"})
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {msg_id=msg.id_,chat_id=msg.to.id,username=matches[2],cmd="remwhitelist"})
end end
if matches[1] == "رفع المدير" and (is_sudo(msg) or is_monsha(msg)) then
if not matches[2] and msg.reply_id then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {msg_id=msg.id_,chat_id=msg.to.id,cmd="setowner"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "GetUser",user_id_ = matches[2],}, action_by_id, {chat_id=msg.to.id,msg_id=msg.id_,user_id=matches[2],cmd="setowner"})
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {msg_id=msg.id_,chat_id=msg.to.id,username=matches[2],cmd="setowner"})
end end
if matches[1] == "تنزيل المدير" and (is_sudo(msg) or is_monsha(msg)) then
if not matches[2] and msg.reply_id then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {msg_id=msg.id_,chat_id=msg.to.id,cmd="remowner"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "GetUser",user_id_ = matches[2],}, action_by_id, {chat_id=msg.to.id,msg_id=msg.id_,user_id=matches[2],cmd="remowner"}) 
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {msg_id=msg.id_,chat_id=msg.to.id,username=matches[2],cmd="remowner"})
end end
if matches[1] == "رفع منشى" and is_sudo(msg) then
if not matches[2] and msg.reply_id then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {msg_id=msg.id_,chat_id=msg.to.id,cmd="setmnsha"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "GetUser",user_id_ = matches[2],}, action_by_id, {chat_id=msg.to.id,msg_id=msg.id_,user_id=matches[2],cmd="setmnsha"})
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {msg_id=msg.id_,chat_id=msg.to.id,username=matches[2],cmd="setmnsha"})
end  end
if matches[1] == "تنزيل منشى" and is_sudo(msg) then
if not matches[2] and msg.reply_id then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {msg_id=msg.id_,chat_id=msg.to.id,cmd="remmnsha"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "GetUser",user_id_ = matches[2],}, action_by_id, {chat_id=msg.to.id,msg_id=msg.id_,user_id=matches[2],cmd="remmnsha"})
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {msg_id=msg.id_,chat_id=msg.to.id,username=matches[2],cmd="remmnsha"})
end end
if matches[1] == "رفع ادمن" and is_owner(msg) then
if not matches[2] and msg.reply_id then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {msg_id=msg.id_,chat_id=msg.to.id,cmd="promote"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "GetUser",user_id_ = matches[2],}, action_by_id, {chat_id=msg.to.id,msg_id=msg.id_,user_id=matches[2],cmd="promote"})
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {msg_id=msg.id_,chat_id=msg.to.id,username=matches[2],cmd="promote"})
end end
if matches[1] == "تنزيل ادمن" and is_owner(msg) then
if not matches[2] and msg.reply_id then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {msg_id=msg.id_,chat_id=msg.to.id,cmd="demote"})
end
if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "GetUser",user_id_ = matches[2],}, action_by_id, {chat_id=msg.to.id,msg_id=msg.id_,user_id=matches[2],cmd="demote"})
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {msg_id=msg.id_,chat_id=msg.to.id,username=matches[2],cmd="demote"})
end end
if matches[1] == "التفاعل" then
if not matches[2] and msg.reply_id then
tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {msg_id=msg.id_,chat_id=msg.to.id,cmd="active"})
end
if matches[2] and not string.match(matches[2], '^%d+$') then
tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {msg_id=msg.id_,chat_id=msg.to.id,username=matches[2],cmd="active"})
end  end
if matches[1] == "قفل" then
if matches[2] == "الكل" and is_mod(msg) then lock_username(msg) mute_gif(msg) mute_photo(msg) mute_audio(msg) mute_voice(msg) mute_sticker(msg) mute_forward(msg) mute_contact(msg) mute_location(msg) mute_document(msg)mute_inline(msg) lock_link(msg) lock_tag(msg) lock_edit(msg) lock_spam(msg) lock_bots(msg) lock_webpage(msg) mute_video(msg) return '🙋🏼‍♂️*¦* أهلا عزيزي  \n📡*¦* تم قفل الكل  \n✓' end
if matches[2] == "الوسائط" then  mute_gif(msg) mute_photo(msg) mute_audio(msg) mute_voice(msg) mute_sticker(msg) mute_video(msg)  return '🙋🏼‍♂️*¦* أهلا عزيزي  \n🔛¦ تم قفل الوسائط  \n✓' end
if matches[2] == "الصور بالتقييد" then return tqeed_photo(msg) end
if matches[2] == "الفيديو بالتقييد" then return tqeed_video(msg) end
if matches[2] == "المتحركه بالتقييد" then return tqeed_gif(msg) end
if matches[2] == "التوجيه بالتقييد" then return tqeed_fwd(msg) end
if matches[2] == "الروابط بالتقييد" then return tqeed_link(msg) end
if matches[2] == "الدردشه" then return mute_text(msg) end
if matches[2] == "المتحركه" then return mute_gif(msg) end
if matches[2] == "الصور" then return mute_photo(msg) end
if matches[2] == "الفيديو" then return mute_video(msg) end
if matches[2] == "البصمات" then  return mute_audio(msg) end
if matches[2] == "الصوت" then return mute_voice(msg) end
if matches[2] == "الملصقات" then return mute_sticker(msg) end
if matches[2] == "الجهات" then return mute_contact(msg) end
if matches[2] == "التوجيه" then return mute_forward(msg) end
if matches[2] == "الموقع" then return mute_location(msg) end
if matches[2] == "الملفات" then return mute_document(msg) end
if matches[2] == "الاشعارات" then return mute_tgservice(msg) end
if matches[2] == "الانلاين" then return mute_inline(msg) end
if matches[2] == "الالعاب" then return mute_game(msg) end
if matches[2] == "الكيبورد" then return mute_keyboard(msg) end
if matches[2] == "الروابط" then return lock_link(msg) end
if matches[2] == "التاك" then return lock_tag(msg) end
if matches[2] == "المعرفات" then return lock_username(msg) end
if matches[2] == "التعديل" then return lock_edit(msg) end
if matches[2] == "الكلايش" then return lock_spam(msg) end
if matches[2] == "التكرار" then return lock_flood(msg) end
if matches[2] == "البوتات" then return lock_bots(msg) end
if matches[2] == "البوتات بالطرد" then return lock_bots_by_kick(msg) end
if matches[2] == "الماركدوان" then return lock_markdown(msg) end
if matches[2] == "الويب" then return lock_webpage(msg) end end
if matches[1] == "فتح" then 
if matches[2] == "الكل" and is_mod(msg) then unlock_username(msg) unmute_gif(msg) unmute_photo(msg) unmute_audio(msg) unmute_voice(msg) unmute_sticker(msg) unmute_forward(msg) unmute_contact(msg) unmute_location(msg) unmute_document(msg) unlock_link(msg) unlock_tag(msg) unlock_edit(msg) unlock_spam(msg) unlock_bots(msg) unlock_webpage(msg) unmute_video(msg) unmute_inline(msg) return '🙋🏼‍♂️*¦* أهلا عزيزي  \n📡*¦* تم فتح الكل  \n✓' end
if matches[2] == "الوسائط" then unmute_gif(msg) unmute_photo(msg) unmute_audio(msg) unmute_voice(msg) unmute_sticker(msg) unmute_video(msg) return '🙋🏼‍♂️*¦* أهلا عزيزي  \n🔛¦ تم فتح الوسائط  \n✓'  end
if matches[2] == "الصور بالتقييد" then return fktqeed_photo(msg) end
if matches[2] == "الفيديو بالتقييد" then return fktqeed_video(msg) end
if matches[2] == "المتحركه بالتقييد" then return fktqeed_gif(msg) end
if matches[2] == "التوجيه بالتقييد" then return fktqeed_fwd(msg) end
if matches[2] == "الروابط بالتقييد" then return fktqeed_link(msg) end
if matches[2] == "المتحركه" then return unmute_gif(msg) end
if matches[2] == "الدردشه" then return unmute_text(msg) end
if matches[2] == "الصور" then return unmute_photo(msg) end
if matches[2] == "الفيديو" then return unmute_video(msg) end
if matches[2] == "البصمات" then return unmute_audio(msg) end
if matches[2] == "الصوت" then return unmute_voice(msg) end
if matches[2] == "الملصقات" then return unmute_sticker(msg) end
if matches[2] == "الجهات" then return unmute_contact(msg) end
if matches[2] == "التوجيه" then return unmute_forward(msg) end
if matches[2] == "الموقع" then return unmute_location(msg) end
if matches[2] == "الملفات" then return unmute_document(msg) end
if matches[2] == "الاشعارات" then return unmute_tgservice(msg) end
if matches[2] == "الانلاين" then return unmute_inline(msg) end
if matches[2] == "الالعاب" then return unmute_game(msg) end
if matches[2] == "الكيبورد" then return unmute_keyboard(msg) end
if matches[2] == "الروابط" then return unlock_link(msg) end
if matches[2] == "التاك" then return unlock_tag(msg) end
if matches[2] == "المعرفات" then return unlock_username(msg) end
if matches[2] == "التعديل" then return unlock_edit(msg) end
if matches[2] == "الكلايش" then return unlock_spam(msg) end
if matches[2] == "التكرار" then return unlock_flood(msg) end
if matches[2] == "البوتات" then return unlock_bots(msg) end
if matches[2] == "البوتات بالطرد" then return unlock_bots_by_kick(msg) end
if matches[2] == "الماركدوان" then return unlock_markdown(msg) end
if matches[2] == "الويب" then return unlock_webpage(msg) end
end
if matches[1] == "المجموعه" and is_mod(msg) then
tdcli_function({ID = "GetChannelFull",channel_id_ = getChatId(msg.to.id).ID}, function(arg, data) sendMsg(arg.chat_id,arg.msg_id,"*📦¦* معلومات المجموعه :\n\n*🗣¦* عدد الادمنيه » *"..data.administrator_count_.."*\n*👥¦* عدد الاعضاء » *"..data.member_count_.."*\n*📛¦* عدد المطرودين » *"..data.kicked_count_.."*\n*🔚¦* ايدي المجموعه » *"..data.channel_.id_.."*\n📡",'md')end, {chat_id=msg.to.id,msg_id=msg.id_}) return false
end
if matches[1] == "ضع رابط" and is_owner(msg) then
redis:setex(boss..'waiting_link'..msg.from.id,300,true)
return "🙋🏼‍♂️*¦* أهلا عزيزي \n🔖¦ رجائا ارسل الرابط الآن \n🔃"
end
if matches[1] == "الرابط" then
if not redis:get(boss..'linkgp'..msg.to.id) then return "📡*¦* اوه 🙀 لا يوجد هنا رابط\n🔖¦ *رجائا اكتب [ضع رابط]* \n🔃" end
return sendMsg(msg.to.id,msg.id_,"`🔖¦رابـط الـمـجـمـوعه 💯\n🌿¦"..redis:get(boss..'group:name'..msg.to.id).." :\n\n`["..redis:get(boss..'linkgp'..msg.to.id).."]\n",'md')
end
if matches[1] == "الرابط خاص" and is_mod(msg) then
if not redis:get(boss..'linkgp'..msg.to.id) then return "📡*¦* اوه 🙀 لا يوجد هنا رابط\n🔖¦ *رجائا اكتب [ضع رابط]*🔃" end
sendMsg(msg.from.id, 0,"`🔖¦رابـط الـمـجـمـوعه 💯\n🌿¦"..redis:get(boss..'group:name'..msg.to.id).." :\n\n`["..redis:get(boss..'linkgp'..msg.to.id).."]\n",'md')
return "🙋🏼‍♂️*¦* أهلا عزيزي \n🌿¦ تم ارسال الرابط خاص لك 🔃"
end
if matches[1] == "ضع القوانين" and is_mod(msg) then
redis:setex(boss..'rulse:witting'..msg.from.id,300,true)
return '📭¦ حسننا عزيزي  ✋🏿\n🗯¦ الان ارسل القوانين  للمجموعه 🍃'
end
if matches[1] == "القوانين" then
if not redis:get(boss..'rulse:msg'..msg.to.id) then return "📡*¦* مرحبأ عزيري 👋🏻 القوانين كلاتي 👇🏻\n🔖¦ ممنوع نشر الروابط \n🔖¦ ممنوع التكلم او نشر صور اباحيه \n🔖¦ ممنوع  اعاده توجيه\n🔖¦ ممنوع التكلم بلطائفه \n🔖¦ الرجاء احترام المدراء والادمنيه 😅\n"
else return "*🔖¦القوانين :*\n"..redis:get(boss..'rulse:msg'..msg.to.id) end 
end
if matches[1] == "ضع تكرار" and is_mod(msg) then
if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 50 then return "📡*¦* حدود التكرار ,  يجب ان تكون ما بين  *[2-50]*" end
redis:set(boss..'flood'..msg.to.id,matches[2]) 
return "📡*¦* تم وضع التكرار » *[ "..matches[2].." ]*"
end
if matches[1] == "مسح" then
if not matches[2] and msg.reply_id and is_mod(msg)then del_msg(msg.to.id, msg.reply_id) del_msg(msg.to.id, msg.id_) end
if matches[2] and string.match(matches[2], '^%d+$') and is_owner(msg) then
if 100 < tonumber(matches[2]) then return "📛*¦* حدود المسح ,  يجب ان تكون ما بين  *[2-100]*" end
tdcli_function({ID = "GetChatHistory",chat_id_ = msg.to.id,from_message_id_ = 0,offset_ = 0,limit_ = matches[2]}, del_msgs, {chat_id=msg.to.id})
sleep(0.2)
return sendMsg(msg.to.id,0,"*¦ـ\n¦*~⪼ تم مسح ("..matches[2]..") من الرسائل  \n🗑",'md')
end
if matches[2] == "الادمنيه" and is_owner(msg) then 
local list = redis:smembers(boss..'admins:'..msg.to.id)
if #list==0 then  return "📡*¦* اوه ☢ هنالك خطأ 🚸\n📛¦ عذرا لا يوجد ادمنيه ليتم مسحهم ✓" end
redis:del(boss..'admins:'..msg.to.id)
return "🙋🏼‍♂️*¦* أهلا عزيزي  \n📛¦ تم حذف "..#list.." ادمن من البوت ✓"
end
if matches[2] == "قائمه المنع" and is_owner(msg) then
if #redis:smembers(boss..'klmamn3'..msg.to.id) == 0 then return "📡*¦* عذرا لا توجد كلمات ممنوعه ليتم حذفها ✓" end
redis:del(boss..'klmamn3'..msg.to.id)
return "🙋🏼‍♂️*¦* أهلا عزيزي  \n🔖¦ تم حذف الكلمات الممنوعه بنجاح ✓"
end
if matches[2] == "القوانين" and is_owner(msg) then
if not redis:get(boss..'rulse:msg'..msg.to.id) then return "📡*¦* اوه ☢ هنالك خطأ 🚸\n📛¦ عذرا لا يوجد قوانين ليتم مسحه ✓" end
redis:del(boss..'rulse:msg'..msg.to.id)
return "🙋🏼‍♂️*¦* أهلا عزيزي  \n📛¦ تم حذف القوانين بنجاح ✓"
end
if matches[2] == "الترحيب" and is_owner(msg)  then
if not redis:get(boss..'welcome:msg'..msg.to.id) then return "📡*¦* اوه ☢ هنالك خطأ 🚸\n📛¦ عذرا لا يوجد ترحيب ليتم مسحه ✓" end
redis:del(boss..'welcome:msg'..msg.to.id)
return "🙋🏼‍♂️*¦* أهلا عزيزي  \n📛¦ تم حذف الترحيب بنجاح ✓"
end
if matches[2] == "المدراء" and is_sudo(msg) then
if #redis:smembers(boss..'owners:'..msg.to.id) ==0 then return "📡*¦* اوبس ☢ هنالك خطأ 🚸\n📛¦ عذرا لا يوجد مدراء ليتم مسحهم ✓" end
redis:del(boss..'owners:'..msg.to.id)
return "🙋🏼‍♂️*¦* أهلا عزيزي  \n📛¦ تم حذف المدراء بنجاح ✓"
end
if matches[2] == 'المحظورين' and is_owner(msg) then
if #redis:smembers(boss..'banned:'..msg.to.id) ==0 then return "*📌¦ لا يوجد مستخدمين محظورين  *" end
redis:del(boss..'banned:'..msg.to.id)
return "📡*¦* تم مسح المحظورين في المجموعه \n✓"
end
if matches[2] == 'المكتومين' and is_owner(msg)  then
if #redis:smembers(boss..'is_silent_users:'..msg.to.id) ==0 then return "📡*¦* لا يوجد مستخدمين مكتومين في المجموعه " end
redis:del(boss..'is_silent_users:'..msg.to.id)
return "⚙️*¦* تم مسح قائمه الكتم \n✓"
end
if matches[2] == 'المميزين' and is_owner(msg)  then
if #redis:smembers(boss..'whitelist:'..msg.to.id) ==0 then return "*⚙️*¦ لا يوجد مستخدمين مميزين في المجموعه " end
redis:del(boss..'whitelist:'..msg.to.id)
return "⚙️*¦* تم مسح قائمه المميزين \n✓"
end
if matches[2] == 'الرابط' and is_owner(msg)  then
if not redis:get(boss..'linkgp'..msg.to.id) then return "*⚙️*¦ لا يوجد رابط مضاف اصلا " end
redis:del(boss..'linkgp'..msg.to.id)
return "⚙️*¦* تم مسح رابط المجموعه \n✓"
end
end --end del 
if matches[1] == "ضع اسم" and is_mod(msg) then
redis:setex(boss..'name:witting'..msg.from.id,300,true)
return "📭¦ حسننا عزيزي  ✋🏿\n🗯¦ الان ارسل الاسم  للمجموعه \n🛠"
end
if matches[1] == "حذف صوره" and is_mod(msg) then
https.request("https://api.telegram.org/bot".._info.TOKEN.."/deleteChatPhoto?chat_id="..msg.to.id)
return sendMsg(msg.to.id,msg.id_,'🚸 ¦ تم حذف صوره آلمـجمـوعهہ 🌿\n✓','html')
end
if matches[1] == "ضع صوره" and is_mod(msg) then
if msg.reply_id  then
function photomsg(arg, data)
function photoinfo(arg,data)
if data.content_.ID == 'MessagePhoto' then
if data.content_.photo_.sizes_[3] then photo_id = data.content_.photo_.sizes_[3].photo_.persistent_id_ else photo_id = data.content_.photo_.sizes_[0].photo_.persistent_id_ end
tdcli_function({ID = "ChangeChatPhoto",chat_id_ = msg.to.id,photo_ = getInputFile(photo_id)}, dl_cb, nil)
end end tdcli_function({ID = 'GetMessage',chat_id_ = msg.chat_id_,message_id_ = data.id_ },photoinfo,nil)
end tdcli_function({ID = 'GetMessage',chat_id_ = msg.chat_id_,message_id_ = msg.reply_to_message_id_ },photomsg,nil)
else redis:setex(boss..'photo:group'..msg.to.id..msg.from.id,300,true)
return '📭¦ حسننا عزيزي 🍁\n🌄 ¦ الان قم بارسال الصوره\n🛠' end end
if matches[1] == "ضع وصف" and is_mod(msg) then redis:setex(boss..'about:witting'..msg.from.id,300,true) return "📭¦ حسننا عزيزي  ✋🏿\n🗯¦ الان ارسل الوصف  للمجموعه\n🛠" end
if matches[1] == "منع" and is_mod(msg) then return filter_word(msg, matches[2]) end
if matches[1] == "الغاء منع" and is_mod(msg) then return unfilter_word(msg, matches[2]) end
if matches[1] == "قائمه المنع" and is_mod(msg) then return filter_list(msg) end
if matches[1] == "الحمايه" then settingsall(msg) end
if matches[1] == "الاعدادات" then settings(msg) end
if matches[1] == "الوسائط" then media(msg) end
if matches[1] == "الادمنيه" and is_mod(msg) then return modlist(msg) end
if matches[1] == "المدراء" and is_owner(msg) then return ownerlist(msg) end
if matches[1] == "المميزين" and is_mod(msg) then return whitelist(msg) end
if matches[1] == "طرد البوتات" and is_owner(msg) then
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.to.id).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 80},function(arg, data)
local deleted = 0 
for k, v in pairs(data.members_) do
if v.user_id_ ~= our_id then kick_user(v.user_id_, msg.to.id) deleted = deleted + 1  end end
if deleted == 0 then sendMsg(msg.to.id,msg.id_,'📡*¦* لا يوجد بوتات في المجموعة\n✘','md') else sendMsg(msg.to.id, msg.id_,'📡¦ تم طرد [<code>'..deleted..'</code>] بوت من المجموعة \n✓','html') end end, nil)
end
if matches[1] == "كشف البوتات" and is_owner(msg) then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = getChatId(msg.to.id).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 80},function(arg, data)
local i = 0
for k, v in pairs(data.members_) do
if v.user_id_ ~= our_id then i = i + 1 end end
if i == 0 then sendMsg(msg.to.id, msg.id_,'📡*¦* لا يوجد بوتات في المجموعة 💯','md') else sendMsg(msg.to.id,msg.id_,'📡*¦* عدد البوتات الموجودة *['..i..']* بوت \n💯','md') end end, nil)
end
if matches[1] == 'طرد المحذوف' then 
if not we_sudo(msg) then return "☔️هذا الاوامر للمطور الاساسي فقط 🌿" end
tdcli_function ({ID = "GetChannelMembers",channel_id_ = getChatId(msg.to.id).ID,offset_ = 0,limit_ = 80}, function(arg, data) 
for k, v in pairs(data.members_) do 
local function infousers(arg, data)
if not data.first_name_  then 
kick_user(data.id_,arg.group) 
end  end
tdcli_function ({ID = "GetUser",user_id_ = v.user_id_}, infousers, {group=arg.group})
end  end , {group=msg.to.id}) sendMsg(msg.to.id, msg.id_,'🚸 ¦ تم طـرد آلحسـآبآت آلمـحذوفهہ‏‏ 🌿','md') 
end 
if matches[1] == 'شحن' and matches[2] and is_sudo(msg) then
if tonumber(matches[2]) > 0 and tonumber(matches[2]) < 1001 then
local extime = (tonumber(matches[2]) * 86400)
redis:setex(boss..'ExpireDate:'..msg.to.id, extime, true)
if not redis:get(boss..'CheckExpire::'..msg.to.id) then redis:set(boss..'CheckExpire::'..msg.to.id,true) end
sendMsg(msg.to.id,msg.id_,'💂🏻‍♀️¦ تم شحن الاشتراك الى `'..matches[2]..'` يوم   ... 👍🏿','md')
sendMsg(SUDO_ID, 0,'💂🏻‍♀️¦ تم شحن الاشتراك الى `'..matches[2]..'` يوم   ... 👍🏿\n🕵🏼️‍♀️¦ في مجموعه  » »  '..redis:get(boss..'group:name'..msg.to.id),'md')
else
sendMsg(msg.to.id,msg.id_,'💂🏻‍♀️¦ عزيزي المطور ✋🏿\n👨🏻‍🔧¦ شحن الاشتراك يكون ما بين يوم الى 1000 يوم فقط 🍃','md')
end end
if matches[1]:lower() == 'الاشتراك' and matches[2] then 
if matches[2] == '1' then
redis:setex(boss..'ExpireDate:'..msg.to.id, 2592000, true)
if not redis:get(boss..'CheckExpire::'..msg.to.id) then redis:set(boss..'CheckExpire::'..msg.to.id,true) end
sendMsg(SUDO_ID,msg.id_,'💂🏻‍♀️¦ تم تفعيل الاشتراك  👍🏿\n📆¦  الاشتراك » `30 يوم`  *(شهر)*','md')
sendMsg(msg.to.id,0,'💂🏻‍♀️¦ تم تفعيل الاشتراك   👍🏿\n📆¦  الاشتراك » `30 يوم`  *(شهر)*','md')
end
if matches[2] == '2' then
redis:setex(boss..'ExpireDate:'..msg.to.id,7776000,true)
if not redis:get(boss..'CheckExpire::'..msg.to.id) then redis:set(boss..'CheckExpire::'..msg.to.id,true) end
sendMsg(SUDO_ID, msg.id_,'💂🏻‍♀️¦ تم تفعيل الاشتراك   👍🏿\n📆¦  الاشتراك » `90 يوم`  *(3 اشهر)*','md')
sendMsg(msg.to.id, 0,'💂🏻‍♀️¦ تم تفعيل الاشتراك   👍🏿\n📆¦  الاشتراك » `90 يوم`  *(3 اشهر)*','md')
end
if matches[2] == '3' then
redis:set(boss..'ExpireDate:'..msg.to.id,true)
if not redis:get(boss..'CheckExpire::'..msg.to.id) then redis:set(boss..'CheckExpire::'..msg.to.id,true) end
sendMsg(SUDO_ID, msg.id_,'💂🏻‍♀️¦ تم تفعيل الاشتراك   👍🏿\n📆¦  الاشتراك » `مفتوح`  *(مدى الحياة)*','md')
sendMsg(msg.to.id, 0,'💂🏻‍♀️¦ تم تفعيل الاشتراك   👍🏿\n📆¦  الاشتراك » `مفتوح`  *(مدى الحياة)*','md')
end end
if matches[1] == 'الاشتراك' and not matches[2] and is_mod(msg) then
local check_time = redis:ttl(boss..'ExpireDate:'..msg.to.id)
if check_time < 0 then return '*مـفـتـوح *🎖\n✓' end
year = math.floor(check_time / 31536000)
byear = check_time % 31536000 
month = math.floor(byear / 2592000)
bmonth = byear % 2592000 
day = math.floor(bmonth / 86400)
bday = bmonth % 86400 
hours = math.floor( bday / 3600)
bhours = bday % 3600 
min = math.floor(bhours / 60)
sec = math.floor(bhours % 60)
if tonumber(check_time) > 1 and check_time < 60 then
remained_expire = '💳¦ `باقي من الاشتراك ` » » * \n 📆¦  '..sec..'* ثانيه'
elseif tonumber(check_time) > 60 and check_time < 3600 then
remained_expire = '💳¦ `باقي من الاشتراك ` » » '..min..' *دقيقه و * *'..sec..'* ثانيه'
elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
remained_expire = '💳¦ `باقي من الاشتراك ` » » * \n 📆¦  '..hours..'* ساعه و *'..min..'* دقيقه و *'..sec..'* ثانيه'
elseif tonumber(check_time) > 86400 and tonumber(check_time) < 2592000 then
remained_expire = '💳¦ `باقي من الاشتراك ` » » * \n 📆¦  '..day..'* يوم و *'..hours..'* ساعه و *'..min..'* دقيقه و *'..sec..'* ثانيه'
elseif tonumber(check_time) > 2592000 and tonumber(check_time) < 31536000 then
remained_expire = '💳¦ `باقي من الاشتراك ` » » * \n 📆¦  '..month..'* شهر و *'..day..'* يوم و *'..hours..'* ساعه و *'..min..'* دقيقه و *'..sec..'* ثانيه'
elseif tonumber(check_time) > 31536000 then
remained_expire = '💳¦ `باقي من الاشتراك ` » » * \n 📆¦  '..year..'* سنه و *'..month..'* شهر و *'..day..'* يوم و *'..hours..'* ساعه و *'..min..'* دقيقه و *'..sec..'* ثانيه' end
sendMsg(msg.to.id,msg.id_,remained_expire,'md') end
if matches[1] == "الرتبه" and not matches[2] and msg.reply_id then return tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {msg_id=msg.id_,chat_id=msg.to.id,cmd="rtba"}) end
if matches[1] == "كشف الادمن" and not matches[2] and is_owner(msg) then
local checkmod = false
tdcli_function ({ID = "GetChannelMembers",channel_id_ = getChatId(msg.to.id).ID,filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100}, function(a, b)
local secchk = true
for k,v in pairs(b.members_) do
if v.user_id_ == tonumber(our_id) then secchk = false end end
if secchk then return sendMsg(msg.to.id, msg.id_,'📡*¦* كلا البوت ليس ادمن في المجموعة ♨️',"md") else return sendMsg(msg.to.id, msg.id_,'📡*¦* نعم انه ادمن في المجموعة 👍🏿',"md") end end, nil) end
if matches[1]== 'رسائلي' or matches[1]=='رسايلي' then
return '🗯*¦* عدد رسـآئلگ هہيهہ‏‏» (*'..tonumber(redis:get(boss..'msgs:'..msg.from.id..':'..msg.to.id) or 0)..'*) رساله \n' end
 if matches[1]== 'جهاتي' then
 return '🧟‍♂*¦*  عدد جهہآتگ آلمـضـآفهہ‏‏ » 【'..(tonumber(redis:get(boss..':addusers_group:'..msg.to.id..':'..msg.from.id)) or 0)..'】 . \n🐾'
end
if matches[1] == 'معلوماتي' or matches[1] == 'موقعي' then
if msg.from.username then username = '@'..msg.from.username else username = 'لا يوجد ❕' end
local msgs = tonumber(redis:get(boss..'msgs:'..msg.from.id..':'..msg.to.id) or 0)
sendMsg(msg.to.id, msg.id_,'*👨🏽‍🔧¦ اهـلا بـك عزيزي » \n\n📜¦ الاسم » * ['..check_name(namecut(msg.from.first_name))..']\n*🎟¦ المعرف:* ['..username..']\n*🏷¦ الايدي » * 【 `'..msg.from.id..'` 】\n📨*¦* رسائلك » 【*'..msgs..'*】رسـآلهہ‏‏ \n🧟‍♂*¦*  عدد جهہآتگ » 【'..(tonumber(redis:get(boss..':addusers_group:'..msg.to.id..':'..msg.from.id)) or 0)..'】جهہ‏‏\n⭐️*¦* تفاعلك » '..get_ttl(msgs)..'\n*🎗¦ رتبتك » * '..get_rank(msg)..'\n*🎫¦ ايدي المجموعه » * ( `'..msg.to.id..'` ) \n\n*🏌🏻¦ مـطـور البوت * » '..SUDO_USER..'\n👨🏽‍🔧','md') end
if matches[1] == "git" and not matches[2]:match("clone") then
if not is_mod(msg) then return 'للاداريين فقط' end
url = "https://api.github.com/users/"..URL.escape(matches[2])
jstr, res = https.request(url) jdat = JSON.decode(jstr)
if jdat.message then return '🚸 ¦ اليوزر غير موجود في الـGithub'  end
download_file(jdat.avatar_url, './inc/git_pro.jpg')
return sendPhoto(msg.to.id, msg.id_, 0,nil, './inc/git_pro.jpg','🎟¦ الاسم » '..(jdat.name or 'لا يوجد اسم')..'\n🔅¦ البايو » '..(jdat.bio or 'لا يوجد بايو')..'\n🔅¦ المتابعون » '..jdat.followers..'\n🔅¦ المتابعين » '..jdat.following..'\n🔅¦ المشاريع » '..jdat.public_repos..'\n🔅¦ الرابط » '..jdat.html_url,dl_cb,nil) 
end
if matches[1] == "تفعيل" and is_mod(msg) then
if matches[2] == "الرد بالرد" then redis:set(boss..":msg_id"..msg.to.id,true) return "🙋🏼‍♂️*¦* أهلا عزيزي \n📡*¦* تم تفعيل الرد بالرد \n✓" end
if matches[2] == "الردود" then return unlock_replay(msg) end
if matches[2] == "الاذاعه" and is_sudo(msg) then return unlock_brod(msg) end
if matches[2] == "الايدي" then
if redis:get(boss..'lock_id'..msg.to.id) then return "🙋🏼‍♂️*¦* أهلا عزيزي \n📡*¦* امر الايدي شغال بالفعل\n✓" else redis:set(boss..'lock_id'..msg.to.id,true)  return "🙋🏼‍♂️*¦* أهلا عزيزي \n📡*¦* تم تفعيل امر الايدي \n✓" end end
if matches[2] == "الترحيب" then 
if redis:get(boss..'welcome:get'..msg.to.id) then return "🙋🏼‍♂️*¦* أهلا عزيزي \n📡*¦* تفعيل الترحيب مفعل مسبقاً\n✓" else redis:set(boss..'welcome:get'..msg.to.id,true)  return "🙋🏼‍♂️*¦* أهلا عزيزي \n📡*¦* تم تفعيل الترحيب \n✓" end end
if matches[2] == "التحذير" then 
if redis:get(boss..'lock_woring'..msg.to.id) then return "🙋🏼‍♂️*¦* أهلا عزيزي \n📡*¦* تفعيل التحذير مفعل مسبقاً \n✓" else redis:set(boss..'lock_woring'..msg.to.id,true) return "🙋🏼‍♂️*¦* أهلا عزيزي \n📡*¦* تم تفعيل التحذير \n✓" end end end
if matches[1] == "تعطيل" and is_mod(msg) then
if matches[2] == "الرد بالرد" then redis:del(boss..":msg_id"..msg.to.id) return "🙋🏼‍♂️*¦* أهلا عزيزي \n📡*¦* تم تعطيل الرد بالرد \n✓" end
if matches[2] == "الردود" then return lock_replay(msg) end
if matches[2] == "الاذاعه" and is_sudo(msg) then return lock_brod(msg) end
if matches[2] == "الايدي" then
if not redis:get(boss..'lock_id'..msg.to.id) then return "🙋🏼‍♂️*¦* أهلا عزيزي \n📡*¦* الايدي بالتأكيد معطل\n✓" else redis:del(boss..'lock_id'..msg.to.id) return "🙋🏼‍♂️*¦* أهلا عزيزي \n📡*¦* تم تعطيل امر الايدي\n✓" end end
if matches[2] == "الترحيب" then
if not redis:get(boss..'welcome:get'..msg.to.id) then return "🙋🏼‍♂️*¦* أهلا عزيزي \n📡*¦* الترحيب بالتأكيد معطل\n✓" else redis:del(boss..'welcome:get'..msg.to.id) return "🙋🏼‍♂️*¦* أهلا عزيزي \n📡*¦* تم تعطيل الترحيب \n✓" end end
if matches[2] == "التحذير" then
if not redis:get(boss..'lock_woring'..msg.to.id) then return "🙋🏼‍♂️*¦* أهلا عزيزي \n📡*¦* التحذير بالتأكيد معطل\n✓" else redis:del(boss..'lock_woring'..msg.to.id) return "🙋🏼‍♂️*¦* أهلا عزيزي \n📡*¦* تم تعطيل التحذير \n✓" end end end
if matches[1] == "ضع الترحيب" and is_mod(msg) then redis:set(boss..'welcom:witting'..msg.from.id,true) return "📭¦ حسننا عزيزي  ✋🏿\n🗯¦ ارسل كليشه الترحيب الان\n🛠" end
if matches[1] == "الترحيب"  and is_mod(msg) then
if redis:get(boss..'welcome:msg'..msg.to.id)  then
return redis:get(boss..'welcome:msg'..msg.to.id)
else return "🙋🏼‍♂️*¦* أهلا عزيزي \n🌿¦ نورت المجموعه \n💂🏼‍♀️" end end
if matches[1] == "رفع الادمنيه" and is_owner(msg) then set_admins(msg) end
if matches[1] == "كشف"  then
if not matches[2] and msg.reply_id then tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {msg_id=msg.id_,chat_id=msg.to.id,cmd="whois"})end 
if matches[2] and string.match(matches[2], '^%d+$') then tdcli_function ({ID = "GetUser",user_id_ = matches[2],}, action_by_id, {chat_id=msg.to.id,msg_id=msg.id_,user_id=matches[2],cmd="whois"}) end
if matches[2] and not string.match(matches[2], '^%d+$') then tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {msg_id=msg.id_,chat_id=msg.to.id,username=matches[2],cmd="whois"}) end end
if matches[1] == "طرد" and is_mod(msg) then
if not matches[2] and msg.reply_id then 
tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {msg_id=msg.id_,chat_id=msg.to.id,msg_id=msg.id_,cmd="kick"})  end
if matches[2] and string.match(matches[2], '^%d+$') then
if matches[2] == our_id then sendMsg(msg.chat_id_,msg.id_,"📛¦ لا تستطيع طرد البوت\n🛠","md")
elseif is_mod1(msg.to.id,matches[2]) then sendMsg(msg.chat_id_,msg.id_,"📛¦ لا تستطيع طرد المدراء اوالادمنيه\n🛠","md")
else kick_user(matches[2], msg.to.id) sleep(1) channel_unblock(msg.to.id, matches[2])
sendMsg(msg.chat_id_, msg.id_,"🙋🏼‍♂️*¦* أهلا عزيزي  \n📡*¦* تم طرد العضو ["..matches[2].."]\n✓","md") end end
if matches[2] and string.match(matches[2], '@[%a%d_]') then tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {msg_id=msg.id_,chat_id=msg.to.id,msg_id=msg.id_,username=matches[2],cmd="kick"}) end end
if matches[1] == "حظر" and is_mod(msg)  then
if not matches[2] and msg.reply_id then tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {msg_id=msg.id_,chat_id=msg.to.id,cmd="ban"}) end
if matches[2] and string.match(matches[2], '^%d+$') then tdcli_function ({ID = "GetUser",user_id_ = matches[2],}, action_by_id, {chat_id=msg.to.id,user_id=matches[2],msg_id=msg.id_,cmd="ban"}) end
if matches[2] and string.match(matches[2], '@[%a%d_]') then tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {msg_id=msg.id_,chat_id=msg.to.id,username=matches[2],cmd="ban"}) end end
if matches[1] == "الغاء الحظر" and is_mod(msg)  then
if not matches[2] and msg.reply_id then tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {msg_id=msg.id_,chat_id=msg.to.id,cmd="unban"}) end
if matches[2] and string.match(matches[2], '^%d+$') then tdcli_function ({ID = "GetUser",user_id_ = matches[2],}, action_by_id, {chat_id=msg.to.id,user_id=matches[2],msg_id=msg.id_,cmd="uban"}) end
if matches[2] and string.match(matches[2], '@[%a%d_]') then tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {msg_id=msg.id_,chat_id=msg.to.id,username=matches[2],cmd="unban"}) end end
if matches[1] == "كتم" and is_mod(msg)  then
if not matches[2] and msg.reply_id then tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {msg_id=msg.id_,chat_id=msg.to.id,cmd="silent"}) end
if matches[2] and string.match(matches[2], '^%d+$') then tdcli_function ({ID = "GetUser",user_id_ = matches[2],}, action_by_id, {chat_id=msg.to.id,user_id=matches[2],msg_id=msg.id_,cmd="ktm"}) end
if matches[2] and string.match(matches[2], '@[%a%d_]') then tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username,{msg_id=msg.id_,chat_id=msg.to.id,username=matches[2],cmd="silent"}) end end
if matches[1] == "الغاء الكتم" and is_mod(msg)  then
if not matches[2] and msg.reply_id then tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply,{msg_id=msg.id_,chat_id=msg.to.id,cmd="unsilent"}) end
if matches[2] and string.match(matches[2], '^%d+$') then tdcli_function ({ID = "GetUser",user_id_ = matches[2],}, action_by_id,{chat_id=msg.to.id,user_id=matches[2],msg_id=msg.id_,cmd="unktm"}) end
if matches[2] and string.match(matches[2], '@[%a%d_]') then tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]},action_by_username,{msg_id=msg.id_,chat_id=msg.to.id,username=matches[2],cmd="unsilent"}) end end
if matches[1] == "المكتومين" and is_mod(msg)  then return silent_users_list(msg.to.id) end
if matches[1] == "المحظورين" and is_mod(msg)  then return banned_list(msg.to.id) end
 end -- end of insert group 
 if matches[1] == 'مسح' and matches[2] == 'المطورين' and we_sudo(msg)  then
if #redis:smembers(boss..':SUDO_BOT:') == 0 then  return "⚙️*¦* عذرا لا يوجد مطورين في البوت  ✖️" end
sendMsg(msg.to.id,msg.id_,"📛*¦* تم مسح `"..redis:scard(boss..':SUDO_BOT:').."` من المطورين ☔️\n✓","md")
redis:del(boss..':SUDO_BOT:') return false end			
if matches[1] == 'مسح' and matches[2] == "قائمه العام" and we_sudo(msg)  then
if #redis:smembers(boss..'gban_users')==0 then return "*⚙️¦ لا يوجد مستخدمين محظورين عام في المجموعه *" end
redis:del(boss..'gban_users') return "⚙️*¦* تم مسح قائمه العام\n✓" end 
if we_sudo(msg) then
if matches[1] == "رفع مطور" then
if not matches[2] and msg.reply_id then tdcli_function({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {msg_id=msg.id_,chat_id=msg.to.id,cmd="up_sudo"}) end
if matches[2] and string.match(matches[2], '^%d+$') then tdcli_function ({ID = "GetUser",user_id_ = matches[2],}, action_by_id, {chat_id=msg.to.id,msg_id=msg.id_,user_id=matches[2],cmd="up_sudo"}) end
if matches[2] and not string.match(matches[2], '^%d+$') then tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {msg_id=msg.id_,chat_id=msg.to.id,username=matches[2],cmd="up_sudo"}) end end
if matches[1] == "تنزيل مطور" then
if not matches[2] and msg.reply_id then tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {msg_id=msg.id_,chat_id=msg.to.id,cmd="dn_sudo"}) end
if matches[2] and string.match(matches[2], '^%d+$') then tdcli_function ({ID = "GetUser",user_id_ = matches[2],}, action_by_id, {chat_id=msg.to.id,msg_id=msg.id_,user_id=matches[2],cmd="dn_sudo"}) end
if matches[2] and not string.match(matches[2], '^%d+$') then tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {msg_id=msg.id_,chat_id=msg.to.id,username=matches[2],cmd="dn_sudo"}) end end
if matches[1] == "ضع صوره للترحيب" or matches[1]=="ضع صوره للترحيب 🌄" then
redis:setex(boss..'welcom_ph:witting'..msg.from.id,300,true) return'📭¦ حسننا عزيزي 🍁\n🌄 ¦ الان قم بارسال الصوره للترحيب \n🛠' end
if matches[1] == "تعطيل" and matches[2] == "البوت خدمي" then return lock_service(msg) end
if matches[1] == "تفعيل" and matches[2] == "البوت خدمي" then return unlock_service(msg) end
if matches[1] == "صوره الترحيب" then
return sendPhoto(msg.to.id,msg.id_,0,1,nil,redis:get(boss..':WELCOME_BOT'),[[💯¦ مـرحبآ آنآ بوت آسـمـي ]]..redis:get(boss..'bot:name')..[[ 🎖
💰¦ آختصـآصـي حمـآيهہ‏‏ آلمـجمـوعآت
📛¦ مـن آلسـبآم وآلتوجيهہ‏‏ وآلتگرآر وآلخ...
⚖️¦ مـعرف آلمـطـور  » ]]..SUDO_USER:gsub([[\_]],'_')..[[ 🌿
👨🏽‍🔧]],dl_cb,nil) end
if matches[1] == "ضع كليشه المطور" then 
redis:setex(boss..'text_sudo:witting'..msg.from.id,1200,true) return'📭¦ حسننا عزيزي 🍁\n💬¦ الان قم بارسال الكليشه \n🛠' end
if matches[1] == "ضع شرط التفعيل" and matches[2] and string.match(matches[2], '^%d+$') then 
redis:set(boss..':addnumberusers',matches[2]) return'💱*¦* تم وضـع شـرط آلتفعيل آلبوت آذآ گآنت آلمـجمـوعهہ‏‏ آگثر مـن*【'..matches[2]..'】* عضـو  🍁\n' end
if matches[1] == "شرط التفعيل" then return'🚸*¦* شـرط آلتفعيل آلبوت آذآ گآنت آلمـجمـوعهہ‏‏ آگثر مـن*【'..redis:get(boss..':addnumberusers')..'】* عضـو  🍁\n' end end
if is_sudo(msg) then
if (matches[1] == 'المجموعات' or matches[1] == "المجموعات 🔝") and is_sudo(msg) then return chat_num(msg) end
if matches[1] == 'قائمه المجموعات' and is_sudo(msg) then return chat_list(msg) end
if matches[1] == 'تعطيل' and matches[2] and matches[2]:match("-100(%d+)")  and is_sudo(msg) then
if redis:sismember(boss..'group:ids',matches[2]) then
local name_gp = redis:get(boss..'group:name'..matches[2])
sendMsg(matches[2],0,'📛*¦* تم تعطيل المجموعه بأمر من المطور  \n🚸*¦* سوف اغادر جاوو 🚶🏻🚶🏻 ...\n✘','md')
rem_data_group(matches[2]) 
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = matches[2],user_id_ = our_id,status_ = {ID = "ChatMemberStatusLeft"},},dl_cb,nil)
return '📛*¦* تم تعطيل المجموعه ومغادرتها \n🏷*¦* المجموعةة » ['..name_gp..']\n🎫*¦* الايدي » ( *'..matches[2]..'* )\n✓'
else return '📛*¦* لا توجد مجموعه مفعله بهذا الايدي !\n 🌿' end end end
if matches[1] == 'المطور' then
sendMsg(msg.to.id,msg.id_,(redis:get(boss..":TEXT_SUDO") or '🗃¦ لا توجد كليشه المطور .\n📰¦ يمكنك اضافه كليشه من خلال الامر\n       " `ضع كليشه المطور` " \n📡'),'md') end
if (matches[1] == "اذاعه عام بالتوجيه" or matches[1] == "اذاعه عام بالتوجيه 📣") and is_sudo(msg) then		
if not we_sudo(msg) and not redis:get(boss..'lock_brod') then  return "هذا الاوامر للمطور الاساسي فقط "  end
redis:setex(boss..'fwd:'..msg.from.id,300, true) return "📭¦ حسننا الان ارسل التوجيه للاذاعه \n🔛" end
if (matches[1] == "اذاعه عام" or matches[1] == "اذاعه عام 📢") and is_sudo(msg) then		
if not we_sudo(msg) and not redis:get(boss..'lock_brod') then  return "هذا الاوامر للمطور الاساسي فقط " end
redis:setex(boss..'fwd:all'..msg.from.id,300, true) return "📭¦ حسننا الان ارسل الكليشه للاذاعه عام \n🔛" end
if (matches[1] == "اذاعه خاص" or matches[1] == "اذاعه خاص 👤") and is_sudo(msg) then		
if not we_sudo(msg) and not redis:get(boss..'lock_brod') then  return "هذا الاوامر للمطور الاساسي فقط "  end
redis:setex(boss..'fwd:pv'..msg.from.id,300, true) return "📭¦ حسننا الان ارسل الكليشه للاذاعه خاص \n🔛"	 end
if (matches[1] == "اذاعه" or matches[1] == "اذاعه 🗣") and is_sudo(msg) then		
if not we_sudo(msg) and not redis:get(boss..'lock_brod') then  return "هذا الاوامر للمطور الاساسي فقط "  end
redis:setex(boss..'fwd:groups'..msg.from.id,300, true) return "📭¦ حسننا الان ارسل الكليشه للاذاعه للمجموعات \n🔛" end
if (matches[1] == "المطورين" or matches[1] == "المطورين 🕹") and is_sudo(msg) then return sudolist(msg) end
if (matches[1] == "قائمه العام" or matches[1]=="قائمه العام 📜") and is_sudo(msg)  then return gbanned_list(msg) end
if matches[1] == "تعطيل" and (matches[2] == "التواصل" or matches[2]=="التواصل ✖️") and we_sudo(msg) then return lock_twasel(msg) end
if matches[1] == "تفعيل" and (matches[2] == "التواصل" or matches[2]=="التواصل 🔛") and we_sudo(msg) then return unlock_twasel(msg) end
if matches[1] == "حظر عام"  and we_sudo(msg)  then
if not matches[2] and msg.reply_id then tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {chat_id=msg.to.id,msg_id=msg.id_,cmd="banall"}) end
if matches[2] and string.match(matches[2], '^%d+$') then tdcli_function ({ID = "GetUser",user_id_ = matches[2],}, action_by_id,{chat_id=msg.to.id,user_id=matches[2],msg_id=msg.id_,cmd="bandall"}) end
if matches[2] and string.match(matches[2], '@[%a%d_]') then tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {chat_id=msg.to.id,msg_id=msg.id_,username=matches[2],cmd="banall"}) end end
if matches[1] == "الغاء العام" and we_sudo(msg)  then
if not matches[2] and msg.reply_id then tdcli_function ({ID = "GetMessage",chat_id_ = msg.to.id,message_id_ = msg.reply_id}, action_by_reply, {chat_id=msg.to.id,msg_id=msg.id_,cmd="unbanall"}) end
if matches[2] and string.match(matches[2], '^%d+$') then tdcli_function ({ID = "GetUser",user_id_ = matches[2],},action_by_id,{chat_id=msg.to.id,user_id=matches[2],msg_id=msg.id_,msg_id=msg.id_,cmd="unbandall"}) end
if matches[2] and string.match(matches[2], '@[%a%d_]') then tdcli_function ({ID = "SearchPublicChat",username_ = matches[2]}, action_by_username, {chat_id=msg.to.id,username=matches[2],msg_id=msg.id_,cmd="unbanall"}) end end 
if matches[1] == "رتبتي" then return '🎫*¦* رتبتك » '..get_rank(msg)..'\n🌿' end
if (matches[1] == "الغاء الامر ✖️" or matches[1] == "الغاء" or matches[1] == "الغاء الامر") and is_mod(msg) then
redis:del(boss..'waiting_link'..msg.from.id) redis:del(boss..'welcom:witting'..msg.from.id) redis:del(boss..'rulse:witting'..msg.from.id)redis:del(boss..'rulse:witting'..msg.from.id) redis:del(boss..'name:witting'..msg.from.id) redis:del(boss..'about:witting'..msg.from.id) redis:del(boss..'fwd:all'..msg.from.id) redis:del(boss..'fwd:pv'..msg.from.id) redis:del(boss..'fwd:groups'..msg.from.id) redis:del(boss..'namebot:witting'..msg.from.id) redis:del(boss..'addrd_all:'..msg.from.id) redis:del(boss..'delrd:'..msg.from.id) redis:del(boss..'addrd:'..msg.from.id) redis:del(boss..'delrdall:'..msg.from.id) redis:del(boss..'text_sudo:witting'..msg.from.id)  return '📬*¦* تم آلغآء آلآمـر بنجآح \n🌿'  end
----------------- استقبال الرسائل ---------------
if msg.text and msg.text ~= "الغاء الامر ✖️" and msg.text ~= "الغاء الامر"  and msg.text ~= "الغاء" then
if (msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.text:match("^([https?://w]*.?t.me/joinchat/%S+)$")) and redis:get(boss..'waiting_link'..msg.from.id) then  -- استقبال الرابط
redis:set(boss..'linkgp'..msg.to.id,msg.text)
return "💌*¦* شكرأ لك 😻\n📦*¦* تم حفظ الرابط بنجاح \n✓" end
if redis:get(boss..'text_sudo:witting'..msg.from.id) then -- استقبال كليشه المطور
redis:del(boss..'text_sudo:witting'..msg.from.id) redis:set(boss..':TEXT_SUDO','['..msg.text..']')
return "📜*¦* تم وضع الكليشه بنجاح كلاتي 👋🏻\n\n*{*  ["..msg.text.."]  *}*\n✓"  end
if redis:get(boss..'welcom:witting'..msg.from.id) then -- استقبال كليشه الترحيب
redis:del(boss..'welcom:witting'..msg.from.id) redis:set(boss..'welcome:msg'..msg.to.id,msg.text)
return "📜*¦* تم وضع الترحيب بنجاح كلاتي 👋🏻\n*["..msg.text.."]*\n\n🔖¦ ملاحظه تستطيع\n🗒¦ اضهار القوانين بواسطه  ➣ *{rules}*  \n📰¦  اضهار الاسم بواسطه ➣ *{name}*\n🏷¦ اضهار المعرف بواسطه ➣ *{username}*" end
if redis:get(boss..'rulse:witting'..msg.from.id) then --- استقبال القوانين
redis:del(boss..'rulse:witting'..msg.from.id) redis:set(boss..'rulse:msg'..msg.to.id,check_markdown(msg.text)) return '📜*¦* مرحبآ عزيزي\n📦¦ تم حفظ القوانين بنجاح ✓\n🔖¦ اكتب [[ القوانين ]] لعرضها \n💬✓' end
if redis:get(boss..'name:witting'..msg.from.id) then --- استقبال الاسم
redis:del(boss..'name:witting'..msg.from.id) tdcli_function ({ID = "ChangeChatTitle",chat_id_ = msg.to.id,title_ = msg.text},dl_cb,nil) end
if redis:get(boss..'about:witting'..msg.from.id) then --- استقبال الوصف
redis:del(boss..'about:witting'..msg.from.id) tdcli_function ({ID = "ChangeChannelAbout",channel_id_ = getChatId(msg.to.id).ID,about_ = msg.text}, dl_cb, nil) return "📜*¦* تم وضع الوصف بنجاح\n✓" end
if redis:get(boss..'fwd:all'..msg.from.id) then ---- استقبال رساله الاذاعه عام
redis:del(boss..'fwd:all'..msg.from.id)
local pv = redis:smembers(boss..'users')  
local groups = redis:smembers(boss..'group:ids')
for i = 1, #pv do sendMsg(pv[i],0,check_markdown(msg.text))end
for i = 1, #groups do sendMsg(groups[i],0,check_markdown(msg.text))end
return sendMsg(msg.to.id,msg.id_,'📜*¦* تم اذاعه الكليشه بنجاح 🏌🏻\n🗣*¦* للمـجمـوعآت » *'..#groups..'* گروب \n👥*¦* للمـشـترگين » '..#pv..' مـشـترگ \n✓')end
if redis:get(boss..'fwd:pv'..msg.from.id) then ---- استقبال رساله الاذاعه خاص
redis:del(boss..'fwd:pv'..msg.from.id)
local pv = redis:smembers(boss..'users')
for i = 1, #pv do sendMsg(pv[i],0,'['..msg.text..']')end
sendMsg(msg.to.id,0,'🗣*¦* تم اذاعه الى `'..#pv..'` مـشـترگ 👍🏿\n✓') end
if redis:get(boss..'fwd:groups'..msg.from.id) then ---- استقبال رساله الاذاعه خاص
redis:del(boss..'fwd:groups'..msg.from.id)
local groups = redis:smembers(boss..'group:ids')
for i = 1, #groups do sendMsg(groups[i],0,'['..msg.text..']')end
sendMsg(msg.to.id,0,'🗣*¦*  تم اذاعه الكليشه الى *'..#groups..'* مـجمـوعهہ‏‏\n✓')			
end end end

return {patterns ={"^(تقييد) (%d+)$","^(تقييد) (@[%a%d%_]+)$","^(فك التقييد) (%d+)$","^(فك التقييد) (@[%a%d%_]+)$","^(ضع شرط التفعيل) (%d+)$","^(التفاعل) (@[%a%d%_]+)$","^(ايدي) (@[%a%d%_]+)$","^(كشف) (%d+)$","^(كشف) (@[%a%d%_]+)$",'^(رفع عضو مميز) (@[%a%d%_]+)$','^(رفع عضو مميز) (%d+)$','^(تنزيل عضو مميز) (@[%a%d%_]+)$','^(تنزيل عضو مميز) (%d+)$','^(رفع ادمن) (@[%a%d%_]+)$','^(رفع ادمن) (%d+)$','^(تنزيل ادمن) (@[%a%d%_]+)$','^(تنزيل ادمن) (%d+)$','^(رفع المدير) (@[%a%d%_]+)$','^(رفع المدير) (%d+)$','^(رفع منشى) (%d+)$','^(تنزيل منشى) (%d+)$','^(رفع منشى) (@[%a%d%_]+)$','^(تنزيل منشى) (@[%a%d%_]+)$','^(تنزيل المدير) (@[%a%d%_]+)$','^(تنزيل المدير) (%d+)$','^(قفل) (.*)$','^(فتح) (.*)$','^(تفعيل) (.*)$','^(تعطيل) (.*)$','^(ضع تكرار) (%d+)$',"^(مسح) (.*)$",'^(منع) (.*)$','^(الغاء منع) (.*)$',"^(حظر عام) (@[%a%d%_]+)$","^(حظر عام) (%d+)$","^(الغاء العام) (@[%a%d%_]+)$","^(الغاء العام) (%d+)$","^(حظر) (@[%a%d%_]+)$","^(حظر) (%d+)$","^(الغاء الحظر) (@[%a%d%_]+)$","^(الغاء الحظر) (%d+)$","^(طرد) (@[%a%d%_]+)$","^(طرد) (%d+)$","^(كتم) (@[%a%d%_]+)$","^(كتم) (%d+)$","^(الغاء الكتم) (@[%a%d%_]+)$","^(الغاء الكتم) (%d+)$","^(رفع مطور) (.*)$","^(تنزيل مطور) (.*)$","^(تعطيل) (-%d+)$","^(الاشتراك) ([123])$", "^(شحن) (%d+)$", "^(git) (.*)$", "(.*)" },run=xboss}
