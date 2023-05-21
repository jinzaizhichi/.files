# Firefox configuration
This Firefox configuration was based on [this](https://www.youtube.com/watch?v=BmchttxZ85w) guide.

## Enabling and creating custom configuration files on Firefox
1. Go to about:config and set toolkit.legacyUserProfileCustomizations.stylesheets to true
2. Click on ☰ ➝ Help ➝ More Troubleshooting Information ➝ Click open folder on the profile folder section
3. Create a folder named chrome
4. Create the userChrome.css file and write [this](userChrome.css) to it
5. Create the userContent.css file and write [this](userContent.css) to it
6. Restart Firefox

## Used "plugins"
All "plugins" were taken from [this](https://github.com/MrOtherGuy/firefox-csshacks) repository.

### userChrome.css plugins
- [Round UI Items](https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/round_ui_items.css)
- [Centered Tab Content](https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/centered_tab_content.css)
- [Floating Find Bar on Top](https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/floating_findbar_on_top.css)
- [Loading Indicator Bouncing Line](https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/loading_indicator_bouncing_line.css)
- [Hover to Show Tab Close Button](https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/tab_close_button_always_on_hover.css)

### userContent.css plugins
- [Scrollbar Width and Color](https://github.com/MrOtherGuy/firefox-csshacks/tree/master/content/css_scrollbar_width_color.css)
- [New Tab Background Color](https://github.com/MrOtherGuy/firefox-csshacks/tree/master/content/newtab_background_color.css)
