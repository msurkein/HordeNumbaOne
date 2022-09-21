local addonName, addonData = ...
local function log(name, value)
    print(name.." = "..tostring(value))
end
local function hordeChatFilter(self, event, ...)
    local horde_languages = {
        1,   -- Orcish          Horde
        3,   -- Taurahe         Tauren
        14,  -- Zandali         Troll
        33,  -- Forsaken        Undead
        38,  -- Goblin Binary   Drinking Binary Brew
        40,  -- Goblin          Goblin
        181, -- Shalassian      Nightborne
        285  -- Vulpera         Vulpera
    }
    local alliance_languages = {
        2,  -- Darnassian       Alliance Scum
        6,  -- Dwarvish         Alliance Scum
        7,  -- Common           Alliance Scum
        13, -- Gnomish          Alliance Scum
        35, -- Draenei          Alliance Scum
        37  -- Gnomish Binary   Drunken Alliance Scum
    }
    text, player_name, language_name,
    channel_name, player_name_2, special_flags,
    zone_channel_id, channel_index, channel_base_name,
    message_language_id, line_id, guid,
    battlenet_sender_id, is_mobile, is_subtitle,
    hide_sender_in_letterbox, suppress_raid_icons = ...

    language_is_horde = False
    for i, horde_language_id in ipairs(horde_languages) do
        language_is_horde = language_is_horde or (horde_language_id == message_language_id)
    end

    language_is_alliance = False
    for i, alliance_language_id in ipairs(alliance_languages) do
        language_is_alliance = language_is_alliance or (alliance_language_id == message_language_id)
    end

    language_is_understood = (message_language_id == 0) -- 0 is the language used in chat channels like /1, /2, etc.
    if not language_is_horde then
        for i = 1, GetNumLanguages() do
            name, spoken_language_id = GetLanguageByIndex(i)
            language_is_understood = language_is_understood or (spoken_language_id == message_language_id)
        end
    end

    -- if the language is not horde and we don't understand it
    -- horde numba one
    if language_is_alliance or not (language_is_horde or language_is_understood) then
        last_punctuation = string.match(text, "^.+(%p+)$")
        text = "Horde Numba One"
        if last_punctuation then
            text = text..last_punctuation
        end
    end
    debug = false
    if debug then
        log("text", text)
        log("player_name", player_name)
        log("language_name", language_name)
        log("channel_name", channel_name)
        log("player_name_2", player_name_2)
        log("special_flags", special_flags)
        log("zone_channel_id", zone_channel_id)
        log("channel_index", channel_index)
        log("channel_base_name", channel_base_name)
        log("message_language_id", message_language_id)
        log("line_id", line_id)
        log("guid", guid)
        log("battlenet_sender_id", battlenet_sender_id)
        log("is_mobile", is_mobile)
        log("is_subtitle", is_subtitle)
        log("hide_sender_in_letterbox", hide_sender_in_letterbox)
        log("suppress_raid_icons", suppress_raid_icons)
        log("language_is_horde", language_is_horde)
        log("language_is_alliance", language_is_alliance)
        log("language_is_understood", language_is_understood)
    end
    return false, text, player_name, language_name,
    channel_name, player_name_2, special_flags,
    zone_channel_id, channel_index, channel_base_name,
    message_language_id, line_id, guid,
    battlenet_sender_id, is_mobile, is_subtitle,
    hide_sender_in_letterbox, suppress_raid_icons
end

-- Subscribe to all the events
ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", hordeChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", hordeChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", hordeChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", hordeChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", hordeChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_EMOTE", hordeChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", hordeChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", hordeChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_YELL", hordeChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", hordeChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT", hordeChatFilter)