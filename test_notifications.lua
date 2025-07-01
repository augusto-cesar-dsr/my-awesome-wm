#!/usr/bin/env lua

-- Test script for notification center
-- Run this after restarting AwesomeWM to test notifications

local naughty = require("naughty")

-- Test notifications
naughty.notify({
    title = "Test Notification 1",
    text = "This is a test notification to verify the notification center is working.",
    timeout = 5
})

naughty.notify({
    title = "Test Notification 2", 
    text = "Another test notification with different content.",
    timeout = 5
})

naughty.notify({
    title = "System Alert",
    text = "This is a system alert notification for testing purposes.",
    urgency = "critical",
    timeout = 8
})

print("Test notifications sent! Check your notification center with Super+n")
