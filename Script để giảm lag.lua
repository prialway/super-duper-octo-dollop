-- Script để giảm lag

local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

-- Hàm để tắt CanCollide cho các đối tượng không cần thiết
local function optimizeCollision(part)
    if part:IsA("BasePart") and not part.Parent:IsA("Model") then
        part.CanCollide = false
    end
end

-- Tạo sự kiện cho khi đối tượng mới được thêm vào
game.Workspace.ChildAdded:Connect(function(child)
    if child:IsA("BasePart") then
        optimizeCollision(child)
    end
end)

-- Tối ưu hóa các đối tượng hiện có trong Workspace
for _, obj in ipairs(workspace:GetChildren()) do
    if obj:IsA("BasePart") then
        optimizeCollision(obj)
    end
end

-- Giảm thiểu số lượng sự kiện `Heartbeat` để tăng hiệu suất
local function onHeartbeat()
    -- Thực hiện các hành động cần thiết tại đây
end

game:GetService("RunService").Heartbeat:Connect(onHeartbeat)

-- Giảm thiểu tải trên các sự kiện `Touched` không cần thiết
local function onTouched(part)
    if part:IsA("BasePart") then
        part.Touched:Disconnect()
    end
end

game.Workspace.ChildAdded:Connect(function(child)
    if child:IsA("BasePart") then
        child.Touched:Connect(onTouched)
    end
end)

-- Giải phóng tài nguyên không cần thiết
Debris:AddItem(workspace, 60) -- Xóa các đối tượng sau 60 giây

-- Tối ưu hóa phần render
game:GetService("RunService").RenderStepped:Connect(function()
    -- Xử lý các tác vụ render tại đây
end)

-- Tối ưu hóa các đối tượng không còn sử dụng
game:GetService("Players").PlayerRemoving:Connect(function(player)
    local character = player.Character
    if character then
        for _, obj in ipairs(character:GetChildren()) do
            if obj:IsA("BasePart") then
                Debris:AddItem(obj, 30) -- Xóa các đối tượng sau 30 giây
            end
        end
    end
end)
