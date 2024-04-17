--[[
    >rinichi >> did 50% of the work
    >weda >> did 50% of the work

    >fixed by desktop
]]
--[[
if getgenv().azureloaded then
    return
end

getgenv().azureloaded = true]]

local loadtick = tick()

repeat 
    wait()
until game:IsLoaded()

game:GetService("StarterGui"):SetCore("SendNotification",{Title = "azure (temporary notif)",Text = "loading",Duration = 3.6})

local gamerawmetatable = getrawmetatable(game)
setreadonly(gamerawmetatable, false)

old__namecall1 = gamerawmetatable.__namecall;gamerawmetatable.__namecall = newcclosure(function(self, ...)
    local args = {...}
    if tostring(args[1]) == "TeleportDetect" then
        return
    elseif tostring(args[1]) == "CHECKER_1" then
        return
    elseif tostring(args[1]) == "CHECKER" then
        return
    elseif tostring(args[1]) == "GUI_CHECK" then
        return
    elseif tostring(args[1]) == "OneMoreTime" then
        return
    elseif tostring(args[1]) == "checkingSPEED" then
        return
    elseif tostring(args[1]) == "BANREMOTE" then
        return
    elseif tostring(args[1]) == "PERMAIDBAN" then
        return
    elseif tostring(args[1]) == "KICKREMOTE" then
        return
    elseif tostring(args[1]) == "BR_KICKPC" then
        return
    elseif tostring(args[1]) == "BR_KICKMOBILE" then
        return
    end
    return old__namecall1(self, ...)
end)

function retlibrary()

-- // Variables
local ws = game:GetService("Workspace")
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local hs = game:GetService("HttpService")
local plrs = game:GetService("Players")
local stats = game:GetService("Stats")
-- UI Variables
getgenv().library = {
    drawings = {},
    hidden = {},
    connections = {},
    pointers = {},
    began = {},
    changed = {},
    ended = {},
    colors = {},
    folders = {
        main = "azure",
        assets = "azure/assets",
        configs = "azure/configs"
    },
    shared = {
        initialized = false,
        fps = 0,
        ping = 0
    }
}
--
for i,v in pairs(library.folders) do
    makefolder(v)
end
--
local utility = {}
local pages = {}
local sections = {}
local theme = {
    accent = Color3.fromRGB(168,122,207),
    lightcontrast = Color3.fromRGB(30, 30, 30),
    darkcontrast = Color3.fromRGB(25, 25, 25),
    outline = Color3.fromRGB(0, 0, 0),
    inline = Color3.fromRGB(50, 50, 50),
    textcolor = Color3.fromRGB(255, 255, 255),
    textborder = Color3.fromRGB(0, 0, 0),
    indevcolor = Color3.fromRGB(164, 219, 232),
    font = Drawing.Fonts.Plex,
    textsize = 13
}
-- // Utility Functions
do
    function utility:Size(xScale,xOffset,yScale,yOffset,instance)
        if instance then
            local x = xScale*instance.Size.x+xOffset
            local y = yScale*instance.Size.y+yOffset
            --
            return Vector2.new(x,y)
        else
            local vx,vy = ws.CurrentCamera.ViewportSize.x,ws.CurrentCamera.ViewportSize.y
            --
            local x = xScale*vx+xOffset
            local y = yScale*vy+yOffset
            --
            return Vector2.new(x,y)
        end
    end
    --
    function utility:Position(xScale,xOffset,yScale,yOffset,instance)
        if instance then
            local x = instance.Position.x+xScale*instance.Size.x+xOffset
            local y = instance.Position.y+yScale*instance.Size.y+yOffset
            --
            return Vector2.new(x,y)
        else
            local vx,vy = ws.CurrentCamera.ViewportSize.x,ws.CurrentCamera.ViewportSize.y
            --
            local x = xScale*vx+xOffset
            local y = yScale*vy+yOffset
            --
            return Vector2.new(x,y)
        end
    end
    --
    function utility:CreateInstance(instanceType, properties)
        local instance = Instance.new(instanceType)
        if type(properties) == "table" then
            for property, value in next, properties do
                instance[property] = value
            end
        end
        return instance
    end
    --
	function utility:Create(instanceType, instanceOffset, instanceProperties, instanceParent)
        local instanceType = instanceType or "Frame"
        local instanceOffset = instanceOffset or {Vector2.new(0,0)}
        local instanceProperties = instanceProperties or {}
        local instanceHidden = false
        local instance = nil
        --
		if instanceType == "Frame" or instanceType == "frame" then
            local frame = Drawing.new("Square")
            frame.Visible = true
            frame.Filled = true
            frame.Thickness = 0
            frame.Color = Color3.fromRGB(255,255,255)
            frame.Size = Vector2.new(100,100)
            frame.Position = Vector2.new(0,0)
            frame.ZIndex = 1000
            frame.Transparency = library.shared.initialized and 1 or 0
            instance = frame
        elseif instanceType == "TextLabel" or instanceType == "textlabel" then
            local text = Drawing.new("Text")
            text.Font = 3
            text.Visible = true
            text.Outline = true
            text.Center = false
            text.Color = Color3.fromRGB(255,255,255)
            text.ZIndex = 1000
            text.Transparency = library.shared.initialized and 1 or 0
            instance = text
        elseif instanceType == "Triangle" or instanceType == "triangle" then
            local frame = Drawing.new("Triangle")
            frame.Visible = true
            frame.Filled = true
            frame.Thickness = 0
            frame.Color = Color3.fromRGB(255,255,255)
            frame.ZIndex = 1000
            frame.Transparency = library.shared.initialized and 1 or 0
            instance = frame
        elseif instanceType == "Image" or instanceType == "image" then
            local image = Drawing.new("Image")
            image.Size = Vector2.new(12,19)
            image.Position = Vector2.new(0,0)
            image.Visible = true
            image.ZIndex = 1000
            image.Transparency = library.shared.initialized and 1 or 0
            instance = image
        elseif instanceType == "Circle" or instanceType == "circle" then
            local circle = Drawing.new("Circle")
            circle.Visible = false
            circle.Color = Color3.fromRGB(255, 0, 0)
            circle.Thickness = 1
            circle.NumSides = 30
            circle.Filled = true
            circle.Transparency = 1
            circle.ZIndex = 1000
            circle.Radius = 50
            circle.Transparency = library.shared.initialized and 1 or 0
            instance = circle
        elseif instanceType == "Quad" or instanceType == "quad" then
            local quad = Drawing.new("Quad")
            quad.Visible = false
            quad.Color = Color3.fromRGB(255, 255, 255)
            quad.Thickness = 1.5
            quad.Transparency = 1
            quad.ZIndex = 1000
            quad.Filled = false
            quad.Transparency = library.shared.initialized and 1 or 0
            instance = quad
        elseif instanceType == "Line" or instanceType == "line" then
            local line = Drawing.new("Line")
            line.Visible = false
            line.Color = Color3.fromRGB(255, 255, 255)
            line.Thickness = 1.5
            line.Transparency = 1
            line.Thickness = 1.5
            line.ZIndex = 1000
            line.Transparency = library.shared.initialized and 1 or 0
            instance = line
        end
        --
        if instance then
            for i, v in pairs(instanceProperties) do
                if (i == "Hidden" or i == "hidden") then
                    instanceHidden = v
                else
                    if library.shared.initialized then
                        instance[i] = v
                    elseif i ~= "Transparency" then
                        instance[i] = v
                    end
                end
                --[[if typeof(v) == "Color3" then
                    local found_theme = utility:Find(theme, v)
                    if found_theme then
                        themes[found_theme] = themes[found_theme] or {}
                        themes[found_theme][i] = themes[found_theme][i]
                        table.insert(themes[found_theme][i], instance)
                    end
                end]]
            end
            --
            if not instanceHidden then
                library.drawings[#library.drawings + 1] = {instance, instanceOffset, instanceProperties["Transparency"] or 1}
            else
                library.hidden[#library.hidden + 1] = {instance, instanceOffset, instanceProperties["Transparency"] or 1}
            end
            --
            if instanceParent then
                instanceParent[#instanceParent + 1] = instance
            end
            --
            return instance
        end
	end
    --
    function utility:UpdateOffset(instance, instanceOffset)
        for i,v in pairs(library.drawings) do
            if v[1] == instance then
                v[2] = instanceOffset
                return
            end
        end
    end
    --
    function utility:UpdateTransparency(instance, instanceTransparency)
        for i,v in pairs(library.drawings) do
            if v[1] == instance then
                v[3] = instanceTransparency
                return
            end
        end
    end
    --
    function utility:Remove(instance, hidden)
        library.colors[instance] = nil
        --
        local ind = 0
        --
        for i,v in pairs(hidden and library.hidden or library.drawings) do
            if v[1] == instance then
                v[1] = nil
                v[2] = nil
                table.remove(hidden and library.hidden or library.drawings, i)
                break
            end
        end
        instance:Remove()
    end
    --
    function utility:GetSubPrefix(str)
        local str = tostring(str):gsub(" ","")
        local var = ""
        --
        if #str == 2 then
            local sec = string.sub(str,#str,#str+1)
            var = sec == "1" and "st" or sec == "2" and "nd" or sec == "3" and "rd" or "th"
        end
        --
        return var
    end
    --
    function utility:Connection(connectionType, connectionCallback)
        local connection = connectionType:Connect(connectionCallback)
        library.connections[#library.connections + 1] = connection
        --
        return connection
    end
    --
    function utility:Disconnect(connection)
        for i,v in pairs(library.connections) do
            if v == connection then
                library.connections[i] = nil
                v:Disconnect()
            end
        end
    end
    --
    function utility:MouseLocation()
        return uis:GetMouseLocation()
    end
    --
    function utility:MouseOverDrawing(values, valuesAdd)
        local valuesAdd = valuesAdd or {}
        local values = {
            (values[1] or 0) + (valuesAdd[1] or 0),
            (values[2] or 0) + (valuesAdd[2] or 0),
            (values[3] or 0) + (valuesAdd[3] or 0),
            (values[4] or 0) + (valuesAdd[4] or 0)
        }
        --
        local mouseLocation = utility:MouseLocation()
	    return (mouseLocation.x >= values[1] and mouseLocation.x <= (values[1] + (values[3] - values[1]))) and (mouseLocation.y >= values[2] and mouseLocation.y <= (values[2] + (values[4] - values[2])))
    end
    --
    function utility:GetTextBounds(text, textSize, font)
        local textbounds = Vector2.new(0, 0)
        --
        local textlabel = utility:Create("TextLabel", {Vector2.new(0, 0)}, {
            Text = text,
            Size = textSize,
            Font = font,
            Hidden = true
        })
        --
        textbounds = textlabel.TextBounds
        utility:Remove(textlabel, true)
        --
        return textbounds
    end
    --
    function utility:GetScreenSize()
        return ws.CurrentCamera.ViewportSize
    end
    --
    function utility:LoadImage(instance, imageName, imageLink)
        local data
        --
        if isfile(library.folders.assets.."/"..imageName..".png") then
            data = readfile(library.folders.assets.."/"..imageName..".png")
        else
            if imageLink then
                data = game:HttpGet(imageLink)
                writefile(library.folders.assets.."/"..imageName..".png", data)
            else
                return
            end
        end
        --
        if data and instance then
            instance.Data = data
        end
    end
    --
    function utility:Lerp(instance, instanceTo, instanceTime)
        local currentTime = 0
        local currentIndex = {}
        local connection
        --
        for i,v in pairs(instanceTo) do
            currentIndex[i] = instance[i]
        end
        --
        local function lerp()
            for i,v in pairs(instanceTo) do
                instance[i] = ((v - currentIndex[i]) * currentTime / instanceTime) + currentIndex[i]
            end
        end
        --
        connection = rs.RenderStepped:Connect(function(delta)
            if currentTime < instanceTime then
                currentTime = currentTime + delta
                lerp()
            else
                connection:Disconnect()
            end
        end)
    end
    --
    function utility:Combine(table1, table2)
        local table3 = {}
        for i,v in pairs(table1) do table3[i] = v end
        local t = #table3
        for z,x in pairs(table2) do table3[z + t] = x end
        return table3
    end
    --
    function utility:WrapText(Text, Size)
        local Max = (Size / 7)
        --
        return Text:sub(0, Max)
    end
end
--// desktop fixed this btw
-- // Library Functions
do
    library.__index = library
	pages.__index = pages
	sections.__index = sections
    --
    function library:New(info)
		local info = info or {}
        local name = info.name or info.Name or info.title or info.Title or "UI Title"
        local size = info.size or info.Size or Vector2.new(550,700)
        local accent = info.accent or info.Accent or info.color or info.Color or theme.accent
        --
        theme.accent = accent
        --
        local window = {pages = {}, unloaded = false, isVisible = false, uibind = Enum.KeyCode.RightShift, currentPage = nil, fading = false, dragging = false, drag = Vector2.new(0,0), currentContent = {frame = nil, dropdown = nil, multibox = nil, colorpicker = nil, keybind = nil}}
        --
        local main_frame = utility:Create("Frame", {Vector2.new(0,0)}, {
            Size = utility:Size(0, size.X, 0, size.Y),
            Position = utility:Position(0.5, -(size.X/2) ,0.5, -(size.Y/2)),
            Color = theme.outline
        });window["main_frame"] = main_frame
        --
        library.colors[main_frame] = {
            Color = "outline"
        }
        --
        local frame_inline = utility:Create("Frame", {Vector2.new(1,1), main_frame}, {
            Size = utility:Size(1, -2, 1, -2, main_frame),
            Position = utility:Position(0, 1, 0, 1, main_frame),
            Color = theme.lightcontrast
        })
        --
        library.colors[frame_inline] = {
            Color = "lightcontrast"
        }
        --
        local inner_frame = utility:Create("Frame", {Vector2.new(1,1), frame_inline}, {
            Size = utility:Size(1, -2, 1, -2, frame_inline),
            Position = utility:Position(0, 1, 0, 1, frame_inline),
            Color = theme.lightcontrast
        })
        --
        library.colors[inner_frame] = {
            Color = "lightcontrast"
        }
        --
        local title = utility:Create("TextLabel", {Vector2.new(4,2), inner_frame}, {
            Text = name,
            Size = theme.textsize,
            Font = theme.font,
            Color = theme.textcolor,
            OutlineColor = theme.textborder,
            Position = utility:Position(0, 4, 0, 2, inner_frame)
        })
        --
        library.colors[title] = {
            OutlineColor = "textborder",
            Color = "textcolor"
        }
        --
        local inner_frame_inline = utility:Create("Frame", {Vector2.new(4,18), inner_frame}, {
            Size = utility:Size(1, -8, 1, -22, inner_frame),
            Position = utility:Position(0, 4, 0, 18, inner_frame),
            Color = theme.inline
        })
        --
        library.colors[inner_frame_inline] = {
            Color = "inline"
        }
        --
        local inner_frame_inline2 = utility:Create("Frame", {Vector2.new(1,1), inner_frame_inline}, {
            Size = utility:Size(1, -2, 1, -2, inner_frame_inline),
            Position = utility:Position(0, 1, 0, 1, inner_frame_inline),
            Color = theme.outline
        })
        --
        library.colors[inner_frame_inline2] = {
            Color = "outline"
        }
        --
        local back_frame = utility:Create("Frame", {Vector2.new(1,1), inner_frame_inline2}, {
            Size = utility:Size(1, -2, 1, -2, inner_frame_inline2),
            Position = utility:Position(0, 1, 0, 1, inner_frame_inline2),
            Color = theme.darkcontrast
        });window["back_frame"] = back_frame
        --
        library.colors[back_frame] = {
            Color = "darkcontrast"
        }
        --
        local tab_frame_inline = utility:Create("Frame", {Vector2.new(4,24), back_frame}, {
            Size = utility:Size(1, -8, 1, -28, back_frame),
            Position = utility:Position(0, 4, 0, 24, back_frame),
            Color = theme.outline
        })
        --
        library.colors[tab_frame_inline] = {
            Color = "outline"
        }
        --
        local tab_frame_inline2 = utility:Create("Frame", {Vector2.new(1,1), tab_frame_inline}, {
            Size = utility:Size(1, -2, 1, -2, tab_frame_inline),
            Position = utility:Position(0, 1, 0, 1, tab_frame_inline),
            Color = theme.inline
        })
        --
        library.colors[tab_frame_inline2] = {
            Color = "inline"
        }
        --
        local tab_frame = utility:Create("Frame", {Vector2.new(1,1), tab_frame_inline2}, {
            Size = utility:Size(1, -2, 1, -2, tab_frame_inline2),
            Position = utility:Position(0, 1, 0, 1, tab_frame_inline2),
            Color = theme.lightcontrast
        });window["tab_frame"] = tab_frame
        --
        library.colors[tab_frame] = {
            Color = "lightcontrast"
        }
        --
        function window:GetConfig()
            local config = {}
            --
            if not pcall(function()
                for i,v in pairs(library.pointers) do
                    if type(v:get()) == "table" and v:get().Transparency then
                        local hue, sat, val = v:get().Color:ToHSV()
                        config[i] = {Color = {hue, sat, val}, Transparency = v:get().Transparency}
                    elseif v.keybindname then
                        local key, mode = v:get(), v.mode
                        config[i] = {Key = key, Mode = mode}
                    elseif typeof(v:get()) == "Color3" then
                        local hue, sat, val = v:get():ToHSV()
                        config[i] = {Color = {hue, sat, val}, Transparency = v.current[4] or 1}
                    else
                        config[i] = v:get()
                    end
                end
            end) then
            end
            --
            return hs:JSONEncode(config)
        end
        --
        function window:ChangeUIBind(new_uibind)
            window.uibind = new_uibind
        end
        --
        function window:Retitle(new_name)
            title.Text = new_name
            name = new_name
        end
        --
        function window:LoadConfig(config)
            local config = hs:JSONDecode(config)
            --
            for i,v in next, config do
                if library.pointers[i] then
                    library.pointers[i]:set(v)
                end
            end
        end
        --
        function window:Move(vector)
            for i,v in pairs(library.drawings) do
                if v[2][2] then
                    v[1].Position = utility:Position(0, v[2][1].X, 0, v[2][1].Y, v[2][2])
                else
                    v[1].Position = utility:Position(0, vector.X, 0, vector.Y)
                end
            end
        end
        --
        function window:CloseContent()
            if window.currentContent.dropdown and window.currentContent.dropdown.open then
                local dropdown = window.currentContent.dropdown
                dropdown.open = not dropdown.open
                utility:LoadImage(dropdown.dropdown_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                --
                for i,v in pairs(dropdown.holder.drawings) do
                    utility:Remove(v)
                end
                --
                dropdown.holder.drawings = {}
                dropdown.holder.buttons = {}
                dropdown.holder.inline = nil
                --
                window.currentContent.frame = nil
                window.currentContent.dropdown = nil
            elseif window.currentContent.multibox and window.currentContent.multibox.open then
                local multibox = window.currentContent.multibox
                multibox.open = not multibox.open
                utility:LoadImage(multibox.multibox_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                --
                for i,v in pairs(multibox.holder.drawings) do
                    utility:Remove(v)
                end
                --
                multibox.holder.drawings = {}
                multibox.holder.buttons = {}
                multibox.holder.inline = nil
                --
                window.currentContent.frame = nil
                window.currentContent.multibox = nil
            elseif window.currentContent.colorpicker and window.currentContent.colorpicker.open then
                local colorpicker = window.currentContent.colorpicker
                colorpicker.open = not colorpicker.open
                --
                for i,v in pairs(colorpicker.holder.drawings) do
                    utility:Remove(v)
                end
                --
                colorpicker.holder.drawings = {}
                --
                window.currentContent.frame = nil
                window.currentContent.colorpicker = nil
            elseif window.currentContent.keybind and window.currentContent.keybind.open then
                local modemenu = window.currentContent.keybind.modemenu
                window.currentContent.keybind.open = not window.currentContent.keybind.open
                --
                for i,v in pairs(modemenu.drawings) do
                    utility:Remove(v)
                end
                --
                modemenu.drawings = {}
                modemenu.buttons = {}
                modemenu.frame = nil
                --
                window.currentContent.frame = nil
                window.currentContent.keybind = nil
            end
        end
        --
        function window:IsOverContent()
            local isOver = false
            --
            if window.currentContent.frame and utility:MouseOverDrawing({window.currentContent.frame.Position.X,window.currentContent.frame.Position.Y,window.currentContent.frame.Position.X + window.currentContent.frame.Size.X,window.currentContent.frame.Position.Y + window.currentContent.frame.Size.Y}) then
                isOver = true
            end
            --
            return isOver
        end
        --
        function window:Unload()
            for i,v in pairs(library.connections) do
                v:Disconnect()
                v = nil
            end
            --
            for i,v in next, library.hidden do
                coroutine.wrap(function()
                    if v[1] and v[1].Remove then
                        local instance = v[1]
                        v[1] = nil
                        v = nil
                        --
                        instance:Remove()
                    end
                end)()
            end
            --
            for i,v in pairs(library.drawings) do
                coroutine.wrap(function()
                    if v[1] and v[1].Remove then
                        local instance = v[1]
                        v[2] = nil
                        v[1] = nil
                        v = nil
                        --
                        instance:Remove()
                    end
                end)()
            end
            --
            for i,v in pairs(library.began) do
                v = nil
            end
            --
            for i,v in pairs(library.changed) do
                v = nil
            end
            --
            for i,v in pairs(library.ended) do
                v = nil
            end
            --
            for i,v in pairs(library.changed) do
                v = nil
            end
            --
            library.drawings = nil
            library.hidden = nil
            library.connections = nil
            library.began = nil
            library.ended = nil
            library.changed = nil

            window.unloaded = true
        end
        --
        function window:Watermark(info)
            window.watermark = {visible = false}
            --
            local info = info or {}
            local watermark_name = info.name or info.Name or info.title or info.Title or string.format("$$ Splix || uid : %u || ping : %u || fps : %u", 1, 100, 200)
            --
            local text_bounds = utility:GetTextBounds(watermark_name, theme.textsize, theme.font)
            --
            local watermark_outline = utility:Create("Frame", {Vector2.new(100,38/2-10)}, {
                Size = utility:Size(0, text_bounds.X+20, 0, 21),
                Position = utility:Position(0, 100, 0, 38/2-10),
                Hidden = true,
                ZIndex = 60,
                Color = theme.outline,
                Visible = window.watermark.visible
            })window.watermark.outline = watermark_outline
            library.colors[watermark_outline] = {
                Color = "outline",
            }
            --
            local watermark_inline = utility:Create("Frame", {Vector2.new(1,1), watermark_outline}, {
                Size = utility:Size(1, -2, 1, -2, watermark_outline),
                Position = utility:Position(0, 1, 0, 1, watermark_outline),
                Hidden = true,
                ZIndex = 60,
                Color = theme.inline,
                Visible = window.watermark.visible
            })
            library.colors[watermark_inline] = {
                Color = "inline",
            }
            --
            local watermark_frame = utility:Create("Frame", {Vector2.new(1,1), watermark_inline}, {
                Size = utility:Size(1, -2, 1, -2, watermark_inline),
                Position = utility:Position(0, 1, 0, 1, watermark_inline),
                Hidden = true,
                ZIndex = 60,
                Color = theme.lightcontrast,
                Visible = window.watermark.visible
            })
            library.colors[watermark_frame] = {
                Color = "lightcontrast",
            }
            --
            local watermark_accent = utility:Create("Frame", {Vector2.new(0,0), watermark_frame}, {
                Size = utility:Size(1, 0, 0, 1, watermark_frame),
                Position = utility:Position(0, 0, 0, 0, watermark_frame),
                Hidden = true,
                ZIndex = 60,
                Color = theme.accent,
                Visible = window.watermark.visible
            })
            library.colors[watermark_accent] = {
                Color = "accent",
            }
            --
            local watermark_title = utility:Create("TextLabel", {Vector2.new(2 + 6,4), watermark_outline}, {
                Text = string.format("splix - fps : %u - uid : %u", 35, 2),
                Size = theme.textsize,
                Font = theme.font,
                Color = theme.textcolor,
                OutlineColor = theme.textborder,
                Hidden = true,
                ZIndex = 60,
                Position = utility:Position(0, 2 + 6, 0, 4, watermark_outline),
                Visible = window.watermark.visible
            })
            library.colors[watermark_title] = {
                Color = "textcolor",
                OutlineColor = "textborder"
            }
            --
            function window.watermark:UpdateSize()
                watermark_outline.Size = utility:Size(0, watermark_title.TextBounds.X + 4 + (6*2), 0, 21)
                watermark_inline.Size = utility:Size(1, -2, 1, -2, watermark_outline)
                watermark_frame.Size = utility:Size(1, -2, 1, -2, watermark_inline)
                watermark_accent.Size = utility:Size(1, 0, 0, 1, watermark_frame)
            end
            --
            function window.watermark:Visibility()
                watermark_outline.Visible = window.watermark.visible
                watermark_inline.Visible = window.watermark.visible
                watermark_frame.Visible = window.watermark.visible
                watermark_accent.Visible = window.watermark.visible
                watermark_title.Visible = window.watermark.visible
            end
            --
            function window.watermark:Update(updateType, updateValue)
                if updateType == "Visible" then
                    window.watermark.visible = updateValue
                    window.watermark:Visibility()
                end
                if updateType == "Title" then
                    watermark_title.Text = updateValue
                end
            end
            --
            utility:Connection(rs.RenderStepped, function(fps)
                library.shared.fps = math.round(1 / fps)
                library.shared.ping = tonumber(string.split(stats.Network.ServerStatsItem["Data Ping"]:GetValueString(), " ")[1] .. "")
            end)
            --
            return window.watermark
        end
        --
        function window:NotificationList(info)
            window.notificationlist = {notifications = {}}
            --
            local info = info or {}
            --
            function window.notificationlist:AddNotification(info)
                local info = info or {}
                local text = info.text or "label"
                local lifetime = info.lifetime or 5
                --
                local notification = {pressed = false}
                --
                local notify_outline = utility:Create("Frame", {Vector2.new(0, 0)}, {
                    Size = utility:Size(0, 18 + (7 * #text), 0, 29),
                    Position = utility:Position(0, 10, 0, 3 + (#window.notificationlist.notifications * 35)),
                    Color = theme.outline,
                    ZIndex = 1,
                    Transparency = 0,
                    Hidden = true,
                    Visible = false,
                })notification["notify_outline"] = notify_outline
                --
                local notify_inline = utility:Create("Frame", {Vector2.new(1, 1), notify_outline}, {
                    Size = utility:Size(1, -2, 1, -2, notify_outline),
                    Position = utility:Position(0, 1, 0, 1, notify_outline),
                    Color = theme.inline,
                    ZIndex = 2,
                    Transparency = 0,
                    Hidden = true,
                    Visible = false,
                })notification["notify_inline"] = notify_inline
                --
                local notify_frame = utility:Create("Frame", {Vector2.new(1, 1), notify_inline}, {
                    Size = utility:Size(1, -2, 1, -2, notify_inline),
                    Position = utility:Position(0, 1, 0, 1, notify_inline),
                    Color = theme.light_contrast,
                    ZIndex = 3,
                    Transparency = 0,
                    Hidden = true,
                    Visible = false,
                })notification["notify_frame"] = notify_frame
                --
                local notify_accent = utility:Create("Frame", {Vector2.new(0, 0), notify_frame}, {
                    Size = utility:Size(0, 5, 0, 25),
                    Position = utility:Position(0, 0, 0, 0, notify_frame),
                    Color = theme.accent,
                    ZIndex = 3,
                    Transparency = 0,
                    Hidden = true,
                    Visible = false,
                })notification["notify_accent"] = notify_accent
                --
                local notify_title = utility:Create("TextLabel", {Vector2.new(8, 5), notify_frame}, {
                    Size = 13,
                    Position = utility:Position(0, 10, 0, 5, notify_frame),
                    Font = Drawing.Fonts.Plex,
                    Color = theme.accent,
                    Outline = true,
                    ZIndex = 5,
                    Text = text,
                    Transparency = 0,
                    Hidden = true,
                    Visible = true,
                })notification["notify_title"] = notify_title
                --
                local notify__gradient = utility:Create("Image", {Vector2.new(0, 0), notify_frame}, {
                    Size = utility:Size(1, 0, 1, 0, notify_frame),
                    Position = utility:Position(0, 0, 0, 0, notify_frame),
                    Transparency = 0,
                    ZIndex = 4,
                    Hidden = true,
                    Visible = false,
                })notification["notify__gradient"] = notify__gradient
                --
                utility:LoadImage(notify__gradient, "gradient", "https://raw.githubusercontent.com/portallol/luna/main/Gradient.png")
                --
                utility:Lerp(notify_outline, {Transparency = 1}, 0.25)
                utility:Lerp(notify_inline, {Transparency = 1}, 0.25)
                utility:Lerp(notify_frame, {Transparency = 1}, 0.25)
                utility:Lerp(notify_accent, {Transparency = 10}, 0.25)
                utility:Lerp(notify_title, {Transparency = 1}, 0.25)
                utility:Lerp(notify__gradient, {Transparency = 0.5}, 0.25)
                --
                window.notificationlist.notifications[#window.notificationlist.notifications + 1] = notification
                --
                local function began_function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 and utility:MouseOverDrawingInstance(notify_outline) and not notification.pressed then
                        notification.Remove()
                    end
                end
                --
                library.began[#library.began + 1] = began_function
                --
                local function changed_function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseMovement and not notification.pressed then
                        if utility:MouseOverDrawingInstance(notify_outline) then
                            local h, s, v = theme.accent:ToHSV()
                            notify_inline.Color = Color3.fromHSV(h, 0.44, v)
                        else
                            notify_inline.Color = theme.inline
                        end
                    end
                end
                --
                library.changed[#library.changed + 1] = changed_function
                --
                function notification.Remove()
                    if notification.pressed then return end
                    notification.pressed = true
                    --
                    utility:Lerp(notify_outline, {Transparency = 0}, 0.25)
                    utility:Lerp(notify_inline, {Transparency = 0}, 0.25)
                    utility:Lerp(notify_frame, {Transparency = 0}, 0.25)
                    utility:Lerp(notify_accent, {Transparency = 0}, 0.25)
                    utility:Lerp(notify_title, {Transparency = 0}, 0.25)
                    utility:Lerp(notify__gradient, {Transparency = 0}, 0.25)
                    --
                    task.wait(0.25)
                    --
                    notify_outline:Remove()
                    notify_inline:Remove()
                    notify_frame:Remove()
                    notify_accent:Remove()
                    notify_title:Remove()
                    notify__gradient:Remove()
                    --
                    for index, notify in next, window.notificationlist.notifications do
                        if notify == notification then
                            window.notificationlist.notifications[index] = nil
                        end
                    end
                    --
                    for index, func in next, library.changed do
                        if func == changed_function then
                            library.changed[index] = nil
                        end
                    end
                    --
                    for index, func in next, library.began do
                        if func == began_function then
                            library.began[index] = nil
                        end
                    end
                    --
                    window.notificationlist:SortNotifications()
                end
                --
                delay(lifetime + 0.25, notification.Remove)
            end
            --
            function window.notificationlist:SortNotifications()
                for index, notification in next, window.notificationlist.notifications do
                    notification["notify_outline"].Position = utility:Position(0, 0, 0, -3, notification["notify_outline"])
                    notification["notify_inline"].Position = utility:Position(0, 1, 0, 1, notification["notify_outline"])
                    notification["notify_frame"].Position = utility:Position(0, 1, 0, 1, notification["notify_inline"])
                    notification["notify_accent"].Position = utility:Position(0, 0, 0, 0, notification["notify_frame"])
                    notification["notify_title"].Position = utility:Position(0, 8, 0, -5, notification["notify_frame"])
                    notification["notify__gradient"].Position = utility:Position(0, 0, 0, 0, notification["notify_frame"])
                end
            end
        end
        --
        function window:KeybindsList(info)
            window.keybindslist = {visible = false, keybinds = {}}
            --
            local info = info or {}
            --
            local keybindslist_outline = utility:Create("Frame", {Vector2.new(10,(utility:GetScreenSize().Y/2)-200)}, {
                Size = utility:Size(0, 180, 0, 22),
                Position = utility:Position(0, 10, 0.4, 0),
                Hidden = true,
                ZIndex = 1005,
                Color = theme.outline,
                Visible = window.keybindslist.visible
            })window.keybindslist.outline = keybindslist_outline
            --
            library.colors[keybindslist_outline] = {
                Color = "outline"
            }
            --
            local keybindslist_inline = utility:Create("Frame", {Vector2.new(1,1), keybindslist_outline}, {
                Size = utility:Size(1, -2, 1, -2, keybindslist_outline),
                Position = utility:Position(0, 1, 0, 1, keybindslist_outline),
                Hidden = true,
                ZIndex = 1005,
                Color = theme.inline,
                Visible = window.keybindslist.visible
            })
            --
            library.colors[keybindslist_inline] = {
                Color = "inline"
            }
            --
            local keybindslist_frame = utility:Create("Frame", {Vector2.new(1,1), keybindslist_inline}, {
                Size = utility:Size(1, -2, 1, -2, keybindslist_inline),
                Position = utility:Position(0, 1, 0, 1, keybindslist_inline),
                Hidden = true,
                ZIndex = 1005,
                Color = theme.lightcontrast,
                Visible = window.keybindslist.visible
            })
            --
            library.colors[keybindslist_frame] = {
                Color = "lightcontrast"
            }
            --
            local keybindslist_accent = utility:Create("Frame", {Vector2.new(0,0), keybindslist_frame}, {
                Size = utility:Size(1, 0, 0, 1, keybindslist_frame),
                Position = utility:Position(0, 0, 0, 0, keybindslist_frame),
                Hidden = true,
                ZIndex = 1005,
                Color = theme.accent,
                Visible = window.keybindslist.visible
            })
            --
            library.colors[keybindslist_accent] = {
                Color = "accent"
            }
            --
            local keybindslist_title = utility:Create("TextLabel", {Vector2.new(keybindslist_outline.Size.X/2,4), keybindslist_outline}, {
                Text = "Keybinds",
                Size = theme.textsize,
                Font = theme.font,
                Color = theme.textcolor,
                OutlineColor = theme.textborder,
                Center = true,
                Hidden = true,
                ZIndex = 1005,
                Position = utility:Position(0.5, 0, 0, 5, keybindslist_outline),
                Visible = window.keybindslist.visible
            })
            --
            library.colors[keybindslist_title] = {
                OutlineColor = "textborder",
                Color = "textcolor"
            }
            --
            function window.keybindslist:Resort()
                local index = 0
                for i,v in pairs(window.keybindslist.keybinds) do
                    v:Move(0 + (index*17))
                    --
                    index = index + 1
                end
            end
            --
            function window.keybindslist:Add(keybindname, keybindvalue)
                if keybindname and keybindvalue and not window.keybindslist.keybinds[keybindname] then
                    local keybindTable = {}
                    --
                    local keybind_outline = utility:Create("Frame", {Vector2.new(0,keybindslist_outline.Size.Y-1), keybindslist_outline}, {
                        Size = utility:Size(1, 0, 0, 18, keybindslist_outline),
                        Position = utility:Position(0, 0, 1, -1, keybindslist_outline),
                        Hidden = true,
                        ZIndex = 1005,
                        Color = theme.outline,
                        Visible = window.keybindslist.visible
                    })
                    --
                    library.colors[keybind_outline] = {
                        Color = "outline"
                    }
                    --
                    local keybind_inline = utility:Create("Frame", {Vector2.new(1,1), keybind_outline}, {
                        Size = utility:Size(1, -2, 1, -2, keybind_outline),
                        Position = utility:Position(0, 1, 0, 1, keybind_outline),
                        Hidden = true,
                        ZIndex = 1005,
                        Color = theme.inline,
                        Visible = window.keybindslist.visible
                    })
                    --
                    library.colors[keybind_inline] = {
                        Color = "inline"
                    }
                    --
                    local keybind_frame = utility:Create("Frame", {Vector2.new(1,1), keybind_inline}, {
                        Size = utility:Size(1, -2, 1, -2, keybind_inline),
                        Position = utility:Position(0, 1, 0, 1, keybind_inline),
                        Hidden = true,
                        ZIndex = 1005,
                        Color = theme.darkcontrast,
                        Visible = window.keybindslist.visible
                    })
                    --
                    library.colors[keybind_frame] = {
                        Color = "darkcontrast"
                    }
                    --
                    local keybind_title = utility:Create("TextLabel", {Vector2.new(4,3), keybind_outline}, {
                        Text = keybindname,
                        Size = theme.textsize,
                        Font = theme.font,
                        Color = theme.textcolor,
                        OutlineColor = theme.textborder,
                        Center = false,
                        Hidden = true,
                        ZIndex = 1005,
                        Position = utility:Position(0, 4, 0, 3, keybind_outline),
                        Visible = window.keybindslist.visible
                    })
                    --
                    library.colors[keybind_title] = {
                        OutlineColor = "textborder",
                        Color = "textcolor"
                    }
                    --
                    local keybind_value = utility:Create("TextLabel", {Vector2.new(keybind_outline.Size.X - 4 - utility:GetTextBounds(keybindname, theme.textsize, theme.font).X,3), keybind_outline}, {
                        Text = "["..keybindvalue.."]",
                        Size = theme.textsize,
                        Font = theme.font,
                        Color = theme.textcolor,
                        OutlineColor = theme.textborder,
                        Hidden = true,
                        ZIndex = 1005,
                        Position = utility:Position(1, -4 - utility:GetTextBounds(keybindname, theme.textsize, theme.font).X, 0, 3, keybind_outline),
                        Visible = window.keybindslist.visible
                    })
                    --
                    library.colors[keybind_value] = {
                        OutlineColor = "textborder",
                        Color = "textcolor"
                    }
                    --
                    function keybindTable:Move(yPos)
                        keybind_outline.Position = utility:Position(0, 0, 1, -1 + yPos, keybindslist_outline)
                        keybind_inline.Position = utility:Position(0, 1, 0, 1, keybind_outline)
                        keybind_frame.Position = utility:Position(0, 1, 0, 1, keybind_inline)
                        keybind_title.Position = utility:Position(0, 4, 0, 3, keybind_outline)
                        keybind_value.Position = utility:Position(1, -4 - keybind_value.TextBounds.X, 0, 3, keybind_outline)
                    end
                    --
                    function keybindTable:Remove()
                        utility:Remove(keybind_outline, true)
                        utility:Remove(keybind_inline, true)
                        utility:Remove(keybind_frame, true)
                        utility:Remove(keybind_title, true)
                        utility:Remove(keybind_value, true)
                        --
                        window.keybindslist.keybinds[keybindname] = nil
                        keybindTable = nil
                    end
                    --
                    function keybindTable:Visibility()
                        keybind_outline.Visible = window.keybindslist.visible
                        keybind_inline.Visible = window.keybindslist.visible
                        keybind_frame.Visible = window.keybindslist.visible
                        keybind_title.Visible = window.keybindslist.visible
                        keybind_value.Visible = window.keybindslist.visible
                    end
                    --
                    window.keybindslist.keybinds[keybindname] = keybindTable
                    window.keybindslist:Resort()
                end
            end
            --
            function window.keybindslist:Remove(keybindname)
                if keybindname and window.keybindslist.keybinds[keybindname] then
                    window.keybindslist.keybinds[keybindname]:Remove()
                    window.keybindslist.keybinds[keybindname] = nil
                    window.keybindslist:Resort()
                end
            end
            --
            function window.keybindslist:Visibility()
                keybindslist_outline.Visible = window.keybindslist.visible
                keybindslist_inline.Visible = window.keybindslist.visible
                keybindslist_frame.Visible = window.keybindslist.visible
                keybindslist_accent.Visible = window.keybindslist.visible
                keybindslist_title.Visible = window.keybindslist.visible
                --
                for i,v in pairs(window.keybindslist.keybinds) do
                    v:Visibility()
                end
            end
            --
            function window.keybindslist:Update(updateType, updateValue)
                if updateType == "Visible" then
                    window.keybindslist.visible = updateValue
                    window.keybindslist:Visibility()
                end
            end
            --
            utility:Connection(ws.CurrentCamera:GetPropertyChangedSignal("ViewportSize"),function()
                keybindslist_outline.Position = utility:Position(0, 10, 0.4, 0)
                keybindslist_inline.Position = utility:Position(0, 1, 0, 1, keybindslist_outline)
                keybindslist_frame.Position = utility:Position(0, 1, 0, 1, keybindslist_inline)
                keybindslist_accent.Position = utility:Position(0, 0, 0, 0, keybindslist_frame)
                keybindslist_title.Position = utility:Position(0.5, 0, 0, 5, keybindslist_outline)
                --
                window.keybindslist:Resort()
            end)
        end
        --
        function window:StatusList(info)
            window.statuslist = {visible = false, statuses = {}}
            --
            local info = info or {}
            --
            local statuslist_outline = utility:Create("Frame", {Vector2.new(10,(utility:GetScreenSize().Y/2)-200)}, {
                Size = utility:Size(0, 150, 0, 22),
                Position = utility:Position(1, -160, 0.4, 0),
                Hidden = true,
                ZIndex = 1005,
                Color = theme.outline,
                Visible = window.statuslist.visible
            })window.statuslist.outline = statuslist_outline
            --
            library.colors[statuslist_outline] = {
                Color = "outline"
            }
            --
            local statuslist_inline = utility:Create("Frame", {Vector2.new(1,1), statuslist_outline}, {
                Size = utility:Size(1, -2, 1, -2, statuslist_outline),
                Position = utility:Position(0, 1, 0, 1, statuslist_outline),
                Hidden = true,
                ZIndex = 1005,
                Color = theme.inline,
                Visible = window.statuslist.visible
            })
            --
            library.colors[statuslist_inline] = {
                Color = "inline"
            }
            --
            local statuslist_frame = utility:Create("Frame", {Vector2.new(1,1), statuslist_inline}, {
                Size = utility:Size(1, -2, 1, -2, statuslist_inline),
                Position = utility:Position(0, 1, 0, 1, statuslist_inline),
                Hidden = true,
                ZIndex = 1005,
                Color = theme.lightcontrast,
                Visible = window.statuslist.visible
            })
            --
            library.colors[statuslist_frame] = {
                Color = "lightcontrast"
            }
            --
            local statuslist_accent = utility:Create("Frame", {Vector2.new(0,0), statuslist_frame}, {
                Size = utility:Size(1, 0, 0, 1, statuslist_frame),
                Position = utility:Position(0, 0, 0, 0, statuslist_frame),
                Hidden = true,
                ZIndex = 1005,
                Color = theme.accent,
                Visible = window.statuslist.visible
            })
            --
            library.colors[statuslist_accent] = {
                Color = "accent"
            }
            --
            local statuslist_title = utility:Create("TextLabel", {Vector2.new(statuslist_outline.Size.X/2,4), statuslist_outline}, {
                Text = "Status",
                Size = theme.textsize,
                Font = theme.font,
                Color = theme.textcolor,
                OutlineColor = theme.textborder,
                Center = true,
                Hidden = true,
                ZIndex = 1005,
                Position = utility:Position(0.5, 0, 0, 5, statuslist_outline),
                Visible = window.statuslist.visible
            })
            --
            library.colors[statuslist_title] = {
                OutlineColor = "textborder",
                Color = "textcolor"
            }
            --
            function window.statuslist:Resort()
                local index = 0
                for i,v in pairs(window.statuslist.statuses) do
                    v:Move(0 + (index*17))
                    --
                    index = index + 1
                end
            end
            --
            function window.statuslist:Add(statusname)
                if statusname and not window.statuslist.statuses[statusname] then
                    local statusTable = {}
                    --
                    local status_outline = utility:Create("Frame", {Vector2.new(0,statuslist_outline.Size.Y-1), statuslist_outline}, {
                        Size = utility:Size(1, 0, 0, 18, statuslist_outline),
                        Position = utility:Position(0, 0, 1, -1, statuslist_outline),
                        Hidden = true,
                        ZIndex = 1005,
                        Color = theme.outline,
                        Visible = window.statuslist.visible
                    })
                    --
                    library.colors[status_outline] = {
                        Color = "outline"
                    }
                    --
                    local status_inline = utility:Create("Frame", {Vector2.new(1,1), status_outline}, {
                        Size = utility:Size(1, -2, 1, -2, status_outline),
                        Position = utility:Position(0, 1, 0, 1, status_outline),
                        Hidden = true,
                        ZIndex = 1005,
                        Color = theme.inline,
                        Visible = window.statuslist.visible
                    })
                    --
                    library.colors[status_inline] = {
                        Color = "inline"
                    }
                    --
                    local status_frame = utility:Create("Frame", {Vector2.new(1,1), status_inline}, {
                        Size = utility:Size(1, -2, 1, -2, status_inline),
                        Position = utility:Position(0, 1, 0, 1, status_inline),
                        Hidden = true,
                        ZIndex = 1005,
                        Color = theme.darkcontrast,
                        Visible = window.statuslist.visible
                    })
                    --
                    library.colors[status_frame] = {
                        Color = "darkcontrast"
                    }
                    --
                    local status_title = utility:Create("TextLabel", {Vector2.new(4,3), status_outline}, {
                        Text = statusname,
                        Size = theme.textsize,
                        Font = theme.font,
                        Color = theme.textcolor,
                        OutlineColor = theme.textborder,
                        Center = false,
                        Hidden = true,
                        ZIndex = 1005,
                        Position = utility:Position(0, 4, 0, 3, status_outline),
                        Visible = window.statuslist.visible
                    })
                    --
                    library.colors[status_title] = {
                        OutlineColor = "textborder",
                        Color = "textcolor"
                    }
                    --
                    function statusTable:Move(yPos)
                        status_outline.Position = utility:Position(0, 0, 1, -1 + yPos, statuslist_outline)
                        status_inline.Position = utility:Position(0, 1, 0, 1, status_outline)
                        status_frame.Position = utility:Position(0, 1, 0, 1, status_inline)
                        status_title.Position = utility:Position(0, 4, 0, 3, status_outline)
                    end
                    --
                    function statusTable:Remove()
                        utility:Remove(status_outline, true)
                        utility:Remove(status_inline, true)
                        utility:Remove(status_frame, true)
                        utility:Remove(status_title, true)
                        --
                        window.statuslist.statuses[statusname] = nil
                        statusTable = nil
                    end
                    --
                    function statusTable:Visibility()
                        status_outline.Visible = window.statuslist.visible
                        status_inline.Visible = window.statuslist.visible
                        status_frame.Visible = window.statuslist.visible
                        status_title.Visible = window.statuslist.visible
                    end
                    --
                    window.statuslist.statuses[statusname] = statusTable
                    window.statuslist:Resort()
                end
            end
            --
            function window.statuslist:Remove(statusname)
                if statusname and window.statuslist.statuses[statusname] then
                    window.statuslist.statuses[statusname]:Remove()
                    window.statuslist.statuses[statusname] = nil
                    window.statuslist:Resort()
                end
            end
            --
            function window.statuslist:Visibility()
                statuslist_outline.Visible = window.statuslist.visible
                statuslist_inline.Visible = window.statuslist.visible
                statuslist_frame.Visible = window.statuslist.visible
                statuslist_accent.Visible = window.statuslist.visible
                statuslist_title.Visible = window.statuslist.visible
                --
                for i,v in pairs(window.statuslist.statuses) do
                    v:Visibility()
                end
            end
            --
            function window.statuslist:Update(updateType, updateValue)
                if updateType == "Visible" then
                    window.statuslist.visible = updateValue
                    window.statuslist:Visibility()
                end
            end
            --
            utility:Connection(ws.CurrentCamera:GetPropertyChangedSignal("ViewportSize"),function()
                statuslist_outline.Position = utility:Position(1, -160, 0.4, 0)
                statuslist_inline.Position = utility:Position(0, 1, 0, 1, statuslist_outline)
                statuslist_frame.Position = utility:Position(0, 1, 0, 1, statuslist_inline)
                statuslist_accent.Position = utility:Position(0, 0, 0, 0, statuslist_frame)
                statuslist_title.Position = utility:Position(0.5, 0, 0, 5, statuslist_outline)
        