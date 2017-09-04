function send_msg(chat_id, text, parse)
    assert( tdbot_function ({
    	_ = "sendMessage",
    	chat_id = chat_id,
    	reply_to_message_id = 0,
    	disable_notification = 0,
    	from_background = 1,
    	reply_markup = nil,
    	input_message_content = {
    		_ = "inputMessageText",
    		text = text,
    		disable_web_page_preview = 1,
    		clear_draft = 0,
    		parse_mode = getParse(parse),
    		entities = {}
    	}
    }, dl_cb, nil))

end

function reply_msg(chat_id, text, msg_id, parse)
    tdbot_function ({
    	_ = "sendMessage",
    	chat_id = chat_id,
    	reply_to_message_id = msg_id,
    	disable_notification = 0,
    	from_background = 1,
    	reply_markup = nil,
    	input_message_content = {
    		_ = "inputMessageText",
    		text = text,
    		disable_web_page_preview = 1,
    		clear_draft = 0,
    		parse_mode = getParse(parse),
    		entities = {}
    	}
    }, dl_cb, nil)
end

function createNewGroupChat(user_ids, title, cb, cmd)
  	tdbot_function ({
    _ = "createNewGroupChat",
	    user_ids = user_ids, -- vector
	    title = title
  	}, cb or dl_cb, cmd)
end

function migrateGroupChatToChannelChat(chat_id, cb, cmd)
  	tdbot_function ({
	    ID = "migrateGroupChatToChannelChat",
	    chat_id = chat_id
  	}, cb or dl_cb, cmd)
end

function changeChatMemberStatus(chat_id, user_id, status, cb, cmd)
  	tdbot_function ({
	    _ = "changeChatMemberStatus",
	    chat_id = chat_id,
	    user_id = user_id,
	    status = {
	      _ = "chatMemberStatus" .. status
	    },
  	}, cb or dl_cb, cmd)
end

function delete_msg(chat_id, msg_id)
	msg_id = {[0] = msg_id}
    tdbot_function ({
    	_ = "deleteMessages",
    	chat_id = chat_id,
    	message_ids = msg_id
    }, dl_cb, nil)
end

function getParse(parse)
	if parse  == 'md' then
		return {_ = "textParseModeMarkdown"}
	elseif parse == 'html' then
		return {_ = "textParseModeHTML"}
	else
		return nil
	end
end

function sendRequest(request_id, chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, callback, extra)
  	tdbot_function ({
	    _ = request_id,
	    chat_id = chat_id,
	    reply_to_message_id = reply_to_message_id,
	    disable_notification = disable_notification,
	    from_background = from_background,
	    reply_markup = reply_markup,
	    input_message_content = input_message_content,
	}, callback or dl_cb, extra)
end

function add_user(chat_id, user_id)
  	tdbot_function ({
    	_ = "addChatMember",
    	chat_id = chat_id,
    	user_id = user_id,
    	forward_limit = 0
  	}, dl_cb, extra)
end

function mark_as_read(chat_id, message_ids)
  	tdbot_function ({
    	_ = "ViewMessages",
    	chat_id = chat_id,
    	message_ids = message_ids
  	}, dl_cb, extra)
end

function get_msg_info(chat_id, message_id, cb_function, extra)
  	tdbot_function ({
    	_ = "getMessage",
    	chat_id = chat_id,
    	message_id = message_id
  	}, cb_function, extra)
end

function getChats(offset_order, offset_chat_id, limit, cb, cmd)
  	if not limit or limit > 20 then
    	limit = 20
  	end
	tdbot_function ({
	    _ = "getChats",
	    offset_order = offset_order or 9223372036854775807,
	    offset_chat_id = offset_chat_id or 0,
	    limit = limit
  	}, cb or dl_cb, cmd)
end

function getMe(cb, cmd)
  	tdbot_function ({
    	_ = "getMe",
  	}, cb or dl_cb, cmd)
end

function getMeCb(extra, result)
	our_id = result.id
	print("Our id: "..our_id)
	file = io.open("./data/config.lua", "r")
	config = ''
	repeat
		line = file:read ("*l")
		if line then
			line = string.gsub(line, "0", our_id)
			config = config.."\n"..line
		end
	until not line
		
	file:close()
	file = io.open("./data/config.lua", "w")
	file:write(config)
	file:close()	
end

function changeAbout(about, cb, cmd)
 	tdbot_function ({
    	_ = "changeAbout",
    	about = about
  	}, cb or dl_cb, cmd)
end

function pin_msg(channel_id, message_id, disable_notification)
  	tdbot_function ({
    	_ = "pinChannelMessage",
    	channel_id = getChatId(channel_id)._,
    	message_id = message_id,
    	disable_notification = disable_notification
  	}, dl_cb, nil)
end

function openChat(chat_id, cb, cmd)
	tdbot_function ({
    	_ = "openChat",
    	chat_id = chat_id
	}, cb or dl_cb, cmd)
end

function kick_user(chat_id, user_id)
  	tdbot_function ({
    	_ = "changeChatMemberStatus",
    	chat_id = chat_id,
    	user_id = user_id,
    	status = {
      		_ = "chatMemberStatusBanned"
    	},
  	}, dl_cb, nil)
end

function promoteToAdmin(chat_id, user_id)
  	tdbot_function ({
    	_ = "changeChatMemberStatus",
    	chat_id = chat_id,
    	user_id = user_id,
    	status = {
      		_ = "chatMemberStatusAdministrator"
    	},
  	}, dl_cb, nil)
end

function removeFromBanList(chat_id, user_id)
    tdbot_function ({
		_ = "changeChatMemberStatus",
		chat_id = chat_id,
		user_id = user_id,
		status = {
			_ = "chatMemberStatusLeft"
      	},
    }, dl_cb, nil)
end

function addChatMember(chat_id, user_id)
	tdbot_function ({
		_ = "addChatMember",
		chat_id = chat_id,
		user_id = user_id,
		forward_limit = 50
	}, cb or dl_cb, nil)
end

function resolve_username(username, cb_function, cb_extra)
    tdbot_function ({
        _ = "searchPublicChat",
        username = username
    }, cb_function, cb_extra)
end

function resolve_cb(extra, user)
	if compare_permissions(extra.chat_id, extra.superior, user.id) then
		if extra.command == "ban" then
			send_msg(extra.chat_id, lang_text(extra.chat_id, 'banUser'):gsub("$id", user.id), "md")
			kick_user(extra.chat_id, user.id)
			redis:set("ban:" .. extra.chat_id .. ":" .. user.id, true)
		elseif extra.command == "unban" then		
			send_msg(extra.chat_id, lang_text(extra.chat_id, 'unbanUser'):gsub("$id", user.id), "md")
			redis:del("ban:" .. extra.chat_id .. ":" .. user.id)
			removeFromBanList(extra.chat_id, user.id)
		elseif extra.command == "kick" then		
			send_msg(extra.chat_id, lang_text(extra.chat_id, 'kickUser'):gsub("$id", user.id), "md")
			kick_user(extra.chat_id, user.id)
      		removeFromBanList(extra.chat_id, user.id)
		elseif extra.command == "gban" then		
			send_msg(extra.chat_id, lang_text(extra.chat_id, 'gbanUser'):gsub("$id", user.id), "md")
			kick_user(extra.chat_id, user.id)
			redis:sadd("gbans", user.id)
		elseif extra.command == "ungban" then		
			send_msg(extra.chat_id, lang_text(extra.chat_id, 'unbanUser'):gsub("$id", user.id), "md")
			redis:srem("gbans", user.id)
		elseif extra.command == "mute" then
			send_msg(extra.chat_id, lang_text(extra.chat_id, 'muteUser'):gsub("$id", user.id), "md")
			redis:set("muted:" .. extra.chat_id .. ":" .. user.id, true)
		elseif extra.command == "unmute" then
			send_msg(extra.chat_id, lang_text(extra.chat_id, 'unmuteUser'):gsub("$id", user.id), "md")
			redis:del("muted:" .. extra.chat_id .. ":" .. user.id)
		elseif extra.command == "admin" then
			send_msg(extra.chat_id, lang_text(extra.chat_id, 'newAdmin') .. ": @" .. (user.type_.user_.username_ or user.type_.user_.first_name_), "html")
			redis:sadd('admins', user.id)
			redis:srem('mods:'..extra.chat_id, user.id)
      		redis:hset('bot:ids',user.id, '@'.. user.type_.user_.username_)
		elseif extra.command == "mod" then
			send_msg(extra.chat_id, lang_text(extra.chat_id, 'newMod') .. ": @" .. (user.type_.user_.username_ or user.type_.user_.first_name_), "html")
			redis:sadd('mods:'..extra.chat_id, user.id)
			if new_is_sudo(extra.superior) then
				redis:srem('admins', user.id)
			end
      		redis:hset('bot:ids',user.id, '@'.. user.type_.user_.username_)
		elseif extra.command == "user" then
			if new_is_sudo(extra.superior) then
				redis:srem('mods:'..extra.chat_id, user.id)
				redis:srem('admins', user.id)
			elseif is_admin(extra.superior) then
				redis:srem('mods:'..extra.chat_id, user.id)
			end
			send_msg(extra.chat_id, "<code>></code> @" .. (user.type_.user_.username_ or user.type_.user_.first_name_) .. "" ..  lang_text(extra.chat_id, 'nowUser'), "html")
		end
	else
		permissions(extra.superior, extra.chat_id, extra.plugin_tag)
	end
end

function resolve_id(user_id, cb_function, cb_extra)
    tdbot_function ({
        _ = "getUserFull",
        user_id = user_id
    }, cb_function, cb_extra)
end

function getChat(chat_id, cb, cmd)
	tdbot_function ({
    	_ = "getChat",
    	chat_id = chat_id
	}, cb or dl_cb, cmd)
end

function getChannelMembers(channel_id, offset, filter, limit, cb_function, cb_extra)
	if not limit or limit > 200 then
		limit = 200
	end

	tdbot_function ({
    	_ = "getChannelMembers",
    	channel_id = getChatId(channel_id)._,
    	filter = {
      		_ = "channelMembersFilter" .. filter
    	},
    	offset = offset,
    	limit = limit
  	}, cb_function or cb_function, cb_extra)
end

function forward_msg(chat_id, from_chat_id, message_id)
    message_id = {[0] = message_id}
    tdbot_function ({
        _ = "forwardMessages",
        chat_id = chat_id,
        from_chat_id = from_chat_id,
        message_ids = message_id,
        disable_notification = 0,
        from_background = 1
    }, dl_cb, nil)
end

function kick_resolve_cb(extra, user)
    if compare_permissions(extra.chat_id, extra.superior, user.id) then
        tdbot_function ({
            _ = "changeChatMemberStatus",
            chat_id = tonumber(extra.chat_id),
            user_id = user.id,
            status = {
                _ = "chatMemberStatusKicked"
            },
        }, dl_cb, nil)
    else
        send_msg(extra.chat_id, 'error', 'md')
    end
end

function kick_resolve(chat_id, username, extra)
    resolve_username(username, kick_resolve_cb, {chat_id = chat_id, superior = extra})
end

function redisunban_by_reply_cb(channel_id, msg)
    redis:del("ban:" .. channel_id .. ":" .. msg.sender_user_id_)
end

function redisunban_by_reply(channel_id, message_id)
    get_msg_info(channel_id, message_id, redisunban_by_reply_cb, channel_id)
end

function redisban_resolve_cb(extra, user)
    if compare_permissions(extra.chat_id, extra.superior, user.id) then
        redis:set("ban:" .. extra.chat_id .. ":" .. user.id, true)
    end
end

function redisban_resolve(chat_id, username, superior)
    local extra = {}
    resolve_username(username, redisban_resolve_cb, {chat_id = chat_id, superior = superior})
end

function redisgban_resolve_cb(chat_id, user)
    redis:sadd("gbans", user.id)
end

function redisgban_resolve(chat_id, username)
    resolve_username(username, redisgban_resolve_cb, chat_id)
end

function redisgban_resolve_cb(chat_id, user)
    redis:srem("gbans", user.id)
end

function redisgban_resolve(chat_id, username)
    resolve_username(username, redisgban_resolve_cb, chat_id)
end

function redisunban_resolve_cb(extra, user)
    if compare_permissions(extra.chat_id, extra.superior, user.id) then
        redis:del("ban:" .. extra.chat_id .. ":" .. user.id)
    end
end

function redisunban_resolve(chat_id, username, superior)
    resolve_username(username, redisunban_resolve_cb, {chat_id = chat_id, superior = superior})
end

function redismute_resolve_cb(chat_id, user)
    redis:set("muted:" .. chat_id .. ":" .. user.id, true)
end

function redismute_resolve(chat_id, username)
    resolve_username(username, redismute_resolve_cb, chat_id)
end

function redisunmute_resolve_cb(chat_id, user)
    redis:del("muted:" .. chat_id .. ":" .. user.id)
end

function redisunmute_resolve(chat_id, username)
    resolve_username(username, redisunmute_resolve_cb, chat_id)
end

function getInputFile(file)
    if file:match('/') then
        infile = {_ = "InputFileLocal", path = file}
    elseif file:match('^%d+$') then
        infile = {_ = "InputFileId", id = file}
    else
        infile = {_ = "InputFilePersistentId", persistent_id = file}
    end
    return infile
end

function sendSticker(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, sticker, cb, cmd)
	local input_message_content = {
    	_ = "inputMessageSticker",
    	sticker = getInputFile(sticker),
    	width = 0,
    	height = 0
  	}
  	sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)
end

function send_document(chat_id, document)
    tdbot_function ({
    	_ = "sendMessage",
    	chat_id = chat_id,
    	reply_to_message_id = 0,
    	disable_notification = 0,
    	from_background = 1,
    	reply_markup = nil,
    	input_message_content = {
            _ = "inputMessageDocument",
            document = getInputFile(document),
            caption = nil
        },
    }, dl_cb, cb_extra)
end

function sendSticker(chat_id, sticker)
	local input_message_content = {
    	_ = "inputMessageSticker",
    	sticker = getInputFile(sticker),
    	width = 0,
    	height = 0
  	}
  	sendRequest('sendMessage', chat_id, 0, 0, 1, nil, input_message_content, cbsti)
end

function sendAnimation(chat_id, gif, caption)
  	local input_message_content = {
    	_ = "inputMessageAnimation",
    	animation = getInputFile(gif),
    	width = 0,
    	height = 0,
    	caption = caption
  }
  sendRequest('sendMessage', chat_id, 0, 0, 1, nil, input_message_content, cbsti)
end

function sendAudio(chat_id, audio, caption)
  local input_message_content = {
    _ = "inputMessageAudio",
    audio = getInputFile(audio),
    duration = duration or 0,
    title = title or 0,
    performer = performer,
    caption = caption
  }
  sendRequest('sendMessage', chat_id, 0, 0, 1, nil, input_message_content, cbsti)
end

function sendDocument(chat_id, document, caption)
	local input_message_content = {
		_ = "inputMessageDocument",
		document = getInputFile(document),
		caption = caption
	}
	sendRequest('sendMessage', chat_id, 0, 0, 1, nil, input_message_content, cbsti)
end

function sendPhoto(chat_id, photo, caption)
  local input_message_content = {
    _ = "inputMessagePhoto",
    photo = getInputFile(photo),
    added_sticker_file_ids = {},
    width = 0,
    height = 0,
    caption = caption
  }
  sendRequest('SendMessage', chat_id, 0, 0, 1, nil, input_message_content, cbsti)
end

function sendVideo(chat_id, video, caption)
	local input_message_content = {
		_ = "inputMessageVideo",
    	video = getInputFile(video),
    	added_sticker_file_ids = {},
    	duration = duration or 0,
    	width = width or 0,
    	height = height or 0,
    	caption = caption
  	}
  	sendRequest('sendMessage', chat_id, 0, 0, 1, nil, input_message_content, cbsti)
end

function sendVoice(chat_id, voice, caption)
	local input_message_content = {
    	_ = "inputMessageVoice",
    	voice = getInputFile(voice),
    	duration = duration or 0,
    	waveform = waveform or 0,
    	caption = caption
  	}
  	sendRequest('sendMessage', chat_id, 0, 0, 1, nil, input_message_content, cbsti)
end

function cbsti(a,b)
	--vardump(a)
	--vardump(b)
end

function export_link(chat_id, cb_function, cb_extra)
    tdbot_function ({
        _ = "exportChatInviteLink",
        chat_id = chat_id
    }, cb_function, cb_extra)
end

function checkChatInviteLink(link, cb, cmd)
  	tdbot_function ({
    	_ = "checkChatInviteLink",
    	invite_link = link
  	}, cb or dl_cb, cmd)
end

function getChannelFull(channel_id, cb, cmd)
  	tdbot_function ({
    	_ = "GetChannelFull",
    	channel_id = getChatId(channel_id)._
  	}, cb or dl_cb, cmd)
end

function chat_history(chat_id, from_message_id, offset, limit, cb_function, cb_extra)
    if not limit or limit > 100 then
        limit = 100
    end
    tdbot_function ({
        _ = "getChatHistory",
        chat_id = chat_id,
        from_message_id = from_message_id,
        offset = offset or 0,
        limit = limit
    }, cb_function, cb_extra)
end

function delete_msg_user(chat_id, user_id)
    tdbot_function ({
        _ = "deleteMessagesFromUser",
        chat_id = chat_id,
        user_id = user_id
    }, cb or dl_cb, nil)
end