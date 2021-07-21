def make_dict(app)
  "'<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>#{app}</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'"
end

applications = [
  "/Applications/Google Chrome.app/",
  "/Applications/Visual Studio Code.app/",
  "/Applications/iTerm.app/",
  "/Applications/Slack.app/",
  "/Applications/Discord.app/",
  "/Applications/Spotify.app/",
  "/Applications/Microsoft Outlook.app/",
  "/System/Applications/System Preferences.app/",
]
%x[defaults write com.apple.dock persistent-apps -array #{applications.map do |app| make_dict(app) end.join(" \\\n")} && killall Dock]
