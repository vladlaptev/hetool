#coding: cp866
#require_relative '../lib/hackex'
require '../lib/docopt'
require '../lib/mylib'
require "json"
require "rubygems"

doc =<<EOF
Usage:
 #{__FILE__} add <opt1> [<opt2>] [<opt3>] [<opt4>] [<opt5>]
EOF

begin
  arguments = Docopt::docopt(doc)
rescue Docopt::Exit => e
  puts e.message
  exit
end
opt=arguments["<opt1>"]
###ACCAUNT PARSER###
email, at, usr, 
email_login, pass_login, email_addcontact, email_money_from_accs,
email_robobuy, ip_robobuy, email_spamacc, email_createcsv, 
nick_register, email_register, password_register = accauntParser
####################
#Login
if ((opt != "reg") and (opt != "autoLogin") and (opt != "accauntParser"))
#mailA, auth_tokenA, userA = login true
if opt != "CSV" and opt != "megaspam" and opt != "megaCleaner" and opt != "sendmonFromContacts"
accFinder email_login, 0
print "Login: "
wrt = $stdin.gets.to_i
mail = email_login[wrt]
auth_token = at[wrt]
user = JSON.parse(usr[wrt])
end
end

HCrack = "2"

opt=arguments["<opt1>"]
returnValue = case opt
when "ping" then pingDevices auth_token, user, arguments["<opt2>"].to_i
pause
when "CSV" then loginCSV email_login, email_createcsv, at, usr, arguments["<opt2>"], arguments["<opt3>"], arguments["<opt4>"]
pause
when "clean" then cleanProc auth_token, user
pause
when "spam" then uploadSpam auth_token, user, arguments["<opt2>"]
pause
when "sendmon" then sendMoney2Contact auth_token, user, mail, arguments["<opt2>"], arguments["<opt3>"]
pause
when "borc" then bAndC auth_token, user, arguments["<opt2>"]
pause
when "purchase" then purchaseSoft auth_token, user, arguments["<opt2>"], arguments["<opt3>"].to_i, 0
pause
when "getmonfromcrack" then getCrackMoney auth_token, user, mail
pause
when "reg" then regLogin nick_register, email_register, password_register
pause
when "getinfo" then getInfo auth_token, user
pause
when "ip2id" then ip2id auth_token, user, arguments["<opt2>"]
pause
when "logUpdate" then logUpdate auth_token, user, arguments["<opt2>"], arguments["<opt3>"]
pause
when "getUserLog" then getUserLog auth_token, user, arguments["<opt2>"]
pause
when "hackFirewall" then firewallCrack auth_token, user, arguments["<opt2>"], 2, true
pause
when "usersoft" then bankCrack auth_token, user, arguments["<opt2>"], 2, true
pause
when "autoLogin" then autoLogin email_login, pass_login
pause
when "test" then test auth_token, user
pause
when "addcon" then AddCont email_login, email_addcontact, at, usr, auth_token, user
pause
when "megaspam" then multiSpam email_login, email_spamacc, at, usr, arguments["<opt2>"]#, arguments["<opt3>"]
pause
when "megaCleaner" then megaCleaner email_login, email_spamacc, at, usr
pause
when "roboBuy" then roboBuy email_login, email_robobuy, at, usr, ip_robobuy, auth_token, user, arguments["<opt2>"], arguments["<opt3>"], arguments["<opt4>"]
pause
when "usersoft2" then bankCrackList auth_token, user, 2
pause
when "accauntParser" then accauntParser
pause
when "sendmonFromContacts" then
to, at, usr, eml, j = mon2contacts email_login, email_money_from_accs, at, usr
transferedMoney = 0
tMon = 0
j.times{ |i|
begin
	tMon = sendMoney2Contact(at[i], usr[i], eml[i], to, "a")
	transferedMoney += tMon
rescue
	puts "Rescued: #{$!}"
end
}
puts "Money From All Accaunts: ".green+transferedMoney.to_s.fM
pause
else
puts "Error!"
end