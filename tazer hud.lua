font_flag = require('moonloader').font_flag
--ШРИФТЫ ('название', размер)
tazer = renderCreateFont('Arial', 17)
timer = renderCreateFont('Arial', 12, font_flag.BOLD)
--ШРИФТЫ
local sampev = require 'lib.samp.events'
	 
	 -- НАСТРОЙКИ СКРИПТА
	 thud = '{21ff00}Tazer{ff704d}Hud{ffffff} | ' 			-- префикс перед сообщением скрипта def. '{21ff00}Tazer{ff704d}Hud{ffffff} | '
	 tgg = '{08ff00}*{ffffff}' 								-- зелёная звёздочка 08ff00
	 tg = '{00a5ff}*{ffffff}' 								-- обычная звёздочка 00a5ff
	 soff = '{ff0202}OFF' 									-- состояние худа ВЫКЛ def.	'{ff0202}OFF'
	 son = '{19ff00}ON' 									-- состояние худа ВКЛ def. '{19ff00}ON'
	 st = 'Tazer'											-- надпись перед ВКЛ/ВЫКЛ
	 ton = 0 												-- переменная для включения осн. худа def. 0
	 toff = 1 												-- переменная для выключения осн. худа def. 1
	 rab = 0 												-- переменная отображения рабочего дня def. 0
	 timeron = 1											-- переменная вкл/выкл таймера def. 1
	 cx = 42												-- координата X осн. худа def. 42
	 cy = 528 												-- координата Y осн. худа def. 528
	 tcx = 58 												-- координата X таймера def. 58
	 tcy = 512 												-- координата Y таймера def. 512
	 state = soff 											-- !НЕ ТРОГАТЬ! изначальное состояние худа
	 -- НАСТРОЙКИ СКРИПТА

function main()
	 if not isSampfuncsLoaded() or not isSampLoaded() then return end
	 while not isSampAvailable() do wait(100) end
	 sampAddChatMessage("{21ff00}Tazer{ff704d}Hud{ffffff} | Загружен, автоматически активируется при начале рабочего дня. Помощь - {8c00ff}/thelp", -1)
	 sampRegisterChatCommand("thud", day)
	 sampRegisterChatCommand("thelp", guide)

	 while true do
			 wait(0)
			 time=(os.date("%H",os.time())..':'..os.date("%M",os.time())..':'..os.date('%S',os.time()))
			 if not isPauseMenuActive() and isPlayerPlaying(playerHandle) then
				 renderFontDrawText(timer, time, tcx, tcy, 0xFF8c00ff, false)
				 if rab == 1 then
					 	renderFontDrawText(tazer, ''..st..' '..state..'', cx, cy, 0xffffffff, false)
					end
				end
			end
		end

function guide()
	sampShowDialog(0, '{ffd505}TazerHud', '{ffffff}/thud{a0a0a0} - вкл/выкл основного худа\n{ffffff}/tguide{a0a0a0} - гайд по скрипту, этот диалог\n \n'..tg..'Для того что бы настроить положение худа, таймера или прочего..\n   нужно открыть скрипт блокнотом и изменить подписанные параметны\n'..tg..'Время для таймера - время на компьютере \n \n'..tgg..'Если состояние тазера {8c00ff}[ON/OFF]{ffffff} сбилось..\n  нужно выключить скрипт {8c00ff}[/thud]{ffffff}, переключить тазер {8c00ff}[/tazer]{ffffff} и снова включить\n', 'CLOSE', '', 4)
end

function sampev.onServerMessage(tclr, txt)
	if txt:find('Рабочий день начат') then
		rab = 1
		elseif txt:find('Рабочий день окончен') then
		rab = 0
	end
end

function sampev.onSendCommand(cmd)
if cmd == "/tazer" then
	if ton == 0 and toff == 1 then
			ton = 1
			toff = 0
			state = son -- вкл. тазер
			else
				ton = 0
				toff = 1
				state = soff -- выкл. тазер
			end
			if cmd == "/tazer" and rab == 0 then
				ton = 0
				toff = 1
				state = '{ff0202}OFF'
				sampAddChatMessage(thud..'Сначало нужно начать {8c00ff}рабочий день', -1)
			end
		end
			end

function day()
	if rab == 0 then
		rab = 1
		days = "включён"
		else rab = 0
			days = "выключен"
	end
	ton = 0
	toff = 1
sampAddChatMessage(thud..'Состояние скрипта сменено. Сейчас он {8c00ff}'..days, -1)
endравоылфарвыфолар