-- Murder Mystery 2 Script
-- Универсальный скрипт для MM2

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- Ключ доступа
local VALID_KEY = "VKYTNVUJN_8W778N"
local DISCORD_LINK = "https://discord.gg/yeWd226pRE"

-- Forward declaration
local LoadMainScript

-- Функция создания Loading Screen
local function CreateLoadingScreen()
    local LoadingGui = Instance.new("ScreenGui")
    LoadingGui.Name = "LoadingScreen"
    LoadingGui.Parent = game.CoreGui
    LoadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Фон
    local Background = Instance.new("Frame")
    Background.Name = "Background"
    Background.Parent = LoadingGui
    Background.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
    Background.BorderSizePixel = 0
    Background.Size = UDim2.new(1, 0, 1, 0)
    
    -- Градиент фона
    local BgGradient = Instance.new("UIGradient")
    BgGradient.Parent = Background
    BgGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 30)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(10, 10, 20)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
    }
    BgGradient.Rotation = 45
    
    -- Анимация градиента
    spawn(function()
        while BgGradient and BgGradient.Parent do
            TweenService:Create(BgGradient, TweenInfo.new(3, Enum.EasingStyle.Linear), {
                Rotation = 405
            }):Play()
            wait(3)
            BgGradient.Rotation = 45
        end
    end)
    
    -- Главный контейнер
    local Container = Instance.new("Frame")
    Container.Name = "Container"
    Container.Parent = Background
    Container.BackgroundTransparency = 1
    Container.Position = UDim2.new(0.5, -300, 0.5, -200)
    Container.Size = UDim2.new(0, 600, 0, 400)
    
    -- Логотип (большой эмодзи)
    local Logo = Instance.new("TextLabel")
    Logo.Name = "Logo"
    Logo.Parent = Container
    Logo.BackgroundTransparency = 1
    Logo.Position = UDim2.new(0.5, -100, 0, 0)
    Logo.Size = UDim2.new(0, 200, 0, 200)
    Logo.Font = Enum.Font.GothamBold
    Logo.Text = "🔪"
    Logo.TextColor3 = Color3.fromRGB(255, 255, 255)
    Logo.TextSize = 120
    Logo.TextTransparency = 1
    
    -- Анимация появления логотипа
    TweenService:Create(Logo, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        TextTransparency = 0,
        Rotation = 360
    }):Play()
    
    -- Пульсация логотипа
    spawn(function()
        wait(0.8)
        while Logo and Logo.Parent do
            TweenService:Create(Logo, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                TextSize = 130
            }):Play()
            wait(1)
            TweenService:Create(Logo, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                TextSize = 120
            }):Play()
            wait(1)
        end
    end)
    
    -- Заголовок
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = Container
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 0, 0, 180)
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "MURDER MYSTERY 2"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 32
    Title.TextStrokeTransparency = 0.5
    Title.TextTransparency = 1
    
    wait(0.3)
    TweenService:Create(Title, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 0
    }):Play()
    
    -- Подзаголовок
    local Subtitle = Instance.new("TextLabel")
    Subtitle.Name = "Subtitle"
    Subtitle.Parent = Container
    Subtitle.BackgroundTransparency = 1
    Subtitle.Position = UDim2.new(0, 0, 0, 230)
    Subtitle.Size = UDim2.new(1, 0, 0, 30)
    Subtitle.Font = Enum.Font.Gotham
    Subtitle.Text = "Premium Script v1.0"
    Subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
    Subtitle.TextSize = 18
    Subtitle.TextTransparency = 1
    
    wait(0.5)
    TweenService:Create(Subtitle, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 0.3
    }):Play()
    
    -- Статус загрузки
    local Status = Instance.new("TextLabel")
    Status.Name = "Status"
    Status.Parent = Container
    Status.BackgroundTransparency = 1
    Status.Position = UDim2.new(0, 0, 0, 280)
    Status.Size = UDim2.new(1, 0, 0, 25)
    Status.Font = Enum.Font.GothamBold
    Status.Text = "Initializing..."
    Status.TextColor3 = Color3.fromRGB(100, 200, 255)
    Status.TextSize = 16
    Status.TextTransparency = 1
    
    wait(0.7)
    TweenService:Create(Status, TweenInfo.new(0.4), {
        TextTransparency = 0
    }):Play()
    
    -- Прогресс бар контейнер
    local ProgressContainer = Instance.new("Frame")
    ProgressContainer.Name = "ProgressContainer"
    ProgressContainer.Parent = Container
    ProgressContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    ProgressContainer.BorderSizePixel = 0
    ProgressContainer.Position = UDim2.new(0.1, 0, 0, 320)
    ProgressContainer.Size = UDim2.new(0.8, 0, 0, 8)
    ProgressContainer.BackgroundTransparency = 1
    
    local ProgressCorner = Instance.new("UICorner")
    ProgressCorner.CornerRadius = UDim.new(1, 0)
    ProgressCorner.Parent = ProgressContainer
    
    wait(0.9)
    TweenService:Create(ProgressContainer, TweenInfo.new(0.3), {
        BackgroundTransparency = 0
    }):Play()
    
    -- Прогресс бар
    local ProgressBar = Instance.new("Frame")
    ProgressBar.Name = "ProgressBar"
    ProgressBar.Parent = ProgressContainer
    ProgressBar.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    ProgressBar.BorderSizePixel = 0
    ProgressBar.Size = UDim2.new(0, 0, 1, 0)
    
    local ProgressBarCorner = Instance.new("UICorner")
    ProgressBarCorner.CornerRadius = UDim.new(1, 0)
    ProgressBarCorner.Parent = ProgressBar
    
    -- Градиент прогресс бара
    local ProgressGradient = Instance.new("UIGradient")
    ProgressGradient.Parent = ProgressBar
    ProgressGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 100)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 50, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 100))
    }
    
    -- Анимация градиента прогресс бара
    spawn(function()
        while ProgressGradient and ProgressGradient.Parent do
            TweenService:Create(ProgressGradient, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
                Offset = Vector2.new(1, 0)
            }):Play()
            wait(1.5)
            ProgressGradient.Offset = Vector2.new(-1, 0)
        end
    end)
    
    -- Процент загрузки
    local Percentage = Instance.new("TextLabel")
    Percentage.Name = "Percentage"
    Percentage.Parent = Container
    Percentage.BackgroundTransparency = 1
    Percentage.Position = UDim2.new(0, 0, 0, 335)
    Percentage.Size = UDim2.new(1, 0, 0, 20)
    Percentage.Font = Enum.Font.GothamBold
    Percentage.Text = "0%"
    Percentage.TextColor3 = Color3.fromRGB(255, 255, 255)
    Percentage.TextSize = 14
    Percentage.TextTransparency = 1
    
    wait(1)
    TweenService:Create(Percentage, TweenInfo.new(0.3), {
        TextTransparency = 0.5
    }):Play()
    
    -- Этапы загрузки
    local loadingSteps = {
        {text = "Loading libraries...", duration = 0.5, progress = 20},
        {text = "Connecting to server...", duration = 0.6, progress = 40},
        {text = "Verifying game...", duration = 0.7, progress = 60},
        {text = "Loading features...", duration = 0.5, progress = 80},
        {text = "Finalizing...", duration = 0.4, progress = 100}
    }
    
    wait(1.2)
    
    -- Анимация загрузки
    for _, step in ipairs(loadingSteps) do
        Status.Text = step.text
        
        -- Анимация прогресс бара
        TweenService:Create(ProgressBar, TweenInfo.new(step.duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(step.progress / 100, 0, 1, 0)
        }):Play()
        
        -- Обновление процента
        local startProgress = tonumber(Percentage.Text:match("%d+")) or 0
        for i = startProgress, step.progress do
            Percentage.Text = i .. "%"
            wait(step.duration / (step.progress - startProgress))
        end
        
        wait(0.2)
    end
    
    -- Завершение загрузки
    Status.Text = "✓ Loading complete!"
    Status.TextColor3 = Color3.fromRGB(50, 255, 50)
    
    wait(0.5)
    
    -- Анимация исчезновения
    TweenService:Create(Container, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Position = UDim2.new(0.5, -300, 0.5, -300),
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    
    TweenService:Create(Background, TweenInfo.new(0.5), {
        BackgroundTransparency = 1
    }):Play()
    
    wait(0.5)
    LoadingGui:Destroy()
end

-- Функция создания Key System GUI
local function CreateKeySystem()
    local KeyGui = Instance.new("ScreenGui")
    KeyGui.Name = "KeySystemGUI"
    KeyGui.Parent = game.CoreGui
    KeyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Затемнение фона
    local Overlay = Instance.new("Frame")
    Overlay.Name = "Overlay"
    Overlay.Parent = KeyGui
    Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Overlay.BackgroundTransparency = 0.5
    Overlay.BorderSizePixel = 0
    Overlay.Size = UDim2.new(1, 0, 1, 0)
    
    -- Главный фрейм
    local KeyFrame = Instance.new("Frame")
    KeyFrame.Name = "KeyFrame"
    KeyFrame.Parent = KeyGui
    KeyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    KeyFrame.BorderSizePixel = 0
    KeyFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
    KeyFrame.Size = UDim2.new(0, 500, 0, 400)
    KeyFrame.ClipsDescendants = true
    
    local KeyCorner = Instance.new("UICorner")
    KeyCorner.CornerRadius = UDim.new(0, 15)
    KeyCorner.Parent = KeyFrame
    
    -- Тень
    local KeyShadow = Instance.new("ImageLabel")
    KeyShadow.Name = "Shadow"
    KeyShadow.Parent = KeyFrame
    KeyShadow.BackgroundTransparency = 1
    KeyShadow.Position = UDim2.new(0, -15, 0, -15)
    KeyShadow.Size = UDim2.new(1, 30, 1, 30)
    KeyShadow.ZIndex = 0
    KeyShadow.Image = "rbxassetid://6014261993"
    KeyShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    KeyShadow.ImageTransparency = 0.3
    KeyShadow.ScaleType = Enum.ScaleType.Slice
    KeyShadow.SliceCenter = Rect.new(49, 49, 450, 450)
    
    -- Обводка
    local KeyStroke = Instance.new("UIStroke")
    KeyStroke.Parent = KeyFrame
    KeyStroke.Color = Color3.fromRGB(200, 50, 50)
    KeyStroke.Thickness = 3
    KeyStroke.Transparency = 0
    
    -- Заголовок
    local KeyTitle = Instance.new("TextLabel")
    KeyTitle.Name = "Title"
    KeyTitle.Parent = KeyFrame
    KeyTitle.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    KeyTitle.BorderSizePixel = 0
    KeyTitle.Size = UDim2.new(1, 0, 0, 70)
    KeyTitle.Font = Enum.Font.GothamBold
    KeyTitle.Text = "🔐 KEY SYSTEM"
    KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyTitle.TextSize = 28
    KeyTitle.TextStrokeTransparency = 0.5
    
    local KeyTitleCorner = Instance.new("UICorner")
    KeyTitleCorner.CornerRadius = UDim.new(0, 15)
    KeyTitleCorner.Parent = KeyTitle
    
    local KeyTitleGradient = Instance.new("UIGradient")
    KeyTitleGradient.Parent = KeyTitle
    KeyTitleGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 50, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 30, 30))
    }
    KeyTitleGradient.Rotation = 45
    
    -- Описание
    local Description = Instance.new("TextLabel")
    Description.Name = "Description"
    Description.Parent = KeyFrame
    Description.BackgroundTransparency = 1
    Description.Position = UDim2.new(0, 20, 0, 90)
    Description.Size = UDim2.new(1, -40, 0, 60)
    Description.Font = Enum.Font.Gotham
    Description.Text = "Join our Discord server to get the key!\nВступи в наш Discord сервер чтобы получить ключ!"
    Description.TextColor3 = Color3.fromRGB(200, 200, 200)
    Description.TextSize = 14
    Description.TextWrapped = true
    Description.TextYAlignment = Enum.TextYAlignment.Top
    
    -- Кнопка Discord
    local DiscordButton = Instance.new("TextButton")
    DiscordButton.Name = "DiscordButton"
    DiscordButton.Parent = KeyFrame
    DiscordButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    DiscordButton.BorderSizePixel = 0
    DiscordButton.Position = UDim2.new(0.5, -200, 0, 160)
    DiscordButton.Size = UDim2.new(0, 400, 0, 50)
    DiscordButton.Font = Enum.Font.GothamBold
    DiscordButton.Text = "📋 Copy Discord Link / Скопировать ссылку"
    DiscordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DiscordButton.TextSize = 16
    DiscordButton.AutoButtonColor = false
    
    local DiscordCorner = Instance.new("UICorner")
    DiscordCorner.CornerRadius = UDim.new(0, 10)
    DiscordCorner.Parent = DiscordButton
    
    local DiscordGradient = Instance.new("UIGradient")
    DiscordGradient.Parent = DiscordButton
    DiscordGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(88, 101, 242)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(68, 81, 222))
    }
    DiscordGradient.Rotation = 90
    
    -- Поле ввода ключа
    local KeyInput = Instance.new("TextBox")
    KeyInput.Name = "KeyInput"
    KeyInput.Parent = KeyFrame
    KeyInput.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    KeyInput.BorderSizePixel = 0
    KeyInput.Position = UDim2.new(0.5, -200, 0, 230)
    KeyInput.Size = UDim2.new(0, 400, 0, 50)
    KeyInput.Font = Enum.Font.GothamBold
    KeyInput.PlaceholderText = "Enter Key Here / Введите ключ"
    KeyInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    KeyInput.Text = ""
    KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyInput.TextSize = 16
    KeyInput.ClearTextOnFocus = false
    
    local KeyInputCorner = Instance.new("UICorner")
    KeyInputCorner.CornerRadius = UDim.new(0, 10)
    KeyInputCorner.Parent = KeyInput
    
    local KeyInputStroke = Instance.new("UIStroke")
    KeyInputStroke.Parent = KeyInput
    KeyInputStroke.Color = Color3.fromRGB(80, 80, 100)
    KeyInputStroke.Thickness = 2
    
    -- Кнопка проверки ключа
    local CheckButton = Instance.new("TextButton")
    CheckButton.Name = "CheckButton"
    CheckButton.Parent = KeyFrame
    CheckButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    CheckButton.BorderSizePixel = 0
    CheckButton.Position = UDim2.new(0.5, -200, 0, 300)
    CheckButton.Size = UDim2.new(0, 400, 0, 50)
    CheckButton.Font = Enum.Font.GothamBold
    CheckButton.Text = "✓ Check Key / Проверить ключ"
    CheckButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CheckButton.TextSize = 18
    CheckButton.AutoButtonColor = false
    
    local CheckCorner = Instance.new("UICorner")
    CheckCorner.CornerRadius = UDim.new(0, 10)
    CheckCorner.Parent = CheckButton
    
    local CheckGradient = Instance.new("UIGradient")
    CheckGradient.Parent = CheckButton
    CheckGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 200, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 180, 30))
    }
    CheckGradient.Rotation = 90
    
    -- Статус
    local Status = Instance.new("TextLabel")
    Status.Name = "Status"
    Status.Parent = KeyFrame
    Status.BackgroundTransparency = 1
    Status.Position = UDim2.new(0, 20, 0, 360)
    Status.Size = UDim2.new(1, -40, 0, 30)
    Status.Font = Enum.Font.GothamBold
    Status.Text = ""
    Status.TextColor3 = Color3.fromRGB(255, 255, 255)
    Status.TextSize = 14
    Status.TextStrokeTransparency = 0.5
    
    -- Анимация появления
    KeyFrame.Size = UDim2.new(0, 0, 0, 0)
    KeyFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    TweenService:Create(KeyFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 500, 0, 400),
        Position = UDim2.new(0.5, -250, 0.5, -200)
    }):Play()
    
    -- Обработчик кнопки Discord
    DiscordButton.MouseButton1Click:Connect(function()
        setclipboard(DISCORD_LINK)
        
        TweenService:Create(DiscordButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        }):Play()
        
        Status.Text = "✓ Discord link copied! / Ссылка скопирована!"
        Status.TextColor3 = Color3.fromRGB(50, 255, 50)
        
        wait(1)
        
        TweenService:Create(DiscordButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(88, 101, 242)
        }):Play()
    end)
    
    -- Анимация при наведении на Discord
    DiscordButton.MouseEnter:Connect(function()
        TweenService:Create(DiscordButton, TweenInfo.new(0.2), {
            Size = UDim2.new(0, 410, 0, 55)
        }):Play()
    end)
    
    DiscordButton.MouseLeave:Connect(function()
        TweenService:Create(DiscordButton, TweenInfo.new(0.2), {
            Size = UDim2.new(0, 400, 0, 50)
        }):Play()
    end)
    
    -- Анимация при наведении на Check
    CheckButton.MouseEnter:Connect(function()
        TweenService:Create(CheckButton, TweenInfo.new(0.2), {
            Size = UDim2.new(0, 410, 0, 55)
        }):Play()
    end)
    
    CheckButton.MouseLeave:Connect(function()
        TweenService:Create(CheckButton, TweenInfo.new(0.2), {
            Size = UDim2.new(0, 400, 0, 50)
        }):Play()
    end)
    
    -- Обработчик проверки ключа
    CheckButton.MouseButton1Click:Connect(function()
        local enteredKey = KeyInput.Text
        
        if enteredKey == VALID_KEY then
            Status.Text = "✓ Key is correct! Loading script... / Ключ верный! Загрузка..."
            Status.TextColor3 = Color3.fromRGB(50, 255, 50)
            
            -- Воспроизводим звук успеха
            local SuccessSound = Instance.new("Sound")
            SuccessSound.SoundId = "rbxassetid://6026984224" -- Звук успеха
            SuccessSound.Volume = 0.5
            SuccessSound.Parent = game:GetService("SoundService")
            SuccessSound:Play()
            
            game:GetService("Debris"):AddItem(SuccessSound, 3)
            
            -- Анимация успеха
            TweenService:Create(KeyFrame, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(30, 80, 30)
            }):Play()
            
            TweenService:Create(KeyStroke, TweenInfo.new(0.3), {
                Color = Color3.fromRGB(50, 255, 50)
            }):Play()
            
            wait(1)
            
            -- Закрываем Key System
            TweenService:Create(KeyFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0)
            }):Play()
            
            wait(0.5)
            KeyGui:Destroy()
            
            -- Загружаем основной скрипт
            LoadMainScript()
        else
            Status.Text = "✗ Wrong key! / Неверный ключ!"
            Status.TextColor3 = Color3.fromRGB(255, 50, 50)
            
            -- Воспроизводим звук ошибки
            local ErrorSound = Instance.new("Sound")
            ErrorSound.SoundId = "rbxassetid://2865228021" -- Звук ошибки
            ErrorSound.Volume = 0.3
            ErrorSound.Parent = game:GetService("SoundService")
            ErrorSound:Play()
            
            game:GetService("Debris"):AddItem(ErrorSound, 2)
            
            -- Анимация ошибки
            TweenService:Create(KeyFrame, TweenInfo.new(0.1), {
                Position = UDim2.new(0.5, -260, 0.5, -200)
            }):Play()
            wait(0.1)
            TweenService:Create(KeyFrame, TweenInfo.new(0.1), {
                Position = UDim2.new(0.5, -240, 0.5, -200)
            }):Play()
            wait(0.1)
            TweenService:Create(KeyFrame, TweenInfo.new(0.1), {
                Position = UDim2.new(0.5, -250, 0.5, -200)
            }):Play()
            
            TweenService:Create(KeyInputStroke, TweenInfo.new(0.3), {
                Color = Color3.fromRGB(255, 50, 50)
            }):Play()
            
            wait(1)
            
            TweenService:Create(KeyInputStroke, TweenInfo.new(0.3), {
                Color = Color3.fromRGB(80, 80, 100)
            }):Play()
        end
    end)
end

-- Функция загрузки основного скрипта
LoadMainScript = function()

-- Настройки
local Settings = {
    ESP = false,
    ShowRoles = false,
    CoinFarm = false,
    KillAll = false,
    GunMods = false,
    InfiniteJump = false,
    WalkSpeed = 16,
    JumpPower = 50,
    Fly = false,
    Noclip = false,
    AutoCollectGun = false,
    GunDropESP = false,
    Language = "English" -- English или Russian
}

-- Локализация
local Localization = {
    English = {
        Title = "🔪 Murder Mystery 2",
        ESP = "ESP (Player Highlight)",
        GunDropESP = "🔫 Gun Drop ESP",
        ShowRoles = "Show Roles",
        CoinFarm = "Collect Coins",
        AutoCollectGun = "🔫 Auto Collect Gun",
        KillAll = "Kill All (Murderer)",
        InfiniteJump = "Infinite Jump",
        Fly = "Fly",
        Noclip = "Noclip (Through Walls)",
        WalkSpeed = "Walk Speed",
        JumpPower = "Jump Power",
        TeleportMurderer = "Teleport to Murderer",
        TeleportSheriff = "Teleport to Sheriff",
        Debug = "🔍 Debug - Show Roles",
        Close = "Close GUI",
        Language = "🌐 Language: English",
        ON = "ON",
        OFF = "OFF",
        -- Уведомления
        ScriptLoaded = "Script loaded! Good luck!",
        TeleportTo = "Teleport to",
        MurdererNotFound = "Murderer not found!",
        SheriffNotFound = "Sheriff not found!",
        CharacterNotFound = "Your character not found!",
        Error = "Error",
        Teleport = "Teleport",
        GunFound = "Gun found and collected!",
        DebugConsole = "Roles printed to console (F9)",
        ClosingScript = "All functions disabled. GUI closed."
    },
    Russian = {
        Title = "🔪 Murder Mystery 2",
        ESP = "ESP (Подсветка игроков)",
        GunDropESP = "🔫 Подсветка пистолета",
        ShowRoles = "Показать роли",
        CoinFarm = "Собирать монеты",
        AutoCollectGun = "🔫 Автосбор пистолета",
        KillAll = "Kill All (Убийца)",
        InfiniteJump = "Бесконечный прыжок",
        Fly = "Полет",
        Noclip = "Noclip (Сквозь стены)",
        WalkSpeed = "Скорость ходьбы",
        JumpPower = "Сила прыжка",
        TeleportMurderer = "Телепорт к убийце",
        TeleportSheriff = "Телепорт к шерифу",
        Debug = "🔍 Debug - Показать роли",
        Close = "Закрыть GUI",
        Language = "🌐 Язык: Русский",
        ON = "ВКЛ",
        OFF = "ВЫКЛ",
        -- Уведомления
        ScriptLoaded = "Скрипт загружен! Удачной игры!",
        TeleportTo = "Телепорт к",
        MurdererNotFound = "Убийца не найден!",
        SheriffNotFound = "Шериф не найден!",
        CharacterNotFound = "Твой персонаж не найден!",
        Error = "Ошибка",
        Teleport = "Телепорт",
        GunFound = "Пистолет найден и подобран!",
        DebugConsole = "Роли выведены в консоль (F9)",
        ClosingScript = "Все функции отключены. GUI закрыт."
    }
}

-- Функция получения текста на текущем языке
local function GetText(key)
    return Localization[Settings.Language][key] or key
end

local FlySpeed = 50
local Noclipping = nil
local FlingingConnection = nil

-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

-- Настройка GUI
ScreenGui.Name = "MM2GUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -275)
MainFrame.Size = UDim2.new(0, 400, 0, 550)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

-- Добавляем тень
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.Parent = MainFrame
Shadow.BackgroundTransparency = 1
Shadow.Position = UDim2.new(0, -15, 0, -15)
Shadow.Size = UDim2.new(1, 30, 1, 30)
Shadow.ZIndex = 0
Shadow.Image = "rbxassetid://6014261993"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.5
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(49, 49, 450, 450)

-- Добавляем обводку
local Stroke = Instance.new("UIStroke")
Stroke.Parent = MainFrame
Stroke.Color = Color3.fromRGB(200, 50, 50)
Stroke.Thickness = 2
Stroke.Transparency = 0.3

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, 0, 0, 60)
Title.Font = Enum.Font.GothamBold
Title.Text = GetText("Title")
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22
Title.TextStrokeTransparency = 0.8

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 15)
TitleCorner.Parent = Title

-- Градиент для заголовка
local TitleGradient = Instance.new("UIGradient")
TitleGradient.Parent = Title
TitleGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 50, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 30, 30))
}
TitleGradient.Rotation = 45

-- Версия скрипта
local Version = Instance.new("TextLabel")
Version.Name = "Version"
Version.Parent = Title
Version.BackgroundTransparency = 1
Version.Position = UDim2.new(1, -80, 0, 5)
Version.Size = UDim2.new(0, 75, 0, 20)
Version.Font = Enum.Font.GothamBold
Version.Text = "v1.0"
Version.TextColor3 = Color3.fromRGB(255, 255, 255)
Version.TextSize = 12
Version.TextTransparency = 0.3
Version.TextXAlignment = Enum.TextXAlignment.Right

-- Анимированный эмодзи в углу (вместо изображения)
local EmojiFrame = Instance.new("Frame")
EmojiFrame.Name = "EmojiFrame"
EmojiFrame.Parent = MainFrame
EmojiFrame.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
EmojiFrame.BorderSizePixel = 0
EmojiFrame.Position = UDim2.new(1, -120, 1, -120)
EmojiFrame.Size = UDim2.new(0, 100, 0, 100)
EmojiFrame.ZIndex = 10

local EmojiCorner = Instance.new("UICorner")
EmojiCorner.CornerRadius = UDim.new(0.5, 0)
EmojiCorner.Parent = EmojiFrame

-- Градиент для фона
local EmojiGradient = Instance.new("UIGradient")
EmojiGradient.Parent = EmojiFrame
EmojiGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 150)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 50, 100)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 30, 80))
}
EmojiGradient.Rotation = 45

-- Обводка
local EmojiStroke = Instance.new("UIStroke")
EmojiStroke.Parent = EmojiFrame
EmojiStroke.Color = Color3.fromRGB(255, 255, 255)
EmojiStroke.Thickness = 3
EmojiStroke.Transparency = 0.3

-- Эмодзи текст
local EmojiLabel = Instance.new("TextLabel")
EmojiLabel.Name = "Emoji"
EmojiLabel.Parent = EmojiFrame
EmojiLabel.BackgroundTransparency = 1
EmojiLabel.Size = UDim2.new(1, 0, 1, 0)
EmojiLabel.Font = Enum.Font.GothamBold
EmojiLabel.Text = "💕"
EmojiLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
EmojiLabel.TextSize = 50
EmojiLabel.TextStrokeTransparency = 0.5
EmojiLabel.ZIndex = 11

-- Массив эмодзи для смены
local emojis = {"💕", "✨", "🔪", "🎮", "⚡", "🌟", "💎", "🔥"}
local currentEmojiIndex = 1

-- Смена эмодзи каждые 2 секунды
spawn(function()
    while EmojiLabel and EmojiLabel.Parent do
        wait(2)
        currentEmojiIndex = currentEmojiIndex + 1
        if currentEmojiIndex > #emojis then
            currentEmojiIndex = 1
        end
        
        -- Анимация смены
        TweenService:Create(EmojiLabel, TweenInfo.new(0.2), {
            TextTransparency = 1,
            Rotation = 180
        }):Play()
        
        wait(0.2)
        EmojiLabel.Text = emojis[currentEmojiIndex]
        
        TweenService:Create(EmojiLabel, TweenInfo.new(0.2), {
            TextTransparency = 0,
            Rotation = 0
        }):Play()
    end
end)

-- Анимация покачивания
spawn(function()
    while EmojiFrame and EmojiFrame.Parent do
        TweenService:Create(EmojiFrame, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Position = UDim2.new(1, -120, 1, -130),
            Rotation = 10
        }):Play()
        wait(1)
        TweenService:Create(EmojiFrame, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Position = UDim2.new(1, -120, 1, -110),
            Rotation = -10
        }):Play()
        wait(1)
    end
end)

-- Пульсация размера
spawn(function()
    while EmojiFrame and EmojiFrame.Parent do
        TweenService:Create(EmojiFrame, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Size = UDim2.new(0, 110, 0, 110)
        }):Play()
        TweenService:Create(EmojiLabel, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            TextSize = 55
        }):Play()
        wait(0.8)
        TweenService:Create(EmojiFrame, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Size = UDim2.new(0, 100, 0, 100)
        }):Play()
        TweenService:Create(EmojiLabel, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            TextSize = 50
        }):Play()
        wait(0.8)
    end
end)

-- Вращение градиента
spawn(function()
    while EmojiGradient and EmojiGradient.Parent do
        TweenService:Create(EmojiGradient, TweenInfo.new(3, Enum.EasingStyle.Linear), {
            Rotation = 405
        }):Play()
        wait(3)
        EmojiGradient.Rotation = 45
    end
end)

-- Эффект свечения
local GlowEffect = Instance.new("ImageLabel")
GlowEffect.Name = "Glow"
GlowEffect.Parent = EmojiFrame
GlowEffect.BackgroundTransparency = 1
GlowEffect.Position = UDim2.new(0.5, -60, 0.5, -60)
GlowEffect.Size = UDim2.new(0, 120, 0, 120)
GlowEffect.Image = "rbxassetid://6014261993"
GlowEffect.ImageColor3 = Color3.fromRGB(255, 100, 200)
GlowEffect.ImageTransparency = 0.5
GlowEffect.ZIndex = 9

-- Анимация свечения
spawn(function()
    while GlowEffect and GlowEffect.Parent do
        TweenService:Create(GlowEffect, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            ImageTransparency = 0.3,
            Size = UDim2.new(0, 140, 0, 140),
            Rotation = 180
        }):Play()
        wait(1.5)
        TweenService:Create(GlowEffect, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            ImageTransparency = 0.7,
            Size = UDim2.new(0, 120, 0, 120),
            Rotation = 0
        }):Play()
        wait(1.5)
    end
end)

ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Parent = MainFrame
ScrollFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
ScrollFrame.BackgroundTransparency = 0.3
ScrollFrame.BorderSizePixel = 0
ScrollFrame.Position = UDim2.new(0, 15, 0, 75)
ScrollFrame.Size = UDim2.new(1, -30, 1, -90)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(200, 50, 50)

local ScrollCorner = Instance.new("UICorner")
ScrollCorner.CornerRadius = UDim.new(0, 10)
ScrollCorner.Parent = ScrollFrame

UIListLayout.Parent = ScrollFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Автоматическое изменение размера Canvas
UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
end)

-- Функция создания кнопки
local function CreateButton(text, callback)
    local button = Instance.new("TextButton")
    button.Parent = ScrollFrame
    button.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    button.BorderSizePixel = 0
    button.Size = UDim2.new(1, -20, 0, 45)
    button.Font = Enum.Font.GothamBold
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 15
    button.TextStrokeTransparency = 0.5
    button.AutoButtonColor = false
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 10)
    buttonCorner.Parent = button
    
    -- Градиент для кнопки
    local buttonGradient = Instance.new("UIGradient")
    buttonGradient.Parent = button
    buttonGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 45, 60))
    }
    buttonGradient.Rotation = 90
    
    -- Обводка кнопки
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Parent = button
    buttonStroke.Color = Color3.fromRGB(80, 80, 100)
    buttonStroke.Thickness = 1
    buttonStroke.Transparency = 0.3
    
    -- Анимация при наведении
    button.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        }):Play()
        game:GetService("TweenService"):Create(buttonStroke, TweenInfo.new(0.2), {
            Transparency = 0,
            Color = Color3.fromRGB(200, 50, 50)
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(35, 35, 50)
        }):Play()
        game:GetService("TweenService"):Create(buttonStroke, TweenInfo.new(0.2), {
            Transparency = 0.3,
            Color = Color3.fromRGB(80, 80, 100)
        }):Play()
    end)
    
    button.MouseButton1Click:Connect(callback)
    
    return button
end

-- Функция создания переключателя
local function CreateToggle(textKey, setting)
    local button = CreateButton(GetText(textKey) .. ": " .. GetText("OFF"), function() end)
    
    -- Индикатор состояния
    local indicator = Instance.new("Frame")
    indicator.Name = "Indicator"
    indicator.Parent = button
    indicator.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    indicator.BorderSizePixel = 0
    indicator.Position = UDim2.new(1, -55, 0.5, -10)
    indicator.Size = UDim2.new(0, 40, 0, 20)
    
    local indicatorCorner = Instance.new("UICorner")
    indicatorCorner.CornerRadius = UDim.new(1, 0)
    indicatorCorner.Parent = indicator
    
    local circle = Instance.new("Frame")
    circle.Name = "Circle"
    circle.Parent = indicator
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.BorderSizePixel = 0
    circle.Position = UDim2.new(0, 2, 0.5, -8)
    circle.Size = UDim2.new(0, 16, 0, 16)
    
    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = circle
    
    button.MouseButton1Click:Connect(function()
        Settings[setting] = not Settings[setting]
        button.Text = GetText(textKey) .. ": " .. (Settings[setting] and GetText("ON") or GetText("OFF"))
        
        if Settings[setting] then
            -- Звук включения
            local ToggleOnSound = Instance.new("Sound")
            ToggleOnSound.SoundId = "rbxassetid://6895079853" -- Звук включения
            ToggleOnSound.Volume = 0.3
            ToggleOnSound.Parent = game:GetService("SoundService")
            ToggleOnSound:Play()
            game:GetService("Debris"):AddItem(ToggleOnSound, 1)
            
            -- Анимация включения
            game:GetService("TweenService"):Create(indicator, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(50, 200, 50)
            }):Play()
            game:GetService("TweenService"):Create(circle, TweenInfo.new(0.3), {
                Position = UDim2.new(1, -18, 0.5, -8)
            }):Play()
            button.BackgroundColor3 = Color3.fromRGB(40, 60, 40)
        else
            -- Звук выключения
            local ToggleOffSound = Instance.new("Sound")
            ToggleOffSound.SoundId = "rbxassetid://6895079853" -- Звук выключения
            ToggleOffSound.Volume = 0.2
            ToggleOffSound.PlaybackSpeed = 0.8
            ToggleOffSound.Parent = game:GetService("SoundService")
            ToggleOffSound:Play()
            game:GetService("Debris"):AddItem(ToggleOffSound, 1)
            
            -- Анимация выключения
            game:GetService("TweenService"):Create(indicator, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            }):Play()
            game:GetService("TweenService"):Create(circle, TweenInfo.new(0.3), {
                Position = UDim2.new(0, 2, 0.5, -8)
            }):Play()
            button.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
        end
    end)
    
    return button
end

-- Функция обновления всех текстов
local function UpdateLanguage()
    -- Обновляем заголовок
    Title.Text = GetText("Title")
    
    -- Обновляем все кнопки
    for _, button in pairs(ScrollFrame:GetChildren()) do
        if button:IsA("TextButton") then
            local text = button.Text
            
            -- Определяем какая это кнопка и обновляем текст
            if text:find("ESP") and text:find("Player") or text:find("Подсветка игроков") then
                local state = Settings.ESP and GetText("ON") or GetText("OFF")
                button.Text = GetText("ESP") .. ": " .. state
            elseif text:find("Gun Drop ESP") or text:find("Подсветка пистолета") then
                local state = Settings.GunDropESP and GetText("ON") or GetText("OFF")
                button.Text = GetText("GunDropESP") .. ": " .. state
            elseif text:find("Show Roles") or text:find("Показать роли") then
                local state = Settings.ShowRoles and GetText("ON") or GetText("OFF")
                button.Text = GetText("ShowRoles") .. ": " .. state
            elseif text:find("Collect Coins") or text:find("Собирать монеты") then
                local state = Settings.CoinFarm and GetText("ON") or GetText("OFF")
                button.Text = GetText("CoinFarm") .. ": " .. state
            elseif text:find("Auto Collect Gun") or text:find("Автосбор пистолета") then
                local state = Settings.AutoCollectGun and GetText("ON") or GetText("OFF")
                button.Text = GetText("AutoCollectGun") .. ": " .. state
            elseif text:find("Kill All") then
                local state = Settings.KillAll and GetText("ON") or GetText("OFF")
                button.Text = GetText("KillAll") .. ": " .. state
            elseif text:find("Infinite Jump") or text:find("Бесконечный прыжок") then
                local state = Settings.InfiniteJump and GetText("ON") or GetText("OFF")
                button.Text = GetText("InfiniteJump") .. ": " .. state
            elseif text:find("Fly") or text:find("Полет") then
                if not text:find("Noclip") then
                    local state = Settings.Fly and GetText("ON") or GetText("OFF")
                    button.Text = GetText("Fly") .. ": " .. state
                end
            elseif text:find("Noclip") or text:find("Сквозь стены") then
                local state = Settings.Noclip and GetText("ON") or GetText("OFF")
                button.Text = GetText("Noclip") .. ": " .. state
            elseif text:find("Teleport to Murderer") or text:find("Телепорт к убийце") then
                button.Text = GetText("TeleportMurderer")
            elseif text:find("Teleport to Sheriff") or text:find("Телепорт к шерифу") then
                button.Text = GetText("TeleportSheriff")
            elseif text:find("Debug") then
                button.Text = GetText("Debug")
            elseif text:find("Close") or text:find("Закрыть") then
                button.Text = GetText("Close")
            elseif text:find("Language") or text:find("Язык") then
                button.Text = GetText("Language")
            end
        elseif button:IsA("Frame") then
            -- Обновляем слайдеры
            local label = button:FindFirstChildOfClass("TextLabel")
            if label then
                if label.Text:find("Walk Speed") or label.Text:find("Скорость ходьбы") then
                    label.Text = GetText("WalkSpeed") .. ": " .. Settings.WalkSpeed
                elseif label.Text:find("Jump Power") or label.Text:find("Сила прыжка") then
                    label.Text = GetText("JumpPower") .. ": " .. Settings.JumpPower
                end
            end
        end
    end
end

-- Функция создания слайдера
local function CreateSlider(text, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Parent = ScrollFrame
    frame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    frame.BorderSizePixel = 0
    frame.Size = UDim2.new(1, -20, 0, 70)
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 10)
    frameCorner.Parent = frame
    
    -- Градиент для фрейма
    local frameGradient = Instance.new("UIGradient")
    frameGradient.Parent = frame
    frameGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 45, 60))
    }
    frameGradient.Rotation = 90
    
    -- Обводка
    local frameStroke = Instance.new("UIStroke")
    frameStroke.Parent = frame
    frameStroke.Color = Color3.fromRGB(80, 80, 100)
    frameStroke.Thickness = 1
    frameStroke.Transparency = 0.3
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 15, 0, 8)
    label.Size = UDim2.new(1, -30, 0, 25)
    label.Font = Enum.Font.GothamBold
    label.Text = text .. ": " .. default
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextStrokeTransparency = 0.5
    
    local slider = Instance.new("TextButton")
    slider.Parent = frame
    slider.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    slider.BorderSizePixel = 0
    slider.Position = UDim2.new(0, 15, 0, 40)
    slider.Size = UDim2.new(1, -30, 0, 20)
    slider.Text = ""
    slider.AutoButtonColor = false
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(1, 0)
    sliderCorner.Parent = slider
    
    local fill = Instance.new("Frame")
    fill.Parent = slider
    fill.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    fill.BorderSizePixel = 0
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill
    
    -- Градиент для заполнения
    local fillGradient = Instance.new("UIGradient")
    fillGradient.Parent = fill
    fillGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 50, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 80, 80))
    }
    
    local dragging = false
    
    slider.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = input.Position.X
            local sliderPos = slider.AbsolutePosition.X
            local sliderSize = slider.AbsoluteSize.X
            local percent = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
            local value = math.floor(min + (max - min) * percent)
            
            game:GetService("TweenService"):Create(fill, TweenInfo.new(0.1), {
                Size = UDim2.new(percent, 0, 1, 0)
            }):Play()
            
            label.Text = text .. ": " .. value
            callback(value)
        end
    end)
    
    return frame
end

-- Функция определения роли игрока
local function GetPlayerRole(player)
    if not player or not player.Character then
        return "Innocent", Color3.fromRGB(0, 255, 0)
    end
    
    local char = player.Character
    local backpack = player:FindFirstChild("Backpack")
    
    -- Проверка в персонаже
    if char:FindFirstChild("Knife") or (backpack and backpack:FindFirstChild("Knife")) then
        return "MURDERER", Color3.fromRGB(255, 0, 0)
    end
    
    if char:FindFirstChild("Gun") or (backpack and backpack:FindFirstChild("Gun")) then
        return "Sheriff", Color3.fromRGB(0, 100, 255)
    end
    
    -- Проверка через PlayerGui
    local playerGui = player:FindFirstChild("PlayerGui")
    if playerGui then
        -- Проверка на нож в GUI
        for _, gui in pairs(playerGui:GetDescendants()) do
            if gui.Name == "Knife" or (gui:IsA("ImageLabel") and gui.Image:find("knife")) then
                return "MURDERER", Color3.fromRGB(255, 0, 0)
            end
            if gui.Name == "Gun" or (gui:IsA("ImageLabel") and gui.Image:find("gun")) then
                return "Sheriff", Color3.fromRGB(0, 100, 255)
            end
        end
    end
    
    return "Innocent", Color3.fromRGB(0, 255, 0)
end

-- ESP функция
local function UpdateESP()
    -- Удаляем старые ESP
    for _, v in pairs(Workspace:GetDescendants()) do
        if v.Name == "ESPBox" or v.Name == "ESPLabel" then
            v:Destroy()
        end
    end
    
    if not Settings.ESP then return end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local char = player.Character
            local hrp = char.HumanoidRootPart
            
            -- Создаем BillboardGui
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "ESPLabel"
            billboard.Parent = hrp
            billboard.AlwaysOnTop = true
            billboard.Size = UDim2.new(0, 100, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            
            local label = Instance.new("TextLabel")
            label.Parent = billboard
            label.BackgroundTransparency = 1
            label.Size = UDim2.new(1, 0, 1, 0)
            label.Font = Enum.Font.GothamBold
            label.TextSize = 14
            label.TextStrokeTransparency = 0
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            
            -- Определяем роль
            local role, color = GetPlayerRole(player)
            
            label.Text = player.Name .. "\n" .. role
            label.TextColor3 = color
            
            -- Highlight
            local highlight = Instance.new("Highlight")
            highlight.Name = "ESPBox"
            highlight.Parent = char
            highlight.FillColor = color
            highlight.OutlineColor = color
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0
        end
    end
end

-- Coin Farm функция
local function CoinFarm()
    spawn(function()
        while Settings.CoinFarm do
            wait(0.1)
            pcall(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    for _, coin in pairs(Workspace:GetDescendants()) do
                        if coin.Name == "Coin" or coin.Name == "CoinContainer" or (coin:IsA("Model") and coin:FindFirstChild("Coin")) then
                            local coinPart = coin:IsA("BasePart") and coin or coin:FindFirstChildWhichIsA("BasePart")
                            if coinPart then
                                LocalPlayer.Character.HumanoidRootPart.CFrame = coinPart.CFrame
                                wait(0.1)
                            end
                        end
                    end
                end
            end)
        end
    end)
end

-- Kill All функция (только для убийцы)
local function KillAll()
    spawn(function()
        while Settings.KillAll do
            wait(0.1)
            pcall(function()
                local char = LocalPlayer.Character
                local myRole = GetPlayerRole(LocalPlayer)
                
                if myRole == "MURDERER" and char and char:FindFirstChild("HumanoidRootPart") then
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local targetHRP = player.Character.HumanoidRootPart
                            char.HumanoidRootPart.CFrame = targetHRP.CFrame
                            wait(0.5)
                        end
                    end
                end
            end)
        end
    end)
end

-- Infinite Jump
local function InfiniteJump()
    if Settings.InfiniteJump then
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if Settings.InfiniteJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end

-- Fly функция
local function Fly()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    local hrp = char.HumanoidRootPart
    local humanoid = char:FindFirstChild("Humanoid")
    
    if Settings.Fly then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Name = "FlyVelocity"
        bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = hrp
        
        local bodyGyro = Instance.new("BodyGyro")
        bodyGyro.Name = "FlyGyro"
        bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.P = 9e4
        bodyGyro.CFrame = hrp.CFrame
        bodyGyro.Parent = hrp
        
        spawn(function()
            local mouse = LocalPlayer:GetMouse()
            while Settings.Fly and char and hrp do
                wait()
                local cam = Workspace.CurrentCamera
                local direction = Vector3.new()
                
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                    direction = direction + (cam.CFrame.LookVector)
                end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                    direction = direction - (cam.CFrame.LookVector)
                end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
                    direction = direction - (cam.CFrame.RightVector)
                end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
                    direction = direction + (cam.CFrame.RightVector)
                end
                
                bodyVelocity.Velocity = direction * FlySpeed
                bodyGyro.CFrame = cam.CFrame
            end
            
            if hrp:FindFirstChild("FlyVelocity") then hrp.FlyVelocity:Destroy() end
            if hrp:FindFirstChild("FlyGyro") then hrp.FlyGyro:Destroy() end
        end)
    else
        if hrp:FindFirstChild("FlyVelocity") then hrp.FlyVelocity:Destroy() end
        if hrp:FindFirstChild("FlyGyro") then hrp.FlyGyro:Destroy() end
    end
end

-- Noclip функция
local function Noclip()
    if Settings.Noclip then
        Noclipping = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if Noclipping then
            Noclipping:Disconnect()
            Noclipping = nil
        end
    end
end

-- Auto Collect Gun функция
local function AutoCollectGun()
    spawn(function()
        while Settings.AutoCollectGun do
            wait(0.5) -- Увеличил задержку для меньших лагов
            pcall(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = LocalPlayer.Character.HumanoidRootPart
                    local myRole = GetPlayerRole(LocalPlayer)
                    
                    -- Ищем упавший пистолет только если мы не убийца и не шериф
                    if myRole == "Innocent" then
                        local gunFound = false
                        
                        -- Метод 1: Поиск по папке GunDrop (самый быстрый)
                        local gunDropFolder = Workspace:FindFirstChild("GunDrop")
                        if gunDropFolder then
                            for _, item in pairs(gunDropFolder:GetChildren()) do
                                if item:IsA("Model") or item:IsA("Tool") or item:IsA("BasePart") then
                                    local gunPart = item:IsA("BasePart") and item or item:FindFirstChildWhichIsA("BasePart")
                                    if gunPart then
                                        hrp.CFrame = gunPart.CFrame
                                        gunFound = true
                                        
                                        game.StarterGui:SetCore("SendNotification", {
                                            Title = "Auto Collect Gun";
                                            Text = GetText("GunFound");
                                            Duration = 2;
                                        })
                                        
                                        wait(1)
                                        break
                                    end
                                end
                            end
                        end
                        
                        -- Метод 2: Поиск в Normal (некоторые карты)
                        if not gunFound then
                            local normalFolder = Workspace:FindFirstChild("Normal")
                            if normalFolder then
                                local gunDrop = normalFolder:FindFirstChild("GunDrop")
                                if gunDrop then
                                    local gunPart = gunDrop:FindFirstChildWhichIsA("BasePart")
                                    if gunPart then
                                        hrp.CFrame = gunPart.CFrame
                                        gunFound = true
                                        
                                        game.StarterGui:SetCore("SendNotification", {
                                            Title = "Auto Collect Gun";
                                            Text = GetText("GunFound");
                                            Duration = 2;
                                        })
                                        
                                        wait(1)
                                    end
                                end
                            end
                        end
                        
                        -- Метод 3: Быстрый поиск только по верхнему уровню Workspace
                        if not gunFound then
                            for _, item in pairs(Workspace:GetChildren()) do
                                if item.Name == "GunDrop" then
                                    local gunPart = item:IsA("BasePart") and item or item:FindFirstChildWhichIsA("BasePart")
                                    if gunPart then
                                        hrp.CFrame = gunPart.CFrame
                                        gunFound = true
                                        
                                        game.StarterGui:SetCore("SendNotification", {
                                            Title = "Auto Collect Gun";
                                            Text = GetText("GunFound");
                                            Duration = 2;
                                        })
                                        
                                        wait(1)
                                        break
                                    end
                                end
                            end
                        end
                    else
                        -- Если мы уже шериф, отключаем автосбор
                        if myRole == "Sheriff" then
                            Settings.AutoCollectGun = false
                            
                            -- Обновляем кнопку
                            for _, button in pairs(ScrollFrame:GetChildren()) do
                                if button:IsA("TextButton") and (button.Text:find("Auto Collect Gun") or button.Text:find("Автосбор пистолета")) then
                                    button.Text = GetText("AutoCollectGun") .. ": " .. GetText("OFF")
                                    button.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
                                    break
                                end
                            end
                            
                            game.StarterGui:SetCore("SendNotification", {
                                Title = "Auto Collect Gun";
                                Text = "You are Sheriff! Auto collect disabled.";
                                Duration = 3;
                            })
                        end
                    end
                end
            end)
        end
    end)
end

-- Gun Drop ESP функция
local function UpdateGunDropESP()
    -- Удаляем старые ESP для пистолета
    for _, v in pairs(Workspace:GetDescendants()) do
        if v.Name == "GunESPBox" or v.Name == "GunESPLabel" or v.Name == "GunESPBeam" then
            v:Destroy()
        end
    end
    
    if not Settings.GunDropESP then return end
    
    pcall(function()
        -- Ищем упавший пистолет
        for _, item in pairs(Workspace:GetDescendants()) do
            if item.Name == "GunDrop" or item.Name == "Gun" or item.Name == "Revolver" then
                local gunPart = nil
                
                if item:IsA("Model") or item:IsA("Tool") then
                    gunPart = item:FindFirstChildWhichIsA("BasePart")
                elseif item:IsA("BasePart") then
                    gunPart = item
                end
                
                if gunPart and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    -- Создаем BillboardGui
                    local billboard = Instance.new("BillboardGui")
                    billboard.Name = "GunESPLabel"
                    billboard.Parent = gunPart
                    billboard.AlwaysOnTop = true
                    billboard.Size = UDim2.new(0, 200, 0, 50)
                    billboard.StudsOffset = Vector3.new(0, 2, 0)
                    
                    local label = Instance.new("TextLabel")
                    label.Parent = billboard
                    label.BackgroundTransparency = 1
                    label.Size = UDim2.new(1, 0, 1, 0)
                    label.Font = Enum.Font.GothamBold
                    label.TextSize = 16
                    label.TextStrokeTransparency = 0
                    label.TextColor3 = Color3.fromRGB(255, 215, 0)
                    
                    -- Вычисляем расстояние
                    local distance = (LocalPlayer.Character.HumanoidRootPart.Position - gunPart.Position).Magnitude
                    label.Text = "🔫 ПИСТОЛЕТ 🔫\n" .. math.floor(distance) .. " studs"
                    
                    -- Highlight для пистолета
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "GunESPBox"
                    highlight.Parent = gunPart
                    highlight.FillColor = Color3.fromRGB(255, 215, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 215, 0)
                    highlight.FillTransparency = 0.3
                    highlight.OutlineTransparency = 0
                    
                    -- Создаем луч от игрока к пистолету
                    local attachment0 = Instance.new("Attachment")
                    attachment0.Name = "GunESPBeam"
                    attachment0.Parent = LocalPlayer.Character.HumanoidRootPart
                    
                    local attachment1 = Instance.new("Attachment")
                    attachment1.Name = "GunESPBeam"
                    attachment1.Parent = gunPart
                    
                    local beam = Instance.new("Beam")
                    beam.Name = "GunESPBeam"
                    beam.Parent = LocalPlayer.Character.HumanoidRootPart
                    beam.Attachment0 = attachment0
                    beam.Attachment1 = attachment1
                    beam.Color = ColorSequence.new(Color3.fromRGB(255, 215, 0))
                    beam.Width0 = 0.5
                    beam.Width1 = 0.5
                    beam.FaceCamera = true
                    
                    -- Обновляем расстояние каждую секунду
                    spawn(function()
                        while Settings.GunDropESP and gunPart and gunPart.Parent and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") do
                            wait(0.5)
                            local newDistance = (LocalPlayer.Character.HumanoidRootPart.Position - gunPart.Position).Magnitude
                            if label and label.Parent then
                                label.Text = "🔫 ПИСТОЛЕТ 🔫\n" .. math.floor(newDistance) .. " studs"
                            end
                        end
                    end)
                end
            end
        end
        
        -- Метод 2: Поиск по папке GunDrop
        local gunDropFolder = Workspace:FindFirstChild("GunDrop")
        if gunDropFolder then
            for _, gunPart in pairs(gunDropFolder:GetDescendants()) do
                if gunPart:IsA("BasePart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    -- Проверяем, нет ли уже ESP на этом объекте
                    if not gunPart:FindFirstChild("GunESPLabel") then
                        local billboard = Instance.new("BillboardGui")
                        billboard.Name = "GunESPLabel"
                        billboard.Parent = gunPart
                        billboard.AlwaysOnTop = true
                        billboard.Size = UDim2.new(0, 200, 0, 50)
                        billboard.StudsOffset = Vector3.new(0, 2, 0)
                        
                        local label = Instance.new("TextLabel")
                        label.Parent = billboard
                        label.BackgroundTransparency = 1
                        label.Size = UDim2.new(1, 0, 1, 0)
                        label.Font = Enum.Font.GothamBold
                        label.TextSize = 16
                        label.TextStrokeTransparency = 0
                        label.TextColor3 = Color3.fromRGB(255, 215, 0)
                        
                        local distance = (LocalPlayer.Character.HumanoidRootPart.Position - gunPart.Position).Magnitude
                        label.Text = "🔫 ПИСТОЛЕТ 🔫\n" .. math.floor(distance) .. " studs"
                        
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "GunESPBox"
                        highlight.Parent = gunPart
                        highlight.FillColor = Color3.fromRGB(255, 215, 0)
                        highlight.OutlineColor = Color3.fromRGB(255, 215, 0)
                        highlight.FillTransparency = 0.3
                        highlight.OutlineTransparency = 0
                    end
                end
            end
        end
    end)
end

-- Создание кнопок
CreateButton(GetText("Language"), function()
    -- Звук смены языка
    local LangSound = Instance.new("Sound")
    LangSound.SoundId = "rbxassetid://6895079853"
    LangSound.Volume = 0.3
    LangSound.PlaybackSpeed = 1.2
    LangSound.Parent = game:GetService("SoundService")
    LangSound:Play()
    game:GetService("Debris"):AddItem(LangSound, 1)
    
    -- Переключаем язык
    if Settings.Language == "English" then
        Settings.Language = "Russian"
    else
        Settings.Language = "English"
    end
    
    -- Обновляем все тексты
    UpdateLanguage()
    
    game.StarterGui:SetCore("SendNotification", {
        Title = "Language / Язык";
        Text = "Language changed to " .. Settings.Language .. " / Язык изменен на " .. Settings.Language;
        Duration = 3;
    })
end)

CreateToggle("ESP", "ESP")
CreateToggle("GunDropESP", "GunDropESP")
CreateToggle("ShowRoles", "ShowRoles")
CreateToggle("CoinFarm", "CoinFarm")
CreateToggle("AutoCollectGun", "AutoCollectGun")
CreateToggle("KillAll", "KillAll")
CreateToggle("InfiniteJump", "InfiniteJump")
CreateToggle("Fly", "Fly")
CreateToggle("Noclip", "Noclip")

CreateSlider(GetText("WalkSpeed"), 16, 200, 16, function(value)
    Settings.WalkSpeed = value
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)

CreateSlider(GetText("JumpPower"), 50, 200, 50, function(value)
    Settings.JumpPower = value
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = value
    end
end)

CreateButton(GetText("TeleportMurderer"), function()
    pcall(function()
        if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            game.StarterGui:SetCore("SendNotification", {
                Title = GetText("Error");
                Text = GetText("CharacterNotFound");
                Duration = 3;
            })
            return
        end
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local role = GetPlayerRole(player)
                if role == "MURDERER" and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                    game.StarterGui:SetCore("SendNotification", {
                        Title = GetText("Teleport");
                        Text = GetText("TeleportTo") .. ": " .. player.Name;
                        Duration = 3;
                    })
                    return
                end
            end
        end
        
        game.StarterGui:SetCore("SendNotification", {
            Title = GetText("Error");
            Text = GetText("MurdererNotFound");
            Duration = 3;
        })
    end)
end)

CreateButton(GetText("TeleportSheriff"), function()
    pcall(function()
        if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            game.StarterGui:SetCore("SendNotification", {
                Title = GetText("Error");
                Text = GetText("CharacterNotFound");
                Duration = 3;
            })
            return
        end
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local role = GetPlayerRole(player)
                if role == "Sheriff" and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                    game.StarterGui:SetCore("SendNotification", {
                        Title = GetText("Teleport");
                        Text = GetText("TeleportTo") .. ": " .. player.Name;
                        Duration = 3;
                    })
                    return
                end
            end
        end
        
        game.StarterGui:SetCore("SendNotification", {
            Title = GetText("Error");
            Text = GetText("SheriffNotFound");
            Duration = 3;
        })
    end)
end)

CreateButton(GetText("Debug"), function()
    print("\n========== РОЛИ ИГРОКОВ ==========")
    for _, player in pairs(Players:GetPlayers()) do
        local role, color = GetPlayerRole(player)
        print(player.Name .. " = " .. role)
        
        -- Проверяем что есть в персонаже
        if player.Character then
            print("  В персонаже:")
            for _, item in pairs(player.Character:GetChildren()) do
                if item.Name == "Knife" or item.Name == "Gun" then
                    print("    - " .. item.Name)
                end
            end
        end
        
        -- Проверяем Backpack
        if player:FindFirstChild("Backpack") then
            print("  В рюкзаке:")
            for _, item in pairs(player.Backpack:GetChildren()) do
                if item.Name == "Knife" or item.Name == "Gun" then
                    print("    - " .. item.Name)
                end
            end
        end
    end
    print("========== КОНЕЦ ==========\n")
    
    game.StarterGui:SetCore("SendNotification", {
        Title = "Debug";
        Text = GetText("DebugConsole");
        Duration = 3;
    })
end)

CreateButton(GetText("Close"), function()
    -- Звук закрытия
    local CloseSound = Instance.new("Sound")
    CloseSound.SoundId = "rbxassetid://6895079853"
    CloseSound.Volume = 0.4
    CloseSound.PlaybackSpeed = 0.6
    CloseSound.Parent = game:GetService("SoundService")
    CloseSound:Play()
    
    Settings.ESP = false
    Settings.CoinFarm = false
    Settings.KillAll = false
    Settings.Fly = false
    Settings.Noclip = false
    Settings.AutoCollectGun = false
    Settings.GunDropESP = false
    UpdateESP()
    UpdateGunDropESP()
    
    -- Анимация закрытия
    -- 1. Затемнение
    local Overlay = Instance.new("Frame")
    Overlay.Name = "CloseOverlay"
    Overlay.Parent = ScreenGui
    Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Overlay.BackgroundTransparency = 1
    Overlay.BorderSizePixel = 0
    Overlay.Size = UDim2.new(1, 0, 1, 0)
    Overlay.ZIndex = 100
    
    TweenService:Create(Overlay, TweenInfo.new(0.3), {
        BackgroundTransparency = 0.5
    }):Play()
    
    -- 2. Вращение и уменьшение главного фрейма
    TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Rotation = 180
    }):Play()
    
    -- 3. Исчезновение эмодзи виджета
    if EmojiFrame then
        TweenService:Create(EmojiFrame, TweenInfo.new(0.4), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(1, -60, 1, -60),
            Rotation = 360,
            BackgroundTransparency = 1
        }):Play()
        
        if EmojiLabel then
            TweenService:Create(EmojiLabel, TweenInfo.new(0.4), {
                TextTransparency = 1
            }):Play()
        end
    end
    
    -- 4. Эффект частиц (звездочки)
    for i = 1, 20 do
        local particle = Instance.new("Frame")
        particle.Parent = ScreenGui
        particle.BackgroundColor3 = Color3.fromRGB(255, math.random(100, 255), math.random(100, 255))
        particle.BorderSizePixel = 0
        particle.Position = UDim2.new(0.5, 0, 0.5, 0)
        particle.Size = UDim2.new(0, 10, 0, 10)
        particle.ZIndex = 101
        
        local particleCorner = Instance.new("UICorner")
        particleCorner.CornerRadius = UDim.new(1, 0)
        particleCorner.Parent = particle
        
        local angle = math.rad(i * 18)
        local distance = math.random(100, 300)
        local targetX = 0.5 + math.cos(angle) * distance / 1920
        local targetY = 0.5 + math.sin(angle) * distance / 1080
        
        TweenService:Create(particle, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(targetX, 0, targetY, 0),
            Size = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            Rotation = math.random(0, 360)
        }):Play()
        
        game:GetService("Debris"):AddItem(particle, 1)
    end
    
    wait(0.5)
    
    game.StarterGui:SetCore("SendNotification", {
        Title = "Murder Mystery 2";
        Text = GetText("ClosingScript");
        Duration = 3;
    })
    
    ScreenGui:Destroy()
end)

-- Обработчики
local espButton = ScrollFrame:FindFirstChild("TextButton")
if espButton then
    espButton.MouseButton1Click:Connect(UpdateESP)
end

-- Постоянное обновление ESP
spawn(function()
    while wait(1) do
        if Settings.ESP then
            UpdateESP()
        end
    end
end)

-- Постоянное обновление Gun Drop ESP
spawn(function()
    while wait(1) do
        if Settings.GunDropESP then
            UpdateGunDropESP()
        end
    end
end)

-- Обработчик для CoinFarm
spawn(function()
    while wait(0.5) do
        if Settings.CoinFarm then
            CoinFarm()
        end
    end
end)

-- Обработчик для KillAll
spawn(function()
    while wait(0.5) do
        if Settings.KillAll then
            KillAll()
        end
    end
end)

-- Обработчик для AutoCollectGun
spawn(function()
    while wait(0.5) do
        if Settings.AutoCollectGun then
            AutoCollectGun()
        end
    end
end)

-- Обработчик для Fly
spawn(function()
    while wait(0.5) do
        pcall(function()
            local flyButton = nil
            for _, button in pairs(ScrollFrame:GetChildren()) do
                if button:IsA("TextButton") and button.Text:find("Fly") then
                    flyButton = button
                    break
                end
            end
            
            if flyButton then
                flyButton.MouseButton1Click:Connect(function()
                    wait(0.1)
                    Fly()
                end)
            end
        end)
        break
    end
end)

-- Обработчик для Noclip
spawn(function()
    while wait(0.5) do
        pcall(function()
            local noclipButton = nil
            for _, button in pairs(ScrollFrame:GetChildren()) do
                if button:IsA("TextButton") and button.Text:find("Noclip") then
                    noclipButton = button
                    break
                end
            end
            
            if noclipButton then
                noclipButton.MouseButton1Click:Connect(function()
                    wait(0.1)
                    Noclip()
                end)
            end
        end)
        break
    end
end)

-- Обработчик для InfiniteJump
InfiniteJump()

-- Постоянное применение скорости и прыжка
spawn(function()
    while wait(0.5) do
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = Settings.WalkSpeed
                LocalPlayer.Character.Humanoid.JumpPower = Settings.JumpPower
            end
        end)
    end
end)

-- Уведомление
game.StarterGui:SetCore("SendNotification", {
    Title = "Murder Mystery 2";
    Text = GetText("ScriptLoaded");
    Duration = 5;
})

print("Murder Mystery 2 Script загружен!")

end -- Конец функции LoadMainScript

-- [[ MENÜ AÇMA / KAPATMA KONTROLÜ ]] --
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        -- Insert tuşu kontrolü
        if input.KeyCode == Enum.KeyCode.Insert then
            MainFrame.Visible = not MainFrame.Visible
        end
    end
end)

-- Hileyi başlatan ana komut (Zaten sendeydi)
LoadMainScript()
LoadMainScript()
