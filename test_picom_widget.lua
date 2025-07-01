#!/usr/bin/env lua

-- Test script for picom widget
-- Run this to test if the widget loads correctly

local success, picom_control = pcall(require, "config.ui.widgets.picom-control")

if success then
    print("✅ Picom control widget loaded successfully!")
    if picom_control.widget then
        print("✅ Widget object created")
    else
        print("❌ Widget object not found")
    end
    
    if picom_control.toggle then
        print("✅ Toggle function available")
    else
        print("❌ Toggle function not found")
    end
else
    print("❌ Failed to load picom control widget:")
    print(picom_control) -- This will be the error message
end
