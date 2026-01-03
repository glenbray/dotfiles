#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Dismiss Notifications
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔕
# @raycast.packageName System

# Documentation:
# @raycast.description Dismiss all notifications from Notification Center

tell application "System Events" to tell process "NotificationCenter"
	-- Handle alert-style notifications (separate windows)
	repeat with w in (windows whose name is not "Notification Center")
		repeat with a in (actions of group 1 of group 1 of w whose description is "Close" or description starts with "Clear")
			ignoring application responses
				perform a
			end ignoring
		end repeat
	end repeat

	-- Handle banner notifications in Notification Center
	if not (window "Notification Center" exists) then return

	set notificationContainer to a reference to group 1 of scroll area 1 of group 1 of group 1 of window "Notification Center"

	set notificationGroups to a reference to groups of notificationContainer
	repeat with i from (number of notificationGroups) to 1 by -1
		set g to item i of notificationGroups
		repeat with a in (actions of g whose description is "Close" or description starts with "Clear")
			ignoring application responses
				perform a
			end ignoring
		end repeat
	end repeat

	repeat with a in (actions of notificationContainer whose description is "Close" or description starts with "Clear")
		perform a
	end repeat
end tell

return
