# Remove WiFi SSID and password
#git config filter.password.clean "sed -e 's/[RealPassword]/[PasswordPlaceHolder]/' -e 's/[RealSSID]/[SSIDPlaceHolder]/'"
git config filter.password.clean "sed -e 's/--PASS--/--PASS--/' -e 's/--USER--/--USER--/'"

# Restore WiFi SSID and password
#git config filter.password.smudge "sed -e 's/[PasswordPlaceHolder]/[RealPassword]/' -e 's/[SSIDPlaceHolder]/[RealSSID]/'"
git config filter.password.smudge "sed -e 's/--PASS--/--PASS--/' -e 's/--USER--/--USER--/'"


cat > .git/info/attributes << EOF
** filter=password
EOF
