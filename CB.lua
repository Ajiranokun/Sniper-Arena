-- =========================================================
-- CB HUB SECURITY CHECK (PC EXECUTION ONLY)
-- =========================================================
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ตรวจสอบว่าเป็นแพลตฟอร์ม PC หรือไม่ (บล็อกตัวรันบนมือถือ/แท็บเล็ต)
local isPC = (UserInputService.KeyboardEnabled and UserInputService.MouseEnabled) and not UserInputService.TouchEnabled

if not isPC then
    pcall(function()
        LocalPlayer:Kick("\n[ CB Hub Security ]\nสคริปต์นี้รองรับการใช้งานบนคอมพิวเตอร์ (PC) เท่านั้น!")
    end)
    return -- ยกเลิกการรันสคริปต์ทันที
end

-- =========================================================
-- MAIN SCRIPT (CB HUB ARENA)
-- =========================================================
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("CustomExecutorUI") then
    PlayerGui.CustomExecutorUI:Destroy()
end

-- Global Configurations
getgenv().ESPPlayerColor = Color3.fromRGB(255, 0, 0)
getgenv().ESPBotColor = Color3.fromRGB(0, 255, 255)
getgenv().ESPNameColor = Color3.fromRGB(255, 255, 255)
getgenv().ToggleKeybind = Enum.KeyCode.RightShift
getgenv().ESPPlayerEnabled = false
getgenv().ESPBotEnabled = false
getgenv().ESPNameEnabled = false
getgenv().RainbowPlayerEnabled = false
getgenv().RainbowBotEnabled = false
getgenv().RainbowNameEnabled = false

-- Aimbot & Combat Configurations
getgenv().AimbotHeadEnabled = false
getgenv().AimbotBodyEnabled = false
getgenv().LockBotsEnabled = false
getgenv().AimbotIntensity = 1

-- Language Configuration (Default: English)
getgenv().CurrentLanguage = "EN"

-- Dictionary for 10 Languages
local LocText = {
    EN = {
        Title = "CB Hub Arena",
        TabAimbot = "🎯 Aimbot",
        TabESP = "👁️ ESP",
        TabSetting = "⚙️ Setting",
        HeadOn = "Aimbot Head",
        HeadOff = "Aimbot Head",
        BodyOn = "Aimbot Body",
        BodyOff = "Aimbot Body",
        BotLockOn = "Lock Bots",
        BotLockOff = "Lock Bots",
        Intensity = "Lock Intensity Level: ",
        EspPlayerOn = "ESP Player",
        EspPlayerOff = "ESP Player",
        EspBotOn = "ESP Bot",
        EspBotOff = "ESP Bot",
        EspNameOn = "ESP Name Player",
        EspNameOff = "ESP Name Player",
        ColorPlayer = "Color ESP Player Spectrum:",
        ColorBot = "Color ESP Bot Spectrum:",
        ColorName = "Color ESP Name Spectrum:",
        RbPlayerOn = "Rainbow ESP Player",
        RbPlayerOff = "Rainbow ESP Player",
        RbBotOn = "Rainbow ESP Bot",
        RbBotOff = "Rainbow ESP Bot",
        RbNameOn = "Rainbow ESP Name",
        RbNameOff = "Rainbow ESP Name",
        ResetBtn = "🔴 Reset / Clear All",
        KeybindLabel = "Toggle Hide UI Keybind:",
        LangButton = "🌐 Change Language",
        LangTitle = "Select Language",
        BackBtn = "⬅️ Back",
    },
    TH = {
        Title = "ซีบี ฮับ อารีน่า",
        TabAimbot = "🎯 ล็อกเป้า (Aimbot)",
        TabESP = "👁️ มองทะลุ (ESP)",
        TabSetting = "⚙️ ตั้งค่า (Setting)",
        HeadOn = "ล็อกหัว",
        HeadOff = "ล็อกหัว",
        BodyOn = "ล็อกตัว",
        BodyOff = "ล็อกตัว",
        BotLockOn = "ล็อกบอท",
        BotLockOff = "ล็อกบอท",
        Intensity = "ระดับความแรงในการล็อก: ",
        EspPlayerOn = "มองผู้เล่น",
        EspPlayerOff = "มองผู้เล่น",
        EspBotOn = "มองบอท",
        EspBotOff = "มองบอท",
        EspNameOn = "ชื่อผู้เล่น",
        EspNameOff = "ชื่อผู้เล่น",
        ColorPlayer = "สี ESP ผู้เล่น:",
        ColorBot = "สี ESP บอท:",
        ColorName = "สีชื่อ ESP:",
        RbPlayerOn = "เรนโบว์ ผู้เล่น",
        RbPlayerOff = "เรนโบว์ ผู้เล่น",
        RbBotOn = "เรนโบว์ บอท",
        RbBotOff = "เรนโบว์ บอท",
        RbNameOn = "เรนโบว์ ชื่อ",
        RbNameOff = "เรนโบว์ ชื่อ",
        ResetBtn = "🔴 รีเซ็ต / ล้างค่าทั้งหมด",
        KeybindLabel = "ปุ่มซ่อน/เปิด เมนู:",
        LangButton = "🌐 เปลี่ยนภาษา",
        LangTitle = "เลือกภาษา (Select Language)",
        BackBtn = "⬅️ กลับ",
    },
    RU = {
        Title = "CB Hub Arena",
        TabAimbot = "🎯 Аимбот",
        TabESP = "👁️ ВХ (ESP)",
        TabSetting = "⚙️ Настройки",
        HeadOn = "Аим на Голову",
        HeadOff = "Аим на Голову",
        BodyOn = "Аим на Тело",
        BodyOff = "Аим на Тело",
        BotLockOn = "Лок Ботов",
        BotLockOff = "Лок Ботов",
        Intensity = "Уровень силы лока: ",
        EspPlayerOn = "ESP Игрока",
        EspPlayerOff = "ESP Игрока",
        EspBotOn = "ESP Бота",
        EspBotOff = "ESP Бота",
        EspNameOn = "ESP Имени",
        EspNameOff = "ESP Имени",
        ColorPlayer = "Цвет ESP Игрока:",
        ColorBot = "Цвет ESP Бота:",
        ColorName = "Цвет ESP Имени:",
        RbPlayerOn = "Радуга Игрока",
        RbPlayerOff = "Радуга Игрока",
        RbBotOn = "Радуга Бота",
        RbBotOff = "Радуга Бота",
        RbNameOn = "Радуга Имени",
        RbNameOff = "Радуга Имени",
        ResetBtn = "🔴 Сбросить / Очистить все",
        KeybindLabel = "Кнопка скрытия UI:",
        LangButton = "🌐 Сменить язык",
        LangTitle = "Выберите язык",
        BackBtn = "⬅️ Назад",
    },
    PT = {
        Title = "CB Hub Arena",
        TabAimbot = "🎯 Aimbot",
        TabESP = "👁️ ESP",
        TabSetting = "⚙️ Configurações",
        HeadOn = "Aimbot Cabeça",
        HeadOff = "Aimbot Cabeça",
        BodyOn = "Aimbot Corpo",
        BodyOff = "Aimbot Corpo",
        BotLockOn = "Travar Bots",
        BotLockOff = "Travar Bots",
        Intensity = "Nível de Intensidade: ",
        EspPlayerOn = "ESP Jogador",
        EspPlayerOff = "ESP Jogador",
        EspBotOn = "ESP Bot",
        EspBotOff = "ESP Bot",
        EspNameOn = "ESP Nome",
        EspNameOff = "ESP Nome",
        ColorPlayer = "Cor ESP Jogador:",
        ColorBot = "Cor ESP Bot:",
        ColorName = "Cor ESP Nome:",
        RbPlayerOn = "Arco-íris Jogador",
        RbPlayerOff = "Arco-íris Jogador",
        RbBotOn = "Arco-íris Bot",
        RbBotOff = "Arco-íris Bot",
        RbNameOn = "Arco-íris Nome",
        RbNameOff = "Arco-íris Nome",
        ResetBtn = "🔴 Redefinir / Limpar Tudo",
        KeybindLabel = "Tecla Ocultar UI:",
        LangButton = "🌐 Mudar Idioma",
        LangTitle = "Selecionar Idioma",
        BackBtn = "⬅️ Voltar",
    },
    IT = {
        Title = "CB Hub Arena",
        TabAimbot = "🎯 Aimbot",
        TabESP = "👁️ ESP",
        TabSetting = "⚙️ Impostazioni",
        HeadOn = "Aimbot Testa",
        HeadOff = "Aimbot Testa",
        BodyOn = "Aimbot Corpo",
        BodyOff = "Aimbot Corpo",
        BotLockOn = "Blocca Bot",
        BotLockOff = "Blocca Bot",
        Intensity = "Livello Intensità: ",
        EspPlayerOn = "ESP Giocatore",
        EspPlayerOff = "ESP Giocatore",
        EspBotOn = "ESP Bot",
        EspBotOff = "ESP Bot",
        EspNameOn = "ESP Nome",
        EspNameOff = "ESP Nome",
        ColorPlayer = "Colore ESP Giocatore:",
        ColorBot = "Colore ESP Bot:",
        ColorName = "Colore ESP Nome:",
        RbPlayerOn = "Arcobaleno Giocatore",
        RbPlayerOff = "Arcobaleno Giocatore",
        RbBotOn = "Arcobaleno Bot",
        RbBotOff = "Arcobaleno Bot",
        RbNameOn = "Arcobaleno Nome",
        RbNameOff = "Arcobaleno Nome",
        ResetBtn = "🔴 Reimposta / Pulisci Tutto",
        KeybindLabel = "Tasto Nascondi UI:",
        LangButton = "🌐 Cambia Lingua",
        LangTitle = "Seleziona Lingua",
        BackBtn = "⬅️ Indietro",
    },
    BR = {
        Title = "CB Hub Arena",
        TabAimbot = "🎯 Aimbot",
        TabESP = "👁️ ESP",
        TabSetting = "⚙️ Configurações",
        HeadOn = "Aimbot Cabeça",
        HeadOff = "Aimbot Cabeça",
        BodyOn = "Aimbot Corpo",
        BodyOff = "Aimbot Corpo",
        BotLockOn = "Travar Bots",
        BotLockOff = "Travar Bots",
        Intensity = "Nível de Intensidade: ",
        EspPlayerOn = "ESP Jogador",
        EspPlayerOff = "ESP Jogador",
        EspBotOn = "ESP Bot",
        EspBotOff = "ESP Bot",
        EspNameOn = "ESP Nome",
        EspNameOff = "ESP Nome",
        ColorPlayer = "Cor ESP Jogador (BR):",
        ColorBot = "Cor ESP Bot:",
        ColorName = "Cor ESP Nome:",
        RbPlayerOn = "Arco-íris Jogador",
        RbPlayerOff = "Arco-íris Jogador",
        RbBotOn = "Arco-íris Bot",
        RbBotOff = "Arco-íris Bot",
        RbNameOn = "Arco-íris Nome",
        RbNameOff = "Arco-íris Nome",
        ResetBtn = "🔴 Redefinir / Limpar Tudo",
        KeybindLabel = "Tecla Ocultar UI:",
        LangButton = "🌐 Mudar Idioma (PT-BR)",
        LangTitle = "Selecionar Idioma",
        BackBtn = "⬅️ Voltar",
    },
    AR = {
        Title = "CB Hub Arena",
        TabAimbot = "🎯 Aimbot",
        TabESP = "👁️ ESP",
        TabSetting = "⚙️ Configuración",
        HeadOn = "Aimbot Cabeza",
        HeadOff = "Aimbot Cabeza",
        BodyOn = "Aimbot Cuerpo",
        BodyOff = "Aimbot Cuerpo",
        BotLockOn = "Bloquear Bots",
        BotLockOff = "Bloquear Bots",
        Intensity = "Nivel de Intensidad: ",
        EspPlayerOn = "ESP Jugador",
        EspPlayerOff = "ESP Jugador",
        EspBotOn = "ESP Bot",
        EspBotOff = "ESP Bot",
        EspNameOn = "ESP Nombre",
        EspNameOff = "ESP Nombre",
        ColorPlayer = "Color ESP Jugador (Arg):",
        ColorBot = "Color ESP Bot:",
        ColorName = "Color ESP Nombre:",
        RbPlayerOn = "Arcoíris Jugador",
        RbPlayerOff = "Arcoíris Jugador",
        RbBotOn = "Arcoíris Bot",
        RbBotOff = "Arcoíris Bot",
        RbNameOn = "Arcoíris Nombre",
        RbNameOff = "Arcoíris Nombre",
        ResetBtn = "🔴 Reiniciar / Borrar Todo",
        KeybindLabel = "Tecla Ocultar UI:",
        LangButton = "🌐 Cambiar Idioma (ES-AR)",
        LangTitle = "Seleccionar Idioma",
        BackBtn = "⬅️ Volver",
    },
    CN = {
        Title = "CB Hub 竞技场",
        TabAimbot = "🎯 自瞄",
        TabESP = "👁️ 透视 (ESP)",
        TabSetting = "⚙️ 设置",
        HeadOn = "头部自瞄",
        HeadOff = "头部自瞄",
        BodyOn = "身体自瞄",
        BodyOff = "身体自瞄",
        BotLockOn = "锁定机器人",
        BotLockOff = "锁定机器人",
        Intensity = "锁定强度级别: ",
        EspPlayerOn = "玩家透视",
        EspPlayerOff = "玩家透视",
        EspBotOn = "机器人透视",
        EspBotOff = "机器人透视",
        EspNameOn = "名字透视",
        EspNameOff = "名字透视",
        ColorPlayer = "玩家透视颜色:",
        ColorBot = "机器人透视颜色:",
        ColorName = "名字透视颜色:",
        RbPlayerOn = "彩虹玩家",
        RbPlayerOff = "彩虹玩家",
        RbBotOn = "彩虹机器人",
        RbBotOff = "彩虹机器人",
        RbNameOn = "彩虹名字",
        RbNameOff = "彩虹名字",
        ResetBtn = "🔴 重置 / 清除所有",
        KeybindLabel = "隐藏UI快捷键:",
        LangButton = "🌐 更改语言",
        LangTitle = "选择语言",
        BackBtn = "⬅️ 返回",
    },
    JP = {
        Title = "CB Hub アリーナ",
        TabAimbot = "🎯 エイムボット",
        TabESP = "👁️ ESP",
        TabSetting = "⚙️ 設定",
        HeadOn = "ヘッドロック",
        HeadOff = "ヘッドロック",
        BodyOn = "ボディロック",
        BodyOff = "ボディロック",
        BotLockOn = "ボットロック",
        BotLockOff = "ボットロック",
        Intensity = "ロック強度: ",
        EspPlayerOn = "プレイヤーESP",
        EspPlayerOff = "プレイヤーESP",
        EspBotOn = "ボットESP",
        EspBotOff = "ボットESP",
        EspNameOn = "名前ESP",
        EspNameOff = "名前ESP",
        ColorPlayer = "プレイヤーESPカラー:",
        ColorBot = "ボットESPカラー:",
        ColorName = "ネームESPカラー:",
        RbPlayerOn = "レインボー プレイヤー",
        RbPlayerOff = "レインボー プレイヤー",
        RbBotOn = "レインボー ボット",
        RbBotOff = "レインボー ボット",
        RbNameOn = "レインボー ネーム",
        RbNameOff = "レインボー ネーム",
        ResetBtn = "🔴 リセット / すべてクリア",
        KeybindLabel = "UI表示/非表示キー:",
        LangButton = "🌐 言語変更",
        LangTitle = "言語を選択",
        BackBtn = "⬅️ 戻る",
    },
    ES = {
        Title = "CB Hub Arena",
        TabAimbot = "🎯 Aimbot",
        TabESP = "👁️ ESP",
        TabSetting = "⚙️ Ajustes",
        HeadOn = "Aimbot Cabeza",
        HeadOff = "Aimbot Cabeza",
        BodyOn = "Aimbot Cuerpo",
        BodyOff = "Aimbot Cuerpo",
        BotLockOn = "Bloquear Bots",
        BotLockOff = "Bloquear Bots",
        Intensity = "Nivel de Intensidad: ",
        EspPlayerOn = "ESP Jugador",
        EspPlayerOff = "ESP Jugador",
        EspBotOn = "ESP Bot",
        EspBotOff = "ESP Bot",
        EspNameOn = "ESP Nombre",
        EspNameOff = "ESP Nombre",
        ColorPlayer = "Color ESP Jugador:",
        ColorBot = "Color ESP Bot:",
        ColorName = "Color ESP Nombre:",
        RbPlayerOn = "Arcoíris Jugador",
        RbPlayerOff = "Arcoíris Jugador",
        RbBotOn = "Arcoíris Bot",
        RbBotOff = "Arcoíris Bot",
        RbNameOn = "Arcoíris Nombre",
        RbNameOff = "Arcoíris Nombre",
        ResetBtn = "🔴 Reiniciar / Borrar Todo",
        KeybindLabel = "Tecla Ocultar UI:",
        LangButton = "🌐 Cambiar Idioma",
        LangTitle = "Seleccionar Idioma",
        BackBtn = "⬅️ Volver",
    }
}

local function L(key)
    local lang = getgenv().CurrentLanguage
    if LocText[lang] and LocText[lang][key] then
        return LocText[lang][key]
    end
    return LocText["EN"][key] or key
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CustomExecutorUI"
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999999999
ScreenGui.ResetOnSpawn = false

-- Open Button (Floating Icon)
local OpenButton = Instance.new("ImageButton")
OpenButton.Name = "OpenButton"
OpenButton.Size = UDim2.new(0, 52, 0, 52)
OpenButton.Position = UDim2.new(0, 20, 0, 200)
OpenButton.BackgroundColor3 = Color3.fromRGB(20, 5, 8)
OpenButton.BorderColor3 = Color3.fromRGB(120, 20, 35)
OpenButton.BorderSizePixel = 0
OpenButton.Image = "rbxassetid://75292697352125"
OpenButton.ZIndex = 10
OpenButton.Parent = ScreenGui

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 14)
ButtonCorner.Parent = OpenButton

local OpenBtnStroke = Instance.new("UIStroke")
OpenBtnStroke.Color = Color3.fromRGB(140, 25, 40)
OpenBtnStroke.Thickness = 1.5
OpenBtnStroke.Parent = OpenButton

-- Main Dashboard Window
local MainWindow = Instance.new("Frame")
MainWindow.Name = "MainWindow"
MainWindow.Size = UDim2.new(0, 580, 0, 380)
MainWindow.Position = UDim2.new(0.5, -290, 0.5, -190)
MainWindow.BackgroundColor3 = Color3.fromRGB(12, 6, 8)
MainWindow.BorderSizePixel = 0
MainWindow.Visible = false
MainWindow.ZIndex = 10
MainWindow.Parent = ScreenGui

local WindowCorner = Instance.new("UICorner")
WindowCorner.CornerRadius = UDim.new(0, 14)
WindowCorner.Parent = MainWindow

local WindowStroke = Instance.new("UIStroke")
WindowStroke.Color = Color3.fromRGB(130, 20, 35)
WindowStroke.Thickness = 1.5
WindowStroke.Parent = MainWindow

local WindowBgGradient = Instance.new("UIGradient")
WindowBgGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(35, 8, 12)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(15, 5, 8)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(5, 2, 3))
})
WindowBgGradient.Rotation = 90
WindowBgGradient.Parent = MainWindow

-- Top Bar (Draggable Window)
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 8, 12)
TopBar.BorderSizePixel = 0
TopBar.ZIndex = 11
TopBar.Parent = MainWindow

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 14)
TopBarCorner.Parent = TopBar

local TopBarFix = Instance.new("Frame")
TopBarFix.Size = UDim2.new(1, 0, 0, 8)
TopBarFix.Position = UDim2.new(0, 0, 1, -8)
TopBarFix.BackgroundColor3 = Color3.fromRGB(25, 8, 12)
TopBarFix.BorderSizePixel = 0
TopBarFix.ZIndex = 11
TopBarFix.Parent = TopBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 14, 0, 14)
CloseButton.Position = UDim2.new(1, -22, 0.5, -7)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 95, 86)
CloseButton.Text = ""
CloseButton.ZIndex = 12
CloseButton.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 14, 0, 14)
MinimizeButton.Position = UDim2.new(1, -44, 0.5, -7)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 189, 46)
MinimizeButton.Text = ""
MinimizeButton.ZIndex = 12
MinimizeButton.Parent = TopBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(1, 0)
MinCorner.Parent = MinimizeButton

-- Sidebar Panel (Left Menu)
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 160, 1, -35)
Sidebar.Position = UDim2.new(0, 0, 0, 35)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 5, 8)
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 11
Sidebar.Parent = MainWindow

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Padding = UDim.new(0, 4)
SidebarLayout.Parent = Sidebar

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 10)
SidebarPadding.PaddingLeft = UDim.new(0, 10)
SidebarPadding.PaddingRight = UDim.new(0, 10)
SidebarPadding.Parent = Sidebar

-- Profile Header Box
local ProfileBox = Instance.new("Frame")
ProfileBox.Size = UDim2.new(1, 0, 0, 60)
ProfileBox.BackgroundColor3 = Color3.fromRGB(35, 10, 15)
ProfileBox.BorderSizePixel = 0
ProfileBox.ZIndex = 12
ProfileBox.Parent = Sidebar

local ProfileCorner = Instance.new("UICorner")
ProfileCorner.CornerRadius = UDim.new(0, 8)
ProfileCorner.Parent = ProfileBox

local ProfileStroke = Instance.new("UIStroke")
ProfileStroke.Color = Color3.fromRGB(110, 20, 35)
ProfileStroke.Thickness = 1
ProfileStroke.Parent = ProfileBox

local ProfileAvatar = Instance.new("ImageLabel")
ProfileAvatar.Size = UDim2.new(0, 44, 0, 44)
ProfileAvatar.Position = UDim2.new(0, 8, 0.5, -22)
ProfileAvatar.BackgroundColor3 = Color3.fromRGB(20, 5, 8)
ProfileAvatar.Image = "rbxassetid://75292697352125"
ProfileAvatar.ZIndex = 13
ProfileAvatar.Parent = ProfileBox

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(0, 8)
AvatarCorner.Parent = ProfileAvatar

local ProfileTitle = Instance.new("TextLabel")
ProfileTitle.Size = UDim2.new(1, -60, 0, 20)
ProfileTitle.Position = UDim2.new(0, 56, 0, 10)
ProfileTitle.BackgroundTransparency = 1
ProfileTitle.Text = "CB Hub"
ProfileTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
ProfileTitle.Font = Enum.Font.SourceSansBold
ProfileTitle.TextSize = 14
ProfileTitle.TextXAlignment = Enum.TextXAlignment.Left
ProfileTitle.ZIndex = 13
ProfileTitle.Parent = ProfileBox

local ProfileGradient = Instance.new("UIGradient")
ProfileGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 90, 90)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 15, 35))
})
ProfileGradient.Parent = ProfileTitle

local ProfileSub = Instance.new("TextLabel")
ProfileSub.Size = UDim2.new(1, -60, 0, 18)
ProfileSub.Position = UDim2.new(0, 56, 0, 30)
ProfileSub.BackgroundTransparency = 1
ProfileSub.Text = "[ Arena Mode ]"
ProfileSub.TextColor3 = Color3.fromRGB(180, 110, 125)
ProfileSub.Font = Enum.Font.SourceSans
ProfileSub.TextSize = 11
ProfileSub.TextXAlignment = Enum.TextXAlignment.Left
ProfileSub.ZIndex = 13
ProfileSub.Parent = ProfileBox

local SidebarSpacer = Instance.new("Frame")
SidebarSpacer.Size = UDim2.new(1, 0, 0, 10)
SidebarSpacer.BackgroundTransparency = 1
SidebarSpacer.Parent = Sidebar

-- Content Area (Right Panel)
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -160, 1, -35)
ContentArea.Position = UDim2.new(0, 160, 0, 35)
ContentArea.BackgroundTransparency = 1
ContentArea.BorderSizePixel = 0
ContentArea.ZIndex = 11
ContentArea.Parent = MainWindow

local function createContentPage(name)
	local page = Instance.new("ScrollingFrame")
	page.Name = name .. "Page"
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.Visible = false
	page.ScrollBarThickness = 3
	page.ScrollBarImageColor3 = Color3.fromRGB(100, 25, 40)
	page.CanvasSize = UDim2.new(0, 0, 1, 120)
	page.AutomaticCanvasSize = Enum.AutomaticSize.Y
	page.ZIndex = 11
	page.Parent = ContentArea
	
	local layout = Instance.new("UIListLayout")
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 10)
	layout.Parent = page
	
	local padding = Instance.new("UIPadding")
	padding.PaddingLeft = UDim.new(0, 15)
	padding.PaddingTop = UDim.new(0, 15)
	padding.PaddingRight = UDim.new(0, 15)
	padding.Parent = page
	
	return page
end

local AimbotPage = createContentPage("Aimbot")
local ESPPage = createContentPage("ESP")
local SettingPage = createContentPage("Setting")
local LanguagePage = createContentPage("Language")

AimbotPage.Visible = true

local function createSidebarButton(textKey, targetPage)
	local btn = Instance.new("TextButton")
	btn.Name = "SidebarBtn_" .. textKey
	btn.Size = UDim2.new(1, 0, 0, 38)
	btn.BackgroundColor3 = Color3.fromRGB(50, 15, 25)
	btn.BackgroundTransparency = 1
	btn.Text = "   " .. L(textKey)
	btn.TextColor3 = Color3.fromRGB(180, 130, 145)
	btn.TextSize = 13
	btn.Font = Enum.Font.SourceSansBold
	btn.TextXAlignment = Enum.TextXAlignment.Left
	btn.ZIndex = 12
	btn.Parent = Sidebar

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 8)
	btnCorner.Parent = btn

	btn.MouseButton1Click:Connect(function()
		for _, child in pairs(ContentArea:GetChildren()) do
			if child:IsA("ScrollingFrame") then child.Visible = false end
		end
		for _, b in pairs(Sidebar:GetChildren()) do
			if b:IsA("TextButton") then 
				b.TextColor3 = Color3.fromRGB(180, 130, 145)
				b.BackgroundTransparency = 1
			end
		end
		targetPage.Visible = true
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.BackgroundTransparency = 0
	end)
	return btn
end

local btnAimbot = createSidebarButton("TabAimbot", AimbotPage)
btnAimbot.TextColor3 = Color3.fromRGB(255, 255, 255)
btnAimbot.BackgroundTransparency = 0
createSidebarButton("TabESP", ESPPage)
createSidebarButton("TabSetting", SettingPage)

local function createToggleCard(parent, titleText, initialValue, callback)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 52)
    card.BackgroundColor3 = Color3.fromRGB(20, 8, 12)
    card.BorderSizePixel = 0
    card.ZIndex = 12
    card.Parent = parent

    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 8)
    cardCorner.Parent = card

    local cardStroke = Instance.new("UIStroke")
    cardStroke.Color = Color3.fromRGB(110, 20, 35)
    cardStroke.Thickness = 1
    cardStroke.Parent = card

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -70, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = titleText
    label.TextColor3 = Color3.fromRGB(240, 225, 230)
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 13
    label.Parent = card

    local switchBg = Instance.new("Frame")
    switchBg.Size = UDim2.new(0, 44, 0, 24)
    switchBg.Position = UDim2.new(1, -56, 0.5, -12)
    switchBg.BackgroundColor3 = initialValue and Color3.fromRGB(180, 15, 35) or Color3.fromRGB(45, 18, 26)
    switchBg.BorderSizePixel = 0
    switchBg.ZIndex = 13
    switchBg.Parent = card

    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(1, 0)
    bgCorner.Parent = switchBg

    local switchKnob = Instance.new("Frame")
    switchKnob.Size = UDim2.new(0, 18, 0, 18)
    switchKnob.Position = initialValue and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
    switchKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    switchKnob.BorderSizePixel = 0
    switchKnob.ZIndex = 14
    switchKnob.Parent = switchBg

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = switchKnob

    local clickBtn = Instance.new("TextButton")
    clickBtn.Size = UDim2.new(1, 0, 1, 0)
    clickBtn.BackgroundTransparency = 1
    clickBtn.Text = ""
    clickBtn.ZIndex = 15
    clickBtn.Parent = card

    local state = initialValue

    clickBtn.MouseButton1Click:Connect(function()
        state = not state
        callback(state)
        
        local targetBgColor = state and Color3.fromRGB(180, 15, 35) or Color3.fromRGB(45, 18, 26)
        local targetKnobPos = state and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)

        TweenService:Create(switchBg, TweenInfo.new(0.2), {BackgroundColor3 = targetBgColor}):Play()
        TweenService:Create(switchKnob, TweenInfo.new(0.2), {Position = targetKnobPos}):Play()
    end)

    return {
        SetState = function(val)
            state = val
            switchBg.BackgroundColor3 = state and Color3.fromRGB(180, 15, 35) or Color3.fromRGB(45, 18, 26)
            switchKnob.Position = state and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
        end,
        GetState = function() return state end,
        UpdateText = function(newText) label.Text = newText end
    }
end

---------------------------------------------------------
-- AIMBOT PAGE CONTENT
---------------------------------------------------------
local headToggle = createToggleCard(AimbotPage, L("HeadOff"), getgenv().AimbotHeadEnabled, function(state)
    getgenv().AimbotHeadEnabled = state
end)

local bodyToggle = createToggleCard(AimbotPage, L("BodyOff"), getgenv().AimbotBodyEnabled, function(state)
    getgenv().AimbotBodyEnabled = state
end)

local botToggle = createToggleCard(AimbotPage, L("BotLockOff"), getgenv().LockBotsEnabled, function(state)
    getgenv().LockBotsEnabled = state
end)

local IntensityLabel = Instance.new("TextLabel")
IntensityLabel.Size = UDim2.new(1, 0, 0, 22)
IntensityLabel.BackgroundTransparency = 1
IntensityLabel.Text = L("Intensity") .. tostring(getgenv().AimbotIntensity)
IntensityLabel.TextColor3 = Color3.fromRGB(190, 140, 155)
IntensityLabel.TextSize = 13
IntensityLabel.Font = Enum.Font.SourceSansBold
IntensityLabel.TextXAlignment = Enum.TextXAlignment.Left
IntensityLabel.ZIndex = 12
IntensityLabel.Parent = AimbotPage

local AimSliderFrame = Instance.new("Frame")
AimSliderFrame.Name = "AimSliderFrame"
AimSliderFrame.Size = UDim2.new(1, 0, 0, 10)
AimSliderFrame.BackgroundColor3 = Color3.fromRGB(20, 8, 12)
AimSliderFrame.BorderSizePixel = 0
AimSliderFrame.ZIndex = 12
AimSliderFrame.Parent = AimbotPage

local AimSliderCorner = Instance.new("UICorner")
AimSliderCorner.CornerRadius = UDim.new(1, 0)
AimSliderCorner.Parent = AimSliderFrame

local AimSliderStroke = Instance.new("UIStroke")
AimSliderStroke.Color = Color3.fromRGB(110, 20, 35)
AimSliderStroke.Thickness = 1
AimSliderStroke.Parent = AimSliderFrame

local AimSliderFill = Instance.new("Frame")
AimSliderFill.Name = "AimSliderFill"
AimSliderFill.Size = UDim2.new(0, 0, 1, 0)
AimSliderFill.BackgroundColor3 = Color3.fromRGB(200, 20, 45)
AimSliderFill.BorderSizePixel = 0
AimSliderFill.ZIndex = 13
AimSliderFill.Parent = AimSliderFrame

local AimFillCorner = Instance.new("UICorner")
AimFillCorner.CornerRadius = UDim.new(1, 0)
AimFillCorner.Parent = AimSliderFill

local AimSliderBtn = Instance.new("TextButton")
AimSliderBtn.Size = UDim2.new(1, 0, 1, 0)
AimSliderBtn.BackgroundTransparency = 1
AimSliderBtn.Text = ""
AimSliderBtn.ZIndex = 14
AimSliderBtn.Parent = AimSliderFrame

local isAimSliding = false

local function updateAimSlider(input)
    local pos = math.clamp((input.Position.X - AimSliderFrame.AbsolutePosition.X) / AimSliderFrame.AbsoluteSize.X, 0, 1)
    AimSliderFill.Size = UDim2.new(pos, 0, 1, 0)
    local level = math.floor(1 + (pos * 4) + 0.5)
    getgenv().AimbotIntensity = level
    IntensityLabel.Text = L("Intensity") .. tostring(level)
end

AimSliderBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isAimSliding = true
        updateAimSlider(input)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isAimSliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateAimSlider(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isAimSliding = false
    end
end)

local function getClosestEnemyTarget()
    if not getgenv().AimbotHeadEnabled and not getgenv().AimbotBodyEnabled then return nil end

    local closestTarget = nil
    local shortestDistance = math.huge
    local mousePos = UserInputService:GetMouseLocation()

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj ~= LocalPlayer.Character then
            local hum = obj:FindFirstChildOfClass("Humanoid")
            local player = Players:GetPlayerFromCharacter(obj)
            local isBot = (player == nil)

            if hum and hum.Health > 0 and (not isBot or getgenv().LockBotsEnabled) then
                local targetPart = nil
                if getgenv().AimbotHeadEnabled then
                    targetPart = obj:FindFirstChild("Head")
                end
                if not targetPart and getgenv().AimbotBodyEnabled then
                    targetPart = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Torso") or obj:FindFirstChild("UpperTorso")
                end

                if targetPart then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                    if onScreen then
                        local rayParams = RaycastParams.new()
                        rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
                        rayParams.FilterType = Enum.RaycastFilterType.Exclude
                        local rayResult = workspace:Raycast(Camera.CFrame.Position, targetPart.Position - Camera.CFrame.Position, rayParams)

                        if not rayResult or rayResult.Instance:IsDescendantOf(obj) then
                            local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                            if dist < shortestDistance then
                                shortestDistance = dist
                                closestTarget = targetPart
                            end
                        end
                    end
                end
            end
        end
    end
    return closestTarget
end

RunService.RenderStepped:Connect(function()
    pcall(function()
        local targetPart = getClosestEnemyTarget()

        if (getgenv().AimbotHeadEnabled or getgenv().AimbotBodyEnabled) and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
            if targetPart then
                local targetPos = targetPart.Position
                local velocity = Vector3.new(0, 0, 0)
                if targetPart:IsA("BasePart") then
                    velocity = targetPart.Velocity
                end
                
                local distance = (targetPos - Camera.CFrame.Position).Magnitude
                local predictionTime = distance / 1000
                local predictedPos = targetPos + (velocity * predictionTime)
                
                local targetCFrame = CFrame.new(Camera.CFrame.Position, predictedPos)
                local level = getgenv().AimbotIntensity
                
                if level == 5 then
                    Camera.CFrame = targetCFrame
                else
                    Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, level * 0.2)
                end
            end
        end
    end)
end)

---------------------------------------------------------
-- ESP PAGE CONTENT
---------------------------------------------------------
local espPlayerToggle = createToggleCard(ESPPage, L("EspPlayerOff"), getgenv().ESPPlayerEnabled, function(state)
    getgenv().ESPPlayerEnabled = state
end)

local espBotToggle = createToggleCard(ESPPage, L("EspBotOff"), getgenv().ESPBotEnabled, function(state)
    getgenv().ESPBotEnabled = state
end)

local espNameToggle = createToggleCard(ESPPage, L("EspNameOff"), getgenv().ESPNameEnabled, function(state)
    getgenv().ESPNameEnabled = state
end)

RunService.RenderStepped:Connect(function()
    pcall(function()
        local hue = (tick() % 4) / 4
        local syncedRainbowColor = Color3.fromHSV(hue, 1, 1)

        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local character = player.Character
                local head = character:FindFirstChild("Head")
                
                if getgenv().ESPPlayerEnabled then
                    if not character:FindFirstChild("HighlightESP") then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "HighlightESP"
                        highlight.Adornee = character
                        highlight.FillTransparency = 0.5
                        highlight.OutlineTransparency = 0
                        highlight.Parent = character
                    end
                    local hl = character:FindFirstChild("HighlightESP")
                    if hl then
                        if getgenv().RainbowPlayerEnabled then
                            hl.FillColor = syncedRainbowColor
                            hl.OutlineColor = syncedRainbowColor
                        else
                            hl.FillColor = getgenv().ESPPlayerColor
                            hl.OutlineColor = getgenv().ESPPlayerColor
                        end
                    end
                else
                    if character:FindFirstChild("HighlightESP") then
                        character.HighlightESP:Destroy()
                    end
                end
                
                if getgenv().ESPNameEnabled and head then
                    if not head:FindFirstChild("NameESP") then
                        local bg = Instance.new("BillboardGui")
                        bg.Name = "NameESP"
                        bg.Adornee = head
                        bg.Size = UDim2.new(0, 200, 0, 50)
                        bg.StudsOffset = Vector3.new(0, 2, 0)
                        bg.AlwaysOnTop = true
                        
                        local txt = Instance.new("TextLabel")
                        txt.Name = "NameLabel"
                        txt.Size = UDim2.new(1, 0, 1, 0)
                        txt.BackgroundTransparency = 1
                        txt.Text = player.Name
                        txt.TextSize = 13
                        txt.Font = Enum.Font.SourceSansBold
                        txt.TextStrokeTransparency = 0
                        txt.Parent = bg
                        
                        bg.Parent = head
                    end
                    local nameESP = head:FindFirstChild("NameESP")
                    if nameESP and nameESP:FindFirstChild("NameLabel") then
                        if getgenv().RainbowNameEnabled then
                            nameESP.NameLabel.TextColor3 = syncedRainbowColor
                        else
                            nameESP.NameLabel.TextColor3 = getgenv().ESPNameColor
                        end
                    end
                else
                    if head and head:FindFirstChild("NameESP") then
                        head.NameESP:Destroy()
                    end
                end
            end
        end

        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and obj ~= LocalPlayer.Character then
                local hum = obj:FindFirstChildOfClass("Humanoid")
                local player = Players:GetPlayerFromCharacter(obj)
                local isBot = (player == nil)

                if hum and hum.Health > 0 and isBot then
                    if getgenv().ESPBotEnabled then
                        if not obj:FindFirstChild("BotHighlightESP") then
                            local highlight = Instance.new("Highlight")
                            highlight.Name = "BotHighlightESP"
                            highlight.Adornee = obj
                            highlight.FillTransparency = 0.5
                            highlight.OutlineTransparency = 0
                            highlight.Parent = obj
                        end
                        local hl = obj:FindFirstChild("BotHighlightESP")
                        if hl then
                            if getgenv().RainbowBotEnabled then
                                hl.FillColor = syncedRainbowColor
                                hl.OutlineColor = syncedRainbowColor
                            else
                                hl.FillColor = getgenv().ESPBotColor
                                hl.OutlineColor = getgenv().ESPBotColor
                            end
                        end
                    else
                        if obj:FindFirstChild("BotHighlightESP") then
                            obj.BotHighlightESP:Destroy()
                        end
                    end
                end
            end
        end
    end)
end)

---------------------------------------------------------
-- SETTING PAGE CONTENT
---------------------------------------------------------
local function colorToHex(color)
    return string.format("#%02X%02X%02X", math.floor(color.R * 255), math.floor(color.G * 255), math.floor(color.B * 255))
end

local function hexToColor(hex)
    hex = hex:gsub("#", "")
    if #hex == 6 then
        local r = tonumber(hex:sub(1, 2), 16)
        local g = tonumber(hex:sub(3, 4), 16)
        local b = tonumber(hex:sub(5, 6), 16)
        if r and g and b then
            return Color3.fromRGB(r, g, b)
        end
    end
    return nil
end

local function createColorPicker(titleKey, parent, defaultColor, onColorChanged)
    local Label = Instance.new("TextLabel")
    Label.Name = "ColorLabel_" .. titleKey
    Label.Size = UDim2.new(1, 0, 0, 20)
    Label.BackgroundTransparency = 1
    Label.Text = L(titleKey)
    Label.TextColor3 = Color3.fromRGB(190, 140, 155)
    Label.TextSize = 13
    Label.Font = Enum.Font.SourceSansBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.ZIndex = 12
    Label.Parent = parent

    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 0, 36)
    Container.BackgroundColor3 = Color3.fromRGB(20, 8, 12)
    Container.ZIndex = 12
    Container.Parent = parent

    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 8)
    containerCorner.Parent = Container

    local containerStroke = Instance.new("UIStroke")
    containerStroke.Color = Color3.fromRGB(110, 20, 35)
    containerStroke.Thickness = 1
    containerStroke.Parent = Container

    local SpectrumBar = Instance.new("Frame")
    SpectrumBar.Size = UDim2.new(1, -125, 0, 16)
    SpectrumBar.Position = UDim2.new(0, 10, 0, 10)
    SpectrumBar.BorderSizePixel = 0
    SpectrumBar.ZIndex = 12
    SpectrumBar.Parent = Container

    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(0, 4)
    barCorner.Parent = SpectrumBar

    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
    })
    Gradient.Parent = SpectrumBar

    local PreviewBox = Instance.new("Frame")
    PreviewBox.Size = UDim2.new(0, 22, 0, 22)
    PreviewBox.Position = UDim2.new(1, -110, 0, 7)
    PreviewBox.BackgroundColor3 = defaultColor
    PreviewBox.BorderSizePixel = 0
    PreviewBox.ZIndex = 12
    PreviewBox.Parent = Container

    local prevCorner = Instance.new("UICorner")
    prevCorner.CornerRadius = UDim.new(0, 4)
    prevCorner.Parent = PreviewBox

    local HexBox = Instance.new("TextBox")
    HexBox.Size = UDim2.new(0, 75, 0, 22)
    HexBox.Position = UDim2.new(1, -80, 0, 7)
    HexBox.BackgroundColor3 = Color3.fromRGB(12, 4, 6)
    HexBox.BorderSizePixel = 0
    HexBox.Text = colorToHex(defaultColor)
    HexBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    HexBox.Font = Enum.Font.SourceSansBold
    HexBox.TextSize = 12
    HexBox.ClearTextOnFocus = false
    HexBox.ZIndex = 12
    HexBox.Parent = Container

    local hexCorner = Instance.new("UICorner")
    hexCorner.CornerRadius = UDim.new(0, 4)
    hexCorner.Parent = HexBox

    local hexStroke = Instance.new("UIStroke")
    hexStroke.Color = Color3.fromRGB(110, 20, 35)
    hexStroke.Thickness = 1
    hexStroke.Parent = HexBox

    local PickerBtn = Instance.new("TextButton")
    PickerBtn.Size = UDim2.new(1, 0, 1, 0)
    PickerBtn.BackgroundTransparency = 1
    PickerBtn.Text = ""
    PickerBtn.ZIndex = 13
    PickerBtn.Parent = SpectrumBar

    local isPicking = false

    local function updateColor(input)
        local posX = math.clamp((input.Position.X - SpectrumBar.AbsolutePosition.X) / SpectrumBar.AbsoluteSize.X, 0, 1)
        local selectedColor = Color3.fromHSV(posX, 1, 1)
        PreviewBox.BackgroundColor3 = selectedColor
        HexBox.Text = colorToHex(selectedColor)
        onColorChanged(selectedColor)
    end

    PickerBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isPicking = true
            updateColor(input)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if isPicking and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateColor(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isPicking = false
        end
    end)

    HexBox.FocusLost:Connect(function()
        local parsedColor = hexToColor(HexBox.Text)
        if parsedColor then
            PreviewBox.BackgroundColor3 = parsedColor
            HexBox.Text = colorToHex(parsedColor)
            onColorChanged(parsedColor)
        else
            HexBox.Text = colorToHex(PreviewBox.BackgroundColor3)
        end
    end)

    return Label
end

local playerPickerLabel = createColorPicker("ColorPlayer", SettingPage, getgenv().ESPPlayerColor, function(newColor)
    getgenv().ESPPlayerColor = newColor
end)

local botPickerLabel = createColorPicker("ColorBot", SettingPage, getgenv().ESPBotColor, function(newColor)
    getgenv().ESPBotColor = newColor
end)

local namePickerLabel = createColorPicker("ColorName", SettingPage, getgenv().ESPNameColor, function(newColor)
    getgenv().ESPNameColor = newColor
end)

local rainbowPlayerToggle = createToggleCard(SettingPage, L("RbPlayerOff"), getgenv().RainbowPlayerEnabled, function(state)
    getgenv().RainbowPlayerEnabled = state
end)

local rainbowBotToggle = createToggleCard(SettingPage, L("RbBotOff"), getgenv().RainbowBotEnabled, function(state)
    getgenv().RainbowBotEnabled = state
end)

local rainbowNameToggle = createToggleCard(SettingPage, L("RbNameOff"), getgenv().RainbowNameEnabled, function(state)
    getgenv().RainbowNameEnabled = state
end)

local ResetButton = Instance.new("TextButton")
ResetButton.Size = UDim2.new(1, 0, 0, 38)
ResetButton.BackgroundColor3 = Color3.fromRGB(160, 20, 40)
ResetButton.Text = L("ResetBtn")
ResetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ResetButton.Font = Enum.Font.SourceSansBold
ResetButton.TextSize = 13
ResetButton.ZIndex = 12
ResetButton.Parent = SettingPage

local resetCorner = Instance.new("UICorner")
resetCorner.CornerRadius = UDim.new(0, 8)
resetCorner.Parent = ResetButton

local resetStroke = Instance.new("UIStroke")
resetStroke.Color = Color3.fromRGB(220, 40, 60)
resetStroke.Thickness = 1
resetStroke.Parent = ResetButton

local LanguageNavButton = Instance.new("TextButton")
LanguageNavButton.Size = UDim2.new(1, 0, 0, 38)
LanguageNavButton.BackgroundColor3 = Color3.fromRGB(70, 15, 30)
LanguageNavButton.Text = L("LangButton")
LanguageNavButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LanguageNavButton.Font = Enum.Font.SourceSansBold
LanguageNavButton.TextSize = 13
LanguageNavButton.ZIndex = 12
LanguageNavButton.Parent = SettingPage

local langNavCorner = Instance.new("UICorner")
langNavCorner.CornerRadius = UDim.new(0, 8)
langNavCorner.Parent = LanguageNavButton

local langNavStroke = Instance.new("UIStroke")
langNavStroke.Color = Color3.fromRGB(120, 25, 40)
langNavStroke.Thickness = 1
langNavStroke.Parent = LanguageNavButton

local function refreshAllTexts()
    Sidebar.SidebarBtn_TabAimbot.Text = "   " .. L("TabAimbot")
    Sidebar.SidebarBtn_TabESP.Text = "   " .. L("TabESP")
    Sidebar.SidebarBtn_TabSetting.Text = "   " .. L("TabSetting")
    
    headToggle.UpdateText(getgenv().AimbotHeadEnabled and L("HeadOn") or L("HeadOff"))
    bodyToggle.UpdateText(getgenv().AimbotBodyEnabled and L("BodyOn") or L("BodyOff"))
    botToggle.UpdateText(getgenv().LockBotsEnabled and L("BotLockOn") or L("BotLockOff"))
    IntensityLabel.Text = L("Intensity") .. tostring(getgenv().AimbotIntensity)
    
    espPlayerToggle.UpdateText(getgenv().ESPPlayerEnabled and L("EspPlayerOn") or L("EspPlayerOff"))
    espBotToggle.UpdateText(getgenv().ESPBotEnabled and L("EspBotOn") or L("EspBotOff"))
    espNameToggle.UpdateText(getgenv().ESPNameEnabled and L("EspNameOn") or L("EspNameOff"))
    
    playerPickerLabel.Text = L("ColorPlayer")
    botPickerLabel.Text = L("ColorBot")
    namePickerLabel.Text = L("ColorName")
    
    rainbowPlayerToggle.UpdateText(getgenv().RainbowPlayerEnabled and L("RbPlayerOn") or L("RbPlayerOff"))
    rainbowBotToggle.UpdateText(getgenv().RainbowBotEnabled and L("RbBotOn") or L("RbBotOff"))
    rainbowNameToggle.UpdateText(getgenv().RainbowNameEnabled and L("RbNameOn") or L("RbNameOff"))
    
    ResetButton.Text = L("ResetBtn")
    LanguageNavButton.Text = L("LangButton")
end

local function performReset()
    getgenv().AimbotHeadEnabled = false
    getgenv().AimbotBodyEnabled = false
    getgenv().LockBotsEnabled = false
    
    getgenv().ESPPlayerEnabled = false
    getgenv().ESPBotEnabled = false
    getgenv().ESPNameEnabled = false
    getgenv().RainbowPlayerEnabled = false
    getgenv().RainbowBotEnabled = false
    getgenv().RainbowNameEnabled = false

    headToggle.SetState(false)
    bodyToggle.SetState(false)
    botToggle.SetState(false)
    espPlayerToggle.SetState(false)
    espBotToggle.SetState(false)
    espNameToggle.SetState(false)
    rainbowPlayerToggle.SetState(false)
    rainbowBotToggle.SetState(false)
    rainbowNameToggle.SetState(false)

    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            if player.Character:FindFirstChild("HighlightESP") then
                player.Character.HighlightESP:Destroy()
            end
            local head = player.Character:FindFirstChild("Head")
            if head and head:FindFirstChild("NameESP") then
                head.NameESP:Destroy()
            end
        end
    end

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") then
            if obj:FindFirstChild("BotHighlightESP") then
                obj.BotHighlightESP:Destroy()
            end
        end
    end
end

ResetButton.MouseButton1Click:Connect(function()
    performReset()
    refreshAllTexts()
end)

LanguageNavButton.MouseButton1Click:Connect(function()
    for _, child in pairs(ContentArea:GetChildren()) do
        if child:IsA("ScrollingFrame") then child.Visible = false end
    end
    for _, b in pairs(Sidebar:GetChildren()) do
        if b:IsA("TextButton") then b.TextColor3 = Color3.fromRGB(180, 130, 145) b.BackgroundTransparency = 1 end
    end
    LanguagePage.Visible = true
end)

---------------------------------------------------------
-- LANGUAGE SELECTION PAGE CONTENT
---------------------------------------------------------
local LangPageTitle = Instance.new("TextLabel")
LangPageTitle.Size = UDim2.new(1, 0, 0, 30)
LangPageTitle.BackgroundTransparency = 1
LangPageTitle.Text = L("LangTitle")
LangPageTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
LangPageTitle.TextSize = 15
LangPageTitle.Font = Enum.Font.SourceSansBold
LangPageTitle.TextXAlignment = Enum.TextXAlignment.Left
LangPageTitle.ZIndex = 12
LangPageTitle.Parent = LanguagePage

local function createLanguageOption(langCode, langName)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(25, 10, 15)
    btn.Text = langName
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 13
    btn.ZIndex = 12
    btn.Parent = LanguagePage

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Color3.fromRGB(110, 20, 35)
    btnStroke.Thickness = 1
    btnStroke.Parent = btn

    btn.MouseButton1Click:Connect(function()
        getgenv().CurrentLanguage = langCode
        refreshAllTexts()
        LangPageTitle.Text = L("LangTitle")
        
        LanguagePage.Visible = false
        SettingPage.Visible = true
        for _, b in pairs(Sidebar:GetChildren()) do
            if b:IsA("TextButton") and b.Name == "SidebarBtn_TabSetting" then
                b.TextColor3 = Color3.fromRGB(255, 255, 255)
                b.BackgroundTransparency = 0
            elseif b:IsA("TextButton") then
                b.TextColor3 = Color3.fromRGB(180, 130, 145)
                b.BackgroundTransparency = 1
            end
        end
    end)
end

createLanguageOption("EN", "🇬🇧 English")
createLanguageOption("TH", "🇹🇭 ไทย (Thai)")
createLanguageOption("RU", "🇷🇺 Русский (Russian)")
createLanguageOption("PT", "🇵🇹 Português (Portugal)")
createLanguageOption("BR", "🇧🇷 Português (Brasil)")
createLanguageOption("IT", "🇮🇹 Italiano (Italian)")
createLanguageOption("AR", "🇦🇷 Español (Argentina)")
createLanguageOption("ES", "🇪🇸 Español (Spain)")
createLanguageOption("CN", "🇨🇳 中文 (Chinese)")
createLanguageOption("JP", "🇯🇵 日本語 (Japanese)")

local BackButton = Instance.new("TextButton")
BackButton.Size = UDim2.new(1, 0, 0, 38)
BackButton.BackgroundColor3 = Color3.fromRGB(80, 20, 35)
BackButton.Text = L("BackBtn")
BackButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BackButton.Font = Enum.Font.SourceSansBold
BackButton.TextSize = 13
BackButton.ZIndex = 12
BackButton.Parent = LanguagePage

local backCorner = Instance.new("UICorner")
backCorner.CornerRadius = UDim.new(0, 8)
backCorner.Parent = BackButton

local backStroke = Instance.new("UIStroke")
backStroke.Color = Color3.fromRGB(140, 25, 45)
backStroke.Thickness = 1
backStroke.Parent = BackButton

BackButton.MouseButton1Click:Connect(function()
    LanguagePage.Visible = false
    SettingPage.Visible = true
    for _, b in pairs(Sidebar:GetChildren()) do
        if b:IsA("TextButton") and b.Name == "SidebarBtn_TabSetting" then
            b.TextColor3 = Color3.fromRGB(255, 255, 255)
            b.BackgroundTransparency = 0
        elseif b:IsA("TextButton") then
            b.TextColor3 = Color3.fromRGB(180, 130, 145)
            b.BackgroundTransparency = 1
        end
    end
end)

local KeybindLabel = Instance.new("TextLabel")
KeybindLabel.Size = UDim2.new(1, 0, 0, 20)
KeybindLabel.BackgroundTransparency = 1
KeybindLabel.Text = L("KeybindLabel")
KeybindLabel.TextColor3 = Color3.fromRGB(190, 140, 155)
KeybindLabel.TextSize = 13
KeybindLabel.Font = Enum.Font.SourceSansBold
KeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
KeybindLabel.ZIndex = 12
KeybindLabel.Parent = SettingPage

local KeybindBox = Instance.new("TextBox")
KeybindBox.Size = UDim2.new(1, 0, 0, 38)
KeybindBox.BackgroundColor3 = Color3.fromRGB(20, 8, 12)
KeybindBox.BorderSizePixel = 0
KeybindBox.Text = "RightShift"
KeybindBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeybindBox.Font = Enum.Font.SourceSansBold
KeybindBox.TextSize = 13
KeybindBox.ZIndex = 13
KeybindBox.Parent = SettingPage

local kbCorner = Instance.new("UICorner")
kbCorner.CornerRadius = UDim.new(0, 8)
kbCorner.Parent = KeybindBox

local kbStroke = Instance.new("UIStroke")
kbStroke.Color = Color3.fromRGB(110, 20, 35)
kbStroke.Thickness = 1
kbStroke.Parent = KeybindBox

KeybindBox.FocusLost:Connect(function()
    local text = KeybindBox.Text:upper()
    if text ~= "" then
        local success, key = pcall(function()
            return Enum.KeyCode[text]
        end)
        if success and key then
            getgenv().ToggleKeybind = key
            KeybindBox.Text = text
        else
            KeybindBox.Text = "Invalid Key"
        end
    end
end)

---------------------------------------------------------
-- WINDOW CONTROLS & DRAGGING LOGIC (Fixed Open & Drag)
---------------------------------------------------------
MinimizeButton.MouseButton1Click:Connect(function()
	MainWindow.Visible = false
end)

CloseButton.MouseButton1Click:Connect(function()
    performReset()
	ScreenGui:Destroy()
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == getgenv().ToggleKeybind then
            ScreenGui.Enabled = not ScreenGui.Enabled
        end
    end
end)

-- Main Window Draggable Logic
local dragging, dragInput, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainWindow.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)

TopBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		MainWindow.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Floating OpenButton Drag & Click Separation Logic
local btnDragging = false
local btnDragStart, btnStartPos
local hasMoved = false

OpenButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		btnDragging = true
		hasMoved = false
		btnDragStart = input.Position
		btnStartPos = OpenButton.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if btnDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - btnDragStart
		if delta.Magnitude > 5 then
			hasMoved = true
			OpenButton.Position = UDim2.new(btnStartPos.X.Scale, btnStartPos.X.Offset + delta.X, btnStartPos.Y.Scale, btnStartPos.Y.Offset + delta.Y)
		end
	end
end)

OpenButton.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		if btnDragging then
			btnDragging = false
			-- ถ้าไม่ได้ลากปุ่ม (คลิกเฉยๆ) ให้เปิด-ปิดหน้าต่าง
			if not hasMoved then
				MainWindow.Visible = not MainWindow.Visible
			end
		end
	end
end)
