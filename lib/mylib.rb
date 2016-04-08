#coding: cp866
require_relative 'hackex'
require 'date'

public
def NetworkDo &proc
	HackEx::Request::NetworkDo &proc
end

#Multi Auto Login
def autoLogin email, password
File.open("accaunts/logindata.txt", "w") { |file|
email.size.times { |i|
	begin
	auth_token, user = autoLoginTool email[i], password[i]
	file.puts "#{email[i]}!|f#{auth_token}!|f#{user.to_json}"
	rescue 
		puts "Error: #{$!}"
	end
}
}
puts "LoginsData Saved To: ".green+"accaunts/logindata.txt"
end

#Auto Login Tool
def autoLoginTool email, password
HackEx.LoginDo(email, password) do |http, auth_token, user|
puts "Username '#{user['username']}', level #{user['level']}".bg_green
File.open("log/roboBuy.log", "a") { |file|
			file.puts "#{email}:#{user['ip']}"
	}
File.open("log/addContact.log", "a") { |file|
			file.puts "#{email}"
	}
return auth_token, user
end
end

def accFinder allMail, type, findMail = [], auth_token = '', user = ''
	at = []
	usr = []
	mail = []
	j = findMail.size
	ja = allMail.size
	case type
###AllMail Print
	when 0 then
	ja.times { |i|
	txt = allMail[i]
	puts "#{i.to_s}. ".green+txt
	}
return at, usr, j
###LoginCSV, AddCont, megaSpammer, megaCleaner, 
	when 1 then
	j.times { |i|
	txt = findMail[i]
	jk = 0
	while (txt != allMail[jk]) do
		if jk > allMail.size
			puts "Email: #{txt} not found!".red
			break
		else
			jk+=1
		end
	end
	at << auth_token[jk]
	usr << JSON.parse(user[jk])
	}
return at, usr, j
#roboBuy
	when 2 then
	ip = []
	j = findMail.size
	j.times { |i|
	txt = findMail[i]
	jk = 0
	while (txt != allMail[jk]) do
		if jk > allMail.size
			puts "Email: #{txt} not found!".red
			break
		else
			jk+=1
		end
	end
	mail << allMail[jk]
	at << auth_token[jk]
	usr << JSON.parse(user[jk])
	}
return at, usr, j, mail
#mon2contacts
	when 3 then
	to = ""
	j = findMail.size
	j.times { |i|
	txt = findMail[i]
	jk = 0
	while (txt != allMail[jk]) do
		if jk > allMail.size
			puts "Email: #{txt} not found!".red
			break
		else
			jk+=1
		end
	end
	if i == 0
		to = JSON.parse(user[jk])["ip"]
		#puts "My IP: ".green+to
	else
		at << auth_token[jk]
		usr << JSON.parse(user[jk])
		mail << txt
	end
	}
return at, usr, j, mail, to

	end
end


def accauntParser
accFile = File.readlines("accaunts/accs.txt")
line_count = accFile.size

logindata = File.readlines("accaunts/logindata.txt")
line_count_ld = accFile.size
email = []
auth_token = []
user = []
line_count_ld.times { |i|
if not (logindata[i] == "\n" or logindata[i].nil?)
	txt = logindata[i].split('!|f')
	email << txt[0]
	auth_token << txt[1]
	user << txt[2].chop
end
}

acc_type = 0
email_login = []
pass_login = []
email_addcontact = []
email_money_from_accs =[]
email_robobuy = []
ip_roboBuy = []
email_spamacc = []
email_createcsv = []
nick_register = []
email_register = []
password_register = []

for i in 0..line_count
if not (accFile[i] == "\n" or accFile[i].nil?)
	case accFile[i].chomp
	when "###login###" then
		acc_type = 1
	when "###addcontact###" then
		acc_type = 2
	when "###money_from_accs###" then
		acc_type = 3
	when "###robobuy###" then
		acc_type = 4
	when "###spamacc###" then
		acc_type = 5
	when "###createcsv###" then
		acc_type = 6
	when "###register###" then
		acc_type = 7
	else
		case acc_type
		when 1 then
			txt = accFile[i].split(':')
			email_login << txt[0]
			pass_login << txt[1].chomp
		when 2 then
			email_addcontact << accFile[i].chomp
		when 3 then
			email_money_from_accs << accFile[i].chomp
		when 4 then
			txt = accFile[i].split(':')
			email_robobuy << txt[0]
			ip_roboBuy << txt[1].chomp
		when 5 then
			email_spamacc << accFile[i].chomp
		when 6 then
			email_createcsv << accFile[i].chomp
		when 7 then
			txt = accFile[i].split(':')
			nick_register << txt[0]
			email_register << txt[1]
			password_register << txt[2].chomp
		else
			puts "Not found!".red
		end
	end
end
end
return email, auth_token, user, email_login, pass_login, 
email_addcontact, email_money_from_accs, email_robobuy, 
ip_roboBuy, email_spamacc, email_createcsv, nick_register, 
email_register, password_register
=begin
p "email_login".green,email_login
p "pass_login".green,pass_login
p "email_addcontact".green,email_addcontact
p "email_money_from_accs".green,email_money_from_accs
p "email_robobuy".green,email_robobuy
p "email_spamacc".green,email_spamacc
p "email_createcsv".green,email_createcsv
p "nick_register".green,nick_register
p "email_register".green,email_register
p "password_register".green,password_register
p email
p auth_token
p user
=end
end

def testColors
puts "black".black
puts "red".red
puts "green".green
puts "brown".brown
puts "blue".blue
puts "magenta".magenta
puts "cyan".cyan
puts "gray".gray
puts "bg_black".bg_black
puts "bg_red".bg_red
puts "bg_green".bg_green
puts "bg_brown".bg_brown
puts "bg_blue".bg_blue
puts "bg_magenta".bg_magenta
puts "bg_cyan".bg_cyan
puts "bg_gray".bg_gray
puts "bg_bold".bold
puts "bg_reverse_color".reverse_color
end

def pause
puts "Press Enter for Exit".cyan
$stdin.gets
end

def thrdMaker
th1=[]
th2=[]
th3=[]
n=0
lines = File.readlines("log/ping.log")
n = lines.size
cnt = n/3

j = 0
for i in 0..cnt-1
th1[j]=lines[i]
j+=1
end
j = 0
for i in cnt..cnt*2-1
th2[j]=lines[i]
j+=1
end
j = 0
for i in cnt*2..n-1
th3[j]=lines[i]
j+=1
end

puts "Strings: #{n}"
puts "Strings N/3: #{cnt}"
puts "===================================".red

return th1,th2,th3
end

def multiSpam mailA, mailF, atA, usrA, lvl
auth_token, user, j = accFinder mailA, 1, mailF, atA, usrA
nAccs = auth_token.size
threads = []
th = 1
thID = ""
index = 0

for index in 0..nAccs-1
case th
	when 1 then thID = "[th1]".green
	when 2 then thID = "[th2]".red
	when 3 then thID = "[th3]".blue
end
	threads << Thread.new do
		uploadSpam auth_token[index], user[index], lvl, thID
	end
	sleep(1)
	th += 1
	if (th > 2 or index == nAccs)
		threads.each(&:join)
		th = 0
	end
end

end

def multiCsv auth_token, user, usr_id, money, pswEncryptor
if money == ''
money = '0'
end
if pswEncryptor == ''
pswEncryptor = '90000000000'
end
if usr_id == 'n'
	File.open("log/view.csv", "w") { |file|
		file.puts 'Checkings; Savings; Nick; IP; Level; Last Update Log; Firewall; Pass. Encryptor'
	}
else
	File.open("log/view_usrId.csv", "w") { |file|
		file.puts 'Checkings; Savings; Nick; IP; Level; Last Update Log; Firewall; Pass. Encryptor; userId'
	}
end

nAccs = auth_token.size
ids = File.readlines("log/ping.log")
nIds = ids.size
cnt = nIds/nAccs

threads = []
returnValue = case nAccs
###1 accaunts###
when 1 then 
createCsv auth_token[0], user[0], usr_id, money, pswEncryptor, ids, "[th1]".green, 0, nIds-1
###2 accaunts###
when 2 then 
threads << Thread.new do
	createCsv auth_token[0], user[0], usr_id, money, pswEncryptor, ids, "[th1]".green, 0, cnt-1
end
if nIds > 5
threads << Thread.new do
	createCsv auth_token[1], user[1], usr_id, money, pswEncryptor, ids, "[th2]".red, cnt, nIds-1
end
end
threads.each(&:join)
###3 accaunts###
when 3 then 
p user
threads << Thread.new do
	createCsv auth_token[0], user[0], usr_id, money, pswEncryptor, ids, "[th1]".green, 0, cnt-1
end
if nIds > 5
threads << Thread.new do
	createCsv auth_token[1], user[1], usr_id, money, pswEncryptor, ids, "[th2]".red, cnt, cnt*2-1
end
threads << Thread.new do
	createCsv auth_token[2], user[2], usr_id, money, pswEncryptor, ids, "[th3]".blue, cnt*2, nIds-1
end
end
threads.each(&:join)
else
puts "Error: 1-3 accaunts"
pause
end
end

#Create CSV table for ping.log
def createCsv auth_token, user, usr_id, money, pswEncryptor, idsArr, thNum, startPos, endPos
n = 1
err = 0
suc = 0
drp = 0
cls

NetworkDo do |http|
	puts "Username '#{user['username']}', level #{user['level']}".bg_green
	for index in startPos..endPos
	sleep(0.2)
		begin
			line = idsArr[index].chomp
			# puts "Username '#{user['username']}', level #{user['level']}".bg_green
			File.open("log/view_log.log", "a") { |file|
				file.puts "#{thNum}String: " + index.to_s
			}
			x = HackEx::Request.Do(http, HackEx::Request.VictimInfo(auth_token, line))
			$i=0
			$j=0
			pEnc = '0'
			frwl = '0'
			begin
				while x['user_software'][$i]['software_type_id']!='1' do
					$i += 1
				end
				frwl = x['user_software'][$i]['software_level']
			rescue
				puts "#{thNum}NoFirewall: "+line
			end
			
			begin
				while x['user_software'][$j]['software_type_id']!='4' do
					$j += 1
				end
				pEnc = x['user_software'][$j]['software_level']
			rescue
				puts "#{thNum}NoPassEncoder: "+line
			end
			if x['user_bank']['checking'].to_i >= money.to_i
			if pEnc.to_i <= pswEncryptor.to_i
				puts "#{thNum}ID ##{index.to_s}/#{endPos}. "+"Good".green+" Money: "+x['user_bank']['checking'].mF.magenta
				suc += 1
				if usr_id == 'n'
					File.open("log/view.csv", "a") { |file|
						file.puts x['user_bank']['checking']+'; '+x['user_bank']['savings']+'; '+x['user']['username']+'; '+x['user']['ip']+'; '+x['user']['level']+'; '+x['user_log']['last_updated']+'; '+frwl+'; '+pEnc
					}
				else
					File.open("log/view_usrId.csv", "a") { |file|
					file.puts x['user_bank']['checking']+'; '+x['user_bank']['savings']+'; '+x['user']['username']+'; '+x['user']['ip']+'; '+x['user']['level']+'; '+x['user_log']['last_updated']+'; '+frwl+'; '+pEnc+'; '+x['user']['id']
					}
				end
			else 
				puts "#{thNum}ID ##{index.to_s}/#{endPos}. "+"Password Encryptor high! Drop this id".red
				drp += 1
			end
			else
			    puts "#{thNum}ID ##{index.to_s}/#{endPos}. "+"No Money, No Honey! Drop this id".red
				drp += 1
			end
			
		rescue 
			puts "#{thNum}Rescued: #{$!}"
			err += 1
		end
		n += 1
	end
	sleep(2)
	puts "=================Result==================".bg_cyan
	puts "#{thNum}Succeful:".green+suc.to_s
	puts "#{thNum}Dropped:".red+drp.to_s
	puts "#{thNum}Errors: ".red+err.to_s
	puts "=========================================".bg_cyan
	puts ""
end
end

def test auth_token, user
json = ''
NetworkDo do |http|
puts "Username '#{user['username']}', level #{user['level']}".bg_green
json = HackEx::Request.Do(http, HackEx::Request.UserProcesses(auth_token))
File.open("log/procka.log", "a") { |file|
	file.puts json
}
end
end

def firewallCrack auth_token, user, id, sleepTime, advLog
x =""
cr ="2"
mon = "1"
monOut = 0
idusr= id
if advLog 
	cls 
end
puts "Bypassing ID: #{id}".bg_cyan
NetworkDo do |http|
scan = ""
j = 0
begin
HackEx::Request.Do(http, HackEx::Request.UserAddProcess(auth_token, idusr, 'scan', '1565650', '1'))
rescue
 puts "Process exist!".red
end

idd = 0
puts "[HACKING_USER_FIREWALL]".red
puts "--Create fake process...".red
while idd == 0 do
j+=1
sleep(sleepTime)
HackEx::Request.Do(http, HackEx::Request.UserProcesses(auth_token))['user_processes'].each do |p|
	File.open("log/MegaCrackF.log", "a") { |file|
		if (p['victim_user_id'].to_i == idusr.to_i) and (p['software_type_id'].to_i == 1)
			returnValue = case p['status']
			when "2" then
				if advLog
					puts "#{j}. Status: #{"Ready".green}. Delete process #{p['id']}"
				end
				file.puts "#{j}. Status: ready. Delete process #{p['id']}"
				HackEx::Request.Do(http, HackEx::Request.ProcessDelete(auth_token, p['id']))
				if advLog 
					puts "#{j}. Add process Firewall #{p['id'].green} Success Rate: #{p['success_rate'].green}"
				end
				file.puts "#{j}. Add process Firewall #{p['id']} Success Rate: #{p['success_rate']}"
				HackEx::Request.Do(http, HackEx::Request.UserAddProcess(auth_token, idusr, 'scan', '1565650', '1'))

			when "3" then
				if advLog 
					puts "Status: #{"Failed".red}"
				end
				puts "--Fake process created!".green
				idd = 1
				file.puts "#{j}. Process #{p['id']} Hack: true"
				break
			else
				puts p['status']
				file.puts j.to_s+". Status ="+p['status']
			end
		end
	}
end
end

puts "--Reloading process...".red
while idd == 1 do
HackEx::Request.Do(http, HackEx::Request.UserProcesses(auth_token))['user_processes'].each do |p|
###
	File.open("log/MegaCrackF2.log", "a") { |file|
		if (p['victim_user_id'].to_i == idusr.to_i) and p['status'] == "3" and (p['software_type_id'].to_i == 1)
		    if advLog 
				puts "Retry Process"
			end
			HackEx::Request.Do(http, HackEx::Request.ProcessRetry(auth_token, p['id']))
			file.puts "Retry Process"
		end
	}
###
end
HackEx::Request.Do(http, HackEx::Request.UserProcesses(auth_token))['user_processes'].each do |p|
###
	File.open("log/MegaCrackF2.log", "a") { |file|
		if (p['victim_user_id'].to_i == idusr.to_i) and (p['process_type_id'] == '1')
		    if advLog 
				puts "Current Process Status: #{p['status']}"
			end
			file.puts "Current Process Status: #{p['status']}"
			if p['status']=='2'
				puts "--User: #{id.chop} Firewall Hacked!".green
				idd = 0
			end
		end
	}
###
end
end

return monOut
end
end

def bankCrackList auth_token, user, sleepTime
mon = 0
NetworkDo do |http|
cls
File.open("log/ping.log").each { |line|
id = line
mon += bankCrack auth_token, user, id, sleepTime, false
}
end
puts "======================================"
puts "Transfered Money: ".green+mon.to_s.mF
puts "======================================"
print "\a"
end

def logUpdate auth_token, user, id, text
idusr= id
NetworkDo do |http|
puts "Username '#{user['username']}', level #{user['level']}, Exp #{user['pts_level_progress']}/#{user['pts_to_next_level']}".bg_green
puts HackEx::Request.Do(http, HackEx::Request.UpdateVictimLog(auth_token, idusr, text))
end
end

def getUserLog auth_token, user, id
idusr= id
NetworkDo do |http|
puts "Username '#{user['username']}', level #{user['level']}, Exp #{user['pts_level_progress']}/#{user['pts_to_next_level']}".bg_green
x = HackEx::Request.Do(http, HackEx::Request.VictimInfo(auth_token, idusr))
name = x['user']['username']
File.open("log/#{name}_#{x['user']['id']}.htm", "w") { |file|
			text = x['user_log']['text']
			text.gsub!("&lt;", "<")
			text.gsub!("&gt;", ">")
			file.puts text
			puts text
			puts "Log saved: #{name}_#{x['user']['id']}.htm"
	
	}
end
end

def usersoft3 email, password, id
idusr= id
HackEx.LoginDo(email, password) do |http, auth_token, user|
puts "Username '#{user['username']}', level #{user['level']}, Exp #{user['pts_level_progress']}/#{user['pts_to_next_level']}".bg_green
puts "Money Now: ".green
puts HackEx::Request.Do(http, HackEx::Request.VictimBank(auth_token, idusr))['user_bank']['checking'].mF
puts "Send Money:".green
puts HackEx::Request.Do(http, HackEx::Request.TransferBankFundsFromVictim(auth_token, idusr, $stdin.gets.chop))
end
end

def bankCrack auth_token, user, id, sleepTime, advLog
x =""
cr ="2"
mon = "1"
monOut = 0
idusr= id
if advLog 
	cls 
end
puts "Cracking ID: #{id}".bg_cyan
NetworkDo do |http|
scan = ""
j = 0
begin
HackEx::Request.Do(http, HackEx::Request.UserAddProcess(auth_token, idusr, 'crack', '1565652', '1'))
rescue
 puts "Process exist!".red
end

idd = 0
puts "[HACKING_USER_BANK]".red
puts "--Create fake process...".red
while idd == 0 do
j+=1
sleep(sleepTime)
HackEx::Request.Do(http, HackEx::Request.UserProcesses(auth_token))['user_processes'].each do |p|
	File.open("log/MegaCrack.log", "a") { |file|
		if (p['victim_user_id'].to_i == idusr.to_i)
			returnValue = case p['status']
			when "2" then
				if advLog
					puts "#{j}. Status: #{"Ready".green}. Delete process #{p['id']}"
				end
				file.puts "#{j}. Status: ready. Delete process #{p['id']}"
				HackEx::Request.Do(http, HackEx::Request.ProcessDelete(auth_token, p['id']))
				if advLog 
					puts "#{j}. Add process Encryptor #{p['id'].green} Success Rate: #{p['success_rate'].green}"
				end
				begin
				file.puts "#{j}. Add process Encryptor #{p['id']} Success Rate: #{p['success_rate']}"
				HackEx::Request.Do(http, HackEx::Request.UserAddProcess(auth_token, idusr, 'crack', '1565652', '1'))
				rescue
				puts "Process exist!".red
				end
			when "3" then
				if advLog 
					puts "Status: #{"Failed".red}"
				end
				puts "--Fake process created!".green
				idd = 1
				file.puts "#{j}. Process #{p['id']} Hack: true"
				break
			else
				puts p['status']
				file.puts j.to_s+". Status ="+p['status']
			end
		end
	}
end
end

begin
puts "--Hack injection...".red
puts HackEx::Request.Do(http, HackEx::Request.TransferBankFundsFromVictim(auth_token, idusr, '10'))
rescue
puts "--Succefull!".green
end

puts "--Reloading process...".red
while idd == 1 do
HackEx::Request.Do(http, HackEx::Request.UserProcesses(auth_token))['user_processes'].each do |p|
###
	File.open("log/MegaCrack2.log", "a") { |file|
		if (p['victim_user_id'].to_i == idusr.to_i) and p['status'] == "3"
		    if advLog 
				puts "Retry Process"
			end
			HackEx::Request.Do(http, HackEx::Request.ProcessRetry(auth_token, p['id']))
			file.puts "Retry Process"
		end
	}
###
end
HackEx::Request.Do(http, HackEx::Request.UserProcesses(auth_token))['user_processes'].each do |p|
###
	File.open("log/MegaCrack2.log", "a") { |file|
		if (p['victim_user_id'].to_i == idusr.to_i) and (p['process_type_id'] == '2')
		    if advLog 
				puts "Current Process Status: #{p['status']}"
			end
			file.puts "Current Process Status: #{p['status']}"
			if p['status']=='2'
				puts "--User: #{id.chop} Bank Hacked!".green
				idd = 0
			end
		end
	}
###
end
end

puts ""
puts "[Money In Bank]".green
while mon.to_i != 0 do
mon = HackEx::Request.Do(http, HackEx::Request.VictimBank(auth_token, idusr))['user_bank']['checking']
puts mon.mF
if mon.to_i > 100000000
	HackEx::Request.Do(http, HackEx::Request.TransferBankFundsFromVictim(auth_token, idusr, 100000000))
	monOut += mon.to_i
else
	if mon.to_i != 0
	HackEx::Request.Do(http, HackEx::Request.TransferBankFundsFromVictim(auth_token, idusr, mon))
	monOut += mon.to_i
	end
end
end
puts "",""
if advLog
print "\a"
end

return monOut
end
end

#BuyRobot
def roboBuy mailA, mailF, atA, usrA, ip, auth_token, user, moneyCount, softId, softCount
at,usr, j, mail = accFinder mailA, 2, mailF, atA, usrA
puts "Money: #{moneyCount.mF}, SoftId: #{softId}, Count: #{softCount}"
j.times { |i|
begin
	puts "roboBuy: #{mail[i]}".bg_cyan
	sendMoney2Contact auth_token, user, mail[i], ip[i], "c", moneyCount
	purchaseSoft at[i], usr[i], softId, softCount.to_i, 0
rescue 
	puts "Error: #{$!}"
	puts ""
end
	}
print "\a"

end

#Login Parser
def login out = false
lines = File.readlines("accaunts/logindata.txt")
line_count = lines.size
text = lines.join

j=line_count
email = []
auth_token = []
user = []
j.times { |i|
	txt = lines[i]
	tmp = txt.split('!|f')
	email[i] = tmp[0]
	auth_token[i] = tmp[1]
	user[i] = tmp[2]
	if out 
		puts i.to_s+" = "+email[i]
	end
}

return email, auth_token, user
end

#Login Parser for CSV
def loginCSV mailA, mailF, atA, usrA, usr_id, money, pswEncryptor
at,usr = accFinder mailA, 1, mailF, atA, usrA
multiCsv at, usr, usr_id, money, pswEncryptor
end

def ip2id auth_token, user, ip
NetworkDo do |http|
puts HackEx::Request.Do(http, HackEx::Request.UserByIp(auth_token, ip))["user"]["id"]
end
end

#get Information
def getInfo auth_token, user
x = ""
json = ""
cls
NetworkDo do |http|
	puts "Username '#{user['username']}', level #{user['level']}, UserIP: '#{user['ip']}', Exp #{user['pts_level_progress']}/#{user['pts_to_next_level']}".bg_green
	#Spam Info
	ind = 0
	mon = 0
	spam = HackEx::Request.Do(http, HackEx::Request.UserSpam(auth_token))
	spam['spam'].each do |p|
		begin
		    tmp = p["earning_rate_hr"].to_i
			mon += tmp
			ind += 1
		rescue
			puts "Error: #{$!}"
		end
	end
	puts "Spam Info:".bg_cyan,"Spam Count:".green+ind.to_s+" Money/hour:".green+mon.to_s.mF
	###########
	puts ""
	id=0
	x = HackEx::Request.Do(http, HackEx::Request.VictimInfo(auth_token, user["id"]))
	x2 = HackEx::Request.Do(http, HackEx::Request.UserSoftware(auth_token))
	user = HackEx::Request.Do(http, HackEx::Request.UserInfo(auth_token))
	#
	check = x['user_bank']['checking']
	savin = x['user_bank']['savings']
	puts 'Money:'.bg_cyan
	puts 'Checkings - '+check.mF.green 
	puts 'Savings   - '+savin.mF.green
	puts ""
    user_processes = user['user_processes']
	###
	bypass_processes = HackEx::Helper.FilterHashArray user_processes, {'process_type_id' => HackEx::Helper.ProcessTypeId('bypass')}
    failed_processes = HackEx::Helper.FilterHashArray bypass_processes, {'status' => HackEx::Helper.ProcessStatusId('failed')}
    ready_processes = HackEx::Helper.FilterHashArray bypass_processes, {'status' => HackEx::Helper.ProcessStatusId('ready')}
    progress_processes = HackEx::Helper.FilterHashArray bypass_processes, {'status' => HackEx::Helper.ProcessStatusId('progress')}
	###
	crack_processes = HackEx::Helper.FilterHashArray user_processes, {'process_type_id' => HackEx::Helper.ProcessTypeId('crack')}
    failed_processes2 = HackEx::Helper.FilterHashArray crack_processes, {'status' => HackEx::Helper.ProcessStatusId('failed')}
    ready_processes2 = HackEx::Helper.FilterHashArray crack_processes, {'status' => HackEx::Helper.ProcessStatusId('ready')}
    progress_processes2 = HackEx::Helper.FilterHashArray crack_processes, {'status' => HackEx::Helper.ProcessStatusId('progress')}
	###
	upload_processes = HackEx::Helper.FilterHashArray user_processes, {'process_type_id' => HackEx::Helper.ProcessTypeId('upload')}
    failed_processes3 = HackEx::Helper.FilterHashArray upload_processes, {'status' => HackEx::Helper.ProcessStatusId('failed')}
    ready_processes3 = HackEx::Helper.FilterHashArray upload_processes, {'status' => HackEx::Helper.ProcessStatusId('ready')}
    progress_processes3 = HackEx::Helper.FilterHashArray upload_processes, {'status' => HackEx::Helper.ProcessStatusId('progress')}
	###
	download_processes = HackEx::Helper.FilterHashArray user_processes, {'process_type_id' => HackEx::Helper.ProcessTypeId('download')}
    failed_processes4 = HackEx::Helper.FilterHashArray download_processes, {'status' => HackEx::Helper.ProcessStatusId('failed')}
    ready_processes4 = HackEx::Helper.FilterHashArray download_processes, {'status' => HackEx::Helper.ProcessStatusId('ready')}
    progress_processes4 = HackEx::Helper.FilterHashArray download_processes, {'status' => HackEx::Helper.ProcessStatusId('progress')}
	#
	format = '%-30s %-5s %-13s %-13s %s'
	puts format % ["Process Type:".bg_cyan, "All","[P]".blue, "[R]".green, "[F]".red]
	puts format % ["Bypass processes:   ".magenta,bypass_processes.size,progress_processes.size.to_s.blue,ready_processes.size.to_s.green,failed_processes.size.to_s.red]
	puts format % ["Crack processes:    ".magenta,crack_processes.size,progress_processes2.size.to_s.blue,ready_processes2.size.to_s.green,failed_processes2.size.to_s.red]
	puts format % ["Upload processes:   ".magenta,upload_processes.size,progress_processes3.size.to_s.blue,ready_processes3.size.to_s.green,failed_processes3.size.to_s.red]
	puts format % ["Download processes: ".magenta,download_processes.size,progress_processes4.size.to_s.blue,ready_processes4.size.to_s.green,failed_processes4.size.to_s.red]
	###
	puts "", "UserSoftware:".bg_cyan
	while ((id < 8) && x2['user_software'][id] != nil) do
		check = x2['user_software'][id]
		puts "#{check.fetch("name")}: #{(check.fetch("software_level")).green}"
		id +=1
	end
	puts ""
	puts 'Upload Progress:'.bg_cyan
	json = HackEx::Request.Do(http, HackEx::Request.UserProcesses(auth_token))
	ind = 1
	json['user_processes'].each do |p|
		if p['status'].to_i == 1 && p['process_type_id'].to_i == 4 && p['software_type_id'].to_i == 6
		begin
		    duration = p["duration"].to_f/60/60
		    puts (ind.to_s).red+"Spam L:".green+p["software_level"]+" IP:".green+p["ip"]+" Dur.:".green+(duration.round(1)).to_s+" Start:".green+p["started_at"]
			ind += 1
		rescue
			puts "Error: #{$!}"
		end
		end
	end
		File.open("log/processes.log", "w") { |file|
		    file.puts user_processes
		}
end
end

#Money From Contacts
def mon2contacts mailA, mailF, atA, usrA
at, usr, j, mail, to = accFinder mailA, 3, mailF, atA, usrA
cls
return to, at, usr, mail, j
end

#Register Login
def regLogin nick_register, email_register, password_register
j=nick_register.size
x = ""
begin
j.times { |i|
	puts "Register nick:> ".bg_cyan+nick_register[i]
	HackEx.NetworkDo do |http|
	x = HackEx::Request.Do(http, HackEx::Request.CreateUser(nick_register[i], email_register[i], password_register[i]))
	end
	if x["success"]==true
	puts "Успешно!".green
	puts "ID: ".blue+x["user"]["id"]
	puts "IP: ".blue+x["user"]["ip"]
	puts ""
	else
	puts "Провал!".red
	end
}
rescue 
	puts "Error: #{$!}"
	puts ""
end
return nick_register, email_register, password_register, j
end

#Upload Spam list
def megaSpammer mailA, mailF, atA, usrA, ind
at, usr, j = accFinder mailA, 1, mailF, atA, usrA
begin
	j.times { |i|
	uploadSpam at[i], usr[i], ind
	}
rescue 
	puts "Error: #{$!}"
	puts ""
end
end

#Multi Clean Spam processes
def megaCleaner mailA, mailF, atA, usrA
cls
at, usr, j = accFinder mailA, 1, mailF, atA, usrA
begin
j.times { |i|
	cleanProc at[i], usr[i]
	}
print "\a"
rescue 
	puts "Error: #{$!}"
	puts ""
end
end


def AddCont mailA, mailF, atA, usrA, auth_token, user
begin
at, usr, j = accFinder mailA, 1, mailF, atA, usrA

	(j).times { |i|
		NetworkDo do |http|
				begin
				puts "Add Contact: "+mailF[i]
				puts "UserId: "+usr[i]["id"]
				x = HackEx::Action.AddContact http, usr[i]["id"], at[i], user["id"], auth_token
				if x["success"]==true
					puts "Успешно!".green
				else
					puts "Провал!".red
				end
				puts ""
				rescue
					puts "Error: #{$!}"
				end
		end
	}
rescue
	puts "Error: #{$!}"
end
end

#Colors and CleanScreen
class String
def black;          "\033[30m#{self}\033[0m" end
def red;            "\033[31m#{self}\033[0m" end
def green;          "\033[32m#{self}\033[0m" end
def brown;          "\033[33m#{self}\033[0m" end
def blue;           "\033[34m#{self}\033[0m" end
def magenta;        "\033[35m#{self}\033[0m" end
def cyan;           "\033[36m#{self}\033[0m" end
def gray;           "\033[37m#{self}\033[0m" end
def bg_black;       "\033[40m#{self}\033[0m" end
def bg_red;         "\033[41m#{self}\033[0m" end
def bg_green;       "\033[42m#{self}\033[0m" end
def bg_brown;       "\033[43m#{self}\033[0m" end
def bg_blue;        "\033[44m#{self}\033[0m" end
def bg_magenta;     "\033[45m#{self}\033[0m" end
def bg_cyan;        "\033[46m#{self}\033[0m" end
def bg_gray;        "\033[47m#{self}\033[0m" end
def bold;           "\033[1m#{self}\033[22m" end
def reverse_color;  "\033[7m#{self}\033[27m" end
def mF;    			"#{self.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}" end
end

def cls
  puts "\e[H\e[2J"
end

#Register
def registerUser
usr, log, pas, j = regLogin
puts usr[0]
puts log[0]
puts pas[0]
j.times {
username = usr[j]
email = log[j]
tmp = pas[j]
password = tmp
puts HackEx::Request.CreateUser(username, email, password)
}
end

#Money From Crack IP
def getCrackMoney auth_token, user, mail
allmoney = 0
cls
NetworkDo do |http|
	puts "Username '#{user['username']}', level #{user['level']}".bg_green

	json = HackEx::Request.Do(http, HackEx::Request.UserProcesses(auth_token))
	json['user_processes'].each do |p|
		if p['status'].to_i == 2 && p['process_type_id'].to_i == 2
		begin
			mon = HackEx::Request.Do(http, HackEx::Request.VictimBank(auth_token, p['victim_user_id']))['user_bank']['checking']
			puts "==============================================="
			usrip = HackEx::Request.Do(http, HackEx::Request.VictimInfo(auth_token, p['victim_user_id']))["user"]["ip"]
			puts "UserIP: "+usrip.magenta
			puts "Money: "+mon.mF
			File.open("log/bank/"+mail+".csv", "a") { |file|
					file.puts "#{Date.today}; #{usrip}; #{mon}; #{p['victim_user_id']}"
			}
			if mon.to_i != 0
				if mon.to_i > 100000000
					mon = 99999999
				end
				tmp = HackEx::Request.Do(http, HackEx::Request.TransferBankFundsFromVictim(auth_token, p['victim_user_id'], mon))
				tmp2 = tmp["success"].to_s
				tmp3 = tmp["amount_transfered"]
				if tmp["success"] == true
					allmoney += tmp3.to_i
					puts "Success: "+tmp2.green+"  Money Transfered:"+tmp3.mF.green
				else
					puts "Success: "+tmp2.red
					puts tmp
				end
			else
				puts "Success: "+"false. No Money!".red
			end
		rescue
			if ($!.to_s).include?("no longer accessible")
				puts "Error: "+"Bank account no longer accessible.".red
			else
				puts "Error: #{$!}"
			end
		end
		end
	end
end
puts "======================================"
puts "Get Money From All Accaunts: ".green+(allmoney.to_s).mF
puts "======================================"
end

#Purchase Soft
def purchaseSoft auth_token, user, item, count, beep = 1
NetworkDo do |http|
	puts "Username '#{user['username']}', level #{user['level']}".bg_green
	begin
	c = 0
	m1 = HackEx::Request.Do(http, HackEx::Request.UserBank(auth_token))['user_bank']['checking'].to_i
	count.times do 
	returnValue = case item
	when "0" then
	    json = HackEx::Request.Do(http, HackEx::Request.StorePurchase(auth_token, "network", "8209"))
		if json['success'].to_s != 'true'
			puts 'Error in buying'
		else
			puts 'Buy Succefull!'.green
		end
	when "9" then
	    json = HackEx::Request.Do(http, HackEx::Request.StorePurchase(auth_token, "device", "4210"))
		if json['success'].to_s != 'true'
			puts 'Error in buying'
		else
			puts 'Buy Succefull!'.green
		end
	else
		json = HackEx::Request.Do(http, HackEx::Request.StorePurchase(auth_token, 'software', item))
		if json['success'].to_s != 'true'
			puts 'Error in buying'
		else
			c += 1
			puts "Buy Succefull! #{c}/#{count}".green
		end
	end
	end
	rescue
		puts "Error in Buying: #{$!}"
	end
	m2 = HackEx::Request.Do(http, HackEx::Request.UserBank(auth_token))['user_bank']['checking'].to_i
	puts "Money Now: "+m2.to_s.mF.green+" Used Money: "+(m1-m2).to_s.mF.red
end
if beep == 1
print "\a"
end
end

#Bypass and Cracking
def bAndC auth_token, user, borc
NetworkDo do |http|
	puts "Username '#{user['username']}', level #{user['level']}".bg_green
	user = HackEx::Request.Do(http, HackEx::Request.UserInfo(auth_token))
    user_processes = user['user_processes']
    user_software = user['user_software']
	if borc == 'b'
		File.open("log/proc.log").each { |line| 
			begin
			usr_id = line.chop
			puts usr_id
			HackEx::Action.StartBypass(http, auth_token, usr_id)#, :user_processes => user_processes, :software_level => jrtva['software_level'], :software_id => jrtva['software_id']
			rescue
			puts "Rescued: #{$!}"
			end
		}
	else
	File.open("log/proc.log").each { |line| 
	begin
		usr_id = line.chop
		puts usr_id
		HackEx::Action.StartCrack(http, auth_token, usr_id)#, :user_processes => user_processes
	rescue
		puts "Rescued: #{$!}"
	end
	}
	end
end
end

#Send Money To Contact
def sendMoney2Contact auth_token, user, mail, ip, trig, count = "0"
tmpMon = 0

NetworkDo do |http|
	puts "Username '#{user['username']}', level #{user['level']}".bg_green
	HackEx::Request.Do(http, HackEx::Request.UserBank(auth_token))
	id_ip = HackEx::Request.Do(http, HackEx::Request.UserByIp(auth_token, ip))["user"]["id"]
	my_ip = "#{user['ip']}"
	my_id = HackEx::Request.Do(http, HackEx::Request.UserByIp(auth_token, my_ip))["user"]["id"]
	money = HackEx::Request.Do(http, HackEx::Request.VictimInfo(auth_token, my_id))['user_bank']['checking']
	puts 'Checkings - '+money.mF.bg_cyan
	#Spam Info
	ind = 0
	mon = 0
	spam = HackEx::Request.Do(http, HackEx::Request.UserSpam(auth_token))
	spam['spam'].each do |p|
		begin
		    tmp = p["earning_rate_hr"].to_i
			mon += tmp
			ind += 1
		rescue
			puts "Error: #{$!}"
		end
	end
	puts "Spam Count:".green+ind.to_s+" Money/hour:".green+mon.to_s.mF
	###########
	if trig=='a' 
	if money.to_i > 100000000
		money = 99999999
	end
		tmp = HackEx::Request.Do(http, HackEx::Request.TransferBankFundsToContact(auth_token, id_ip, money.to_i))
		tmp2 = tmp["success"].to_s
		tmp3 = tmp["amount_transfered"]
		tmpMon = tmp3.to_i
		if tmp["success"] == true
			puts "Success: "+tmp2.green+"  Money Transfered:"+tmp3.mF
		else
			puts "Success: "+tmp2.red
			puts tmp
		end
	else
	    if count == "0" then
			puts 'Transfer Money(<=100kk):'
			wrt = $stdin.gets.to_i
		else
			wrt = count
		end
		if wrt.to_i > 100000000
			wrt = 99999999
		end
		tmp = HackEx::Request.Do(http, HackEx::Request.TransferBankFundsToContact(auth_token, id_ip, wrt))
		tmp2 = tmp["success"].to_s
		tmp3 = tmp["amount_transfered"]
		tmpMon = tmp3.to_i
		if tmp["success"] == true
			puts "Success: "+tmp2.green+"  Money Transfered:"+tmp3.mF
		else
			puts "Success: "+tmp2.red
			puts tmp
		end
	end
end

return tmpMon
end

#Clean Processes
def cleanProc auth_token, user
HackEx.ProcessClean(auth_token, user)
end

#Upload Spam
def uploadSpam auth_token, user, ind, thID = ''
n = 1
err = 0
suc = 0
#cls
NetworkDo do |http|
	puts "Username '#{user['username']}', level #{user['level']}".bg_green
	File.open("log/ping.log").each { |line| 
	begin
		puts "Spam ##{n.to_s}.#{thID}".green
		x = HackEx.SpamUpload(http, auth_token, line, ind)
		File.open("log/spam/"+user['username']+"_spam.log", "a") { |file|
			file.puts "#{n.to_s}. #{x}"
		}
		
		n += 1
		suc += 1
	rescue
		puts "Rescued: #{$!}"
		err += 1
	end
	}
	puts "Succeful:".green+suc.to_s
	puts "Errors: ".red+err.to_s
end
end


#Ping Devices
def pingDevices auth_token, user, ind
n = 1

cls
NetworkDo do |http|
	puts "Username '#{user['username']}', level #{user['level']}".bg_green
	tmp = []
	pingList = []
	(1..ind).map(){ 
	begin
		#cls
		#puts "Username '#{user['username']}', level #{user['level']}".bg_green
		puts 'Progress: ' + n.to_s + '/' + ind.to_s
		x = HackEx::Request.Do(http, HackEx::Request.RandomUsers(auth_token))
		tmp << x['users'][0]['id']
		tmp << x['users'][1]['id']
		tmp << x['users'][2]['id']
		tmp << x['users'][3]['id']
		tmp << x['users'][4]['id']
	rescue 
		puts "Rescued: #{$!}"
	end  
	n += 1
	}
  pingList = tmp.uniq
  for i in 0..pingList.size
	File.open("log/ping.log", "a") { |file|
		file.puts pingList[i]
	}
  end
  puts "#{(pingList.size).to_s} IDs Saved".green
end
end