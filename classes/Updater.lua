UT.Updater = {}

UT.Updater.filename = "Ultimate Trainer 4.1.2"
UT.Updater.username = "ChildOfSorrow"
UT.Updater.requests = 6

function UT.Updater.updateAvailable()
    local menu = {
        title = "update available",
        text = UT.Updater.filename .. " is available, you can download it from the official UnknownCheats thread.",
        button_list = {
            {text = "download", callback_func = function() Steam:overlay_activate("url", UT.url) end},
            {text = "cancel", cancel_button = true},
        }
    }
    UT.openMenu(menu)
end

function UT.Updater.checkUpdate(url)
    local url = url or "https://mobile.twitter.com/unknowncheats"
    Steam:http_request(url,
        function(success, body)
            if not success then return end
            local pattern = UT.Updater.filename .. " by " .. UT.Updater.username .. " has been approved"
            local result = string.match(body, pattern)
            if result then
                UT.Updater.updateAvailable()
                return
            end
            local tweets = {}
            local pattern = "/UnKnoWnCheaTs/status/%d+"
            local result = string.gmatch(body, pattern)
            for value in result do
                local tweet = string.match(value, "%d+")
                if not UT.inTable(tweet, tweets) then
                    table.insert(tweets, tweet)
                end
            end
            if not UT.checkTable(tweets) then
                return
            end
            local tweet = tweets[#tweets]
            UT.Updater.requests = UT.Updater.requests - 1
            if UT.Updater.requests <= 0 then return end
            local url = "https://mobile.twitter.com/unknowncheats?max_id=" .. tweet
            UT.Updater.checkUpdate(url)
        end
    )
end

UTClassUpdater = true